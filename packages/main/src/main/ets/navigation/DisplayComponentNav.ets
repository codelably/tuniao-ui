/**
 * @file 展示组件页面导航构建器
 * @description TuniaoUI 展示组件展示页面路由注册
 * @author JunBin.Yang
 */

import { TnPhotoAlbumPage } from '../view/TnPhotoAlbumPage';
import { TnSwiperPage } from '../view/TnSwiperPage';

/**
 * 相册页面导航入口
 */
@Builder
export function TnPhotoAlbumNav(): void {
  TnPhotoAlbumPage();
}

export const TnPhotoAlbumNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnPhotoAlbumNav);

/**
 * 轮播图页面导航入口
 */
@Builder
export function TnSwiperNav(): void {
  TnSwiperPage();
}

export const TnSwiperNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnSwiperNav);
