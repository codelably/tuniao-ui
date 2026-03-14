/**
 * @file TnRate 展示页面 ViewModel
 * @author JunBin.Yang
 */
import { BaseViewModel } from "@core/base";

@ObservedV2
export default class TnRateViewModel extends BaseViewModel {
  /** 评分组件1的当前评分值 */
  @Trace rateValue1: number = 3;

  /** 评分组件2的当前评分值（支持半星） */
  @Trace rateValue2: number = 2.5;

  /**
   * 设置评分组件1的评分值
   * @param value 新的评分值
   */
  setRateValue1(value: number): void {
    this.rateValue1 = value;
  }

  /**
   * 设置评分组件2的评分值
   * @param value 新的评分值
   */
  setRateValue2(value: number): void {
    this.rateValue2 = value;
  }
}
