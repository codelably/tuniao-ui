/**
 * @file TnCollapse 折叠面板展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

@ObservedV2
export default class TnCollapseViewModel extends BaseViewModel {
  /**
   * 基础用法 - 手风琴模式当前展开面板
   */
  @Trace accordionValue: number = 0;
  /**
   * 多面板展开模式当前展开面板
   */
  @Trace multipleValue: number[] = [0];
  /**
   * 自定义箭头颜色当前展开面板
   */
  @Trace arrowColorValue: number = -1;
  /**
   * 隐藏箭头当前展开面板
   */
  @Trace hideArrowValue: number = 0;
  /**
   * 禁用面板当前展开面板
   */
  @Trace disabledValue: number = 0;
  /**
   * 自定义标题当前展开面板
   */
  @Trace customTitleValue: number = -1;
  /**
   * 无边框当前展开面板
   */
  @Trace noBorderValue: number = 0;
  /**
   * 自定义内容当前展开面板
   */
  @Trace customContentValue: number[] = [0];
  /**
   * 事件回调当前展开面板
   */
  @Trace eventValue: number = -1;
  /**
   * 事件变化记录
   */
  @Trace changeLog: string = "";

  /**
   * 处理 change 事件
   * @param value 当前展开面板标识
   */
  handleChange(value: number | number[]): void {
    if (Array.isArray(value)) {
      this.changeLog = `当前展开: [${value.join(", ")}]`;
    } else {
      this.changeLog = value === -1 ? "全部关闭" : `当前展开: ${value}`;
    }
  }
}
