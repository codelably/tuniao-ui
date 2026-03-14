/**
 * @file TnRate 评分组件类型定义
 * @author JunBin.Yang
 */

/**
 * TnRate 组件属性接口
 */
export interface TnRateProps {
  /** 当前评分 */
  modelValue?: number;
  /** 最大评分，默认 5 */
  max?: number;
  /** 最小评分，默认 0 */
  min?: number;
  /** 允许半星 */
  allowHalf?: boolean;
  /** 只读 */
  readonly?: boolean;
  /** 图标尺寸(vp)，0 为默认 */
  rateSize?: number;
  /** 图标间距(vp) */
  gutter?: number;
  /** 激活图标名称 */
  activeIcon?: string;
  /** 未激活图标名称 */
  inactiveIcon?: string;
  /** 激活颜色（主题色名或 hex） */
  activeColor?: string;
  /** 未激活颜色 */
  inactiveColor?: string;
  /** 值变化回调 */
  onChange?: (value: number) => void;
}
