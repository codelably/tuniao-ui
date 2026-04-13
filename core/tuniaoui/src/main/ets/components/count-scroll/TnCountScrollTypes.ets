/**
 * @file TnCountScroll 数字滚动组件类型定义
 * @description 定义 TnCountScroll 组件的属性接口
 * @author JunBin.Yang
 */

/**
 * TnCountScroll 数字滚动组件属性接口
 */
export interface TnCountScrollProps {
  /** 显示的值（支持小数和千分位分隔符），默认 '' */
  value?: string;
  /** 文字颜色（主题色名或自定义颜色值） */
  textColor?: string;
  /** 字体大小（vp），0 表示使用主题默认值 */
  fontSize?: number;
  /** 字重 */
  fontWeight?: FontWeight;
  /** 小数点分隔符，默认 '.' */
  decimalSeparator?: string;
  /** 千分位分隔符，默认 ','；空字符串表示不使用千分位 */
  thousandsSeparator?: string;
  /** 动画执行时间（毫秒），默认 1500 */
  duration?: number;
}
