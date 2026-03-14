/**
 * @file 组件共用主题工具函数
 * @description 提供统一的颜色类型、主题色获取、浅色变种、字体大小映射等共用逻辑
 * @author JunBin.Yang
 */

import { ColorVariant } from "../theme-chalk/color.type";
import { TnUIBaseStyleType } from "../theme-chalk/index.type";
import { ShadowLevelConfig } from "../theme-chalk/shadow.type";

/**
 * 组件通用颜色类型
 * - primary: 主色
 * - success: 成功色
 * - warning: 警告色
 * - danger: 危险色
 * - info: 信息色
 */
export type TnComponentColorType = "primary" | "success" | "warning" | "danger" | "info";

/** 主题色名列表 */
export const THEME_COLOR_NAMES: string[] = ["primary", "success", "warning", "danger", "info"];

/**
 * 根据颜色类型获取对应的主题主色值
 * @param baseStyle 全局基础样式
 * @param type 颜色类型
 * @returns 对应的 ResourceColor
 */
export function getThemeColor(baseStyle: TnUIBaseStyleType, type: TnComponentColorType): ResourceColor {
  switch (type) {
    case "primary":
      return baseStyle.primary.value();
    case "success":
      return baseStyle.success.value();
    case "warning":
      return baseStyle.warning.value();
    case "danger":
      return baseStyle.danger.value();
    case "info":
      return baseStyle.info.value();
    default:
      return baseStyle.primary.value();
  }
}

/**
 * 根据颜色类型获取对应的浅色变种（light_9）
 * @param baseStyle 全局基础样式
 * @param type 颜色类型
 * @returns 对应颜色的 light_9 变种值
 */
export function getThemeColorLight(baseStyle: TnUIBaseStyleType, type: TnComponentColorType, suffix: ColorVariant = "light_9"): ResourceColor {
  switch (type) {
    case "primary":
      return baseStyle.primary.variant(suffix);
    case "success":
      return baseStyle.success.variant(suffix);
    case "warning":
      return baseStyle.warning.variant(suffix);
    case "danger":
      return baseStyle.danger.variant(suffix);
    case "info":
      return baseStyle.info.variant(suffix);
    default:
      return baseStyle.primary.variant(suffix);
  }
}

/**
 * 根据字体大小属性名获取 baseStyle 中对应的字体大小值
 * @param baseStyle 全局基础样式
 * @param key 字体大小属性名（如 "fontSizeXs"、"fontSizeSm" 等）
 * @returns 字体大小字符串
 */
export function getFontSizeByKey(baseStyle: TnUIBaseStyleType, key: string): string {
  switch (key) {
    case "fontSizeXxs":
      return baseStyle.fontSizeXxs;
    case "fontSizeXs":
      return baseStyle.fontSizeXs;
    case "fontSizeSm":
      return baseStyle.fontSizeSm;
    case "fontSizeLg":
      return baseStyle.fontSizeLg;
    case "fontSizeXl":
      return baseStyle.fontSizeXl;
    case "fontSizeXXl":
      return baseStyle.fontSizeXXl;
    case "fontSizeXXXl":
      return baseStyle.fontSizeXXXl;
    case "fontSizeXXXXl":
      return baseStyle.fontSizeXXXXl;
    default:
      return baseStyle.fontSize;
  }
}

/**
 * 阴影级别类型
 */
export type TnShadowLevelType = "sm" | "default" | "md" | "lg";

/**
 * 根据阴影级别获取完整的 ShadowOptions
 * @param baseStyle 全局基础样式
 * @param level 阴影级别
 * @returns ShadowOptions 对象，颜色统一使用 tn_shadow_light 资源色
 */
export function getTnShadow(baseStyle: TnUIBaseStyleType, level: TnShadowLevelType): ShadowOptions {
  let config: ShadowLevelConfig;
  switch (level) {
    case "sm":
      config = baseStyle.shadowSm;
      break;
    case "md":
      config = baseStyle.shadowMd;
      break;
    case "lg":
      config = baseStyle.shadowLg;
      break;
    default:
      config = baseStyle.shadowDefault;
      break;
  }
  return {
    radius: config.radius,
    color: $r("app.color.tn_shadow_light"),
    offsetX: config.offsetX,
    offsetY: config.offsetY
  };
}
