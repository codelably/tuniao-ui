/**
 * @file TnNotify 消息通知展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

/**
 * TnNotify 消息通知展示页面 ViewModel
 */
@ObservedV2
export default class TnNotifyViewModel extends BaseViewModel {
  /** 操作结果文本 */
  @Trace resultText: string = "";
}
