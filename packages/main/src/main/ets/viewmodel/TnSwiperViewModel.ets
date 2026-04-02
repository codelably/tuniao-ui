/**
 * @file TnSwiper 轮播图展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

/** 示例轮播图数据 */
const SWIPER_IMAGES: string[] = [
  "https://resource.tuniaokj.com/images/xiongjie/x14.jpg",
  "https://resource.tuniaokj.com/images/xiongjie/xiong-3d-2.jpg",
  "https://resource.tuniaokj.com/images/xiongjie/xiong-3d-new.jpg",
  "https://resource.tuniaokj.com/images/xiongjie/xiong-3d-new1.png",
  "https://resource.tuniaokj.com/images/xiongjie/xiong-3d.jpg"
];

/**
 * TnSwiper 轮播图展示页面 ViewModel
 */
@ObservedV2
export default class TnSwiperViewModel extends BaseViewModel {
  /**
   * 完整的轮播图数据
   */
  readonly allImages: string[] = SWIPER_IMAGES;

  /**
   * 少量图片数据（用于展示部分场景）
   */
  readonly fewImages: string[] = SWIPER_IMAGES.slice(0, 3);

  /**
   * 当前选中索引（用于受控模式演示）
   */
  @Trace currentIndex: number = 0;
}
