/**
 * @file TnNoticeBar 通知栏组件
 * @description 支持水平滚动、垂直轮播、可关闭、链接模式，自定义图标等
 * @author JunBin.Yang
 */

import { AppStorageV2, componentUtils } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { getFontSizeByKey, getThemeColor, getThemeColorLight } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { convertDimensionsWidthUnit, getSizeByUnit } from "../../utils/Utils";
import { ContextUtil } from "../../utils/ContextUtil";
import { TnIcon } from "../icon/TnIcon";
import { TnNoticeBarDirection, TnNoticeBarMode } from "./TnNoticeBarTypes";

/** 通知栏默认高度(vp) */
const NOTICE_BAR_DEFAULT_HEIGHT: number = 40;
/** 图标默认尺寸(vp) */

const ICON_DEFAULT_SIZE: number = 18;
/** 图标区域最小宽度(vp) */
const ICON_AREA_MIN_WIDTH: number = 24;

/**
 * TnNoticeBar 通知栏组件
 *
 * @example
 * // 基础用法
 * TnNoticeBar({ text: "这是一条通知消息" })
 *
 * // 可关闭
 * TnNoticeBar({ text: "可关闭通知", mode: "closeable" })
 *
 * // 垂直轮播
 * TnNoticeBar({ data: ["通知1", "通知2", "通知3"], scrollDirection: "vertical" })
 *
 * // 自定义左侧图标
 * TnNoticeBar({ text: "带图标通知", leftIcon: "sound" })
 */
@ComponentV2
export struct TnNoticeBar {
  /**
   * 全局基础样式（响应式绑定，主题切换时自动更新）
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /**
   * 通知文本（水平模式使用）
   */
  @Param text: string = "";
  /**
   * 通知数据列表（垂直模式使用）
   */
  @Param data: string[] = [];
  /**
   * 滚动方向
   */
  @Param scrollDirection: TnNoticeBarDirection = "horizontal";
  /**
   * 通知栏模式
   */
  @Param mode: TnNoticeBarMode | undefined = undefined;
  /**
   * 自定义背景色
   */
  @Param bgColor: ResourceColor | undefined = undefined;
  /**
   * 自定义文字色
   */
  @Param textColor: ResourceColor | undefined = undefined;
  /**
   * 自定义文字大小
   */
  @Param fontSize: number | string | undefined = undefined;
  /**
   * 左侧图标名称
   */
  @Param leftIcon: string = "";
  /**
   * 左侧图标颜色
   */
  @Param leftIconColor: ResourceColor | undefined = undefined;
  /**
   * 左侧图标大小
   */
  @Param leftIconSize: number = ICON_DEFAULT_SIZE;
  /**
   * 右侧图标名称（优先级高于 mode 自动图标）
   */
  @Param rightIcon: string = "";
  /**
   * 右侧图标颜色
   */
  @Param rightIconColor: ResourceColor | undefined = undefined;
  /**
   * 右侧图标大小
   */
  @Param rightIconSize: number = ICON_DEFAULT_SIZE;
  /**
   * 通知栏高度
   */
  @Param barHeight: number | string = NOTICE_BAR_DEFAULT_HEIGHT;
  /**
   * 是否开启滚动播放（undefined 时文字溢出自动开启）
   */
  @Param scrollable: boolean | undefined = undefined;
  /**
   * 是否换行显示（为 true 时滚动不生效）
   */
  @Param wrapable: boolean = false;
  /**
   * 滚动速度（vp/s）
   */
  @Param speed: number = 60;
  /**
   * 动画开始延迟时间（秒）
   */
  @Param delay: number = 1;
  /**
   * 垂直滚动间隔（秒）
   */
  @Param verticalInterval: number = 3;
  /**
   * 是否循环播放
   */
  @Param loop: boolean = true;
  /**
   * 圆角大小
   */
  @Param radius: number | string = 0;
  /**
   * 左右内边距
   */
  @Param leftRightPadding: number | string | undefined = undefined;
  /**
   * 自定义左侧内容插槽
   */
  @BuilderParam leftBuilder: CustomBuilder;
  /**
   * 自定义右侧内容插槽
   */
  @BuilderParam rightBuilder: CustomBuilder;
  /**
   * 通知栏点击回调
   */
  @Event onBarClick: () => void = () => {};
  /**
   * 关闭通知栏回调
   */
  @Event onClose: () => void = () => {};
  /**
   * 垂直模式下文本点击回调
   */
  @Event onTextClick: (index: number) => void = () => {};
  /**
   * 左侧图标点击回调
   */
  @Event onLeftIconClick: () => void = () => {};
  /**
   * 右侧图标点击回调
   */
  @Event onRightIconClick: () => void = () => {};

  /** 组件唯一标识 */
  @Local private uniId: number = 0;
  /** 是否可见 */
  @Local private isShow: boolean = true;
  /** 水平滚动偏移量 */
  @Local private transX: number = 0;
  /** 动画时长（秒） */
  @Local private animDuration: number = 0;
  /** 内部滚动启用标志 */
  @Local private innerScrollable: boolean = false;
  /** 容器宽度 */
  private contentWidth: number = 0;
  /** 文本宽度 */
  private textWidth: number = 0;
  /** 延迟启动定时器 */
  private startTimer: number = 0;
  /** UIContext 引用 */
  private uiContext: UIContext | undefined = undefined;

  aboutToAppear(): void {
    this.uniId = this.getUniqueId();
  }

  aboutToDisappear(): void {
    clearTimeout(this.startTimer);
  }

  /**
   * 监听文本变化，重新初始化滚动
   */
  @Monitor("text")
  onTextChange(): void {
    this.initScroll();
  }

  /**
   * 获取解析后的背景色
   * @returns 背景颜色
   */
  private getResolvedBgColor(): ResourceColor {
    if (this.bgColor !== undefined) {
      return this.bgColor;
    }
    return getThemeColorLight(this.baseStyle, "warning", "light_9");
  }

  /**
   * 获取解析后的文字色
   * @returns 文字颜色
   */
  private getResolvedTextColor(): ResourceColor {
    if (this.textColor !== undefined) {
      return this.textColor;
    }
    return getThemeColor(this.baseStyle, "warning");
  }

  /**
   * 获取解析后的左侧图标颜色
   * @returns 图标颜色
   */
  private getResolvedLeftIconColor(): ResourceColor {
    if (this.leftIconColor !== undefined) {
      return this.leftIconColor;
    }
    return this.getResolvedTextColor();
  }

  /**
   * 获取解析后的右侧图标颜色
   * @returns 图标颜色
   */
  private getResolvedRightIconColor(): ResourceColor {
    if (this.rightIconColor !== undefined) {
      return this.rightIconColor;
    }
    return this.getResolvedTextColor();
  }

  /**
   * 获取解析后的字体大小
   * @returns 字体大小字符串
   */
  private getResolvedFontSize(): string {
    if (this.fontSize !== undefined) {
      if (typeof this.fontSize === "number") {
        return getSizeByUnit(this.fontSize, true);
      }
      return this.fontSize;
    }
    return getFontSizeByKey(this.baseStyle, "fontSize");
  }

  /**
   * 获取解析后的左右内边距
   * @returns 内边距字符串
   */
  private getResolvedPadding(): string {
    if (this.leftRightPadding !== undefined) {
      if (typeof this.leftRightPadding === "number") {
        return getSizeByUnit(this.leftRightPadding);
      }
      return this.leftRightPadding;
    }
    return this.baseStyle.spaceMlg;
  }

  /**
   * 获取右侧图标名称
   * @returns 图标名称，不显示时返回空字符串
   */
  private getRightIconName(): string {
    if (this.rightIcon) {
      return this.rightIcon;
    }
    if (this.mode === "closeable") {
      return "close";
    }
    if (this.mode === "link") {
      return "right";
    }
    return "";
  }

  /**
   * 是否显示右侧图标区域
   * @returns 是否显示
   */
  private hasRightIcon(): boolean {
    return this.getRightIconName().length > 0;
  }

  /**
   * 初始化水平滚动动画
   */
  private initScroll(): void {
    if (!this.isShow) {
      return;
    }
    clearTimeout(this.startTimer);
    this.transX = 0;
    this.animDuration = 0;
    if (this.scrollable === false || this.wrapable) {
      return;
    }
    this.startTimer = setTimeout(() => {
      this.measureAndStartScroll();
    }, 50);
  }

  /**
   * 测量文本和容器宽度，启动滚动
   */
  private measureAndStartScroll(): void {
    if (this.uiContext === undefined) {
      this.uiContext = ContextUtil.getUICtx();
    }
    const ctx: UIContext = this.uiContext;
    const containerId: string = `tn_notice_bar_${this.uniId}`;
    const textId: string = `tn_notice_bar_text_${this.uniId}`;
    try {
      const containerInfo: componentUtils.ComponentInfo = ctx.getComponentUtils().getRectangleById(containerId);
      const textInfo: componentUtils.ComponentInfo = ctx.getComponentUtils().getRectangleById(textId);
      this.contentWidth = ctx.px2vp(containerInfo.size.width);
      this.textWidth = ctx.px2vp(textInfo.size.width);
    } catch (e) {
      return;
    }
    this.resetScroll();
  }

  /**
   * 重置并启动滚动动画
   */
  private resetScroll(): void {
    this.startTimer = setTimeout(() => {
      if (this.textWidth > this.contentWidth && this.scrollable === undefined) {
        this.innerScrollable = true;
      }
      const shouldScroll: boolean = this.scrollable === true || this.innerScrollable;
      if (shouldScroll) {
        this.animDuration = this.textWidth / this.speed;
        this.transX = -this.textWidth;
      }
    }, this.delay * 1000);
  }

  /**
   * 滚动动画结束回调，实现循环
   */
  private onScrollFinish(): void {
    if (!this.loop) {
      return;
    }
    this.transX = this.contentWidth;
    this.animDuration = 0;
    setTimeout(() => {
      this.animDuration = (this.contentWidth + this.textWidth) / this.speed;
      this.transX = -this.textWidth;
    }, 100);
  }

  /**
   * 处理右侧图标点击
   */
  private handleRightIconClick(): void {
    if (this.mode === "closeable") {
      this.isShow = false;
      this.onClose();
    }
    this.onRightIconClick();
  }

  build() {
    if (this.isShow) {
      Row() {
        // 左侧区域
        if (this.leftIcon) {
          Row() {
            TnIcon({
              name: this.leftIcon,
              color: this.getResolvedLeftIconColor(),
              iconSize: this.leftIconSize
            }).enabled(false);
          }
          .constraintSize({ minWidth: convertDimensionsWidthUnit(ICON_AREA_MIN_WIDTH) })
          .margin({ right: this.baseStyle.spaceBase })
          .onClick(() => {
            this.onLeftIconClick();
          });
        } else if (this.leftBuilder) {
          this.leftBuilder();
        }

        // 内容区域
        if (this.scrollDirection === "vertical") {
          this.VerticalContentBuilder();
        } else {
          this.HorizontalContentBuilder();
        }

        // 右侧区域
        if (this.hasRightIcon()) {
          Row() {
            TnIcon({
              name: this.getRightIconName(),
              color: this.getResolvedRightIconColor(),
              iconSize: this.rightIconSize
            }).enabled(false);
          }
          .constraintSize({ minWidth: convertDimensionsWidthUnit(ICON_AREA_MIN_WIDTH) })
          .justifyContent(FlexAlign.End)
          .margin({ left: this.baseStyle.spaceBase })
          .onClick(() => {
            this.handleRightIconClick();
          });
        } else if (this.rightBuilder) {
          this.rightBuilder();
        }
      }
      .width("100%")
      .height(this.wrapable ? "auto" : getSizeByUnit(this.barHeight))
      .constraintSize({ minHeight: this.wrapable ? getSizeByUnit(this.barHeight) : "" })
      .backgroundColor(this.getResolvedBgColor())
      .borderRadius(getSizeByUnit(this.radius))
      .padding({
        left: this.getResolvedPadding(),
        right: this.getResolvedPadding(),
        top: this.wrapable ? this.baseStyle.spaceXsm : 0,
        bottom: this.wrapable ? this.baseStyle.spaceXsm : 0
      })
      .alignItems(VerticalAlign.Center)
      .clip(true)
      .stateStyles({
        normal: {
          .opacity(1.0)
        },
        pressed: {
          .opacity(0.7)
        }
      })
      .onClick(() => {
        this.onBarClick();
      })
      .onAreaChange(() => {
        if (this.scrollDirection === "horizontal" && !this.wrapable) {
          this.initScroll();
        }
      })
      .transition(TransitionEffect.OPACITY)
      .animation({ duration: this.baseStyle.animationDuration });
    }
  }

  /**
   * 水平滚动内容构建器
   */
  @Builder
  private HorizontalContentBuilder(): void {
    Scroll() {
      Text(this.text)
        .width(this.scrollable === false || this.wrapable ? "100%" : "auto")
        .fontColor(this.getResolvedTextColor())
        .fontSize(this.getResolvedFontSize())
        .lineHeight(this.baseStyle.lineHeightSm)
        .maxLines(this.wrapable ? undefined : 1)
        .textOverflow(this.wrapable ? undefined : { overflow: TextOverflow.Ellipsis })
        .id(`tn_notice_bar_text_${this.uniId}`)
        .translate({ x: this.transX })
        .animation({
          duration: this.animDuration * 1000,
          curve: Curve.Linear,
          onFinish: (): void => this.onScrollFinish()
        });
    }
    .layoutWeight(1)
    .scrollable(ScrollDirection.None)
    .align(Alignment.Start)
    .id(`tn_notice_bar_${this.uniId}`);
  }

  /**
   * 垂直轮播内容构建器
   */
  @Builder
  private VerticalContentBuilder(): void {
    Swiper() {
      ForEach(this.data, (item: string, index: number) => {
        Text(item)
          .width("100%")
          .fontColor(this.getResolvedTextColor())
          .fontSize(this.getResolvedFontSize())
          .lineHeight(this.baseStyle.lineHeightSm)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .onClick(() => {
            this.onTextClick(index);
          });
      }, (item: string, index: number) => `${index}_${item}`);
    }
    .layoutWeight(1)
    .height("100%")
    .vertical(true)
    .interval(this.verticalInterval * 1000)
    .autoPlay(true)
    .loop(this.loop)
    .indicator(false)
    .disableSwipe(true);
  }
}
