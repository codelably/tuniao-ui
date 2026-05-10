/**
 * @file TnSearchBox 搜索框组件类型定义
 * @description 定义搜索框组件的属性接口和相关类型
 * @author JunBin.Yang
 */

/**
 * 搜索框形状
 * - square: 方形（默认圆角）
 * - round: 圆形（胶囊形）
 */
export type TnSearchBoxShape = "square" | "round";

/**
 * 搜索框尺寸
 * - sm: 小尺寸
 * - default: 默认尺寸
 * - lg: 大尺寸
 * - xl: 超大尺寸
 */
export type TnSearchBoxSize = "sm" | "default" | "lg" | "xl";

/**
 * 清除按钮触发方式
 * - always: 有值时始终显示
 * - focus: 仅聚焦且有值时显示
 */
export type TnSearchBoxClearTrigger = "always" | "focus";

/**
 * TnSearchBox 组件属性接口
 */
export interface TnSearchBoxProps {
  /**
   * 搜索框输入值
   * @default ""
   */
  modelValue?: string;
  /**
   * 占位文本
   * @default "请输入搜索内容"
   */
  placeholder?: string;
  /**
   * 搜索框形状
   * @default "square"
   */
  shape?: TnSearchBoxShape;
  /**
   * 搜索框尺寸
   * @default "default"
   */
  boxSize?: TnSearchBoxSize;
  /**
   * 输入文字颜色
   */
  textColor?: ResourceColor;
  /**
   * 占位文字颜色
   */
  placeholderColor?: ResourceColor;
  /**
   * 文字对齐方式
   * @default TextAlign.Start
   */
  textAlign?: TextAlign;
  /**
   * 是否显示边框
   * @default true
   */
  showBorder?: boolean;
  /**
   * 边框颜色
   */
  inputBorderColor?: ResourceColor;
  /**
   * 是否禁用
   * @default false
   */
  disabled?: boolean;
  /**
   * 是否可清除
   * @default true
   */
  clearable?: boolean;
  /**
   * 清除按钮触发方式
   * @default "focus"
   */
  clearTrigger?: TnSearchBoxClearTrigger;
  /**
   * 是否显示搜索按钮
   * @default true
   */
  searchButton?: boolean;
  /**
   * 搜索按钮文字
   * @default "搜索"
   */
  searchButtonText?: string;
  /**
   * 搜索按钮文字颜色
   */
  searchButtonTextColor?: ResourceColor;
  /**
   * 搜索按钮背景色
   */
  searchButtonBgColor?: ResourceColor;
  /**
   * 搜索框背景色
   */
  bgColor?: ResourceColor;
  /**
   * 是否自动聚焦
   * @default false
   */
  focus?: boolean;
}
