/**
 * @file TnToast 轻提示展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

/**
 * TnToast 轻提示展示页面 ViewModel
 */
@ObservedV2
export default class TnToastViewModel extends BaseViewModel {
  /** 操作结果文本 */
  @Trace resultText: string = "";
}
