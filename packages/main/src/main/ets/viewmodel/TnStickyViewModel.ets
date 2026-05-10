/**
 * @file TnSticky 吸顶展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

@ObservedV2
export default class TnStickyViewModel extends BaseViewModel {
  /**
   * 基础用法 - 滚动偏移量
   */
  @Trace basicScrollTop: number = 0;
  /**
   * 自定义偏移 - 滚动偏移量
   */
  @Trace offsetScrollTop: number = 0;
  /**
   * 禁用吸顶 - 滚动偏移量
   */
  @Trace disabledScrollTop: number = 0;
  /**
   * 事件回调 - 滚动偏移量
   */
  @Trace eventScrollTop: number = 0;
  /**
   * 自定义背景色 - 滚动偏移量
   */
  @Trace bgColorScrollTop: number = 0;
  /**
   * 吸顶状态变化记录
   */
  @Trace changeLog: string = "";
  /**
   * 当前吸顶状态
   */
  @Trace isFixed: boolean = false;

  /**
   * 处理吸顶状态变化
   * @param fixed 是否吸顶
   */
  handleStickyChange(fixed: boolean): void {
    this.isFixed = fixed;
    this.changeLog = fixed ? "已吸顶" : "已脱离吸顶";
  }
}
