/**
 * @file 基础组件页面导航构建器
 * @description TuniaoUI 基础组件（Icon、Button、Tag、Badge 等）展示页面路由注册
 * @author JunBin.Yang
 */

import { TnIconPage } from '../view/TnIconPage';
import { TnButtonPage } from '../view/TnButtonPage';
import { TnTagPage } from '../view/TnTagPage';
import { TnBadgePage } from '../view/TnBadgePage';
import { TnLoadingPage } from '../view/TnLoadingPage';

/**
 * 图标页面导航入口
 * @returns {void} 无返回值
 */
@Builder
export function TnIconNav(): void {
  TnIconPage();
}

/**
 * 导出包装后的构建器
 */
export const TnIconNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnIconNav);

/**
 * 按钮页面导航入口
 * @returns {void} 无返回值
 */
@Builder
export function TnButtonNav(): void {
  TnButtonPage();
}

/**
 * 导出包装后的构建器
 */
export const TnButtonNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnButtonNav);

/**
 * 标签页面导航入口
 * @returns {void} 无返回值
 */
@Builder
export function TnTagNav(): void {
  TnTagPage();
}

/**
 * 导出包装后的构建器
 */
export const TnTagNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnTagNav);

/**
 * 徽标页面导航入口
 * @returns {void} 无返回值
 */
@Builder
export function TnBadgeNav(): void {
  TnBadgePage();
}

/**
 * 导出包装后的构建器
 */
export const TnBadgeNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnBadgeNav);

/**
 * 加载页面导航入口
 * @returns {void} 无返回值
 */
@Builder
export function TnLoadingNav(): void {
  TnLoadingPage();
}

/**
 * 导出包装后的构建器
 */
export const TnLoadingNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnLoadingNav);
