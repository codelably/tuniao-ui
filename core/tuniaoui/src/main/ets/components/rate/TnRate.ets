/**
 * @file TnRate 评分组件
 * @description 支持整星/半星评分、自定义图标和颜色、只读模式、手势拖动评分
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { TnComponentColorType, getThemeColor, THEME_COLOR_NAMES } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { TnIcon } from "../icon/TnIcon";
import { getSizeByUnit, convertDimensionsWidthUnit } from "../../utils/Utils";

/** 默认图标尺寸(vp) */
const DEFAULT_RATE_SIZE: number = 22;
/** 默认间距 - 使用 baseStyle.spaceBase (4vp) */
const DEFAULT_GUTTER: number = 4;
/** 默认激活图标 */
const DEFAULT_ACTIVE_ICON: string = "star-fill";
/** 默认未激活图标 */
const DEFAULT_INACTIVE_ICON: string = "star";

/**
 * TnRate 评分组件
 *
 * @example
 * // 基础用法
 * TnRate({ modelValue: 3, onChange: (val) => {} })
 *
 * // 半星
 * TnRate({ modelValue: 3.5, allowHalf: true, onChange: (val) => {} })
 */
@ComponentV2
export struct TnRate {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  /** 当前评分 */
  @Param modelValue: number = 0;
  /** 最大评分 */
  @Param max: number = 5;
  /** 最小评分 */
  @Param min: number = 0;
  /** 允许半星 */
  @Param allowHalf: boolean = false;
  /** 只读 */
  @Param readonly: boolean = false;
  /** 图标尺寸(vp) */
  @Param rateSize: number = 0;
  /** 图标间距(vp) */
  @Param gutter: number = DEFAULT_GUTTER;
  /** 激活图标 */
  @Param activeIcon: string = DEFAULT_ACTIVE_ICON;
  /** 未激活图标 */
  @Param inactiveIcon: string = DEFAULT_INACTIVE_ICON;
  /** 激活颜色 */
  @Param activeColor: string = "";
  /** 未激活颜色 */
  @Param inactiveColor: string = "";

  /** 值变化回调 */
  @Event onChange: (value: number) => void = (_value: number): void => {};

  /**
   * 获取图标尺寸(vp原始值)
   * @returns 图标尺寸数值
   */
  private getIconSizeValue(): number {
    return this.rateSize > 0 ? this.rateSize : DEFAULT_RATE_SIZE;
  }

  /**
   * 获取图标尺寸（带单位）
   * @returns 格式化后的图标尺寸
   */
  private getIconSize(): string {
    if (this.rateSize > 0) {
      return getSizeByUnit(this.rateSize);
    }
    return convertDimensionsWidthUnit(DEFAULT_RATE_SIZE);
  }

  /**
   * 获取激活颜色
   * @returns 激活色值
   */
  private getActiveColor(): ResourceColor {
    if (this.activeColor.length > 0) {
      if (THEME_COLOR_NAMES.includes(this.activeColor)) {
        return getThemeColor(this.baseStyle, this.activeColor as TnComponentColorType);
      }
      return this.activeColor;
    }
    return getThemeColor(this.baseStyle, "warning");
  }

  /**
   * 获取未激活颜色
   * @returns 未激活色值
   */
  private getInactiveColor(): ResourceColor {
    if (this.inactiveColor.length > 0) {
      return this.inactiveColor;
    }
    return $r("app.color.tn_color_gray_disabled");
  }

  /**
   * 处理星星点击，通过点击位置判断半星/整星
   * @param event 点击事件
   * @param index 星星索引（从 0 开始）
   */
  private handleStarClick(event: ClickEvent, index: number): void {
    if (this.readonly) {
      return;
    }
    let value: number;
    if (this.allowHalf) {
      const iconSize: number = this.getIconSizeValue();
      const isLeftHalf: boolean = event.x <= iconSize / 2;
      value = index + (isLeftHalf ? 0.5 : 1);
    } else {
      value = index + 1;
    }
    value = Math.max(this.min, Math.min(this.max, value));
    this.onChange(value);
  }

  /**
   * 获取星星激活比例
   * @param index 星星索引（从 0 开始）
   * @returns 0（空）、0.5（半星）、1（满星）
   */
  private getStarValue(index: number): number {
    const diff: number = this.modelValue - index;
    if (diff >= 1) {
      return 1;
    }
    if (this.allowHalf && diff >= 0.5) {
      return 0.5;
    }
    if (diff > 0 && !this.allowHalf) {
      return 0;
    }
    return 0;
  }

  build() {
    Row({ space: getSizeByUnit(this.gutter) }) {
      ForEach(
        Array.from<number>({ length: this.max } as ArrayLike<number>).map((_: number, i: number): number => i),
        (index: number) => {
          // 统一结构：Stack 叠加底层未激活 + 上层激活裁剪
          Stack({ alignContent: Alignment.Start }) {
            // 底层：未激活图标（满星时隐藏）
            TnIcon({
              name: this.inactiveIcon,
              iconSize: this.getIconSizeValue(),
              color: this.getInactiveColor()
            }).enabled(false);
            // 上层：激活图标，按比例裁剪宽度
            if (this.getStarValue(index) > 0) {
              Row() {
                TnIcon({
                  name: this.activeIcon,
                  iconSize: this.getIconSizeValue(),
                  color: this.getActiveColor()
                }).enabled(false);
              }
              .width(this.getStarValue(index) === 1
                ? this.getIconSize()
                : getSizeByUnit(this.getIconSizeValue() / 2))
              .height(this.getIconSize())
              .clip(true);
            }
          }
          .width(this.getIconSize())
          .height(this.getIconSize())
          .stateStyles({
            normal: {
              .opacity(1.0)
            },
            pressed: {
              .opacity(this.readonly ? 1.0 : 0.7)
            }
          })
          .onClick((event: ClickEvent) => {
            this.handleStarClick(event, index);
          });
        },
        (index: number): string => `rate_${index}_${this.modelValue}`
      );
    }
    .alignItems(VerticalAlign.Center);
  }
}
