/**
 * @file TnPopup 弹出框组件
 * @description 支持5个方向弹出（center/top/bottom/left/right）、遮罩层、关闭按钮、安全区适配等
 * @author JunBin.Yang
 */

import { AppStorageV2, ImmersiveMode, LengthMetrics } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { TnBaseDataTypeObs, TnStringNumber } from "../../common/types";
import { getSizeByUnit, convertDimensionsWidthUnit } from "../../utils/Utils";
import { TnUIInitializer } from "../..";
import { TnIcon } from "../icon/TnIcon";
import { TnPopupOpenDirection, TnPopupCloseBtnPosition, TnPopupBaseController } from "./TnPopupTypes";

/** 弹出动画时长（毫秒） */
const POPUP_SHOW_DURATION: number = 200;

/** 隐藏动画时长（毫秒） */
const POPUP_HIDE_DURATION: number = 220;

/**
 * 异步等待指定毫秒数
 * @param ms 等待时间
 * @returns Promise
 */
function popupSleep(ms: number): Promise<void> {
  return new Promise<void>((resolve: Function) => {
    setTimeout(() => {
      resolve();
    }, ms);
  });
}

/**
 * 弹出框内容尺寸
 */
interface TnPopupContentSize {
  width: TnStringNumber;
  height: TnStringNumber;
}

/**
 * TnPopupContent 弹出框内容层
 * 负责内容布局和滑动动画
 */
@ComponentV2
struct TnPopupContent {
  /** 全局基础样式 */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /** 是否横屏 */
  @Local isLandscape: TnBaseDataTypeObs = AppStorageV2.connect(TnBaseDataTypeObs, TnAppStorageKey.IS_LANDSCAPE)!;
  /** 顶部规避高度 */
  @Local topAvoidHeight: TnBaseDataTypeObs = AppStorageV2.connect(TnBaseDataTypeObs, TnAppStorageKey.TOP_AVOID_HEIGHT)!;
  /** 底部导航条高度 */
  @Local bottomBarHeight: TnBaseDataTypeObs = AppStorageV2.connect(TnBaseDataTypeObs, TnAppStorageKey.BOTTOM_BAR_HEIGHT)!;
  /** 弹出方向 */
  @Param openDirection: TnPopupOpenDirection = "center";
  /** 弹框宽度 */
  @Param popupWidth: TnStringNumber = "";
  /** 弹框高度 */
  @Param popupHeight: TnStringNumber = "";
  /** 背景颜色 */
  @Param bgColor: ResourceColor = "";
  /** 圆角 */
  @Param radius: TnStringNumber = 0;
  /** 是否显示关闭按钮 */
  @Param closeBtn: boolean = false;
  /** 关闭按钮位置 */
  @Param closeBtnPosition: TnPopupCloseBtnPosition = "right-top";
  /** 是否开启底部安全区适配 */
  @Param safeAreaInsetBottom: boolean = true;
  /** 距离顶部的距离（仅 top/left/right 方向有效） */
  @Param top: TnStringNumber = "";
  /** 遮罩是否可关闭 */
  @Param overlayCloseable: boolean = true;
  /** 自定义内容 */
  @BuilderParam contentBuilder: CustomBuilder;
  /** 自定义关闭按钮 */
  @BuilderParam closeBtnBuilder: CustomBuilder;
  /** 点击遮罩回调 */
  @Event onOverlayClick: () => void = () => {};
  /** 关闭按钮点击回调 */
  @Event onCloseBtnClick: () => void = () => {};
  /** 内部控制器 */
  @Param baseController: TnPopupBaseController = new TnPopupBaseController();
  /** X 轴偏移量（用于左右方向动画） */
  @Local transX: TnStringNumber = "";
  /** Y 轴偏移量（用于上下方向动画） */
  @Local transY: TnStringNumber = "";

  /**
   * 计算弹出框内容的尺寸
   * @returns 宽高尺寸
   */
  @Computed
  get popupSize(): TnPopupContentSize {
    switch (this.openDirection) {
      case "left":
      case "right":
        return {
          width: this.popupWidth || (this.isLandscape.value ? "70%" : "60%"),
          height: this.popupHeight || "100%"
        };
      case "top":
      case "bottom":
        return {
          width: this.popupWidth || "100%",
          height: this.popupHeight || (this.isLandscape.value ? "70%" : "40%")
        };
      case "center":
        return {
          width: this.popupWidth || "",
          height: this.popupHeight || ""
        };
    }
  }

  /**
   * 根据方向计算圆角
   * @returns 圆角配置
   */
  private getResolvedBorderRadius(): BorderRadiuses {
    const r: string = typeof this.radius === "number"
      ? convertDimensionsWidthUnit(this.radius)
      : this.radius;
    const zero: string = "0vp";
    switch (this.openDirection) {
      case "top":
        return { topLeft: zero, topRight: zero, bottomLeft: r, bottomRight: r };
      case "bottom":
        return { topLeft: r, topRight: r, bottomLeft: zero, bottomRight: zero };
      case "left":
        return { topLeft: zero, topRight: r, bottomLeft: zero, bottomRight: r };
      case "right":
        return { topLeft: r, topRight: zero, bottomLeft: r, bottomRight: zero };
      case "center":
      default:
        return { topLeft: r, topRight: r, bottomLeft: r, bottomRight: r };
    }
  }

  /**
   * 计算底部安全区内边距
   * @returns 底部内边距
   */
  private getBottomPadding(): string {
    if (this.safeAreaInsetBottom && this.openDirection === "bottom") {
      return convertDimensionsWidthUnit(this.bottomBarHeight.value as number);
    }
    return "0vp";
  }

  /**
   * 计算顶部安全区内边距
   * @returns 顶部内边距
   */
  private getTopPadding(): string {
    const needTop: boolean =
      this.openDirection === "top" || this.openDirection === "left" || this.openDirection === "right";
    if (needTop && this.topAvoidHeight.value as number > 0) {
      return convertDimensionsWidthUnit(this.topAvoidHeight.value as number);
    }
    return "0vp";
  }

  aboutToAppear(): void {
    this.baseController.hide = (): void => this.init();
    this.init();
  }

  /**
   * 初始化位置（隐藏到屏幕外）
   */
  private init(): void {
    switch (this.openDirection) {
      case "left":
        this.transX = "-100%";
        break;
      case "right":
        this.transX = "100%";
        break;
      case "top":
        this.transY = "-100%";
        break;
      case "bottom":
        this.transY = "100%";
        break;
      default:
        break;
    }
  }

  /**
   * 变换到显示位置
   */
  private trans(): void {
    switch (this.openDirection) {
      case "left":
      case "right":
        this.transX = 0;
        break;
      case "top":
      case "bottom":
        this.transY = 0;
        break;
      default:
        break;
    }
  }

  build() {
    Column() {
      // 上方占位区域（center/bottom 方向时可点击关闭）
      if (this.openDirection === "center" || this.openDirection === "bottom") {
        this.OverlayPlaceholder();
      }
      Row() {
        // 左侧占位区域（center/right 方向时可点击关闭）
        if (this.openDirection === "center" || this.openDirection === "right") {
          this.OverlayPlaceholder();
        }
        // 弹出框主体内容
        Column() {
          // 关闭按钮（顶部位置）
          if (this.closeBtn && (this.closeBtnPosition === "left-top" || this.closeBtnPosition === "right-top")) {
            this.CloseBtnBuilder();
          }
          // 用户自定义内容
          if (this.contentBuilder) {
            this.contentBuilder();
          }
          // 关闭按钮（底部位置）
          if (this.closeBtn && (this.closeBtnPosition === "left-bottom" || this.closeBtnPosition === "right-bottom")) {
            this.CloseBtnBuilder();
          }
        }
        .width(getSizeByUnit(this.popupSize.width))
        .height(getSizeByUnit(this.popupSize.height))
        .backgroundColor(this.bgColor || $r("app.color.tn_bg_color"))
        .borderRadius(this.getResolvedBorderRadius())
        .padding({
          top: this.getTopPadding(),
          bottom: this.getBottomPadding()
        })
        .alignItems(HorizontalAlign.Start)
        .clip(true)
        .translate({
          x: (this.openDirection === "left" || this.openDirection === "right") ? this.transX : "",
          y: (this.openDirection === "top" || this.openDirection === "bottom") ? this.transY : ""
        })
        .animation({ duration: this.baseStyle.animationDuration, curve: Curve.EaseInOut })
        .onAppear(() => {
          setTimeout(() => {
            this.trans();
          }, 100);
        })

        // 右侧占位区域（center/left 方向时可点击关闭）
        if (this.openDirection === "center" || this.openDirection === "left") {
          this.OverlayPlaceholder();
        }
      }
      .width(
        (this.openDirection === "left" || this.openDirection === "center" || this.openDirection === "right")
          ? "100%" : ""
      )
      // 下方占位区域（center/top 方向时可点击关闭）
      if (this.openDirection === "center" || this.openDirection === "top") {
        this.OverlayPlaceholder();
      }
    }
    .height("100%")
    .clip(true)
  }

  /**
   * 遮罩占位区域构建器
   */
  @Builder
  private OverlayPlaceholder(): void {
    Blank()
      .onClick(() => {
        this.onOverlayClick();
      });
  }

  /**
   * 关闭按钮构建器
   */
  @Builder
  private CloseBtnBuilder(): void {
    Row() {
      if (this.closeBtnBuilder) {
        this.closeBtnBuilder();
      } else {
        TnIcon({
          name: "close",
          color: $r("app.color.tn_text_color_secondary"),
          iconSize: convertDimensionsWidthUnit(18, true)
        }).enabled(false);
      }
    }
    .width("100%")
    .padding({
      left: this.baseStyle.spaceXsm,
      right: this.baseStyle.spaceXsm,
      top: this.baseStyle.spaceXsm,
      bottom: this.baseStyle.spaceXsm
    })
    .justifyContent(
      (this.closeBtnPosition === "left-top" || this.closeBtnPosition === "left-bottom")
        ? FlexAlign.Start : FlexAlign.End
    )
    .stateStyles({
      normal: {
        .opacity(1.0)
      },
      pressed: {
        .opacity(0.6)
      }
    })
    .animation({ duration: this.baseStyle.animationDuration })
    .onClick(() => {
      this.onCloseBtnClick();
    });
  }
}

/**
 * TnPopup 弹出框组件
 *
 * @example
 * // 基础用法（中心弹出）
 * TnPopup({
 *   visible: this.showPopup,
 *   $visible: (val: boolean) => { this.showPopup = val; },
 *   contentBuilder: () => { this.MyContent() }
 * })
 *
 * // 从底部弹出
 * TnPopup({
 *   visible: this.showPopup,
 *   $visible: (val: boolean) => { this.showPopup = val; },
 *   openDirection: "bottom",
 *   contentBuilder: () => { this.BottomContent() }
 * })
 */
@ComponentV2
export struct TnPopup {
  /** 全局基础样式 */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /** 是否横屏 */
  @Local isLandscape: TnBaseDataTypeObs = AppStorageV2.connect(TnBaseDataTypeObs, TnAppStorageKey.IS_LANDSCAPE)!;
  /** 顶部规避高度 */
  @Local topAvoidHeight: TnBaseDataTypeObs = AppStorageV2.connect(TnBaseDataTypeObs, TnAppStorageKey.TOP_AVOID_HEIGHT)!;
  /**
   * 控制弹框显示与隐藏
   */
  @Param @Require visible: boolean = false;
  /**
   * 弹框打开方向
   */
  @Param openDirection: TnPopupOpenDirection = "center";
  /**
   * 弹框内容宽度（在 left/right/center 方向有效）
   */
  @Param popupWidth: TnStringNumber = "";
  /**
   * 弹框内容高度（在 top/bottom/center 方向有效）
   */
  @Param popupHeight: TnStringNumber = "";
  /**
   * 弹出框内容的背景颜色
   */
  @Param bgColor: ResourceColor = "";
  /**
   * 弹框内容的圆角
   */
  @Param radius: TnStringNumber = 0;
  /**
   * 是否显示遮罩层
   */
  @Param showOverlay: boolean = true;
  /**
   * 遮罩层透明度（0-1）
   */
  @Param overlayOpacity: number = 0.5;
  /**
   * 点击遮罩层是否关闭弹框
   */
  @Param overlayCloseable: boolean = true;
  /**
   * 是否显示关闭按钮
   */
  @Param closeBtn: boolean = false;
  /**
   * 关闭按钮的位置
   */
  @Param closeBtnPosition: TnPopupCloseBtnPosition = "right-top";
  /**
   * 底部是否开启安全区域（仅 bottom 方向有效）
   */
  @Param safeAreaInsetBottom: boolean = true;
  /**
   * 距离顶部的距离（仅 top/left/right 方向有效）
   */
  @Param top: TnStringNumber = "";
  /**
   * 是否允许返回键关闭
   */
  @Param closeOnBackPress: boolean = true;
  /**
   * 自定义内容
   */
  @BuilderParam contentBuilder: CustomBuilder;
  /**
   * 自定义关闭按钮
   */
  @BuilderParam closeBtnBuilder: CustomBuilder;
  /**
   * 弹框打开事件
   */
  @Event onOpen: () => void = () => {};
  /**
   * 弹框关闭事件
   */
  @Event onClose: () => void = () => {};
  /**
   * 遮罩点击事件
   */
  @Event onOverlayClick: () => void = () => {};
  /**
   * visible 双向绑定回调
   */
  @Event $visible: (visible: boolean) => void = () => {};

  /** 内部控制器 */
  private baseController: TnPopupBaseController = new TnPopupBaseController();
  /** PromptAction 实例 */
  private promptAction = this.getUIContext().getPromptAction();
  /** CustomDialog ID */
  private dialogId: number = 0;

  /**
   * 监听 visible 变化，控制弹框的打开和关闭
   */
  @Monitor("visible")
  async onVisibleChange(): Promise<void> {
    if (this.visible) {
      this.open();
    } else {
      if (this.openDirection !== "center") {
        this.baseController.hide();
        await popupSleep(POPUP_HIDE_DURATION);
      }
      try {
        this.promptAction.closeCustomDialog(this.dialogId);
      } catch (_e) {
        // 忽略关闭时的异常（弹框可能已经被关闭）
      }
    }
  }

  /**
   * 监听横屏变化，重新布局
   */
  @Monitor("isLandscape.value")
  onLandscapeChange(): void {
    if (this.visible) {
      this.$visible(false);
      setTimeout(() => {
        this.$visible(true);
      }, POPUP_HIDE_DURATION * 2);
    }
  }

  /**
   * 计算遮罩颜色
   * @returns 遮罩颜色值
   */
  private getMaskColor(): ResourceColor {
    if (!this.showOverlay) {
      return Color.Transparent;
    }
    return $r("app.color.tn_overlay_bg");
  }

  /**
   * 获取弹框对齐方式
   * @returns DialogAlignment
   */
  private getAlignment(): DialogAlignment {
    switch (this.openDirection) {
      case "left":
        return DialogAlignment.TopStart;
      case "right":
        return DialogAlignment.TopEnd;
      case "top":
        return DialogAlignment.Top;
      case "bottom":
        return DialogAlignment.Bottom;
      default:
        return DialogAlignment.Center;
    }
  }

  /**
   * 打开弹出框
   */
  private async open(): Promise<void> {
    this.dialogId = await this.promptAction.openCustomDialog({
      builder: () => {
        this.DialogContentBuilder();
      },
      width: "100%",
      height: TnUIInitializer.screenHeight,
      backgroundBlurStyle: BlurStyle.NONE,
      cornerRadius: 0,
      alignment: this.getAlignment(),
      offset: { dx: 0, dy: -(this.topAvoidHeight.value as number) },
      isModal: this.showOverlay,
      maskColor: this.getMaskColor(),
      keyboardAvoidMode: KeyboardAvoidMode.DEFAULT,
      keyboardAvoidDistance: LengthMetrics.vp(16),
      immersiveMode: ImmersiveMode.EXTEND,
      onDidAppear: () => {
        this.onOpen();
      },
      onDidDisappear: () => {
        this.onClose();
      },
      onWillDismiss: (dismissDialogAction: DismissDialogAction) => {
        const reason: DismissReason = dismissDialogAction.reason;
        if (reason === DismissReason.PRESS_BACK && this.closeOnBackPress) {
          this.close();
        }
        if (reason === DismissReason.TOUCH_OUTSIDE && this.overlayCloseable) {
          this.close();
        }
      }
    });
  }

  /**
   * 关闭弹出框
   */
  private close(): void {
    this.$visible(false);
  }

  /**
   * Dialog 内容构建器
   */
  @Builder
  private DialogContentBuilder(): void {
    TnPopupContent({
      openDirection: this.openDirection,
      popupWidth: this.popupWidth,
      popupHeight: this.popupHeight,
      bgColor: this.bgColor,
      radius: this.radius !== 0 ? this.radius : this.baseStyle.borderRadiusXxl,
      closeBtn: this.closeBtn,
      closeBtnPosition: this.closeBtnPosition,
      safeAreaInsetBottom: this.safeAreaInsetBottom,
      top: this.top,
      overlayCloseable: this.overlayCloseable,
      baseController: this.baseController,
      contentBuilder: this.contentBuilder,
      closeBtnBuilder: this.closeBtnBuilder,
      onOverlayClick: () => {
        this.onOverlayClick();
        if (this.overlayCloseable) {
          this.close();
        }
      },
      onCloseBtnClick: () => {
        this.close();
      }
    });
  }

  build() {
    // 容器组件，build 为空，逻辑通过 openCustomDialog 实现
  }
}
