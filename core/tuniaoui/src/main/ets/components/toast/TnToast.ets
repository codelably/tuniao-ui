/**
 * @file TnToast 轻提示组件
 * @description 在页面指定位置显示轻提示，支持多种图标类型、加载动画、动态更新等
 * @author JunBin.Yang
 */

import { AppStorageV2, ComponentContent } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { getFontSizeByKey } from "../../common/theme_helpers";
import { convertDimensionsWidthUnit } from "../../utils/Utils";
import { ContextUtil } from "../../utils/ContextUtil";
import { TnLoading } from "../loading/TnLoading";
import { TnIcon } from "../icon/TnIcon";
import { TnToastOption, TnToastLoadingOption, TnToastParams } from "./TnToastTypes";

/** Toast 最小宽度 (vp) */
const TOAST_MIN_WIDTH: number = 96;
/** 带图标时 Toast 最小高度 (vp) */
const TOAST_ICON_MIN_HEIGHT: number = 98;
/** Toast 最大宽度 */
const TOAST_MAX_WIDTH: string = "60%";

/**
 * 轻提示内容组件
 * 负责渲染图标区域和文字内容
 */
@ComponentV2
struct TnToastContent {
  /** 全局基础样式 */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /** 轻提示参数 */
  @Param params: TnToastParams = new TnToastParams();

  /**
   * 是否显示图标区域（设置了 type 或自定义 icon 时显示）
   * @returns 是否显示
   */
  private hasIcon(): boolean {
    return this.params.type !== undefined || this.params.icon !== undefined;
  }

  /**
   * 获取文本换行枚举值
   * @returns WordBreak 枚举
   */
  private getWordBreak(): WordBreak {
    switch (this.params.wordBreak) {
      case "break-all":
        return WordBreak.BREAK_ALL;
      case "break-word":
        return WordBreak.BREAK_WORD;
      default:
        return WordBreak.NORMAL;
    }
  }

  /**
   * 获取图标名称
   * @returns 图标名称字符串
   */
  private getIconName(): string {
    switch (this.params.type) {
      case "success":
        return "success";
      case "warning":
        return "warning";
      case "fail":
        return "close";
      default:
        return "";
    }
  }

  /**
   * 图标区域构建器
   */
  @Builder
  private IconArea(): void {
    if (this.params.icon !== undefined) {
      // 自定义图标（优先级最高）
      Image(this.params.icon)
        .width(convertDimensionsWidthUnit(this.params.iconSize))
        .aspectRatio(1);
    } else if (this.params.type === "loading") {
      // 加载动画
      TnLoading({
        mode: this.params.loadingMode,
        color: this.params.loadingColor !== undefined ? this.params.loadingColor : $r("app.color.tn_color_white"),
        customSize: this.params.iconSize
      });
    } else if (this.params.type !== undefined) {
      // success / warning / fail 图标
      TnIcon({
        name: this.getIconName(),
        color: $r("app.color.tn_color_white"),
        iconSize: this.params.iconSize
      });
    }
  }

  build() {
    Column({ space: this.baseStyle.spaceXs }) {
      // 图标区域（条件渲染）
      if (this.hasIcon()) {
        this.IconArea();
      }
      // 文本区域
      if (this.params.message.length > 0) {
        Text(this.params.message)
          .fontColor($r("app.color.tn_color_white"))
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
          .lineHeight(this.baseStyle.lineHeightSm)
          .textAlign(TextAlign.Center)
          .wordBreak(this.getWordBreak());
      }
    }
    .constraintSize({
      minWidth: convertDimensionsWidthUnit(TOAST_MIN_WIDTH),
      maxWidth: TOAST_MAX_WIDTH,
      minHeight: this.hasIcon() ? convertDimensionsWidthUnit(TOAST_ICON_MIN_HEIGHT) : 0
    })
    .backgroundColor($r("app.color.tn_toast_bg"))
    .borderRadius(this.baseStyle.borderRadiusLg)
    .padding({
      left: this.baseStyle.spaceSm,
      right: this.baseStyle.spaceSm,
      top: this.baseStyle.spaceXsm,
      bottom: this.baseStyle.spaceXsm
    })
    .justifyContent(FlexAlign.Center)
    .animation({ duration: this.baseStyle.animationDuration });
  }
}

/**
 * 轻提示内容 Builder 函数
 * @param params 轻提示参数
 */
@Builder
function tnToastBuilder(params: TnToastParams): void {
  TnToastContent({ params: params });
}

/**
 * TnToast 轻提示服务
 *
 * @example
 * // 文本提示
 * TnToast.show("操作成功");
 *
 * // 带图标的提示
 * TnToast.show({ message: "提交成功", type: "success" });
 *
 * // 加载提示
 * TnToast.showLoading({ message: "加载中..." });
 *
 * // 关闭
 * TnToast.hide();
 *
 * // 动态更新文本
 * TnToast.message = "已完成 50%";
 */
class TnToastService {
  /** ComponentContent 节点 */
  private contentNode: ComponentContent<TnToastParams> | null = null;
  /** UIContext 引用 */
  private uiContext: UIContext | null = null;
  /** 当前参数引用（用于动态更新 message） */
  private toastParams: TnToastParams | null = null;
  /** 自动关闭定时器 */
  private timer: number = -1;
  /** 锁标志，防止并发弹出 */
  private isLock: boolean = false;

  /**
   * 动态更新提示文本
   * 利用 @ObservedV2 + @Trace 实现响应式更新
   */
  set message(msg: string) {
    if (this.toastParams !== null) {
      this.toastParams.message = msg;
    }
  }

  /**
   * 显示轻提示
   * @param option 字符串或配置对象
   * @returns 服务实例（支持链式调用）
   */
  public show(option: string | TnToastOption): TnToastService {
    if (this.isLock) {
      return this;
    }

    // 如果当前有提示正在显示，先关闭
    if (this.contentNode !== null) {
      this.closeImmediate();
    }

    this.isLock = true;
    this.uiContext = ContextUtil.getUICtx();
    const promptAction = this.uiContext.getPromptAction();

    // 规范化参数
    let toastOption: TnToastOption;
    if (typeof option === "string") {
      toastOption = new TnToastOption();
      toastOption.message = option;
    } else {
      toastOption = option;
    }

    const params: TnToastParams = new TnToastParams(toastOption);
    params.hide = (): void => this.hide();
    this.toastParams = params;

    const contentNode: ComponentContent<TnToastParams> =
      new ComponentContent(this.uiContext, wrapBuilder(tnToastBuilder), params);
    this.contentNode = contentNode;

    // 计算对话框对齐方式
    const alignment: DialogAlignment =
      params.position === "top" ? DialogAlignment.Top
        : params.position === "bottom" ? DialogAlignment.Bottom
          : DialogAlignment.Center;

    // 计算模态和遮罩
    const needModal: boolean = params.type === "loading" || params.isShowMask;

    promptAction.openCustomDialog(contentNode, {
      alignment: alignment,
      offset: { dx: 0, dy: params.offsetY },
      isModal: needModal,
      maskColor: params.isShowMask ? $r("app.color.tn_overlay_bg") : Color.Transparent,
      autoCancel: false,
      focusable: false,
      // 轻提示采用瞬间显示，不使用滑入/滑出动画
      transition: TransitionEffect.IDENTITY,
      onDidAppear: (): void => {
        if (params.onOpen !== undefined) {
          params.onOpen();
        }
        // loading 类型保持锁，防止异步操作期间被并发弹出覆盖；其他类型立即释放
        if (params.type !== "loading") {
          this.isLock = false;
        }
        // 自动关闭由 duration 统一控制，对所有类型一致
        if (params.duration > 0) {
          this.autoClose(params);
        }
      },
      onDidDisappear: (): void => {
        contentNode.dispose();
        // 仅当关闭的是当前活跃的 dialog 时才清理状态，
        // 避免连续调用 show() 时旧 dialog 的回调覆盖新 dialog 的引用
        if (this.contentNode === contentNode) {
          this.contentNode = null;
          this.uiContext = null;
          this.toastParams = null;
          this.isLock = false;
        }
        if (params.onClose !== undefined) {
          params.onClose();
        }
      },
      onWillDismiss: (): void => {
        // 阻止返回键等系统关闭行为
      }
    });

    return this;
  }

  /**
   * 显示加载提示（便捷方法）
   * 默认不自动关闭，需手动调用 hide()
   * @param option 加载配置选项
   */
  public showLoading(option?: TnToastLoadingOption): void {
    const toastOption: TnToastOption = new TnToastOption();
    toastOption.type = "loading";
    toastOption.message = option !== undefined ? option.message : "";
    toastOption.duration = option !== undefined ? option.duration : 0;
    toastOption.loadingMode = option !== undefined ? option.loadingMode : "circle";
    toastOption.loadingColor = option !== undefined ? option.loadingColor : undefined;
    this.show(toastOption);
  }

  /**
   * 关闭轻提示
   */
  public hide(): void {
    this.clearTimer();
    if (this.contentNode !== null && this.uiContext !== null) {
      const node: ComponentContent<TnToastParams> = this.contentNode;
      try {
        this.uiContext.getPromptAction().closeCustomDialog(node);
      } catch (_e) {
        // 对话框可能已关闭
        this.contentNode = null;
        this.uiContext = null;
        this.toastParams = null;
        this.isLock = false;
      }
    }
  }

  /**
   * 立即关闭（用于连续调用 show() 时清理前一个）
   */
  private closeImmediate(): void {
    this.clearTimer();
    if (this.contentNode !== null && this.uiContext !== null) {
      const node: ComponentContent<TnToastParams> = this.contentNode;
      try {
        this.uiContext.getPromptAction().closeCustomDialog(node);
      } catch (_e) {
        // 忽略异常
      }
      this.contentNode = null;
      this.uiContext = null;
      this.toastParams = null;
      this.isLock = false;
    }
  }

  /**
   * 设置自动关闭定时器
   * @param params 轻提示参数
   */
  private autoClose(params: TnToastParams): void {
    this.clearTimer();
    this.timer = setTimeout(() => {
      this.hide();
    }, params.duration);
  }

  /**
   * 清除定时器
   */
  private clearTimer(): void {
    if (this.timer !== -1) {
      clearTimeout(this.timer);
      this.timer = -1;
    }
  }
}

const TnToast: TnToastService = new TnToastService();
export default TnToast;
