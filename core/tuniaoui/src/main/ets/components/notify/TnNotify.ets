/**
 * @file TnNotify 消息通知组件
 * @description 在页面顶部或底部显示消息通知，支持多种类型、自动关闭、自定义样式等
 * @author JunBin.Yang
 */

import { AppStorageV2, ComponentContent } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { getThemeColor, getFontSizeByKey, TnComponentColorType } from "../../common/theme_helpers";
import { TnBaseDataTypeObs } from "../../common/types";
import { ContextUtil } from "../../utils/ContextUtil";
import { TnNotifyOption, TnNotifyParams } from "./TnNotifyTypes";

/**
 * 通知内容组件
 * 负责渲染通知的文本和背景色
 */
@ComponentV2
struct TnNotifyContent {
  /** 全局基础样式 */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /** 通知参数 */
  @Param params: TnNotifyParams = new TnNotifyParams();
  /** 顶部安全区高度 */
  @Local topAvoidHeight: TnBaseDataTypeObs = AppStorageV2.connect(TnBaseDataTypeObs, TnAppStorageKey.TOP_AVOID_HEIGHT)!;

  /**
   * 获取通知背景色
   * @returns 背景色
   */
  private getBackgroundColor(): ResourceColor {
    if (this.params.backgroundColor !== undefined) {
      return this.params.backgroundColor;
    }
    const typeMap: Record<string, TnComponentColorType> = {
      "primary": "primary",
      "success": "success",
      "warning": "warning",
      "danger": "danger"
    };
    const colorType: TnComponentColorType = typeMap[this.params.type] || "danger";
    return getThemeColor(this.baseStyle, colorType);
  }

  /**
   * 获取文字颜色
   * @returns 文字颜色
   */
  private getTextColor(): ResourceColor {
    if (this.params.color !== undefined) {
      return this.params.color;
    }
    return $r("app.color.tn_color_white");
  }

  build() {
    Column() {
      Row() {
        Text(this.params.message)
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
          .fontColor(this.getTextColor())
          .lineHeight(this.baseStyle.lineHeightSm)
          .textAlign(TextAlign.Center)
          .maxLines(3)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width("100%");
      }
      .width("100%")
      .justifyContent(FlexAlign.Center)
      .padding({
        left: this.baseStyle.space,
        right: this.baseStyle.space,
        top: this.baseStyle.spaceXsm,
        bottom: this.baseStyle.spaceXsm
      });
    }
    .width("100%")
    .backgroundColor(this.getBackgroundColor())
    .padding({
      top: this.params.position === "top" ? this.topAvoidHeight.value as number : 0,
      bottom: this.params.position === "bottom" ? this.topAvoidHeight.value as number : 0
    })
    .stateStyles({
      normal: {
        .opacity(1.0)
      },
      pressed: {
        .opacity(this.params.onClick !== undefined ? 0.8 : 1.0)
      }
    })
    .animation({ duration: this.baseStyle.animationDuration })
    .onClick(() => {
      if (this.params.onClick !== undefined) {
        this.params.onClick();
      }
    });
  }
}

/**
 * 通知内容 Builder 函数
 * @param params 通知参数
 */
@Builder
function tnNotifyBuilder(params: TnNotifyParams): void {
  TnNotifyContent({ params: params });
}

/**
 * TnNotify 消息通知服务
 *
 * @example
 * // 基础用法（默认 danger 类型）
 * TnNotify.show({ message: "操作失败，请重试" });
 *
 * // 指定类型
 * TnNotify.show({ message: "提交成功", type: "success" });
 *
 * // 自定义时长
 * TnNotify.show({ message: "警告信息", type: "warning", duration: 5000 });
 *
 * // 手动关闭
 * TnNotify.hide();
 */
class TnNotifyService {
  /** ComponentContent 节点 */
  private contentNode: ComponentContent<TnNotifyParams> | null = null;
  /** UIContext 引用 */
  private uiContext: UIContext | null = null;
  /** 自动关闭定时器 */
  private timer: number = -1;
  /** 是否正在显示 */
  private isShowing: boolean = false;

  /**
   * 显示消息通知
   * @param option 通知配置选项
   */
  public show(option: TnNotifyOption): void {
    // 如果当前有通知正在显示，先关闭
    if (this.isShowing) {
      this.closeImmediate();
    }
    this.isShowing = true;
    this.uiContext = ContextUtil.getUICtx();
    const promptAction = this.uiContext.getPromptAction();
    const params: TnNotifyParams = new TnNotifyParams(option);
    params.hide = (): void => this.hide();

    const contentNode: ComponentContent<TnNotifyParams> =
      new ComponentContent(this.uiContext, wrapBuilder(tnNotifyBuilder), params);
    this.contentNode = contentNode;

    const isBottom: boolean = params.position === "bottom";
    const alignment: DialogAlignment =
      isBottom ? DialogAlignment.Bottom : DialogAlignment.Top;

    // 从 baseStyle 获取动画时长
    const baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
    const animDuration: number = baseStyle.animationDuration;

    // 根据位置设置抽屉式滑入/滑出动画
    const slideEdge: TransitionEdge =
      isBottom ? TransitionEdge.BOTTOM : TransitionEdge.TOP;
    const slideTransition: TransitionEffect =
      TransitionEffect.move(slideEdge)
        .animation({ duration: animDuration, curve: Curve.EaseOut });

    promptAction.openCustomDialog(contentNode, {
      alignment: alignment,
      isModal: false,
      autoCancel: false,
      maskColor: Color.Transparent,
      dialogTransition: slideTransition,
      onDidAppear: (): void => {
        if (params.onOpen !== undefined) {
          params.onOpen();
        }
        // 设置自动关闭
        if (params.duration > 0) {
          this.autoClose(params);
        }
      },
      onDidDisappear: (): void => {
        contentNode.dispose();
        this.contentNode = null;
        this.uiContext = null;
        this.isShowing = false;
        if (params.onClose !== undefined) {
          params.onClose();
        }
      }
    });
  }

  /**
   * 关闭消息通知
   */
  public hide(): void {
    this.clearTimer();
    if (this.contentNode !== null && this.uiContext !== null) {
      const node: ComponentContent<TnNotifyParams> = this.contentNode;
      try {
        this.uiContext.getPromptAction().closeCustomDialog(node);
      } catch (_e) {
        // 对话框可能已关闭
        this.isShowing = false;
        this.contentNode = null;
        this.uiContext = null;
      }
    }
  }

  /**
   * 立即关闭（用于连续调用场景）
   */
  private closeImmediate(): void {
    this.clearTimer();
    if (this.contentNode !== null && this.uiContext !== null) {
      const node: ComponentContent<TnNotifyParams> = this.contentNode;
      try {
        this.uiContext.getPromptAction().closeCustomDialog(node);
      } catch (_e) {
        // 忽略异常
      }
      this.contentNode = null;
      this.uiContext = null;
      this.isShowing = false;
    }
  }

  /**
   * 设置自动关闭定时器
   * @param params 通知参数
   */
  private autoClose(params: TnNotifyParams): void {
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

const TnNotify: TnNotifyService = new TnNotifyService();
export default TnNotify;
