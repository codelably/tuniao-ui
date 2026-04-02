/**
 * @file TnModal 模态框展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

/**
 * TnModal 模态框展示页面 ViewModel
 */
@ObservedV2
export default class TnModalViewModel extends BaseViewModel {
  /** 基础模态框 */
  @Trace basicVisible: boolean = false;
  /** 无标题模态框 */
  @Trace noTitleVisible: boolean = false;
  /** 带取消按钮 */
  @Trace showCancelVisible: boolean = false;
  /** 自定义按钮文字 */
  @Trace customBtnTextVisible: boolean = false;
  /** 自定义按钮颜色 */
  @Trace customBtnColorVisible: boolean = false;
  /** 点击遮罩关闭 */
  @Trace overlayCloseVisible: boolean = false;
  /** 无遮罩 */
  @Trace noOverlayVisible: boolean = false;
  /** beforeClose 拦截 */
  @Trace beforeCloseVisible: boolean = false;
  /** 异步 beforeClose 拦截 */
  @Trace asyncBeforeCloseVisible: boolean = false;
  /** 左对齐标题 */
  @Trace leftAlignVisible: boolean = false;
  /** 自定义宽度 */
  @Trace customWidthVisible: boolean = false;
  /** 自定义圆角 */
  @Trace customRadiusVisible: boolean = false;
  /** 自定义内容 */
  @Trace customContentVisible: boolean = false;
  /** 自定义底部按钮 */
  @Trace customFooterVisible: boolean = false;
  /** 长内容模态框 */
  @Trace longContentVisible: boolean = false;
}
