/**
 * @file TnButton 按钮展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

/**
 * TnButton 按钮展示页面 ViewModel
 */
@ObservedV2
export default class TnButtonViewModel extends BaseViewModel {
  /**
   * 点击计数（演示用）
   */
  @Trace clickCount: number = 0;
  /**
   * 加载状态（演示用）
   */
  @Trace isLoading: boolean = false;

  /**
   * 增加点击计数
   */
  incrementClickCount(): void {
    this.clickCount = this.clickCount + 1;
  }

  /**
   * 切换加载状态
   */
  toggleLoading(): void {
    this.isLoading = !this.isLoading;
  }
}
