/**
 * @file TnActionSheet 操作面板展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

/**
 * TnActionSheet 操作面板展示页面 ViewModel
 */
@ObservedV2
export default class TnActionSheetViewModel extends BaseViewModel {
  /** 基础用法 */
  @Trace basicVisible: boolean = false;
  /** 带标题 */
  @Trace withTitleVisible: boolean = false;
  /** 带标题和描述 */
  @Trace withDescVisible: boolean = false;
  /** 带选项描述 */
  @Trace itemDescVisible: boolean = false;
  /** 自定义颜色 */
  @Trace customColorVisible: boolean = false;
  /** 禁用选项 */
  @Trace disabledVisible: boolean = false;
  /** 隐藏取消按钮 */
  @Trace noCancelVisible: boolean = false;
  /** 自定义取消文字 */
  @Trace customCancelVisible: boolean = false;
  /** 点击遮罩不可关闭 */
  @Trace noOverlayCloseVisible: boolean = false;
  /** beforeClose 拦截 */
  @Trace beforeCloseVisible: boolean = false;
  /** 异步 beforeClose 拦截 */
  @Trace asyncBeforeCloseVisible: boolean = false;
  /** 自定义标题 */
  @Trace customTitleVisible: boolean = false;
  /** 选择结果 */
  @Trace selectResult: string = "";
}
