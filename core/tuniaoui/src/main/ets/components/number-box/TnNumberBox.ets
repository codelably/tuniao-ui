/**
 * @file TnNumberBox 步进器组件
 * @description 数字增减输入框，支持步长、范围限制、长按连续增减等
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { getThemeColor, getFontSizeByKey } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { TnIcon } from "../icon/TnIcon";
import { getSizeByUnit, convertDimensionsWidthUnit } from "../../utils/Utils";
import { getHexColorByResoure, mixWithBlack } from "../../utils/ColorUtils";

/** 默认按钮尺寸(vp) */
const DEFAULT_BTN_SIZE: number = 28;
/** 默认输入框宽度(vp) */
const DEFAULT_INPUT_WIDTH: number = 40;
/** 默认长按间隔(ms) */
const DEFAULT_LONG_PRESS_INTERVAL: number = 250;

/**
 * TnNumberBox 步进器组件
 *
 * @example
 * // 基础用法
 * TnNumberBox({ modelValue: 1, onChange: (val) => {} })
 *
 * // 设置范围和步长
 * TnNumberBox({ modelValue: 5, min: 0, max: 10, step: 2, onChange: (val) => {} })
 */
@ComponentV2
export struct TnNumberBox {
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
  /** 禁用输入框编辑 */
  @Param inputDisabled: boolean = false;
  /** 启用长按连续增减 */
  @Param longPress: boolean = true;
  /** 长按间隔(ms) */
  @Param longPressInterval: number = DEFAULT_LONG_PRESS_INTERVAL;
  /** 尺寸(vp) */
  @Param componentSize: number = 0;
  /** 背景色 */
  @Param bgColor: ResourceColor = $r("app.color.tn_color_gray_light");
  /** 文字颜色 */
  @Param textColor: ResourceColor = $r("app.color.tn_text_color_primary");

  /** 值变化回调 */
  @Event onChange: (value: number) => void = (_value: number): void => {};

  /** 长按定时器 ID */
  @Local private longPressTimerId: number = -1;

  /**
   * 获取按钮尺寸（带单位）
   * @returns 格式化后的按钮尺寸
   */
  private getBtnSize(): string {
    if (this.componentSize > 0) {
      return getSizeByUnit(this.componentSize);
    }
    return convertDimensionsWidthUnit(DEFAULT_BTN_SIZE);
  }

  /**
   * 获取按钮尺寸(vp原始值)
   * @returns 按钮尺寸数值
   */
  private getBtnSizeValue(): number {
    return this.componentSize > 0 ? this.componentSize : DEFAULT_BTN_SIZE;
  }

  /**
   * 是否可以减少
   * @returns 是否可以减
   */
  private canDecrease(): boolean {
    return !this.disabled && this.modelValue > this.min;
  }

  /**
   * 是否可以增加
   * @returns 是否可以加
   */
  private canIncrease(): boolean {
    return !this.disabled && this.modelValue < this.max;
  }

  /**
   * 减少
   */
  private decrease(): void {
    if (!this.canDecrease()) {
      return;
    }
    const newValue: number = Math.max(this.min, this.modelValue - this.step);
    this.onChange(newValue);
  }

  /**
   * 增加
   */
  private increase(): void {
    if (!this.canIncrease()) {
      return;
    }
    const newValue: number = Math.min(this.max, this.modelValue + this.step);
    this.onChange(newValue);
  }

  /**
   * 开始长按
   * @param isIncrease 是否为增加方向
   */
  private startLongPress(isIncrease: boolean): void {
    if (!this.longPress) {
      return;
    }
    this.longPressTimerId = setInterval(() => {
      if (isIncrease) {
        this.increase();
      } else {
        this.decrease();
      }
    }, this.longPressInterval);
  }

  /**
   * 停止长按
   */
  private stopLongPress(): void {
    if (this.longPressTimerId >= 0) {
      clearInterval(this.longPressTimerId);
      this.longPressTimerId = -1;
    }
  }

  /**
   * 处理输入框提交
   * @param value 输入的值
   */
  private handleInputSubmit(value: string): void {
    let numValue: number = Number(value);
    if (isNaN(numValue)) {
      return;
    }
    numValue = Math.max(this.min, Math.min(this.max, numValue));
    // step 对齐
    numValue = Math.round(numValue / this.step) * this.step;
    this.onChange(numValue);
  }

  aboutToDisappear(): void {
    this.stopLongPress();
  }

  build() {
    Row({ space: this.baseStyle.spaceMini }) {
      // 减号按钮
      Row() {
        TnIcon({
          name: "reduce",
          iconSize: this.getBtnSizeValue() * 0.55,
          color: this.canDecrease() ? $r("app.color.tn_text_color_primary") : $r("app.color.tn_color_gray_disabled")
        }).enabled(false);
      }
      .width(this.getBtnSize())
      .height(this.getBtnSize())
      .borderRadius(this.baseStyle.borderRadius)
      .backgroundColor(this.bgColor)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .opacity(this.canDecrease() ? 1.0 : 0.5)
      .stateStyles({
        normal: {
          .backgroundColor(this.bgColor)
        },
        pressed: {
          .backgroundColor(this.canDecrease() ? mixWithBlack(getHexColorByResoure(this.bgColor)) : this.bgColor)
        }
      })
      .animation({ duration: this.baseStyle.animationDuration })
      .onClick(() => {
        this.decrease();
      })
      .gesture(
        LongPressGesture()
          .onAction(() => {
            this.startLongPress(false);
          })
          .onActionEnd(() => {
            this.stopLongPress();
          })
      );

      // 输入框
      TextInput({ text: `${this.modelValue}` })
        .width(convertDimensionsWidthUnit(DEFAULT_INPUT_WIDTH))
        .height(this.getBtnSize())
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
        .fontColor(this.textColor)
        .textAlign(TextAlign.Center)
        .backgroundColor(this.bgColor)
        .borderRadius(this.baseStyle.borderRadius)
        .padding(0)
        .type(InputType.Number)
        .enabled(!this.disabled && !this.inputDisabled)
        .onSubmit(() => {
          this.handleInputSubmit(`${this.modelValue}`);
        });

      // 加号按钮
      Row() {
        TnIcon({
          name: "add",
          iconSize: this.getBtnSizeValue() * 0.55,
          color: this.canIncrease() ? $r("app.color.tn_text_color_primary") : $r("app.color.tn_color_gray_disabled")
        }).enabled(false);
      }
      .width(this.getBtnSize())
      .height(this.getBtnSize())
      .borderRadius(this.baseStyle.borderRadius)
      .backgroundColor(this.bgColor)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .opacity(this.canIncrease() ? 1.0 : 0.5)
      .stateStyles({
        normal: {
          .backgroundColor(this.bgColor)
        },
        pressed: {
          .backgroundColor(this.canIncrease() ? mixWithBlack(getHexColorByResoure(this.bgColor)) : this.bgColor)
        }
      })
      .animation({ duration: this.baseStyle.animationDuration })
      .onClick(() => {
        this.increase();
      })
      .gesture(
        LongPressGesture()
          .onAction(() => {
            this.startLongPress(true);
          })
          .onActionEnd(() => {
            this.stopLongPress();
          })
      );
    }
    .alignItems(VerticalAlign.Center)
    .opacity(this.disabled ? 0.5 : 1.0);
  }
}
