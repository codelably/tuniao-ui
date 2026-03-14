/**
 * @file TnBadge 组件类型定义
 * @author JunBin.Yang
 */

import { TnComponentColorType } from "../../common/theme_helpers";

/**
 * 徽标颜色类型（复用组件通用颜色类型）
 */
export type TnBadgeColorType = TnComponentColorType;

/**
 * 徽标尺寸类型
 * - sm: 小尺寸
 * - lg: 大尺寸
 * - xl: 超大尺寸
 * - undefined: 默认尺寸
 */
export type TnBadgeSizeType = "sm" | "lg" | "xl";

/**
 * 徽标定位类型
 * - top-left: 左上角
 * - top-right: 右上角
 * - bottom-left: 左下角
 * - bottom-right: 右下角
 */
export type TnBadgePositionType = "top-left" | "top-right" | "bottom-left" | "bottom-right";

/**
 * 徽标尺寸配置
 */
export interface TnBadgeSizeConfig {
  /** 字体大小（baseStyle 中的属性名） */
  fontSizeKey: string;
  /** 水平内边距(vp) */
  paddingHorizontal: number;
  /** 圆点尺寸(vp) */
  dotSize: number;
  /** 图标尺寸(vp) */
  iconSize: number;
  /** 最小宽度(vp) */
  minWidth: number;
  /** 徽标高度(vp) */
  height: number;
}

/**
 * TnBadge 组件属性接口
 */
export interface TnBadgeProps {
  /** 徽标内容，支持数字、字符串；以 icon- 开头时渲染为图标 */
  value?: string | number;
  /** 最大值，超过时显示 {max}+（仅当 value 为数字时生效） */
  max?: number;
  /** 徽标颜色类型，默认 "danger" */
  type?: TnBadgeColorType;
  /** 是否显示为圆点模式 */
  dot?: boolean;
  /** 当 value 为 0 时是否显示徽标 */
  showZero?: boolean;
  /** 自定义背景色 */
  bgColor?: ResourceColor;
  /** 自定义文字色 */
  textColor?: ResourceColor;
  /** 徽标尺寸 */
  badgeSize?: TnBadgeSizeType;
  /** 自定义字体大小 */
  fontSize?: number | string;
  /** 是否加粗字体 */
  bold?: boolean;
  /** 是否使用绝对定位（配合 defaultBuilder 插槽使用） */
  absolute?: boolean;
  /** 绝对定位位置 */
  badgePosition?: TnBadgePositionType;
  /** 水平偏移量(vp) */
  xOffset?: number;
  /** 垂直偏移量(vp) */
  yOffset?: number;
  /** 徽标点击回调 */
  onBadgeClick?: () => void;
}
