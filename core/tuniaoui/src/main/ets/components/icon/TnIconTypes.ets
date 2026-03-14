/**
 * @file TnIcon 组件类型定义
 * @author JunBin.Yang
 */

import { TnComponentColorType } from "../../common/theme_helpers";

/**
 * 图标主题颜色类型（复用组件通用颜色类型）
 */
export type TnIconColorType = TnComponentColorType;

/**
 * TnIcon 组件属性接口
 */
export interface TnIconProps {
  /**
   * 图标名称或图片路径（必填）
   * - 字体图标：传入图标名称（如 "home"、"user"）
   * - 图片图标：传入图片路径或网络地址（包含 "/" 或以 "http" 开头）
   */
  name: string;
  /**
   * 自定义图标颜色
   */
  color?: ResourceColor;
  /**
   * 主题颜色类型，与 color 互斥时 color 优先
   */
  type?: TnIconColorType;
  /**
   * 图标尺寸，支持数字（跟随全局单位）或字符串（如 "30fp"）
   */
  iconSize?: number | string;
  /**
   * 是否加粗
   */
  bold?: boolean;
  /**
   * 图标圆角
   */
  iconRadius?: Length;
  /**
   * 图标背景色，设置后图标会包裹在带背景色的容器中
   */
  bgColor?: ResourceColor;
  /**
   * 图标内间距，配合 bgColor 使用，控制图标与背景边缘的距离
   * 不设置时默认为 baseStyle.spaceXsm (8vp)
   */
  iconPadding?: number | Padding;
  /**
   * 自定义字体名称（覆盖默认 TnFont）
   */
  customFontName?: string;
  /**
   * 点击回调
   */
  onIconClick?: () => void;
}
