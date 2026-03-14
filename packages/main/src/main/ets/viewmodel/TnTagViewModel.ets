/**
 * @file TnTag 标签展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

/**
 * TnTag 标签展示页面 ViewModel
 */
@ObservedV2
export default class TnTagViewModel extends BaseViewModel {
  /**
   * 点击计数（演示用）
   */
  @Trace clickCount: number = 0;
  /**
   * 可关闭标签 1 是否可见
   */
  @Trace closeable1Visible: boolean = true;
  /**
   * 可关闭标签 2 是否可见
   */
  @Trace closeable2Visible: boolean = true;
  /**
   * 可关闭标签 3 是否可见
   */
  @Trace closeable3Visible: boolean = true;

  /**
   * 增加点击计数
   */
  incrementClickCount(): void {
    this.clickCount = this.clickCount + 1;
  }

  /**
   * 重置所有可关闭标签的可见状态
   */
  resetCloseableTags(): void {
    this.closeable1Visible = true;
    this.closeable2Visible = true;
    this.closeable3Visible = true;
  }
}
