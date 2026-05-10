/**
 * @file TnSubsection 分段器组件类型定义
 * @description 定义分段器组件的属性接口和模式类型
 * @author JunBin.Yang
 */

/**
 * 分段器模式
 * - default: 默认模式，带主题色边框和滑块
 * - button: 按钮模式，灰色背景 + 白色滑块
 */
export type TnSubsectionMode = "default" | "button";

/**
 * TnSubsection 组件属性接口
 */
export interface TnSubsectionProps {
  /**
   * 当前选中项索引
   * @default 0
   */
  modelValue?: number;
  /**
   * 分段选项列表
   * @default []
   */
  items?: string[];
  /**
   * 分段器模式
   * @default "default"
   */
  mode?: TnSubsectionMode;
  /**
   * 是否禁用
   * @default false
   */
  disabled?: boolean;
  /**
   * 激活项颜色（default 模式下为滑块背景色和边框色，button 模式下为激活文字色）
   */
  activeColor?: ResourceColor;
  /**
   * 未激活项文字颜色
   */
  color?: ResourceColor;
}
