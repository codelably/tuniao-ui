/**
 * @file TnProgress 进度条展示页面 ViewModel
 * @author JunBin.Yang
 */
import { BaseViewModel } from "@core/base";

@ObservedV2
export default class TnProgressViewModel extends BaseViewModel {
  /** 基础线形进度条的进度值 */
  @Trace linePercent1: number = 30;

  /** 显示进度文字的进度值 */
  @Trace linePercent2: number = 50;

  /** 进度文字在内部的进度值 */
  @Trace linePercent3: number = 70;

  /** 自定义颜色的进度值 */
  @Trace linePercent4: number = 60;

  /** 自定义格式化文本的进度值 */
  @Trace linePercent6: number = 80;

  /** 基础圆形进度条的进度值 */
  @Trace circlePercent1: number = 40;

  /** 自定义颜色圆形进度条的进度值 */
  @Trace circlePercent2: number = 65;

  /** 自定义半径圆形进度条的进度值 */
  @Trace circlePercent3: number = 75;

  /** 动态进度值 */
  @Trace dynamicPercent: number = 0;

  /** 动态圆形进度值 */
  @Trace dynamicCirclePercent: number = 0;

  /**
   * 增加动态进度值
   * @param step 步进值
   */
  increaseDynamic(step: number): void {
    this.dynamicPercent = Math.min(100, this.dynamicPercent + step);
  }

  /**
   * 减少动态进度值
   * @param step 步进值
   */
  decreaseDynamic(step: number): void {
    this.dynamicPercent = Math.max(0, this.dynamicPercent - step);
  }

  /**
   * 增加动态圆形进度值
   * @param step 步进值
   */
  increaseDynamicCircle(step: number): void {
    this.dynamicCirclePercent = Math.min(100, this.dynamicCirclePercent + step);
  }

  /**
   * 减少动态圆形进度值
   * @param step 步进值
   */
  decreaseDynamicCircle(step: number): void {
    this.dynamicCirclePercent = Math.max(0, this.dynamicCirclePercent - step);
  }
}
