/**
 * @file TnReadMore 阅读更多展示页面 ViewModel
 * @author JunBin.Yang
 */
import { BaseViewModel } from "@core/base";

@ObservedV2
export default class TnReadMoreViewModel extends BaseViewModel {
  /** 基础用法 - 展开状态 */
  @Trace basicExpand: boolean = false;

  /** 自定义高度 - 展开状态 */
  @Trace customHeightExpand: boolean = false;

  /** 自定义文案和图标 - 展开状态 */
  @Trace customTextExpand: boolean = false;

  /** 隐藏收起按钮 - 展开状态 */
  @Trace hideFoldExpand: boolean = false;

  /** 自定义颜色 - 展开状态 */
  @Trace customColorExpand: boolean = false;

  /** 一次性展开 - 展开状态 */
  @Trace onceExpand: boolean = false;

  /** 展开前拦截 - 展开状态 */
  @Trace beforeExpandDemo: boolean = false;

  /** 默认展开 - 展开状态 */
  @Trace defaultExpand: boolean = true;

  /** 事件回调 - 展开状态 */
  @Trace eventExpand: boolean = false;

  /** 事件日志 */
  @Trace eventLog: string = "";

  /**
   * 记录展开事件
   */
  logExpand(): void {
    this.eventLog = "触发了展开事件";
  }

  /**
   * 记录收起事件
   */
  logFold(): void {
    this.eventLog = "触发了收起事件";
  }
}
