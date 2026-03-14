/**
 * @file TnImagePreview 图片预览展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

/**
 * 示例图片地址列表
 */
const DEMO_IMAGES: string[] = [
  "https://picsum.photos/id/10/800/600",
  "https://picsum.photos/id/20/800/600",
  "https://picsum.photos/id/30/800/600",
  "https://picsum.photos/id/40/800/600",
  "https://picsum.photos/id/50/800/600"
];

/**
 * TnImagePreview 图片预览展示页面 ViewModel
 */
@ObservedV2
export default class TnImagePreviewViewModel extends BaseViewModel {
  /**
   * 示例图片列表
   */
  @Trace readonly imageList: string[] = DEMO_IMAGES;

  /**
   * 当前点击的图片索引（用于展示回调信息）
   */
  @Trace clickedIndex: number = -1;

  /**
   * 当前长按的图片索引（用于展示回调信息）
   */
  @Trace longPressIndex: number = -1;

  /**
   * 更新点击索引
   * @param index 图片索引
   */
  updateClickedIndex(index: number): void {
    this.clickedIndex = index;
  }

  /**
   * 更新长按索引
   * @param index 图片索引
   */
  updateLongPressIndex(index: number): void {
    this.longPressIndex = index;
  }
}
