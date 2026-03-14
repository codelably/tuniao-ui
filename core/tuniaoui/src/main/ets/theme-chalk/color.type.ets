import { mixWithWhite, mixWithBlack } from '../utils/ColorUtils';

/**
 * 颜色类型枚举
 */
export enum COLOR_TYPE {
  /**
   * 主要的
   */
  PRIMARY = 'primary',
  /**
   * 成功
   */
  SUCCESS = 'success',
  /**
   * 警告
   */
  WARNING = 'warning',
  /**
   * 危险
   */
  DANGER = 'danger',
  /**
   * 错误
   */
  ERROR = 'error',
  /**
   * 信息
   */
  INFO = 'info',
}

/**
 * 颜色变种
 */
export type ColorVariant = "light_3" | "light_5" | "light_7" | "light_8" | "light_9" | "dark_2";

/**
 * 内置颜色类型
 */
export type BuiltInColorType = "red" | "purplered" | "purple" | "bluepurple" | "aquablue" | "blue" | "indigo" | "cyan" | "teal" | "green"
  | "yellowgreen" | "lime" | "yellow" | "orangeyellow" | "orange" | "orangered" | "brown" | "grey" | "gray";

/**
 * 颜色类型
 */
export type ColorType = `${COLOR_TYPE}` | `${COLOR_TYPE}-${ColorVariant}`;

/**
 * 渐变背景类型
 */
export type GradientBgType = ColorType | `${BuiltInColorType}` | `${BuiltInColorType}-light` | `${BuiltInColorType}-single` |
  `cool-1` | `cool-2` | `cool-3` | `cool-4` | `cool-5` | `cool-6` | `cool-7` | `cool-8` | `cool-9` | `cool-10` |
  `cool-11` | `cool-12` | `cool-13` | `cool-14` | `cool-15` | `cool-16`;

/**
 * 主题色包装器
 */
@ObservedV2
export class ResourceColorWrapper {
  @Trace private baseName: string;

  constructor(type: COLOR_TYPE | string) {
    this.baseName = `tn_color_${type}`;
  }

  value(): ResourceColor {
    return $r(`app.color.${this.baseName}`);
  }

  variant(suffix: ColorVariant): ResourceColor {
    return $r(`app.color.${this.baseName}_${suffix}`);
  }
}

export interface ColorData {
  primary: ResourceColorWrapper;
  success: ResourceColorWrapper;
  warning: ResourceColorWrapper;
  danger: ResourceColorWrapper;
  error: ResourceColorWrapper;
  info: ResourceColorWrapper;
}

/**
 * 自定义颜色包装器，支持任意 hex 颜色值
 * 通过颜色计算动态生成变种色，无需依赖预定义资源文件
 */
@ObservedV2
export class CustomColorWrapper extends ResourceColorWrapper {
  /**
   * 自定义的十六进制颜色值
   */
  @Trace customHexColor: string;

  /**
   * @param hexColor 十六进制颜色字符串，如 "#FF6B6B"
   */
  constructor(hexColor: string) {
    super("custom");
    this.customHexColor = hexColor;
  }

  /**
   * 返回自定义颜色值
   * @returns 自定义 hex 颜色字符串
   */
  value(): ResourceColor {
    return this.customHexColor;
  }

  /**
   * 根据变种后缀计算并返回变种色
   * @param suffix 颜色变种后缀
   * @returns 计算后的变种色 hex 字符串
   */
  variant(suffix: ColorVariant): ResourceColor {
    switch (suffix) {
      case "light_3":
        return mixWithWhite(this.customHexColor, 0.3);
      case "light_5":
        return mixWithWhite(this.customHexColor, 0.5);
      case "light_7":
        return mixWithWhite(this.customHexColor, 0.7);
      case "light_8":
        return mixWithWhite(this.customHexColor, 0.8);
      case "light_9":
        return mixWithWhite(this.customHexColor, 0.9);
      case "dark_2":
        return mixWithBlack(this.customHexColor, 0.2);
      default:
        return this.customHexColor;
    }
  }
}
