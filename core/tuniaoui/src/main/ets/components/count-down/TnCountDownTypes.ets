/**
 * @file TnCountDown 倒计时组件类型定义
 * @author JunBin.Yang
 */

/**
 * 倒计时分割符模式
 * - en: 英文分割符（冒号 :）
 * - cn: 中文分割符（天时分秒）
 */
export type TnCountDownSeparatorMode = 'en' | 'cn';

/**
 * 倒计时控制器
 * 用于外部控制倒计时的开始、暂停和重置
 *
 * @example
 * const controller = new TnCountDownController();
 * TnCountDown({ time: 300, autoStart: false, controller: controller })
 * // 开始
 * controller.start();
 * // 暂停
 * controller.pause();
 * // 重置
 * controller.reset();
 */
export class TnCountDownController {
  /** 开始倒计时 */
  start: () => void = () => {};
  /** 暂停倒计时 */
  pause: () => void = () => {};
  /** 重置倒计时，可传入新的时间（秒） */
  reset: (time?: number) => void = () => {};
}

/**
 * TnCountDown 倒计时组件属性接口
 */
export interface TnCountDownProps {
  /** 倒计时时间，单位 秒，默认 0 */
  time?: number;
  /** 是否自动开始倒计时，默认 true */
  autoStart?: boolean;
  /** 字体颜色（主题色名或自定义颜色值） */
  textColor?: string;
  /** 字体大小（vp），0 表示使用主题默认值 */
  fontSize?: number;
  /** 是否显示天数，默认 false */
  showDay?: boolean;
  /** 是否显示小时，默认 true */
  showHour?: boolean;
  /** 是否显示分钟，默认 true */
  showMinute?: boolean;
  /** 是否显示秒数，默认 true */
  showSecond?: boolean;
  /** 自动隐藏天数（当时间不足一天时自动隐藏），默认 true */
  autoHideDay?: boolean;
  /** 分割符模式，默认 'en' */
  separatorMode?: TnCountDownSeparatorMode;
  /** 分割符颜色（主题色名或自定义颜色值） */
  separatorColor?: string;
  /** 是否显示边框，默认 false */
  showBorder?: boolean;
  /** 边框颜色（主题色名或自定义颜色值） */
  itemBorderColor?: string;
  /** 控制器 */
  controller?: TnCountDownController;
  /** 倒计时开始时的回调 */
  onStart?: () => void;
  /** 倒计时结束时的回调 */
  onEnd?: () => void;
}
