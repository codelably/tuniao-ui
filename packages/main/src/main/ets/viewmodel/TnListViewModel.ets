/**
 * @file TnList 列表展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

@ObservedV2
export default class TnListViewModel extends BaseViewModel {
  /**
   * 点击计数（用于点击事件演示）
   */
  @Trace clickCount: number = 0;
  /**
   * 当前点击的列表项文本
   */
  @Trace lastClickedItem: string = "";

  /**
   * 列表项点击处理
   * @param title 列表项标题
   */
  handleItemClick(title: string): void {
    this.clickCount = this.clickCount + 1;
    this.lastClickedItem = title;
  }

  /**
   * 重置点击状态
   */
  resetClickState(): void {
    this.clickCount = 0;
    this.lastClickedItem = "";
  }
}
