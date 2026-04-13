/**
 * @file TnCountTo 数字跳转组件类型定义
 * @author JunBin.Yang
 */

/**
 * 数字跳转控制器
 * 用于外部控制数字动画的开始、暂停、继续和重置
 *
 * @example
 * const controller = new TnCountToController();
 * TnCountTo({ endValue: 1000, autoPlay: false, controller: controller })
 * // 开始
 * controller.start();
 * // 暂停
 * controller.pause();
 * // 继续
 * controller.resume();
 * // 重置
 * controller.reset();
 */
export class TnCountToController {
  /** 开始动画 */
  start: () => void = () => {};
  /** 暂停动画 */
  pause: () => void = () => {};
  /** 从暂停处继续动画 */
  resume: () => void = () => {};
  /** 重置动画到初始状态 */
  reset: () => void = () => {};
}

/**
 * TnCountTo 数字跳转组件属性接口
 */
export interface TnCountToProps {
  /** 起始值，默认 0 */
  startValue?: number;
  /** 结束值，默认 0 */
  endValue?: number;
  /** 动画持续时间（毫秒），默认 1500 */
  duration?: number;
  /** 是否自动开始动画，默认 true */
  autoPlay?: boolean;
  /** 小数位数，默认 0 */
  decimals?: number;
  /** 小数点分隔符，默认 '.' */
  decimalSeparator?: string;
  /** 千分位分隔符，不设置则不显示千分位 */
  thousandsSeparator?: string;
  /** 是否使用缓动动画，默认 true */
  useEasing?: boolean;
  /** 字体颜色（主题色名或自定义颜色值） */
  textColor?: string;
  /** 字体大小（vp），0 表示使用主题默认值 */
  fontSize?: number;
  /** 字重 */
  fontWeight?: FontWeight;
  /** 控制器 */
  controller?: TnCountToController;
  /** 动画结束时的回调 */
  onEnd?: () => void;
}
