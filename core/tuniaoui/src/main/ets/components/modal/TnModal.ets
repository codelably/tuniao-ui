/**
 * @file TnModal 模态框组件
 * @description 支持标题、内容、取消/确认按钮、遮罩层、关闭前拦截、自定义内容等
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { getThemeColor, getFontSizeByKey } from "../../common/theme_helpers";
import { convertDimensionsWidthUnit } from "../../utils/Utils";
import { getHexColorByResoure, mixWithBlack } from "../../utils/ColorUtils";
import { TnModalAction, TnModalBeforeClose, TnModalTextAlign } from "./TnModalTypes";

/** 默认弹窗宽度 */
const MODAL_DEFAULT_WIDTH: number = 280;

/** 按钮高度 */
const MODAL_BUTTON_HEIGHT: number = 48;

/** 分割线粗细 */
const MODAL_DIVIDER_THICKNESS: number = 0.5;

/**
 * TnModalContent 模态框内容层
 * 负责标题、内容区域、按钮区域的布局渲染
 */
@ComponentV2
struct TnModalContent {
  /** 全局基础样式 */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /** 标题文本 */
  @Param title: string = "";
  /** 内容文本 */
  @Param content: string = "";
  /** 是否显示取消按钮 */
  @Param showCancel: boolean = false;
  /** 取消按钮文字 */
  @Param cancelText: string = "";
  /** 确认按钮文字 */
  @Param confirmText: string = "";
  /** 标题对齐方式 */
  @Param titleTextAlign: TnModalTextAlign = "center";
  /** 内容对齐方式 */
  @Param contentTextAlign: TnModalTextAlign = "center";
  /** 确认按钮文字颜色 */
  @Param confirmButtonColor: ResourceColor = "";
  /** 取消按钮文字颜色 */
  @Param cancelButtonColor: ResourceColor = "";
  /** 确认按钮是否加粗 */
  @Param confirmButtonBold: boolean = true;
  /** 弹窗宽度 */
  @Param dialogWidth: number = MODAL_DEFAULT_WIDTH;
  /** 弹窗圆角 */
  @Param dialogBorderRadius: number = 0;
  /** 自定义默认内容 */
  @BuilderParam defaultBuilder: CustomBuilder;
  /** 自定义标题 */
  @BuilderParam titleBuilder: CustomBuilder;
  /** 自定义底部按钮 */
  @BuilderParam footerBuilder: CustomBuilder;
  /** 确认按钮回调 */
  @Event onConfirmClick: () => void = () => {};
  /** 取消按钮回调 */
  @Event onCancelClick: () => void = () => {};

  /**
   * 将 TnModalTextAlign 转为 TextAlign
   * @param align 对齐类型
   * @returns TextAlign 枚举值
   */
  private resolveTextAlign(align: TnModalTextAlign): TextAlign {
    switch (align) {
      case "left":
        return TextAlign.Start;
      case "right":
        return TextAlign.End;
      default:
        return TextAlign.Center;
    }
  }

  /**
   * 获取确认按钮文字颜色
   * @returns ResourceColor
   */
  @Computed
  get resolvedConfirmColor(): ResourceColor {
    if (this.confirmButtonColor) {
      return this.confirmButtonColor;
    }
    return getThemeColor(this.baseStyle, "primary");
  }

  /**
   * 获取取消按钮文字颜色
   * @returns ResourceColor
   */
  @Computed
  get resolvedCancelColor(): ResourceColor {
    if (this.cancelButtonColor) {
      return this.cancelButtonColor;
    }
    return $r("app.color.tn_text_color_primary");
  }

  /**
   * 获取圆角值
   * @returns 圆角尺寸字符串
   */
  @Computed
  get resolvedBorderRadius(): string {
    if (this.dialogBorderRadius > 0) {
      return convertDimensionsWidthUnit(this.dialogBorderRadius);
    }
    return this.baseStyle.borderRadiusXxl;
  }

  build() {
    Column() {
      // 标题区域
      this.TitleSection();
      // 内容区域
      this.ContentSection();
      // 按钮区域
      this.FooterSection();
    }
    .width(convertDimensionsWidthUnit(this.dialogWidth))
    .backgroundColor($r("app.color.tn_bg_color"))
    .borderRadius(this.resolvedBorderRadius)
    .clip(true)
  }

  /**
   * 标题区域构建器
   */
  @Builder
  private TitleSection(): void {
    if (this.titleBuilder) {
      this.titleBuilder();
    } else if (this.title) {
      Text(this.title)
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeLg"))
        .fontColor($r("app.color.tn_text_color_primary"))
        .fontWeight(FontWeight.Bold)
        .textAlign(this.resolveTextAlign(this.titleTextAlign))
        .width("100%")
        .padding({
          top: this.baseStyle.spaceLg,
          left: this.baseStyle.spaceLg,
          right: this.baseStyle.spaceLg,
          bottom: this.baseStyle.spaceXsm
        })
        .lineHeight(this.baseStyle.lineHeightMd);
    }
  }

  /**
   * 内容区域构建器
   */
  @Builder
  private ContentSection(): void {
    if (this.defaultBuilder) {
      Column() {
        this.defaultBuilder();
      }
      .width("100%")
      .padding({
        left: this.baseStyle.spaceLg,
        right: this.baseStyle.spaceLg,
        top: this.title ? this.baseStyle.spaceSm : this.baseStyle.spaceLg,
        bottom: this.baseStyle.spaceLg
      });
    } else if (this.content) {
      Text(this.content)
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
        .fontColor($r("app.color.tn_text_color_secondary"))
        .textAlign(this.resolveTextAlign(this.contentTextAlign))
        .width("100%")
        .lineHeight(this.baseStyle.lineHeightSm)
        .padding({
          left: this.baseStyle.spaceLg,
          right: this.baseStyle.spaceLg,
          top: this.title ? this.baseStyle.spaceSm : this.baseStyle.spaceLg,
          bottom: this.baseStyle.spaceLg
        })
        .constraintSize({ maxHeight: "60%" });
    }
  }

  /**
   * 底部按钮区域构建器
   */
  @Builder
  private FooterSection(): void {
    if (this.footerBuilder) {
      this.footerBuilder();
    } else {
      // 顶部分割线
      Divider()
        .strokeWidth(convertDimensionsWidthUnit(MODAL_DIVIDER_THICKNESS))
        .color($r("app.color.tn_color_gray_disabled"));
      Row() {
        // 取消按钮
        if (this.showCancel) {
          this.CancelButton();
          // 中间竖向分割线
          Divider()
            .vertical(true)
            .strokeWidth(convertDimensionsWidthUnit(MODAL_DIVIDER_THICKNESS))
            .height(convertDimensionsWidthUnit(MODAL_BUTTON_HEIGHT))
            .color($r("app.color.tn_color_gray_disabled"));
        }
        // 确认按钮
        this.ConfirmButton();
      }
      .width("100%")
      .height(convertDimensionsWidthUnit(MODAL_BUTTON_HEIGHT));
    }
  }

  /**
   * 取消按钮构建器
   */
  @Builder
  private CancelButton(): void {
    Text(this.cancelText || "取消")
      .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeLg"))
      .fontColor(this.resolvedCancelColor)
      .fontWeight(FontWeight.Normal)
      .textAlign(TextAlign.Center)
      .lineHeight(this.baseStyle.lineHeightMd)
      .layoutWeight(1)
      .height("100%")
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
        this.onCancelClick();
      });
  }

  /**
   * 确认按钮构建器
   */
  @Builder
  private ConfirmButton(): void {
    Text(this.confirmText || "确认")
      .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeLg"))
      .fontColor(this.resolvedConfirmColor)
      .fontWeight(this.confirmButtonBold ? FontWeight.Bold : FontWeight.Normal)
      .textAlign(TextAlign.Center)
      .lineHeight(this.baseStyle.lineHeightMd)
      .layoutWeight(1)
      .height("100%")
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
        this.onConfirmClick();
      });
  }
}

/**
 * TnModal 模态框组件
 *
 * @example
 * // 基础用法（仅确认按钮）
 * TnModal({
 *   visible: this.showModal,
 *   $visible: (val: boolean) => { this.showModal = val; },
 *   title: "提示",
 *   content: "确认执行此操作？"
 * })
 *
 * // 带取消按钮
 * TnModal({
 *   visible: this.showModal,
 *   $visible: (val: boolean) => { this.showModal = val; },
 *   title: "确认",
 *   content: "是否删除此项目？",
 *   showCancel: true,
 *   onConfirm: () => { console.info("confirmed"); },
 *   onCancel: () => { console.info("cancelled"); }
 * })
 */
@ComponentV2
export struct TnModal {
  /** 全局基础样式 */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /**
   * 控制模态框显示与隐藏
   */
  @Param @Require visible: boolean = false;
  /**
   * 模态框标题
   */
  @Param title: string = "";
  /**
   * 模态框内容文本
   */
  @Param content: string = "";
  /**
   * 是否显示取消按钮
   */
  @Param showCancel: boolean = false;
  /**
   * 取消按钮文字
   */
  @Param cancelText: string = "";
  /**
   * 确认按钮文字
   */
  @Param confirmText: string = "";
  /**
   * 是否显示遮罩层
   */
  @Param showOverlay: boolean = true;
  /**
   * 点击遮罩层是否关闭模态框
   */
  @Param overlayCloseable: boolean = false;
  /**
   * 是否允许返回键关闭
   */
  @Param closeOnBackPress: boolean = true;
  /**
   * 弹窗宽度（vp）
   */
  @Param dialogWidth: number = MODAL_DEFAULT_WIDTH;
  /**
   * 弹窗圆角（vp），默认使用 baseStyle.borderRadiusXxl
   */
  @Param dialogBorderRadius: number = 0;
  /**
   * 标题文本对齐方式
   */
  @Param titleTextAlign: TnModalTextAlign = "center";
  /**
   * 内容文本对齐方式
   */
  @Param contentTextAlign: TnModalTextAlign = "center";
  /**
   * 确认按钮文字颜色
   */
  @Param confirmButtonColor: ResourceColor = "";
  /**
   * 取消按钮文字颜色
   */
  @Param cancelButtonColor: ResourceColor = "";
  /**
   * 确认按钮是否加粗
   */
  @Param confirmButtonBold: boolean = true;
  /**
   * 关闭前拦截回调，返回 false 可阻止关闭
   */
  @Param beforeClose: TnModalBeforeClose | null = null;
  /**
   * 自定义默认内容（覆盖 content 文本）
   */
  @BuilderParam defaultBuilder: CustomBuilder;
  /**
   * 自定义标题（覆盖 title 文本）
   */
  @BuilderParam titleBuilder: CustomBuilder;
  /**
   * 自定义底部按钮区域
   */
  @BuilderParam footerBuilder: CustomBuilder;
  /**
   * 确认按钮点击事件
   */
  @Event onConfirm: () => void = () => {};
  /**
   * 取消按钮点击事件
   */
  @Event onCancel: () => void = () => {};
  /**
   * 模态框打开事件
   */
  @Event onOpen: () => void = () => {};
  /**
   * 模态框关闭事件
   */
  @Event onClose: () => void = () => {};
  /**
   * visible 双向绑定回调
   */
  @Event $visible: (visible: boolean) => void = () => {};

  /** PromptAction 实例 */
  private promptAction = this.getUIContext().getPromptAction();
  /** CustomDialog ID */
  private dialogId: number = 0;

  /**
   * 监听 visible 变化，控制模态框的打开和关闭
   */
  @Monitor("visible")
  async onVisibleChange(): Promise<void> {
    if (this.visible) {
      this.open();
    } else {
      try {
        this.promptAction.closeCustomDialog(this.dialogId);
      } catch (_e) {
        // 忽略关闭时的异常（模态框可能已经被关闭）
      }
    }
  }

  /**
   * 获取遮罩颜色
   * @returns 遮罩颜色值
   */
  private getMaskColor(): ResourceColor {
    if (!this.showOverlay) {
      return Color.Transparent;
    }
    return $r("app.color.tn_overlay_bg");
  }

  /**
   * 打开模态框
   */
  private async open(): Promise<void> {
    this.dialogId = await this.promptAction.openCustomDialog({
      builder: () => {
        this.DialogContentBuilder();
      },
      alignment: DialogAlignment.Center,
      isModal: this.showOverlay,
      maskColor: this.getMaskColor(),
      cornerRadius: 0,
      backgroundBlurStyle: BlurStyle.NONE,
      backgroundColor: Color.Transparent,
      onDidAppear: () => {
        this.onOpen();
      },
      onDidDisappear: () => {
        this.onClose();
      },
      onWillDismiss: (dismissDialogAction: DismissDialogAction) => {
        const reason: DismissReason = dismissDialogAction.reason;
        if (reason === DismissReason.PRESS_BACK && this.closeOnBackPress) {
          this.handleAction("cancel");
        }
        if (reason === DismissReason.TOUCH_OUTSIDE && this.overlayCloseable) {
          this.close();
        }
      }
    });
  }

  /**
   * 关闭模态框
   */
  private close(): void {
    this.$visible(false);
  }

  /**
   * 处理按钮操作（支持 beforeClose 拦截）
   * @param action 操作类型
   */
  private async handleAction(action: TnModalAction): Promise<void> {
    if (this.beforeClose) {
      try {
        const result: boolean = await this.beforeClose(action);
        if (!result) {
          return;
        }
      } catch (_e) {
        return;
      }
    }
    if (action === "confirm") {
      this.onConfirm();
    } else {
      this.onCancel();
    }
    this.close();
  }

  /**
   * Dialog 内容构建器
   */
  @Builder
  private DialogContentBuilder(): void {
    TnModalContent({
      title: this.title,
      content: this.content,
      showCancel: this.showCancel,
      cancelText: this.cancelText,
      confirmText: this.confirmText,
      titleTextAlign: this.titleTextAlign,
      contentTextAlign: this.contentTextAlign,
      confirmButtonColor: this.confirmButtonColor,
      cancelButtonColor: this.cancelButtonColor,
      confirmButtonBold: this.confirmButtonBold,
      dialogWidth: this.dialogWidth,
      dialogBorderRadius: this.dialogBorderRadius,
      defaultBuilder: this.defaultBuilder,
      titleBuilder: this.titleBuilder,
      footerBuilder: this.footerBuilder,
      onConfirmClick: () => {
        this.handleAction("confirm");
      },
      onCancelClick: () => {
        this.handleAction("cancel");
      }
    });
  }

  build() {
    // 容器组件，build 为空，逻辑通过 openCustomDialog 实现
  }
}
