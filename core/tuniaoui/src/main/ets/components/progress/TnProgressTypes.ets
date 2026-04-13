/**
 * @file TnProgress 进度条组件类型定义
 * @author JunBin.Yang
 */

/**
 * TnLineProgress 线形进度条组件属性接口
 */
export interface TnLineProgressProps {
  /** 当前进度百分比，0-100，默认 0 */
  percent?: number;
  /** 激活时的颜色（主题色名或自定义颜色值） */
  activeColor?: string;
  /** 未激活时的颜色 */
  inactiveColor?: string;
  /** 是否显示进度文字，默认 false */
  showPercent?: boolean;
  /** 进度文字显示在进度条内部，默认 false */
  textInside?: boolean;
  /** 进度条高度(vp)，默认 12 */
  barHeight?: number;
  /** 动画执行时间，单位 ms，0 表示使用主题默认值 */
  duration?: number;
  /** 格式化进度文本函数 */
  format?: (percent: number) => string;
  /** 进度到达 100 时的回调 */
  onComplete?: () => void;
}

/**
 * TnCircleProgress 圆形进度条组件属性接口
 */
export interface TnCircleProgressProps {
  /** 当前进度百分比，0-100，默认 0 */
  percent?: number;
  /** 激活时的颜色（主题色名或自定义颜色值） */
  activeColor?: string;
  /** 未激活时的颜色 */
  inactiveColor?: string;
  /** 是否显示进度文字，默认 true */
  showPercent?: boolean;
  /** 圆的半径(vp)，默认 50 */
  radius?: number;
  /** 圆环宽度(vp)，默认 6 */
  ringWidth?: number;
  /** 动画执行时间，单位 ms，0 表示使用主题默认值 */
  duration?: number;
  /** 格式化进度文本函数 */
  format?: (percent: number) => string;
  /** 进度到达 100 时的回调 */
  onComplete?: () => void;
}
