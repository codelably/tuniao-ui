/**
 * @file TnSlider 滑块组件类型定义
 * @author JunBin.Yang
 */

/**
 * TnSlider 组件属性接口
 */
export interface TnSliderProps {
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
  /** 激活轨道颜色（主题色名或 hex） */
  activeColor?: string;
  /** 未激活轨道颜色 */
  inactiveColor?: string;
  /** 滑块尺寸(vp)，0 为默认 */
  sliderBarSize?: number;
  /** 轨道高度(vp)，0 为默认 */
  sliderHeight?: number;
  /** 值变化回调（松手后） */
  onChange?: (value: number) => void;
  /** 拖动中值变化回调 */
  onChanging?: (value: number) => void;
}
