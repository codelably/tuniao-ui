/**
 * @file TnCountDown 倒计时组件
 * @description 倒计时组件，支持天/时/分/秒显示、中英文分割符、边框、自定义颜色等
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { TnComponentColorType, getThemeColor, THEME_COLOR_NAMES, getFontSizeByKey } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { convertDimensionsWidthUnit, getSizeByUnit } from "../../utils/Utils";
import { TnCountDownController, TnCountDownSeparatorMode } from "./TnCountDownTypes";

/** 时间常量（秒） */
const SECOND = 1;
const MINUTE_S = 60 * SECOND;
const HOUR_S = 60 * MINUTE_S;
const DAY_S = 24 * HOUR_S;

/**
 * 获取分割符文字
 * @param mode 分割符模式
 * @param key 时间段名称
 * @returns 分割符文字
 */
function getSeparator(mode: string, key: string): string {
  if (mode === 'cn') {
    if (key === 'day') {
      return '天';
    } else if (key === 'hour') {
      return '时';
    } else if (key === 'minute') {
      return '分';
    } else if (key === 'second') {
      return '秒';
    }
  } else {
    if (key === 'day' || key === 'hour' || key === 'minute') {
      return ':';
    }
  }
  return '';
}

/**
 * 数字补零
 * @param num 数字
 * @param maxLen 最大位数
 * @returns 补零后的字符串
 */
function padZero(num: number, maxLen: number = 2): string {
  const str: string = num.toString();
  if (str.length < maxLen) {
    return '0'.repeat(maxLen - str.length) + str;
  }
  return str;
}

/**
 * TnCountDown 倒计时组件
 *
 * @example
 * TnCountDown({ time: 300 })
 * TnCountDown({ time: 300, separatorMode: 'cn' })
 * TnCountDown({ time: 86500, showDay: true })
 */
@ComponentV2
export struct TnCountDown {
  /** 全局基础样式 */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  /** 倒计时时间（秒） */
  @Param time: number = 0;
  /** 是否自动开始倒计时 */
  @Param autoStart: boolean = true;
  /** 字体颜色（主题色名或自定义颜色值） */
  @Param textColor: string = "";
  /** 字体大小(vp)，0 表示使用主题默认值 */
  @Param fontSize: number = 0;
  /** 是否显示天数 */
  @Param showDay: boolean = false;
  /** 是否显示小时 */
  @Param showHour: boolean = true;
  /** 是否显示分钟 */
  @Param showMinute: boolean = true;
  /** 是否显示秒数 */
  @Param showSecond: boolean = true;
  /** 自动隐藏天数（当时间不足一天时自动隐藏） */
  @Param autoHideDay: boolean = true;
  /** 分割符模式 */
  @Param separatorMode: TnCountDownSeparatorMode = 'en';
  /** 分割符颜色（主题色名或自定义颜色值） */
  @Param separatorColor: string = "";
  /** 是否显示边框 */
  @Param showBorder: boolean = false;
  /** 边框颜色（主题色名或自定义颜色值） */
  @Param itemBorderColor: string = "";
  /** 控制器 */
  @Param controller: TnCountDownController | null = null;
  /** 倒计时开始时的回调 */
  @Event onStart: () => void = () => {};
  /** 倒计时结束时的回调 */
  @Event onEnd: () => void = () => {};

  /**
   * 当前剩余毫秒数 —— 唯一驱动 UI 刷新的数据源
   * 使用毫秒精度 + 30ms 轮询，与 IBest-UI 已验证可行的模式一致
   */
  @Local remain: number = 0;
  /** 是否正在倒计时 */
  @Local isCounting: boolean = false;
  /** 倒计时结束的绝对时间戳（ms） */
  private endTime: number = 0;
  /** 定时器ID */
  private timer: number = -1;

  aboutToAppear(): void {
    // 绑定控制器
    if (this.controller !== null) {
      this.controller.start = (): void => this.startCountDown();
      this.controller.pause = (): void => this.pauseCountDown();
      this.controller.reset = (time?: number): void => this.resetCountDown(time);
    }
    // 初始化剩余时间（秒转毫秒）
    this.remain = this.time * 1000;
    // 自动开始
    if (this.autoStart && this.time > 0) {
      this.startCountDown();
    }
  }

  aboutToDisappear(): void {
    this.clearTimer();
  }

  @Monitor("time")
  onTimeChange(): void {
    this.resetCountDown();
    if (this.autoStart && this.time > 0) {
      this.startCountDown();
    }
  }

  /**
   * 开始倒计时 —— 与 IBest-UI 完全一致：先启动 timer，再设 isCounting
   */
  private startCountDown(): void {
    if (this.isCounting) {
      return;
    }
    this.endTime = Date.now() + this.remain;
    this.tick();
    this.isCounting = true;
    this.onStart();
  }

  /**
   * 暂停倒计时 —— 与 IBest-UI 一致：只设 isCounting，不清 timer
   */
  private pauseCountDown(): void {
    this.isCounting = false;
  }

  /**
   * 重置倒计时
   * @param time 新的时间（秒），不传则使用 props.time
   */
  private resetCountDown(time?: number): void {
    this.pauseCountDown();
    this.clearTimer();
    const t: number = time !== undefined ? time : this.time;
    this.remain = t * 1000;
  }

  /**
   * 30ms 递归 setTimeout —— 与 IBest-UI 完全一致的定时器模式
   */
  private tick(): void {
    this.clearTimer();
    this.timer = setTimeout(() => {
      if (this.isCounting) {
        this.remain = Math.max(this.endTime - Date.now(), 0);
        if (this.remain > 0) {
          this.tick();
        } else {
          this.isCounting = false;
          this.onEnd();
        }
      }
    }, 30);
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

  // ========== 直接从 this.remain 计算的显示方法 ==========
  // 每个方法都直接读取 this.remain，确保 ArkTS 框架能追踪 @Local 依赖

  /** 获取总秒数 */
  private getTotalSec(): number {
    return Math.ceil(this.remain / 1000);
  }

  /** 获取天数显示文本 */
  getDaysText(): string {
    return padZero(Math.floor(this.getTotalSec() / DAY_S));
  }

  /** 获取小时显示文本 */
  getHoursText(): string {
    const totalSec = this.getTotalSec();
    const hours = this.showDay
      ? Math.floor((totalSec % DAY_S) / HOUR_S)
      : Math.floor(totalSec / HOUR_S);
    return padZero(hours);
  }

  /** 获取分钟显示文本 */
  getMinsText(): string {
    return padZero(Math.floor((this.getTotalSec() % HOUR_S) / MINUTE_S));
  }

  /** 获取秒数显示文本 */
  getSecsText(): string {
    return padZero(Math.floor(this.getTotalSec() % MINUTE_S));
  }

  /** 判断是否应该显示天数 */
  shouldShowDay(): boolean {
    if (!this.showDay) {
      return false;
    }
    if (this.autoHideDay && Math.floor(this.getTotalSec() / DAY_S) === 0) {
      return false;
    }
    return true;
  }

  /** 获取格式化后的完整显示文本 */
  getTimeText(): string {
    const totalSec: number = this.getTotalSec();
    const days: number = Math.floor(totalSec / DAY_S);
    const hoursRaw: number = this.showDay
      ? Math.floor((totalSec % DAY_S) / HOUR_S)
      : Math.floor(totalSec / HOUR_S);
    const mins: number = Math.floor((totalSec % HOUR_S) / MINUTE_S);
    const secs: number = Math.floor(totalSec % MINUTE_S);

    const parts: string[] = [];
    const sepMode: string = this.separatorMode;

    const showDayPart: boolean =
      this.showDay && !(this.autoHideDay && days === 0);
    if (showDayPart) {
      parts.push(padZero(days));
      parts.push(getSeparator(sepMode, 'day'));
    }
    if (this.showHour) {
      parts.push(padZero(hoursRaw));
      if (this.showMinute || this.showSecond) {
        parts.push(getSeparator(sepMode, 'hour'));
      }
    }
    if (this.showMinute) {
      parts.push(padZero(mins));
      if (this.showSecond) {
        parts.push(getSeparator(sepMode, 'minute'));
      }
    }
    if (this.showSecond) {
      parts.push(padZero(secs));
      const secSep: string = getSeparator(sepMode, 'second');
      if (secSep.length > 0) {
        parts.push(secSep);
      }
    }
    return parts.join('');
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

  /** 获取分割符颜色 */
  private getSeparatorColor(): ResourceColor {
    if (this.separatorColor.length > 0) {
      if (THEME_COLOR_NAMES.includes(this.separatorColor)) {
        return getThemeColor(this.baseStyle, this.separatorColor as TnComponentColorType);
      }
      return this.separatorColor;
    }
    return $r("app.color.tn_text_color_secondary");
  }

  /** 获取边框颜色 */
  private getItemBorderColor(): ResourceColor {
    if (this.itemBorderColor.length > 0) {
      if (THEME_COLOR_NAMES.includes(this.itemBorderColor)) {
        return getThemeColor(this.baseStyle, this.itemBorderColor as TnComponentColorType);
      }
      return this.itemBorderColor;
    }
    return $r("app.color.tn_color_gray_disabled");
  }

  /** 获取字体大小 */
  private getTextFontSize(): string {
    if (this.fontSize > 0) {
      return getSizeByUnit(this.fontSize, true);
    }
    return getFontSizeByKey(this.baseStyle, "fontSize");
  }

  /** 获取带边框时时间片段的最小宽度 */
  private getSegmentMinWidth(): string {
    if (this.fontSize > 0) {
      const minW: number = Math.max(this.fontSize * 2, 28);
      return convertDimensionsWidthUnit(minW);
    }
    return convertDimensionsWidthUnit(28);
  }

  // ========== 构建 ==========

  build() {
    Row() {
      // 天 —— 每个 Text 直接调用方法读取 this.remain，不使用 const 中间变量
      if (this.shouldShowDay()) {
        Text(this.getDaysText())
          .fontSize(this.getTextFontSize())
          .fontColor(this.getTextColor())
          .fontWeight(FontWeight.Medium)
          .lineHeight(this.baseStyle.lineHeightSm)
          .textAlign(TextAlign.Center)
          .constraintSize({ minWidth: this.showBorder ? this.getSegmentMinWidth() : 0 })
          .padding(this.showBorder
            ? { left: this.baseStyle.spaceXs, right: this.baseStyle.spaceXs, top: this.baseStyle.spaceBase, bottom: this.baseStyle.spaceBase }
            : 0)
          .borderWidth(this.showBorder ? 1 : 0)
          .borderColor(this.showBorder ? this.getItemBorderColor() : Color.Transparent)
          .borderRadius(this.showBorder ? this.baseStyle.borderRadiusSm : 0);
        Text(getSeparator(this.separatorMode, 'day'))
          .fontSize(this.getTextFontSize())
          .fontColor(this.getSeparatorColor())
          .lineHeight(this.baseStyle.lineHeightSm)
          .margin({ left: this.baseStyle.spaceBase, right: this.baseStyle.spaceBase });
      }
      // 时
      if (this.showHour) {
        Text(this.getHoursText())
          .fontSize(this.getTextFontSize())
          .fontColor(this.getTextColor())
          .fontWeight(FontWeight.Medium)
          .lineHeight(this.baseStyle.lineHeightSm)
          .textAlign(TextAlign.Center)
          .constraintSize({ minWidth: this.showBorder ? this.getSegmentMinWidth() : 0 })
          .padding(this.showBorder
            ? { left: this.baseStyle.spaceXs, right: this.baseStyle.spaceXs, top: this.baseStyle.spaceBase, bottom: this.baseStyle.spaceBase }
            : 0)
          .borderWidth(this.showBorder ? 1 : 0)
          .borderColor(this.showBorder ? this.getItemBorderColor() : Color.Transparent)
          .borderRadius(this.showBorder ? this.baseStyle.borderRadiusSm : 0);
        if (this.showMinute || this.showSecond) {
          Text(getSeparator(this.separatorMode, 'hour'))
            .fontSize(this.getTextFontSize())
            .fontColor(this.getSeparatorColor())
            .lineHeight(this.baseStyle.lineHeightSm)
            .margin({ left: this.baseStyle.spaceBase, right: this.baseStyle.spaceBase });
        }
      }
      // 分
      if (this.showMinute) {
        Text(this.getMinsText())
          .fontSize(this.getTextFontSize())
          .fontColor(this.getTextColor())
          .fontWeight(FontWeight.Medium)
          .lineHeight(this.baseStyle.lineHeightSm)
          .textAlign(TextAlign.Center)
          .constraintSize({ minWidth: this.showBorder ? this.getSegmentMinWidth() : 0 })
          .padding(this.showBorder
            ? { left: this.baseStyle.spaceXs, right: this.baseStyle.spaceXs, top: this.baseStyle.spaceBase, bottom: this.baseStyle.spaceBase }
            : 0)
          .borderWidth(this.showBorder ? 1 : 0)
          .borderColor(this.showBorder ? this.getItemBorderColor() : Color.Transparent)
          .borderRadius(this.showBorder ? this.baseStyle.borderRadiusSm : 0);
        if (this.showSecond) {
          Text(getSeparator(this.separatorMode, 'minute'))
            .fontSize(this.getTextFontSize())
            .fontColor(this.getSeparatorColor())
            .lineHeight(this.baseStyle.lineHeightSm)
            .margin({ left: this.baseStyle.spaceBase, right: this.baseStyle.spaceBase });
        }
      }
      // 秒
      if (this.showSecond) {
        Text(this.getSecsText())
          .fontSize(this.getTextFontSize())
          .fontColor(this.getTextColor())
          .fontWeight(FontWeight.Medium)
          .lineHeight(this.baseStyle.lineHeightSm)
          .textAlign(TextAlign.Center)
          .constraintSize({ minWidth: this.showBorder ? this.getSegmentMinWidth() : 0 })
          .padding(this.showBorder
            ? { left: this.baseStyle.spaceXs, right: this.baseStyle.spaceXs, top: this.baseStyle.spaceBase, bottom: this.baseStyle.spaceBase }
            : 0)
          .borderWidth(this.showBorder ? 1 : 0)
          .borderColor(this.showBorder ? this.getItemBorderColor() : Color.Transparent)
          .borderRadius(this.showBorder ? this.baseStyle.borderRadiusSm : 0);
        if (getSeparator(this.separatorMode, 'second').length > 0) {
          Text(getSeparator(this.separatorMode, 'second'))
            .fontSize(this.getTextFontSize())
            .fontColor(this.getSeparatorColor())
            .lineHeight(this.baseStyle.lineHeightSm)
            .margin({ left: this.baseStyle.spaceBase, right: this.baseStyle.spaceBase });
        }
      }
    }
    .alignItems(VerticalAlign.Center);
  }
}
