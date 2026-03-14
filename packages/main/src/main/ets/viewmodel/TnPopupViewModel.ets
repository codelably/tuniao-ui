/**
 * @file TnPopup 弹出框展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

/**
 * TnPopup 弹出框展示页面 ViewModel
 */
@ObservedV2
export default class TnPopupViewModel extends BaseViewModel {
  /** 基础弹出框（中心） */
  @Trace centerPopupVisible: boolean = false;
  /** 从顶部弹出 */
  @Trace topPopupVisible: boolean = false;
  /** 从底部弹出 */
  @Trace bottomPopupVisible: boolean = false;
  /** 从左侧弹出 */
  @Trace leftPopupVisible: boolean = false;
  /** 从右侧弹出 */
  @Trace rightPopupVisible: boolean = false;
  /** 带关闭按钮（右上） */
  @Trace closeBtnRightTopVisible: boolean = false;
  /** 带关闭按钮（左上） */
  @Trace closeBtnLeftTopVisible: boolean = false;
  /** 带关闭按钮（右下） */
  @Trace closeBtnRightBottomVisible: boolean = false;
  /** 禁止遮罩关闭 */
  @Trace noOverlayCloseVisible: boolean = false;
  /** 不显示遮罩 */
  @Trace noOverlayVisible: boolean = false;
  /** 自定义遮罩透明度 */
  @Trace customOverlayVisible: boolean = false;
  /** 自定义圆角 */
  @Trace customRadiusVisible: boolean = false;
  /** 自定义背景色 */
  @Trace customBgColorVisible: boolean = false;
  /** 自定义宽高 */
  @Trace customSizeVisible: boolean = false;
  /** 底部安全区 */
  @Trace safeAreaVisible: boolean = false;

  /** 切换中心弹框 */
  toggleCenterPopup(): void {
    this.centerPopupVisible = !this.centerPopupVisible;
  }

  /** 切换顶部弹框 */
  toggleTopPopup(): void {
    this.topPopupVisible = !this.topPopupVisible;
  }

  /** 切换底部弹框 */
  toggleBottomPopup(): void {
    this.bottomPopupVisible = !this.bottomPopupVisible;
  }

  /** 切换左侧弹框 */
  toggleLeftPopup(): void {
    this.leftPopupVisible = !this.leftPopupVisible;
  }

  /** 切换右侧弹框 */
  toggleRightPopup(): void {
    this.rightPopupVisible = !this.rightPopupVisible;
  }
}
