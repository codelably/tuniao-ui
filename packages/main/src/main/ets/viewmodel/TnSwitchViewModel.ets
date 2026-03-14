/**
 * @file TnSwitch 展示页面 ViewModel
 * @author JunBin.Yang
 */
import { BaseViewModel } from "@core/base";

/** 加载演示时长(毫秒) */
const LOADING_DURATION: number = 10000;

@ObservedV2
export default class TnSwitchViewModel extends BaseViewModel {
  /** 基础用法：开关状态 */
  @Trace switchBasic: boolean = false;

  /** 自定义颜色：主题色开关 */
  @Trace switchColorPrimary: boolean = true;
  /** 自定义颜色：十六进制色开关 */
  @Trace switchColorHex: boolean = true;
  /** 自定义颜色：成功色开关 */
  @Trace switchColorSuccess: boolean = true;

  /** 自定义文字：开关状态 */
  @Trace switchText: boolean = false;

  /** 自定义图标：开关状态 */
  @Trace switchIcon: boolean = false;

  /** 形状：圆角开关 */
  @Trace switchRound: boolean = true;
  /** 形状：方形开关 */
  @Trace switchSquare: boolean = true;

  /** 加载演示：开关状态 */
  @Trace switchLoading: boolean = false;
  /** 加载演示：是否处于加载中 */
  @Trace isLoading: boolean = false;

  /** 自定义值：字符串状态 */
  @Trace switchCustomValue: string = "open";

  /** 加载定时器ID */
  private loadingTimerId: number = -1;

  /**
   * 切换基础开关状态
   * @param value 新的开关状态
   */
  toggleBasic(value: boolean): void {
    this.switchBasic = value;
  }

  /**
   * 切换自定义颜色-主题色开关
   * @param value 新的开关状态
   */
  toggleColorPrimary(value: boolean): void {
    this.switchColorPrimary = value;
  }

  /**
   * 切换自定义颜色-十六进制色开关
   * @param value 新的开关状态
   */
  toggleColorHex(value: boolean): void {
    this.switchColorHex = value;
  }

  /**
   * 切换自定义颜色-成功色开关
   * @param value 新的开关状态
   */
  toggleColorSuccess(value: boolean): void {
    this.switchColorSuccess = value;
  }

  /**
   * 切换自定义文字开关
   * @param value 新的开关状态
   */
  toggleText(value: boolean): void {
    this.switchText = value;
  }

  /**
   * 切换自定义图标开关
   * @param value 新的开关状态
   */
  toggleIcon(value: boolean): void {
    this.switchIcon = value;
  }

  /**
   * 切换圆角形状开关
   * @param value 新的开关状态
   */
  toggleRound(value: boolean): void {
    this.switchRound = value;
  }

  /**
   * 切换方形形状开关
   * @param value 新的开关状态
   */
  toggleSquare(value: boolean): void {
    this.switchSquare = value;
  }

  /**
   * 点击加载演示开关，进入加载状态并在指定时间后完成切换
   * @param value 期望切换到的目标值
   */
  toggleWithLoading(value: boolean): void {
    if (this.isLoading) {
      return;
    }
    this.isLoading = true;
    this.loadingTimerId = setTimeout(() => {
      this.switchLoading = value;
      this.isLoading = false;
      this.loadingTimerId = -1;
    }, LOADING_DURATION);
  }

  /**
   * 切换自定义值开关
   * @param value 新的字符串状态值
   */
  toggleCustomValue(value: string): void {
    this.switchCustomValue = value;
  }

  /**
   * 页面隐藏前清除定时器，防止页面销毁后回调执行
   */
  override aboutToDisappear(): void {
    this.clearLoadingTimer();
  }

  /**
   * 清除加载定时器
   */
  private clearLoadingTimer(): void {
    if (this.loadingTimerId !== -1) {
      clearTimeout(this.loadingTimerId);
      this.loadingTimerId = -1;
      this.isLoading = false;
    }
  }
}
