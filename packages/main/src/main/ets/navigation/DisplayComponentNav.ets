/**
 * @file 展示组件页面导航构建器
 * @description TuniaoUI 展示组件展示页面路由注册
 * @author JunBin.Yang
 */

import { TnPhotoAlbumPage } from '../view/TnPhotoAlbumPage';
import { TnSwiperPage } from '../view/TnSwiperPage';
import { TnProgressPage } from '../view/TnProgressPage';
import { TnCountDownPage } from '../view/TnCountDownPage';
import { TnCountToPage } from '../view/TnCountToPage';
import { TnCountScrollPage } from '../view/TnCountScrollPage';
import { TnReadMorePage } from '../view/TnReadMorePage';

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

/**
 * 进度条页面导航入口
 */
@Builder
export function TnProgressNav(): void {
  TnProgressPage();
}

export const TnProgressNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnProgressNav);

/**
 * 倒计时页面导航入口
 */
@Builder
export function TnCountDownNav(): void {
  TnCountDownPage();
}

export const TnCountDownNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnCountDownNav);

/**
 * 数字跳转页面导航入口
 */
@Builder
export function TnCountToNav(): void {
  TnCountToPage();
}

export const TnCountToNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnCountToNav);

/**
 * 数字滚动页面导航入口
 */
@Builder
export function TnCountScrollNav(): void {
  TnCountScrollPage();
}

export const TnCountScrollNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnCountScrollNav);

/**
 * 阅读更多页面导航入口
 */
@Builder
export function TnReadMoreNav(): void {
  TnReadMorePage();
}

export const TnReadMoreNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnReadMoreNav);
