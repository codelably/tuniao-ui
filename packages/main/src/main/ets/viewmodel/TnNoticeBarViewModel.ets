/**
 * @file TnNoticeBar 通知栏展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

/**
 * TnNoticeBar 通知栏展示页面 ViewModel
 */
@ObservedV2
export default class TnNoticeBarViewModel extends BaseViewModel {
  /** 可关闭示例的显示状态 */
  @Trace closeableVisible: boolean = true;
}
