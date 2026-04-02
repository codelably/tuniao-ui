/**
 * @file TnPhotoAlbum 相册展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

/** 示例相册图片数据 */
const ALBUM_IMAGES: string[] = [
  "https://resource.tuniaokj.com/images/album/xiong1.jpg",
  "https://resource.tuniaokj.com/images/album/xiong2.jpg",
  "https://resource.tuniaokj.com/images/album/xiong3.jpg",
  "https://resource.tuniaokj.com/images/album/xiong4.jpg",
  "https://resource.tuniaokj.com/images/album/xiong5.jpg",
  "https://resource.tuniaokj.com/images/album/xiong6.jpg",
  "https://resource.tuniaokj.com/images/album/xiong7.jpg",
  "https://resource.tuniaokj.com/images/album/xiong8.jpg",
  "https://resource.tuniaokj.com/images/album/xiong9.jpg",
  "https://resource.tuniaokj.com/images/album/xiong10.jpg",
];

/**
 * TnPhotoAlbum 相册展示页面 ViewModel
 */
@ObservedV2
export default class TnPhotoAlbumViewModel extends BaseViewModel {
  /**
   * 完整的相册图片数据
   */
  readonly allImages: string[] = ALBUM_IMAGES;

  /**
   * 少量图片数据（用于展示不同数量场景）
   */
  readonly fewImages: string[] = ALBUM_IMAGES.slice(0, 3);

  /**
   * 中等数量图片数据
   */
  readonly mediumImages: string[] = ALBUM_IMAGES.slice(0, 6);
}
