/**
 * @file TnSwitch 开关组件
 * @description 支持多种颜色、形状、尺寸、文字/图标显示、加载/禁用状态
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { TnComponentColorType, getThemeColor, THEME_COLOR_NAMES, getFontSizeByKey, getTnShadow } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { TnIcon } from "../icon/TnIcon";
import { TnLoading } from "../loading/TnLoading";
import { TnSwitchShapeType, TnSwitchValueType } from "./TnSwitchTypes";
import { getSizeByUnit, convertDimensionsWidthUnit } from "../../utils/Utils";

/** 开关默认宽度(vp) */
const DEFAULT_SWITCH_WIDTH: number = 48;
/** 开关默认高度(vp) */
const DEFAULT_SWITCH_HEIGHT: number = 26;
/** 滑块边距(vp) */
const THUMB_MARGIN: number = 3;
/** 开关宽高比系数(宽 = 高 x 此值) */
const SWITCH_ASPECT_RATIO: number = 1.85;
/** 图标占滑块尺寸的比例 */
const ICON_SIZE_RATIO: number = 0.6;

/**
 * TnSwitch 开关组件
 *
 * @example
 * // 基础用法
 * TnSwitch({ modelValue: true, onChange: (val) => {} })
 *
 * // 自定义颜色
 * TnSwitch({ modelValue: true, activeColor: "success" })
 */
@ComponentV2
export struct TnSwitch {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  /** 绑定值 */
  @Param modelValue: TnSwitchValueType = false;
  /** 激活时的值 */
  @Param activeValue: TnSwitchValueType = true;
  /** 未激活时的值 */
  @Param inactiveValue: TnSwitchValueType = false;
  /** 激活颜色 */
  @Param activeColor: string = "";
  /** 未激活颜色 */
  @Param inactiveColor: string = "";
  /** 激活文字 */
  @Param activeText: string = "";
  /** 未激活文字 */
  @Param inactiveText: string = "";
  /** 激活图标 */
  @Param activeIcon: string = "";
  /** 未激活图标 */
  @Param inactiveIcon: string = "";
  /** 形状 */
  @Param shape: TnSwitchShapeType = "round";
  /** 尺寸(vp)，0 为默认 */
  @Param switchSize: number = 0;
  /** 禁用 */
  @Param disabled: boolean = false;
  /** 加载中 */
  @Param loading: boolean = false;

  /** 值变化回调 */
  @Event onChange: (value: TnSwitchValueType) => void = (_value: TnSwitchValueType): void => {};

  /** 滑块偏移量 */
  @Local private thumbOffset: number = 0;

  aboutToAppear(): void {
    this.updateThumbOffset(false);
  }

  /**
   * 监听 modelValue 变化，同步更新滑块偏移量
   */
  @Monitor("modelValue")
  onModelValueChange(): void {
    this.updateThumbOffset(true);
  }

  /**
   * 判断当前是否激活
   * @returns 是否激活
   */
  private isActive(): boolean {
    return this.modelValue === this.activeValue;
  }

  /**
   * 获取开关宽度(vp原始值)
   * @returns 宽度数值
   */
  private getSwitchWidthValue(): number {
    if (this.switchSize > 0) {
      return this.switchSize * SWITCH_ASPECT_RATIO;
    }
    return DEFAULT_SWITCH_WIDTH;
  }

  /**
   * 获取开关高度(vp原始值)
   * @returns 高度数值
   */
  private getSwitchHeightValue(): number {
    if (this.switchSize > 0) {
      return this.switchSize;
    }
    return DEFAULT_SWITCH_HEIGHT;
  }

  /**
   * 获取滑块尺寸(vp原始值)
   * @returns 滑块尺寸数值
   */
  private getThumbSizeValue(): number {
    return this.getSwitchHeightValue() - THUMB_MARGIN * 2;
  }

  /**
   * 获取开关宽度（带单位）
   * @returns 格式化后的宽度
   */
  private getSwitchWidth(): string {
    if (this.switchSize > 0) {
      return getSizeByUnit(this.switchSize * 1.85);
    }
    return convertDimensionsWidthUnit(DEFAULT_SWITCH_WIDTH);
  }

  /**
   * 获取开关高度（带单位）
   * @returns 格式化后的高度
   */
  private getSwitchHeight(): string {
    if (this.switchSize > 0) {
      return getSizeByUnit(this.switchSize);
    }
    return convertDimensionsWidthUnit(DEFAULT_SWITCH_HEIGHT);
  }

  /**
   * 获取滑块尺寸（带单位）
   * @returns 格式化后的滑块尺寸
   */
  private getThumbSize(): string {
    return convertDimensionsWidthUnit(this.getThumbSizeValue());
  }

  /**
   * 获取圆角（带单位）
   * @returns 格式化后的圆角值
   */
  private getBorderRadius(): string {
    if (this.shape === "square") {
      return this.baseStyle.borderRadius;
    }
    return this.baseStyle.borderRadiusMax;
  }

  /**
   * 获取激活背景色
   * @returns 激活色值
   */
  private getActiveBgColor(): ResourceColor {
    if (this.activeColor.length > 0) {
      if (THEME_COLOR_NAMES.includes(this.activeColor)) {
        return getThemeColor(this.baseStyle, this.activeColor as TnComponentColorType);
      }
      return this.activeColor;
    }
    return getThemeColor(this.baseStyle, "primary");
  }

  /**
   * 获取未激活背景色
   * @returns 未激活色值
   */
  private getInactiveBgColor(): ResourceColor {
    if (this.inactiveColor.length > 0) {
      return this.inactiveColor;
    }
    return $r("app.color.tn_color_gray_disabled");
  }

  /**
   * 更新滑块偏移量（含边距，不依赖 margin）
   * @param animate 是否使用动画
   */
  private updateThumbOffset(animate: boolean): void {
    const activeOffset: number = this.getSwitchWidthValue() - this.getThumbSizeValue() - THUMB_MARGIN;
    const targetOffset: number = this.isActive() ? activeOffset : THUMB_MARGIN;
    if (animate) {
      animateTo({ duration: this.baseStyle.animationDuration, curve: Curve.EaseInOut }, () => {
        this.thumbOffset = targetOffset;
      });
    } else {
      this.thumbOffset = targetOffset;
    }
  }

  /**
   * 切换开关状态
   */
  private toggle(): void {
    if (this.disabled || this.loading) {
      return;
    }
    const newValue: TnSwitchValueType = this.isActive() ? this.inactiveValue : this.activeValue;
    this.onChange(newValue);
  }

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // 文字内容层
      this.SwitchContentBuilder();

      // 滑块
      Row() {
        if (this.loading) {
          TnLoading({ mode: "flower", loadingSize: "sm" });
        } else if (this.isActive() && this.activeIcon.length > 0) {
          TnIcon({ name: this.activeIcon, iconSize: this.getThumbSizeValue() * ICON_SIZE_RATIO }).enabled(false);
        } else if (!this.isActive() && this.inactiveIcon.length > 0) {
          TnIcon({ name: this.inactiveIcon, iconSize: this.getThumbSizeValue() * ICON_SIZE_RATIO }).enabled(false);
        }
      }
      .width(this.getThumbSize())
      .height(this.getThumbSize())
      .borderRadius(this.shape === "square" ? this.baseStyle.borderRadiusSm : this.getThumbSize())
      .backgroundColor($r("app.color.tn_color_white"))
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .translate({ x: this.thumbOffset })
      .touchable(false)
      .shadow(getTnShadow(this.baseStyle, "sm"));
    }
    .width(this.getSwitchWidth())
    .height(this.getSwitchHeight())
    .borderRadius(this.getBorderRadius())
    .backgroundColor(this.isActive() ? this.getActiveBgColor() : this.getInactiveBgColor())
    .clip(true)
    .animation({ duration: this.baseStyle.animationDuration })
    .opacity(this.disabled ? 0.5 : 1.0)
    .stateStyles({
      normal: {
        .opacity(this.disabled ? 0.5 : 1.0)
      },
      pressed: {
        .opacity(this.disabled ? 0.5 : 0.7)
      }
    })
    .onClick(() => {
      this.toggle();
    });
  }

  /**
   * 开关内文字/图标
   */
  @Builder
  private SwitchContentBuilder(): void {
    Row() {
      if (this.isActive() && this.activeText.length > 0) {
        Text(this.activeText)
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
          .fontColor($r("app.color.tn_color_white"))
          .lineHeight(this.baseStyle.lineHeightXs)
          .maxLines(1);
      } else if (!this.isActive() && this.inactiveText.length > 0) {
        Text(this.inactiveText)
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
          .fontColor($r("app.color.tn_color_white"))
          .lineHeight(this.baseStyle.lineHeightXs)
          .maxLines(1);
      }
    }
    .width("100%")
    .height("100%")
    .alignItems(VerticalAlign.Center)
    .justifyContent(this.isActive() ? FlexAlign.Start : FlexAlign.End)
    .padding({
      left: this.isActive() ? this.baseStyle.spaceXsm : (THUMB_MARGIN + this.getThumbSizeValue() + THUMB_MARGIN),
      right: this.isActive() ? (THUMB_MARGIN + this.getThumbSizeValue() + THUMB_MARGIN) : this.baseStyle.spaceXsm
    })
    .hitTestBehavior(HitTestMode.None);
  }
}
