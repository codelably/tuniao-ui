/**
 * @file TnCheckbox 复选框组件
 * @description 支持独立使用和在 CheckboxGroup 中使用，支持半选、自定义颜色、边框、形状等
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { TnComponentColorType, getThemeColor, THEME_COLOR_NAMES } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { TnIcon } from "../icon/TnIcon";
import tnEmitter from "../../utils/EventEmitter";
import { getSizeByUnit, convertDimensionsWidthUnit } from "../../utils/Utils";
import {
  TnCheckboxValueType,
  TnCheckboxShape,
  TN_CHECKBOX_GROUP_EVENT,
  getTnCheckboxGroupEventName,
  TnCheckboxGroupConfig
} from "./TnCheckboxTypes";

/** 默认复选框尺寸(vp) */
const DEFAULT_CHECKBOX_SIZE: number = 20;

/**
 * TnCheckbox 复选框组件
 *
 * @example
 * // 在 CheckboxGroup 中使用
 * TnCheckboxGroup({ group: "fruits", modelValue: ["a"], onChange: (val) => {} }) {
 *   TnCheckbox({ group: "fruits", label: "a" }) { Text("选项A") }
 *   TnCheckbox({ group: "fruits", label: "b" }) { Text("选项B") }
 * }
 */
@ComponentV2
export struct TnCheckbox {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  /** 分组标识，与 TnCheckboxGroup 的 group 保持一致 */
  @Param group: string = "";
  /** 复选框的值 */
  @Param label: TnCheckboxValueType = "";
  /** 禁用 */
  @Param disabled: boolean = false;
  /** 禁用标签点击切换 */
  @Param labelDisabled: boolean = false;
  /** 激活颜色 */
  @Param activeColor: string = "";
  /** 尺寸(vp) */
  @Param checkboxSize: number = 0;
  /** 显示边框 */
  @Param showBorder: boolean = false;
  /** 半选状态 */
  @Param indeterminate: boolean = false;
  /** 选中图标形状 */
  @Param shape: TnCheckboxShape = TnCheckboxShape.SQUARE;

  /** 值变化回调 */
  @Event onChange: (value: TnCheckboxValueType) => void = (_value: TnCheckboxValueType): void => {};

  /** 内容插槽 */
  @BuilderParam defaultBuilder: CustomBuilder;

  /** 组件唯一 ID */
  @Local private uniId: string = "";
  /** 组下发的选中值列表 */
  @Local private groupSelectedValues: Array<string | number> = [];
  /** 组下发的禁用状态 */
  @Local private groupDisabled: boolean = false;
  /** 组下发的激活颜色 */
  @Local private groupActiveColor: string = "";
  /** 组下发的尺寸 */
  @Local private groupSize: number = 0;
  /** 组下发的最大选择数 */
  @Local private groupMax: number = Infinity;
  /** 独立使用时的内部选中状态 */
  @Local private checkedLocal: boolean = false;

  aboutToAppear(): void {
    this.uniId = `tn_checkbox_${Date.now()}_${Math.floor(Math.random() * 10000)}`;
    if (this.group.length > 0) {
      this.registerToGroup();
    }
  }

  aboutToDisappear(): void {
    if (this.group.length > 0) {
      tnEmitter.off(
        getTnCheckboxGroupEventName(TN_CHECKBOX_GROUP_EVENT.VALUE_CHANGE, this.group),
        this.uniId
      );
      tnEmitter.off(
        getTnCheckboxGroupEventName(TN_CHECKBOX_GROUP_EVENT.CONFIG, this.group),
        this.uniId
      );
    }
  }

  /**
   * 注册到 CheckboxGroup
   */
  private registerToGroup(): void {
    tnEmitter.on(
      getTnCheckboxGroupEventName(TN_CHECKBOX_GROUP_EVENT.VALUE_CHANGE, this.group),
      this.uniId,
      (values: Array<string | number>): void => {
        this.groupSelectedValues = values;
      }
    );
    tnEmitter.on(
      getTnCheckboxGroupEventName(TN_CHECKBOX_GROUP_EVENT.CONFIG, this.group),
      this.uniId,
      (config: TnCheckboxGroupConfig): void => {
        this.groupSelectedValues = config.selectedValues;
        this.groupDisabled = config.disabled;
        this.groupActiveColor = config.activeColor;
        this.groupSize = config.size;
        this.groupMax = config.max;
      }
    );
  }

  /**
   * 判断是否选中
   * @returns 是否选中
   */
  private isChecked(): boolean {
    if (this.group.length > 0) {
      const labelValue: string | number = typeof this.label === "boolean"
        ? (this.label ? 1 : 0)
        : this.label as (string | number);
      return this.groupSelectedValues.includes(labelValue);
    }
    return this.checkedLocal;
  }

  /**
   * 获取是否禁用
   * @returns 是否禁用
   */
  private isDisabled(): boolean {
    if (this.disabled || this.groupDisabled) {
      return true;
    }
    if (this.group.length > 0 && !this.isChecked() && this.groupSelectedValues.length >= this.groupMax) {
      return true;
    }
    return false;
  }

  /**
   * 获取实际尺寸(vp原始值)
   * @returns 尺寸数值
   */
  private getResolvedSizeValue(): number {
    if (this.checkboxSize > 0) {
      return this.checkboxSize;
    }
    if (this.groupSize > 0) {
      return this.groupSize;
    }
    return DEFAULT_CHECKBOX_SIZE;
  }

  /**
   * 获取实际尺寸（带单位）
   * @returns 格式化后的尺寸
   */
  private getResolvedSize(): string {
    if (this.checkboxSize > 0) {
      return getSizeByUnit(this.checkboxSize);
    }
    if (this.groupSize > 0) {
      return getSizeByUnit(this.groupSize);
    }
    return convertDimensionsWidthUnit(DEFAULT_CHECKBOX_SIZE);
  }

  /**
   * 获取激活颜色
   * @returns 激活色值
   */
  private getResolvedActiveColor(): ResourceColor {
    const color: string = this.activeColor.length > 0 ? this.activeColor : this.groupActiveColor;
    if (color.length > 0) {
      if (THEME_COLOR_NAMES.includes(color)) {
        return getThemeColor(this.baseStyle, color as TnComponentColorType);
      }
      return color;
    }
    return getThemeColor(this.baseStyle, "primary");
  }

  /**
   * 处理点击事件
   */
  private handleClick(): void {
    if (this.isDisabled()) {
      return;
    }
    if (this.group.length > 0) {
      tnEmitter.emit(
        getTnCheckboxGroupEventName(TN_CHECKBOX_GROUP_EVENT.ITEM_CLICK, this.group),
        this.label
      );
    } else {
      this.checkedLocal = !this.checkedLocal;
      this.onChange(this.label);
    }
  }

  /**
   * 是否为圆形形状
   * @returns 是否圆形
   */
  private isCircleShape(): boolean {
    return this.shape === TnCheckboxShape.CIRCLE;
  }

  build() {
    Row({ space: this.baseStyle.spaceXsm }) {
      // 复选框图标
      Row() {
        if (this.indeterminate) {
          // 半选状态：显示横线
          Row()
            .width(getSizeByUnit(this.getResolvedSizeValue() * 0.6))
            .height(convertDimensionsWidthUnit(Math.max(2, this.getResolvedSizeValue() * 0.1)))
            .backgroundColor($r("app.color.tn_color_white"));
        } else if (this.isChecked()) {
          if (this.isCircleShape()) {
            // 圆形形状：显示圆点
            Row()
              .width(getSizeByUnit(this.getResolvedSizeValue() * 0.5))
              .height(getSizeByUnit(this.getResolvedSizeValue() * 0.5))
              .borderRadius(this.baseStyle.borderRadiusMax)
              .backgroundColor($r("app.color.tn_color_white"));
          } else {
            // 方形形状：显示勾
            TnIcon({ name: "success", iconSize: this.getResolvedSizeValue() * 0.7, color: $r("app.color.tn_color_white") }).enabled(false);
          }
        }
      }
      .width(this.getResolvedSize())
      .height(this.getResolvedSize())
      .borderRadius(this.isCircleShape() ? this.baseStyle.borderRadiusMax : this.baseStyle.borderRadius)
      .borderWidth(this.isChecked() || this.indeterminate ? 0 : 1)
      .borderColor($r("app.color.tn_color_gray"))
      .backgroundColor(this.isChecked() || this.indeterminate ? this.getResolvedActiveColor() : Color.Transparent)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .animation({ duration: this.baseStyle.animationDuration })
      .stateStyles({
        normal: {
          .opacity(1.0)
        },
        pressed: {
          .opacity(0.7)
        }
      })
      .onClick(() => {
        this.handleClick();
      });

      // 标签内容
      if (this.defaultBuilder) {
        Row() {
          this.defaultBuilder();
        }
        .stateStyles({
          normal: {
            .opacity(1.0)
          },
          pressed: {
            .opacity(0.7)
          }
        })
        .onClick(() => {
          if (!this.labelDisabled) {
            this.handleClick();
          }
        });
      }
    }
    .alignItems(VerticalAlign.Center)
    .opacity(this.isDisabled() ? 0.5 : 1.0)
    .padding(this.showBorder ? this.baseStyle.spaceXsm : 0)
    .borderWidth(this.showBorder ? 1 : 0)
    .borderColor(this.isChecked() ? this.getResolvedActiveColor() : $r("app.color.tn_color_gray_disabled"))
    .borderRadius(this.showBorder ? this.baseStyle.borderRadius : 0);
  }
}
