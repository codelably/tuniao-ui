/**
 * @file TnButton 组件类型定义
 * @author JunBin.Yang
 */

import { TnComponentColorType } from "../../common/theme_helpers";

/**
 * 按钮颜色类型（复用组件通用颜色类型）
 */
export type TnButtonColorType = TnComponentColorType;

/**
 * 按钮尺寸类型
 * - sm: 小尺寸
 * - lg: 大尺寸
 * - xl: 超大尺寸
 * - undefined: 默认尺寸
 */
export type TnButtonSizeType = "sm" | "lg" | "xl";

/**
 * 按钮形状类型
 * - circle: 正圆形
 * - round: 胶囊形
 */
export type TnButtonShapeType = "circle" | "round";

/**
 * 按钮尺寸配置
 */
export interface TnButtonSizeConfig {
  /** 按钮高度(vp) */
  height: number;
  /** 水平内边距(vp) */
  paddingHorizontal: number;
  /** 字体大小（baseStyle 中的属性名） */
  fontSizeKey: string;
}

/**
 * TnButton 组件属性接口
 */
export interface TnButtonProps {
  /** 按钮颜色类型，默认 "primary" */
  type?: TnButtonColorType;
  /** 按钮尺寸 */
  btnSize?: TnButtonSizeType;
  /** 按钮形状 */
  shape?: TnButtonShapeType;
  /** 文本按钮模式（透明背景） */
  textMode?: boolean;
  /** 朴素按钮（边框 + 浅背景） */
  plain?: boolean;
  /** 禁用状态 */
  disabled?: boolean;
  /** 加载状态 */
  loading?: boolean;
  /** 加粗字体 */
  bold?: boolean;
  /** 自定义字体大小 */
  fontSize?: number | string;
  /** 自定义背景色 */
  bgColor?: ResourceColor;
  /** 自定义文字色 */
  textColor?: ResourceColor;
  /** 自定义边框色 */
  btnBorderColor?: ResourceColor;
  /** 显示阴影 */
  showShadow?: boolean;
  /** 阴影颜色 */
  shadowColor?: ResourceColor;
  /** 图标名称（使用 TnIcon） */
  icon?: string;
  /** 自定义宽度 */
  btnWidth?: number | string;
  /** 自定义高度 */
  btnHeight?: number | string;
  /** 点击防抖（250ms） */
  debounce?: boolean;
  /** 按钮文本 */
  content?: ResourceStr;
  /** 点击回调 */
  onBtnClick?: () => void;
}
