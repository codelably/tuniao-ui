/**
 * @file TnCountTo 数字跳转组件
 * @description 数字跳转组件，用于数字的平滑变化动画，支持缓动、千分位、小数位等
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { TnComponentColorType, getThemeColor, THEME_COLOR_NAMES, getFontSizeByKey } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { getSizeByUnit } from "../../utils/Utils";
import { TnCountToController } from "./TnCountToTypes";

/**
 * TnCountTo 数字跳转组件
 *
 * @example
 * TnCountTo({ endValue: 1000 })
 * TnCountTo({ startValue: 0, endValue: 9999.99, decimals: 2, thousandsSeparator: ',' })
 */
@ComponentV2
export struct TnCountTo {
  /** 全局基础样式 */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  /** 起始值 */
  @Param startValue: number = 0;
  /** 结束值 */
  @Param endValue: number = 0;
  /** 动画持续时间（毫秒） */
  @Param duration: number = 1500;
  /** 是否自动开始动画 */
  @Param autoPlay: boolean = true;
  /** 小数位数 */
  @Param decimals: number = 0;
  /** 小数点分隔符 */
  @Param decimalSeparator: string = '.';
  /** 千分位分隔符，不设置则不显示千分位 */
  @Param thousandsSeparator: string = '';
  /** 是否使用缓动动画 */
  @Param useEasing: boolean = true;
  /** 字体颜色（主题色名或自定义颜色值） */
  @Param textColor: string = "";
  /** 字体大小(vp)，0 表示使用主题默认值 */
  @Param fontSize: number = 0;
  /** 字重 */
  @Param fontWeight: FontWeight = FontWeight.Normal;
  /** 控制器 */
  @Param controller: TnCountToController | null = null;
  /** 动画结束时的回调 */
  @Event onEnd: () => void = () => {};

  /** 当前格式化后的显示文本 */
  @Local displayText: string = '';
  /** 当前数值 */
  private currentValue: number = 0;
  /** 动画定时器 ID */
  private timer: number = -1;
  /** 动画起始时间戳 */
  private animStartTime: number = 0;
  /** 动画的起始数值（用于暂停恢复） */
  private animStartValue: number = 0;
  /** 动画的剩余时长（用于暂停恢复） */
  private animDuration: number = 0;
  /** 是否正在动画中 */
  private isAnimating: boolean = false;

  aboutToAppear(): void {
    // 绑定控制器
    if (this.controller !== null) {
      this.controller.start = (): void => this.start();
      this.controller.pause = (): void => this.pause();
      this.controller.resume = (): void => this.resume();
      this.controller.reset = (): void => this.reset();
    }
    // 初始化显示
    this.displayText = this.formatNumber(this.startValue);
    this.currentValue = this.startValue;
    // 自动播放
    if (this.autoPlay) {
      this.start();
    }
  }

  aboutToDisappear(): void {
    this.clearTimer();
  }

  @Monitor("startValue", "endValue")
  onValueChange(): void {
    this.clearTimer();
    this.isAnimating = false;
    this.start();
  }

  /**
   * 开始动画
   */
  private start(): void {
    if (this.isAnimating) {
      return;
    }
    this.animStartTime = 0;
    this.animStartValue = this.startValue;
    this.animDuration = this.duration;
    this.currentValue = this.startValue;
    this.animate();
  }

  /**
   * 暂停动画
   */
  private pause(): void {
    if (!this.isAnimating) {
      return;
    }
    this.clearTimer();
    this.isAnimating = false;
  }

  /**
   * 从暂停处继续动画
   */
  private resume(): void {
    if (this.isAnimating) {
      return;
    }
    // 计算剩余时长
    this.animStartTime = 0;
    this.animStartValue = this.currentValue;
    // 根据当前进度估算剩余时长
    const totalRange: number = this.endValue - this.startValue;
    if (totalRange !== 0) {
      const progress: number = (this.currentValue - this.startValue) / totalRange;
      this.animDuration = Math.max(this.duration * (1 - progress), 16);
    } else {
      this.animDuration = 0;
    }
    this.animate();
  }

  /**
   * 重置到初始状态
   */
  private reset(): void {
    this.clearTimer();
    this.isAnimating = false;
    this.animStartTime = 0;
    this.currentValue = this.startValue;
    this.displayText = this.formatNumber(this.startValue);
  }

  /**
   * 动画核心循环，使用 16ms 间隔的 setTimeout 模拟 requestAnimationFrame
   */
  private animate(): void {
    this.clearTimer();
    this.isAnimating = true;
    this.timer = setTimeout(() => {
      const now: number = Date.now();
      if (this.animStartTime === 0) {
        this.animStartTime = now;
      }
      const elapsed: number = now - this.animStartTime;
      const isCountDown: boolean = this.animStartValue > this.endValue;

      if (elapsed >= this.animDuration) {
        // 动画结束
        this.currentValue = this.endValue;
        this.displayText = this.formatNumber(this.endValue);
        this.isAnimating = false;
        this.onEnd();
      } else {
        // 计算当前值
        if (this.useEasing) {
          this.currentValue = this.easingFn(
            elapsed,
            this.animStartValue,
            this.endValue - this.animStartValue,
            this.animDuration
          );
        } else {
          this.currentValue = this.animStartValue +
            (this.endValue - this.animStartValue) * (elapsed / this.animDuration);
        }
        // 边界限制
        if (isCountDown) {
          this.currentValue = Math.max(this.currentValue, this.endValue);
        } else {
          this.currentValue = Math.min(this.currentValue, this.endValue);
        }
        this.displayText = this.formatNumber(this.currentValue);
        this.animate();
      }
    }, 16);
  }

  /**
   * 清除定时器
   */
  private clearTimer(): void {
    if (this.timer !== -1) {
      clearTimeout(this.timer);
      this.timer = -1;
    }
  }

  /**
   * 缓动函数（easeOut 指数衰减）
   * @param t 已经过时间
   * @param b 起始值
   * @param c 变化量
   * @param d 总时长
   * @returns 当前值
   */
  private easingFn(t: number, b: number, c: number, d: number): number {
    return (c * (-Math.pow(2, (-10 * t) / d) + 1) * 1024) / 1023 + b;
  }

  /**
   * 格式化数字为显示文本
   * @param num 数字
   * @returns 格式化后的字符串
   */
  private formatNumber(num: number): string {
    const arr: string[] = num.toFixed(this.decimals).split('.');
    let integerPart: string = arr[0];
    const decimalPart: string = arr.length > 1 ? this.decimalSeparator + arr[1] : '';
    // 千分位处理
    if (this.thousandsSeparator.length > 0) {
      const rgx: RegExp = /(\d+)(\d{3})/;
      while (rgx.test(integerPart)) {
        integerPart = integerPart.replace(rgx, '$1' + this.thousandsSeparator + '$2');
      }
    }
    return integerPart + decimalPart;
  }

  // ========== 样式方法 ==========

  /** 获取文字颜色 */
  private getTextColor(): ResourceColor {
    if (this.textColor.length > 0) {
      if (THEME_COLOR_NAMES.includes(this.textColor)) {
        return getThemeColor(this.baseStyle, this.textColor as TnComponentColorType);
      }
      return this.textColor;
    }
    return $r("app.color.tn_text_color_primary");
  }

  /** 获取字体大小 */
  private getTextFontSize(): string {
    if (this.fontSize > 0) {
      return getSizeByUnit(this.fontSize, true);
    }
    return getFontSizeByKey(this.baseStyle, "fontSize");
  }

  // ========== 构建 ==========

  build() {
    Text(this.displayText)
      .fontColor(this.getTextColor())
      .fontSize(this.getTextFontSize())
      .fontWeight(this.fontWeight);
  }
}
