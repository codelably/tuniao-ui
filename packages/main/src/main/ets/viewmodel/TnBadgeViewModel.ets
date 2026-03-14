/**
 * @file TnBadge 徽标展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

/**
 * TnBadge 徽标展示页面 ViewModel
 */
@ObservedV2
export default class TnBadgeViewModel extends BaseViewModel {
  /**
   * 动态数值（演示增减）
   */
  @Trace badgeValue: number = 5;

  /**
   * 增加徽标数值
   */
  incrementValue(): void {
    this.badgeValue = this.badgeValue + 1;
  }

  /**
   * 减少徽标数值
   */
  decrementValue(): void {
    if (this.badgeValue > 0) {
      this.badgeValue = this.badgeValue - 1;
    }
  }

  /**
   * 重置徽标数值
   */
  resetValue(): void {
    this.badgeValue = 5;
  }
}
