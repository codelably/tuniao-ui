/**
 * @file TnCountTo 数字跳转展示页面 ViewModel
 * @author JunBin.Yang
 */
import { BaseViewModel } from "@core/base";
import { TnCountToController } from "@tuniao/tn-ui";

@ObservedV2
export default class TnCountToViewModel extends BaseViewModel {
  /** 基础用法：从 0 到 1000 */
  @Trace basicEndValue: number = 1000;

  /** 大数值：从 0 到 999999 */
  @Trace largeEndValue: number = 999999;

  /** 带小数位：从 0 到 186.55 */
  @Trace decimalEndValue: number = 186.55;

  /** 千分位+小数：从 0 到 1234567.89 */
  @Trace thousandsEndValue: number = 1234567.89;

  /** 自定义持续时间：从 0 到 5000 */
  @Trace durationEndValue: number = 5000;

  /** 倒数：从 1000 到 0 */
  @Trace countDownStartValue: number = 1000;
  @Trace countDownEndValue: number = 0;

  /** 无缓动：从 0 到 500 */
  @Trace noEasingEndValue: number = 500;

  /** 手动控制的控制器 */
  controlController: TnCountToController = new TnCountToController();

  /** 手动控制结束值 */
  @Trace controlEndValue: number = 8888;

  /** 控制器状态文字 */
  @Trace controlStatusText: string = "未开始";

  /**
   * 开始手动控制的动画
   */
  startControl(): void {
    this.controlController.start();
    this.controlStatusText = "动画中";
  }

  /**
   * 暂停手动控制的动画
   */
  pauseControl(): void {
    this.controlController.pause();
    this.controlStatusText = "已暂停";
  }

  /**
   * 继续手动控制的动画
   */
  resumeControl(): void {
    this.controlController.resume();
    this.controlStatusText = "动画中";
  }

  /**
   * 重置手动控制的动画
   */
  resetControl(): void {
    this.controlController.reset();
    this.controlStatusText = "未开始";
  }

  /**
   * 手动控制动画结束
   */
  onControlEnd(): void {
    this.controlStatusText = "已结束";
  }
}
