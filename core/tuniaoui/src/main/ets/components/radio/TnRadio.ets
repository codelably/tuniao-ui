/**
 * @file TnRadio 单选框组件
 * @description 支持独立使用和在 RadioGroup 中使用，支持自定义颜色、尺寸、边框等
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { TnComponentColorType, getThemeColor, THEME_COLOR_NAMES } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import tnEmitter from "../../utils/EventEmitter";
import { getSizeByUnit, convertDimensionsWidthUnit } from "../../utils/Utils";
import {
  TnRadioValueType,
  TN_RADIO_GROUP_EVENT,
  getTnRadioGroupEventName,
  TnRadioGroupConfig
} from "./TnRadioTypes";

/** 默认单选框尺寸(vp) */
const DEFAULT_RADIO_SIZE: number = 20;

/**
 * TnRadio 单选框组件
 *
 * @example
 * // 在 RadioGroup 中使用
 * TnRadioGroup({ group: "fruit", modelValue: "a", onChange: (val) => {} }) {
 *   TnRadio({ group: "fruit", label: "a" }) { Text("选项A") }
 *   TnRadio({ group: "fruit", label: "b" }) { Text("选项B") }
 * }
 */
@ComponentV2
export struct TnRadio {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  /** 分组标识，与 TnRadioGroup 的 group 保持一致 */
  @Param group: string = "";
  /** 单选框的值 */
  @Param label: TnRadioValueType = "";
  /** 禁用 */
  @Param disabled: boolean = false;
  /** 禁用标签点击切换 */
  @Param labelDisabled: boolean = false;
  /** 激活颜色 */
  @Param activeColor: string = "";
  /** 尺寸(vp) */
  @Param radioSize: number = 0;
  /** 显示边框 */
  @Param showBorder: boolean = false;

  /** 值变化回调（独立使用时） */
  @Event onChange: (value: TnRadioValueType) => void = (_value: TnRadioValueType): void => {};

  /** 内容插槽 */
  @BuilderParam defaultBuilder: CustomBuilder;

  /** 组件唯一 ID（用于事件注销） */
  @Local private uniId: string = "";
  /** 是否选中 */
  @Local private isChecked: boolean = false;
  /** 组下发的禁用状态 */
  @Local private groupDisabled: boolean = false;
  /** 组下发的激活颜色 */
  @Local private groupActiveColor: string = "";
  /** 组下发的尺寸 */
  @Local private groupSize: number = 0;

  aboutToAppear(): void {
    this.uniId = `tn_radio_${Date.now()}_${Math.floor(Math.random() * 10000)}`;
    if (this.group.length > 0) {
      this.registerToGroup();
    }
  }

  aboutToDisappear(): void {
    if (this.group.length > 0) {
      tnEmitter.off(
        getTnRadioGroupEventName(TN_RADIO_GROUP_EVENT.CONFIG, this.group),
        this.uniId
      );
    }
  }

  /**
   * 注册到 RadioGroup，监听组配置下发事件
   */
  private registerToGroup(): void {
    tnEmitter.on(
      getTnRadioGroupEventName(TN_RADIO_GROUP_EVENT.CONFIG, this.group),
      this.uniId,
      (config: TnRadioGroupConfig): void => {
        this.isChecked = config.selectedValue === this.label;
        this.groupDisabled = config.disabled;
        this.groupActiveColor = config.activeColor;
        this.groupSize = config.size;
      }
    );
  }

  /**
   * 获取是否禁用
   * @returns 是否禁用
   */
  private isDisabled(): boolean {
    return this.disabled || this.groupDisabled;
  }

  /**
   * 获取实际尺寸(vp原始值)
   * @returns 尺寸数值
   */
  private getResolvedSizeValue(): number {
    if (this.radioSize > 0) {
      return this.radioSize;
    }
    if (this.groupSize > 0) {
      return this.groupSize;
    }
    return DEFAULT_RADIO_SIZE;
  }

  /**
   * 获取实际尺寸（带单位）
   * @returns 格式化后的尺寸
   */
  private getResolvedSize(): string {
    if (this.radioSize > 0) {
      return getSizeByUnit(this.radioSize);
    }
    if (this.groupSize > 0) {
      return getSizeByUnit(this.groupSize);
    }
    return convertDimensionsWidthUnit(DEFAULT_RADIO_SIZE);
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
    if (this.isDisabled() || this.isChecked) {
      return;
    }
    if (this.group.length > 0) {
      tnEmitter.emit(
        getTnRadioGroupEventName(TN_RADIO_GROUP_EVENT.ITEM_CLICK, this.group),
        this.label
      );
    } else {
      this.onChange(this.label);
    }
  }

  build() {
    Row({ space: this.baseStyle.spaceXsm }) {
      // 单选框图标
      Row() {
        if (this.isChecked) {
          Row()
            .width(getSizeByUnit(this.getResolvedSizeValue() * 0.5))
            .height(getSizeByUnit(this.getResolvedSizeValue() * 0.5))
            .borderRadius(this.baseStyle.borderRadiusMax)
            .backgroundColor(this.getResolvedActiveColor());
        }
      }
      .width(this.getResolvedSize())
      .height(this.getResolvedSize())
      .borderRadius(this.baseStyle.borderRadiusMax)
      .borderWidth(this.isChecked ? 2 : 1)
      .borderColor(this.isChecked ? this.getResolvedActiveColor() : $r("app.color.tn_color_gray"))
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
    .borderColor(this.isChecked ? this.getResolvedActiveColor() : $r("app.color.tn_color_gray_disabled"))
    .borderRadius(this.showBorder ? this.baseStyle.borderRadius : 0);
  }
}
