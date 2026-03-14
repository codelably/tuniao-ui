/**
 * @file TnLoading 加载展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

/**
 * TnLoading 加载展示页面 ViewModel
 */
@ObservedV2
export default class TnLoadingViewModel extends BaseViewModel {
  /**
   * 是否显示加载动画（动态控制演示）
   */
  @Trace showLoading: boolean = true;

  /**
   * 切换加载显示状态
   */
  toggleLoading(): void {
    this.showLoading = !this.showLoading;
  }
}
