/**
 * @file TnNumberBox 步进器组件类型定义
 * @author JunBin.Yang
 */

/**
 * TnNumberBox 组件属性接口
 */
export interface TnNumberBoxProps {
  /** 绑定值，默认 0 */
  modelValue?: number;
  /** 最小值，默认 0 */
  min?: number;
  /** 最大值，默认 100 */
  max?: number;
  /** 步长，默认 1 */
  step?: number;
  /** 禁用 */
  disabled?: boolean;
  /** 禁用输入框编辑 */
  inputDisabled?: boolean;
  /** 启用长按连续增减 */
  longPress?: boolean;
  /** 长按间隔(ms) */
  longPressInterval?: number;
  /** 尺寸(vp)，0 为默认 */
  size?: number;
  /** 背景色 */
  bgColor?: ResourceColor;
  /** 文字颜色 */
  textColor?: ResourceColor;
  /** 值变化回调 */
  onChange?: (value: number) => void;
}
