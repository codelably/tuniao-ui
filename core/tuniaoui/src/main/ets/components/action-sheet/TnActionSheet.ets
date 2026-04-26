/**
 * @file TnActionSheet 操作面板组件
 * @description 从底部弹出的操作菜单面板，使用 openBindSheet 实现原生半模态效果，
 *   支持标题、描述、多选项、取消按钮、关闭拦截、自定义内容等
 * @author JunBin.Yang
 */

import { AppStorageV2, ComponentContent, LengthMetrics } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { TnBaseDataTypeObs } from "../../common/types";
import { getFontSizeByKey } from "../../common/theme_helpers";
import { convertDimensionsWidthUnit } from "../../utils/Utils";
import { getHexColorByResoure, mixWithBlack } from "../../utils/ColorUtils";
import { TnActionSheetItem, TnActionSheetCloseAction, TnActionSheetBeforeClose } from "./TnActionSheetTypes";
import { BORDER_RADIUS } from "../../theme-chalk/border";
import { SPACE } from "../../theme-chalk/space";

/** 选项行高度 */
const ACTION_ITEM_HEIGHT: number = 56;

/** 取消按钮高度 */
const CANCEL_BUTTON_HEIGHT: number = 56;

/** 分割线粗细 */
const DIVIDER_THICKNESS: number = 0.5;

/** 最大可见选项数（超出后滚动） */
const MAX_VISIBLE_ITEMS: number = 6;

/** 禁用态透明度 */
const DISABLED_OPACITY: number = 0.5;

/**
 * 操作面板内容参数类
 * 用于通过 ComponentContent 传递数据到内容组件
 */
class TnActionSheetContentParams {
  title: string = "";
  description: string = "";
  actions: TnActionSheetItem[] = [];
  cancelText: string = "";
  showCancel: boolean = true;
  safeAreaInsetBottom: boolean = true;
  onItemClick: (index: number) => void = () => {};
  onCancelClick: () => void = () => {};
}

/**
 * 操作面板内容构建器（模块级）
 * 供 ComponentContent 使用
 * @param params 内容参数
 */
@Builder
function tnActionSheetContentBuilder(params: TnActionSheetContentParams) {
  TnActionSheetContent({ params: params });
}

/**
 * TnActionSheetContent 操作面板内容层
 * 负责标题、描述、选项列表、取消按钮的布局渲染
 */
@ComponentV2
struct TnActionSheetContent {
  /** 全局基础样式 */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /** 底部安全区高度 */
  @Local bottomBarHeight: TnBaseDataTypeObs = AppStorageV2.connect(TnBaseDataTypeObs, TnAppStorageKey.BOTTOM_BAR_HEIGHT)!;
  /** 内容参数 */
  @Param @Require params: TnActionSheetContentParams;

  /**
   * 获取选项文字颜色
   * @param item 选项数据
   * @returns 文字颜色
   */
  private getItemTextColor(item: TnActionSheetItem): ResourceColor {
    if (item.disabled) {
      return $r("app.color.tn_text_color_disabled");
    }
    if (item.color) {
      return item.color;
    }
    return $r("app.color.tn_text_color_primary");
  }

  /**
   * 获取底部安全区内边距
   * @returns 底部内边距值
   */
  private getBottomSafePadding(): string {
    if (this.params.safeAreaInsetBottom) {
      return convertDimensionsWidthUnit(this.bottomBarHeight.value as number);
    }
    return "0vp";
  }

  /**
   * 计算选项列表最大高度
   * @returns 最大高度字符串
   */
  @Computed
  get listMaxHeight(): string {
    return convertDimensionsWidthUnit(ACTION_ITEM_HEIGHT * MAX_VISIBLE_ITEMS);
  }

  build() {
    Column() {
      // 标题与描述区域
      this.HeaderSection();
      // 选项列表区域
      this.ActionsSection();
      // 取消按钮区域
      if (this.params.showCancel) {
        this.CancelSection();
      }
    }
    .width("100%")
    .backgroundColor($r("app.color.tn_bg_color"))
    .padding({ bottom: this.getBottomSafePadding() })
  }

  /**
   * 标题与描述区域
   */
  @Builder
  private HeaderSection(): void {
    if (this.params.title || this.params.description) {
      Column() {
        if (this.params.title) {
          Text(this.params.title)
            .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeLg"))
            .fontColor($r("app.color.tn_text_color_primary"))
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
            .width("100%")
            .lineHeight(this.baseStyle.lineHeightMd);
        }
        if (this.params.description) {
          Text(this.params.description)
            .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
            .fontColor($r("app.color.tn_text_color_secondary"))
            .textAlign(TextAlign.Center)
            .width("100%")
            .lineHeight(this.baseStyle.lineHeightXsm)
            .margin({ top: this.params.title ? this.baseStyle.spaceBase : 0 });
        }
      }
      .width("100%")
      .padding({
        top: this.baseStyle.spaceLg,
        bottom: this.baseStyle.spaceSm,
        left: this.baseStyle.spaceLg,
        right: this.baseStyle.spaceLg
      });

      Divider()
        .strokeWidth(convertDimensionsWidthUnit(DIVIDER_THICKNESS))
        .color($r("app.color.tn_color_gray_disabled"));
    }
  }

  /**
   * 选项列表区域
   */
  @Builder
  private ActionsSection(): void {
    Scroll() {
      Column() {
        ForEach(this.params.actions, (item: TnActionSheetItem, index: number) => {
          this.ActionItem(item, index);
          if (index < this.params.actions.length - 1) {
            Divider()
              .strokeWidth(convertDimensionsWidthUnit(DIVIDER_THICKNESS))
              .color($r("app.color.tn_color_gray_disabled"));
          }
        });
      }
      .width("100%");
    }
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Off)
    .constraintSize({ maxHeight: this.listMaxHeight });
  }

  /**
   * 单个选项构建器
   * @param item 选项数据
   * @param index 选项索引
   */
  @Builder
  private ActionItem(item: TnActionSheetItem, index: number): void {
    Column() {
      Text(item.text)
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeLg"))
        .fontColor(this.getItemTextColor(item))
        .textAlign(TextAlign.Center)
        .lineHeight(this.baseStyle.lineHeightMd)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis });
      if (item.desc) {
        Text(item.desc)
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
          .fontColor($r("app.color.tn_text_color_secondary"))
          .textAlign(TextAlign.Center)
          .lineHeight(this.baseStyle.lineHeightXs)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ top: this.baseStyle.spaceMini });
      }
    }
    .width("100%")
    .height(convertDimensionsWidthUnit(ACTION_ITEM_HEIGHT))
    .justifyContent(FlexAlign.Center)
    .padding({ left: this.baseStyle.spaceLg, right: this.baseStyle.spaceLg })
    .backgroundColor($r("app.color.tn_bg_color"))
    .opacity(item.disabled ? DISABLED_OPACITY : 1)
    .stateStyles({
      normal: {
        .backgroundColor($r("app.color.tn_bg_color"))
      },
      pressed: {
        .backgroundColor(item.disabled
          ? $r("app.color.tn_bg_color")
          : mixWithBlack(getHexColorByResoure($r("app.color.tn_bg_color"))))
      }
    })
    .animation({ duration: this.baseStyle.animationDuration })
    .onClick(() => {
      if (!item.disabled) {
        this.params.onItemClick(index);
      }
    });
  }

  /**
   * 取消按钮区域
   */
  @Builder
  private CancelSection(): void {
    Column()
      .width("100%")
      .height(convertDimensionsWidthUnit(SPACE.XSM))
      .backgroundColor($r("app.color.tn_bg_color_page"));

    Text(this.params.cancelText || "取消")
      .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeLg"))
      .fontColor($r("app.color.tn_text_color_primary"))
      .textAlign(TextAlign.Center)
      .lineHeight(this.baseStyle.lineHeightMd)
      .width("100%")
      .height(convertDimensionsWidthUnit(CANCEL_BUTTON_HEIGHT))
      .backgroundColor($r("app.color.tn_bg_color"))
      .stateStyles({
        normal: {
          .backgroundColor($r("app.color.tn_bg_color"))
        },
        pressed: {
          .backgroundColor(mixWithBlack(getHexColorByResoure($r("app.color.tn_bg_color"))))
        }
      })
      .animation({ duration: this.baseStyle.animationDuration })
      .onClick(() => {
        this.params.onCancelClick();
      });
  }
}

/**
 * TnActionSheet 操作面板组件
 * 使用 openBindSheet 实现原生底部半模态面板效果
 *
 * @example
 * // 基础用法
 * TnActionSheet({
 *   visible: this.showSheet,
 *   $visible: (val: boolean) => { this.showSheet = val; },
 *   actions: [
 *     new TnActionSheetItem("选项一"),
 *     new TnActionSheetItem("选项二"),
 *     new TnActionSheetItem("选项三")
 *   ],
 *   onSelect: (index: number) => { console.info(`选择了第 ${index} 项`); }
 * })
 */
@ComponentV2
export struct TnActionSheet {
  /**
   * 控制面板显示与隐藏
   */
  @Param @Require visible: boolean = false;
  /**
   * 选项列表
   */
  @Param actions: TnActionSheetItem[] = [];
  /**
   * 面板标题
   */
  @Param title: string = "";
  /**
   * 面板描述文本
   */
  @Param description: string = "";
  /**
   * 取消按钮文字
   */
  @Param cancelText: string = "";
  /**
   * 是否显示取消按钮
   */
  @Param showCancel: boolean = true;
  /**
   * 点击遮罩层是否关闭面板
   */
  @Param overlayCloseable: boolean = true;
  /**
   * 是否允许返回键关闭
   */
  @Param closeOnBackPress: boolean = true;
  /**
   * 是否适配底部安全区
   */
  @Param safeAreaInsetBottom: boolean = true;
  /**
   * 关闭前拦截回调，返回 false 可阻止关闭
   */
  @Param beforeClose: TnActionSheetBeforeClose | null = null;
  /**
   * 选项选中事件
   * @param index 选中项索引
   * @param value 选中项标识值
   */
  @Event onSelect: (index: number, value: string) => void = () => {};
  /**
   * 取消按钮点击事件
   */
  @Event onCancel: () => void = () => {};
  /**
   * 面板打开事件
   */
  @Event onOpen: () => void = () => {};
  /**
   * 面板关闭事件
   */
  @Event onClose: () => void = () => {};
  /**
   * visible 双向绑定回调
   */
  @Event $visible: (visible: boolean) => void = () => {};

  /** UIContext 实例 */
  private uiContext: UIContext = this.getUIContext();
  /** ComponentContent 实例 */
  private contentNode: ComponentContent<TnActionSheetContentParams> | null = null;

  /**
   * 监听 visible 变化，控制面板的打开和关闭
   */
  @Monitor("visible")
  async onVisibleChange(): Promise<void> {
    if (this.visible) {
      this.openSheet();
    } else {
      this.closeSheet();
    }
  }

  /**
   * 构建内容参数
   * @returns 内容参数对象
   */
  private buildParams(): TnActionSheetContentParams {
    const params: TnActionSheetContentParams = new TnActionSheetContentParams();
    params.title = this.title;
    params.description = this.description;
    params.actions = this.actions;
    params.cancelText = this.cancelText;
    params.showCancel = this.showCancel;
    params.safeAreaInsetBottom = this.safeAreaInsetBottom;
    params.onItemClick = (index: number): void => {
      this.handleAction("select", index);
    };
    params.onCancelClick = (): void => {
      this.handleAction("cancel");
    };
    return params;
  }

  /**
   * 打开面板
   */
  private async openSheet(): Promise<void> {
    const params: TnActionSheetContentParams = this.buildParams();
    this.contentNode = new ComponentContent<TnActionSheetContentParams>(
      this.uiContext,
      wrapBuilder(tnActionSheetContentBuilder),
      params
    );

    await this.uiContext.openBindSheet(this.contentNode, {
      height: SheetSize.FIT_CONTENT,
      preferType: SheetType.BOTTOM,
      backgroundColor: $r("app.color.tn_bg_color"),
      dragBar: false,
      showClose: false,
      radius: new LengthMetrics(BORDER_RADIUS.XXL),
      onAppear: () => {
        this.onOpen();
      },
      onDisappear: () => {
        this.onClose();
      },
      onWillDismiss: (dismissAction: DismissSheetAction) => {
        const reason: DismissReason = dismissAction.reason;
        if (reason === DismissReason.PRESS_BACK && !this.closeOnBackPress) {
          return;
        }
        if (reason === DismissReason.TOUCH_OUTSIDE && !this.overlayCloseable) {
          return;
        }
        this.close();
      }
    });
  }

  /**
   * 关闭面板（释放 ComponentContent）
   */
  private async closeSheet(): Promise<void> {
    if (this.contentNode) {
      try {
        await this.uiContext.closeBindSheet(this.contentNode);
        this.contentNode.dispose();
      } catch (_e) {
        // 忽略关闭时的异常（面板可能已经被关闭）
      }
      this.contentNode = null;
    }
  }

  /**
   * 更新 visible 状态以触发关闭
   */
  private close(): void {
    this.$visible(false);
  }

  /**
   * 处理关闭动作（支持 beforeClose 拦截）
   * @param action 操作类型
   * @param index 选项索引（仅 select 时有值）
   */
  private async handleAction(action: TnActionSheetCloseAction, index?: number): Promise<void> {
    const itemValue: string = (action === "select" && index !== undefined && index < this.actions.length)
      ? this.actions[index].value : "";

    if (this.beforeClose) {
      try {
        const result: boolean = await this.beforeClose(action, index, itemValue);
        if (!result) {
          return;
        }
      } catch (_e) {
        return;
      }
    }

    if (action === "select" && index !== undefined) {
      this.onSelect(index, itemValue);
    } else {
      this.onCancel();
    }
    this.close();
  }

  build() {
    // 容器组件，build 为空，逻辑通过 openBindSheet 实现
  }
}
