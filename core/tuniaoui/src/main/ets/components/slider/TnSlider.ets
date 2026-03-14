/**
 * @file TnSlider 滑块组件
 * @description 基于系统 Slider 组件封装，支持主题色映射和自定义样式
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { TnComponentColorType, getThemeColor, THEME_COLOR_NAMES } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { getSizeByUnit } from "../../utils/Utils";

/**
 * TnSlider 滑块组件
 *
 * @example
 * // 基础用法
 * TnSlider({ modelValue: 50, onChange: (val) => {} })
 *
 * // 自定义颜色和步长
 * TnSlider({ modelValue: 30, step: 10, activeColor: "success", onChange: (val) => {} })
 */
@ComponentV2
export struct TnSlider {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  /** 绑定值 */
  @Param modelValue: number = 0;
  /** 最小值 */
  @Param min: number = 0;
  /** 最大值 */
  @Param max: number = 100;
  /** 步长 */
  @Param step: number = 1;
  /** 禁用 */
  @Param disabled: boolean = false;
  /** 激活轨道颜色 */
  @Param activeColor: string = "";
  /** 未激活轨道颜色 */
  @Param inactiveColor: string = "";
  /** 滑块尺寸(vp) */
  @Param sliderBarSize: number = 0;
  /** 轨道高度(vp) */
  @Param sliderHeight: number = 0;

  /** 值变化回调 */
  @Event onChange: (value: number) => void = (_value: number): void => {};
  /** 拖动中值变化回调 */
  @Event onChanging: (value: number) => void = (_value: number): void => {};

  /**
   * 获取激活轨道颜色
   * @returns 激活色值
   */
  private getActiveColor(): ResourceColor {
    if (this.activeColor.length > 0) {
      if (THEME_COLOR_NAMES.includes(this.activeColor)) {
        return getThemeColor(this.baseStyle, this.activeColor as TnComponentColorType);
      }
      return this.activeColor;
    }
    return getThemeColor(this.baseStyle, "primary");
  }

  /**
   * 获取未激活轨道颜色
   * @returns 未激活色值
   */
  private getInactiveColor(): ResourceColor {
    if (this.inactiveColor.length > 0) {
      return this.inactiveColor;
    }
    return $r("app.color.tn_color_gray_disabled");
  }

  build() {
    Slider({
      value: this.modelValue,
      min: this.min,
      max: this.max,
      step: this.step,
      style: SliderStyle.OutSet
    })
      .width("100%")
      .selectedColor(this.getActiveColor())
      .trackColor(this.getInactiveColor())
      .blockSize(this.sliderBarSize > 0 ? { width: getSizeByUnit(this.sliderBarSize), height: getSizeByUnit(this.sliderBarSize) } : undefined)
      .trackThickness(this.sliderHeight > 0 ? getSizeByUnit(this.sliderHeight) : undefined)
      .enabled(!this.disabled)
      .opacity(this.disabled ? 0.5 : 1.0)
      .animation({ duration: this.baseStyle.animationDuration })
      .onChange((value: number, mode: SliderChangeMode) => {
        // step 对齐
        const alignedValue: number = Math.round(value / this.step) * this.step;
        if (mode === SliderChangeMode.End || mode === SliderChangeMode.Click) {
          this.onChange(alignedValue);
        } else {
          this.onChanging(alignedValue);
        }
      });
  }
}
