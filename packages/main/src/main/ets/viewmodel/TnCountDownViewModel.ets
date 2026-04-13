/**
 * @file TnCountDown 倒计时展示页面 ViewModel
 * @author JunBin.Yang
 */
import { BaseViewModel } from "@core/base";
import { TnCountDownController } from "@tuniao/tn-ui";

@ObservedV2
export default class TnCountDownViewModel extends BaseViewModel {
  /** 基础用法倒计时时间（秒）：5分钟 */
  @Trace basicTime: number = 300;

  /** 显示天的倒计时时间（秒）：1天零1小时 */
  @Trace dayTime: number = 90100;

  /** 只显示分秒的倒计时时间（秒）：10分钟 */
  @Trace minuteSecondTime: number = 600;

  /** 中文分割符倒计时时间（秒） */
  @Trace cnSeparatorTime: number = 500;

  /** 自定义颜色倒计时时间（秒） */
  @Trace customColorTime: number = 3700;

  /** 带边框倒计时时间（秒） */
  @Trace borderTime: number = 450;

  /** 带边框中文分割符倒计时时间（秒） */
  @Trace borderCnTime: number = 86500;

  /** 自定义字体大小倒计时时间（秒） */
  @Trace fontSizeTime: number = 360;

  /** 手动控制倒计时时间（秒）：10分钟 */
  @Trace controlTime: number = 600;

  /** 手动控制的控制器 */
  controlController: TnCountDownController = new TnCountDownController();

  /** 控制器状态文字 */
  @Trace controlStatusText: string = "未开始";

  /**
   * 开始手动控制的倒计时
   */
  startControl(): void {
    this.controlController.start();
    this.controlStatusText = "倒计时中";
  }

  /**
   * 暂停手动控制的倒计时
   */
  pauseControl(): void {
    this.controlController.pause();
    this.controlStatusText = "已暂停";
  }

  /**
   * 重置手动控制的倒计时
   */
  resetControl(): void {
    this.controlController.reset();
    this.controlStatusText = "未开始";
  }

  /**
   * 手动控制倒计时结束
   */
  onControlEnd(): void {
    this.controlStatusText = "已结束";
  }

  /**
   * 手动控制倒计时开始
   */
  onControlStart(): void {
    this.controlStatusText = "倒计时中";
  }
}
