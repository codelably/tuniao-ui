/**
 * @file TnBadge 徽标组件
 * @description 支持数字、文本、图标、圆点等多种模式，可配合绝对定位包裹子内容使用
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { getFontSizeByKey, getThemeColor } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { getHexColorByResoure, mixWithBlack } from "../../utils/ColorUtils";
import { convertDimensionsWidthUnit, getSizeByUnit } from "../../utils/Utils";
import { TnIcon } from "../icon/TnIcon";
import {
  TnBadgeColorType,
  TnBadgePositionType,
  TnBadgeSizeConfig,
  TnBadgeSizeType
} from "./TnBadgeTypes";

/** 图标前缀标识 */
const ICON_PREFIX: string = "icon-";

/**
 * 根据尺寸类型获取徽标尺寸配置
 * @param size 尺寸类型
 * @returns 尺寸配置
 */
function getBadgeSizeConfig(size: TnBadgeSizeType | undefined): TnBadgeSizeConfig {
  switch (size) {
    case "sm":
      return {
        fontSizeKey: "fontSizeXs",
        paddingHorizontal: 3,
        dotSize: 6,
        iconSize: 8,
        minWidth: 14,
        height: 14
      };
    case "lg":
      return {
        fontSizeKey: "fontSizeSm",
        paddingHorizontal: 5,
        dotSize: 10,
        iconSize: 12,
        minWidth: 20,
        height: 20
      };
    case "xl":
      return {
        fontSizeKey: "fontSize",
        paddingHorizontal: 6,
        dotSize: 12,
        iconSize: 14,
        minWidth: 24,
        height: 24
      };
    default:
      return {
        fontSizeKey: "fontSizeXs",
        paddingHorizontal: 4,
        dotSize: 8,
        iconSize: 10,
        minWidth: 16,
        height: 16
      };
  }
}

/**
 * TnBadge 徽标组件
 *
 * @example
 * // 数字徽标
 * TnBadge({ value: 99 })
 *
 * // 圆点徽标
 * TnBadge({ dot: true })
 *
 * // 最大值限制
 * TnBadge({ value: 200, max: 99 })
 *
 * // 配合子内容绝对定位
 * TnBadge({ value: 5, absolute: true }) {
 *   Image($r("app.media.avatar"))
 * }
 */
@ComponentV2
export struct TnBadge {
  /**
   * 全局基础样式（响应式绑定，主题切换时自动更新）
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /**
   * 徽标内容
   */
  @Param value: string | number | undefined = undefined;
  /**
   * 最大值
   */
  @Param max: number | undefined = undefined;
  /**
   * 徽标颜色类型
   */
  @Param type: TnBadgeColorType = "danger";
  /**
   * 圆点模式
   */
  @Param dot: boolean = false;
  /**
   * 值为 0 时是否显示
   */
  @Param showZero: boolean = true;
  /**
   * 自定义背景色
   */
  @Param bgColor: ResourceColor | undefined = undefined;
  /**
   * 自定义文字色
   */
  @Param textColor: ResourceColor | undefined = undefined;
  /**
   * 徽标尺寸
   */
  @Param badgeSize: TnBadgeSizeType | undefined = undefined;
  /**
   * 自定义字体大小
   */
  @Param fontSize: number | string | undefined = undefined;
  /**
   * 是否加粗字体
   */
  @Param bold: boolean = false;
  /**
   * 是否使用绝对定位
   */
  @Param absolute: boolean = true;
  /**
   * 绝对定位位置
   */
  @Param badgePosition: TnBadgePositionType = "top-right";
  /**
   * 水平偏移量(vp)
   */
  @Param xOffset: number = 0;
  /**
   * 垂直偏移量(vp)
   */
  @Param yOffset: number = 0;
  /**
   * 徽标点击回调
   */
  @Event onBadgeClick: () => void = () => {
  };
  /**
   * 自定义内容插槽
   */
  @BuilderParam defaultBuilder: CustomBuilder;

  /**
   * 获取当前尺寸配置
   * @returns 尺寸配置
   */
  private getSizeConfig(): TnBadgeSizeConfig {
    return getBadgeSizeConfig(this.badgeSize);
  }

  /**
   * 判断徽标内容是否为图标模式
   * @returns 是否为图标
   */
  private isIcon(): boolean {
    if (typeof this.value === "string") {
      return this.value.startsWith(ICON_PREFIX);
    }
    return false;
  }

  /**
   * 获取图标名称（去除 icon- 前缀）
   * @returns 图标名称
   */
  private getIconName(): string {
    if (typeof this.value === "string") {
      return this.value.substring(ICON_PREFIX.length);
    }
    return "";
  }

  /**
   * 判断徽标是否应该显示
   * @returns 是否显示
   */
  private shouldShow(): boolean {
    if (this.dot) {
      return true;
    }
    if (this.value === undefined) {
      return false;
    }
    if (typeof this.value === "number" && this.value === 0 && !this.showZero) {
      return false;
    }
    if (typeof this.value === "string" && this.value.length === 0) {
      return false;
    }
    return true;
  }

  /**
   * 获取显示文本（处理 max 逻辑）
   * @returns 显示文本
   */
  private getDisplayContent(): string {
    if (typeof this.value === "number") {
      if (this.max !== undefined && this.max > 0 && this.value > this.max) {
        return `${this.max}+`;
      }
      return `${this.value}`;
    }
    if (typeof this.value === "string") {
      return this.value;
    }
    return "";
  }

  /**
   * 获取解析后的背景色
   * @returns 背景色
   */
  private getResolvedBgColor(): ResourceColor {
    if (this.bgColor !== undefined) {
      return this.bgColor;
    }
    return getThemeColor(this.baseStyle, this.type);
  }

  /**
   * 获取解析后的文字色
   * @returns 文字色
   */
  private getResolvedTextColor(): ResourceColor {
    if (this.textColor !== undefined) {
      return this.textColor;
    }
    return $r("app.color.tn_color_white");
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
    const config: TnBadgeSizeConfig = this.getSizeConfig();
    return getFontSizeByKey(this.baseStyle, config.fontSizeKey);
  }

  /**
   * 获取绝对定位的边缘位置
   * @returns 边缘定位对象
   */
  private getPositionEdges(): Edges {
    switch (this.badgePosition) {
      case "top-left":
        return { left: this.xOffset, top: this.yOffset };
      case "top-right":
        return { right: this.xOffset, top: this.yOffset };
      case "bottom-left":
        return { left: this.xOffset, bottom: this.yOffset };
      case "bottom-right":
        return { right: this.xOffset, bottom: this.yOffset };
      default:
        return { right: this.xOffset, top: this.yOffset };
    }
  }

  /**
   * 获取绝对定位的平移量（使徽标中心对齐锚点）
   * @returns 平移配置
   */
  private getTranslateOptions(): TranslateOptions {
    switch (this.badgePosition) {
      case "top-left":
        return { x: "-50%", y: "-50%" };
      case "top-right":
        return { x: "50%", y: "-50%" };
      case "bottom-left":
        return { x: "-50%", y: "50%" };
      case "bottom-right":
        return { x: "50%", y: "50%" };
      default:
        return { x: "50%", y: "-50%" };
    }
  }

  build() {
    if (this.defaultBuilder) {
      // 有子内容时作为包裹容器
      Row() {
        this.defaultBuilder();
        if (this.shouldShow()) {
          this.BadgeContent();
        }
      }
    } else {
      // 无子内容时仅展示徽标本身
      if (this.shouldShow()) {
        this.BadgeContent();
      }
    }
  }

  /**
   * 徽标内容构建器
   */
  @Builder
  private BadgeContent(): void {
    if (this.dot) {
      this.DotBuilder();
    } else if (this.isIcon()) {
      this.IconBuilder();
    } else {
      this.TextBuilder();
    }
  }

  /**
   * 圆点模式构建器
   */
  @Builder
  private DotBuilder(): void {
    Text()
      .width(convertDimensionsWidthUnit(this.getSizeConfig().dotSize))
      .aspectRatio(1)
      .borderRadius(this.baseStyle.borderRadiusMax)
      .backgroundColor(this.getResolvedBgColor())
      .position(this.absolute ? this.getPositionEdges() : undefined)
      .translate(this.absolute ? this.getTranslateOptions() : undefined)
      .onClick(() => {
        this.onBadgeClick();
      });
  }

  /**
   * 图标模式构建器
   */
  @Builder
  private IconBuilder(): void {
    Row() {
      TnIcon({
        name: this.getIconName(),
        color: this.getResolvedTextColor(),
        iconSize: this.getSizeConfig().iconSize
      });
    }
    .constraintSize({ minWidth: convertDimensionsWidthUnit(this.getSizeConfig().minWidth) })
    .height(convertDimensionsWidthUnit(this.getSizeConfig().height))
    .padding({
      left: convertDimensionsWidthUnit(this.getSizeConfig().paddingHorizontal),
      right: convertDimensionsWidthUnit(this.getSizeConfig().paddingHorizontal)
    })
    .backgroundColor(this.getResolvedBgColor())
    .borderRadius(this.baseStyle.borderRadiusMax)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .position(this.absolute ? this.getPositionEdges() : undefined)
    .translate(this.absolute ? this.getTranslateOptions() : undefined)
    .onClick(() => {
      this.onBadgeClick();
    });
  }

  /**
   * 文本/数字模式构建器
   */
  @Builder
  private TextBuilder(): void {
    Text(this.getDisplayContent())
      .constraintSize({ minWidth: convertDimensionsWidthUnit(this.getSizeConfig().minWidth) })
      .height(convertDimensionsWidthUnit(this.getSizeConfig().height))
      .padding({
        left: convertDimensionsWidthUnit(this.getSizeConfig().paddingHorizontal),
        right: convertDimensionsWidthUnit(this.getSizeConfig().paddingHorizontal)
      })
      .fontSize(this.getResolvedFontSize())
      .fontColor(this.getResolvedTextColor())
      .fontWeight(this.bold ? FontWeight.Bold : FontWeight.Normal)
      .textAlign(TextAlign.Center)
      .lineHeight(this.baseStyle.lineHeightXs)
      .maxLines(1)
      .backgroundColor(this.getResolvedBgColor())
      .borderRadius(this.baseStyle.borderRadiusMax)
      .position(this.absolute ? this.getPositionEdges() : undefined)
      .translate(this.absolute ? this.getTranslateOptions() : undefined)
      .onClick(() => {
        this.onBadgeClick();
      });
  }
}
