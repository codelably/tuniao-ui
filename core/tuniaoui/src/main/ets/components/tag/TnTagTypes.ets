/**
 * @file TnTag 组件类型定义
 * @author JunBin.Yang
 */

import { TnComponentColorType } from "../../common/theme_helpers";

/**
 * 标签颜色类型（复用组件通用颜色类型）
 */
export type TnTagColorType = TnComponentColorType;

/**
 * 标签尺寸类型
 * - sm: 小尺寸
 * - lg: 大尺寸
 * - xl: 超大尺寸
 * - undefined: 默认尺寸
 */
export type TnTagSizeType = "sm" | "lg" | "xl";

/**
 * 标签形状类型
 * - circle: 圆形（全圆角）
 * - round: 圆角
 * - circleLeft: 左侧圆形
 * - circleRight: 右侧圆形
 */
export type TnTagShapeType = "circle" | "round" | "circleLeft" | "circleRight";

/**
 * 标签尺寸配置
 */
export interface TnTagSizeConfig {
  /** 标签高度(vp) */
  height: number;
  /** 水平内边距(vp) */
  paddingHorizontal: number;
  /** 字体大小（baseStyle 中的属性名） */
  fontSizeKey: string;
}

/**
 * TnTag 组件属性接口
 */
export interface TnTagProps {
  /** 标签颜色类型，默认 "primary" */
  type?: TnTagColorType;
  /** 标签尺寸 */
  tagSize?: TnTagSizeType;
  /** 标签形状 */
  shape?: TnTagShapeType;
  /** 标签文本 */
  text?: ResourceStr;
  /** 自定义背景色 */
  bgColor?: ResourceColor;
  /** 自定义文字色 */
  textColor?: ResourceColor;
  /** 是否显示边框 */
  showBorder?: boolean;
  /** 自定义边框色（设置后自动开启边框） */
  tagBorderColor?: ResourceColor;
  /** 边框是否加粗 */
  borderBold?: boolean;
  /** 是否加粗字体 */
  bold?: boolean;
  /** 自定义字体大小 */
  fontSize?: number | string;
  /** 自定义宽度 */
  tagWidth?: number | string;
  /** 自定义高度 */
  tagHeight?: number | string;
  /** 朴素模式（透明背景 + 主题色边框和文字） */
  plain?: boolean;
  /** 是否可关闭（显示关闭图标） */
  closeable?: boolean;
  /** 标签点击回调 */
  onTagClick?: () => void;
  /** 关闭回调 */
  onClose?: () => void;
}
