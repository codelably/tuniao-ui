/**
 * @file 布局组件页面导航构建器
 * @description TuniaoUI 布局组件（List、Collapse、Sticky、WaterFall、SwitchTab 等）展示页面路由注册
 * @author JunBin.Yang
 */

import { TnListPage } from '../view/TnListPage';
import { TnCollapsePage } from '../view/TnCollapsePage';
import { TnStickyPage } from '../view/TnStickyPage';
import { TnWaterFallPage } from '../view/TnWaterFallPage';
import { TnSwitchTabPage } from '../view/TnSwitchTabPage';
import { TnSubsectionPage } from '../view/TnSubsectionPage';
import { TnSearchBoxPage } from '../view/TnSearchBoxPage';

/**
 * 列表页面导航入口
 * @returns {void} 无返回值
 */
@Builder
export function TnListNav(): void {
  TnListPage();
}

/**
 * 导出包装后的构建器
 */
export const TnListNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnListNav);

/**
 * 折叠面板页面导航入口
 * @returns {void} 无返回值
 */
@Builder
export function TnCollapseNav(): void {
  TnCollapsePage();
}

/**
 * 导出包装后的构建器
 */
export const TnCollapseNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnCollapseNav);

/**
 * 吸顶页面导航入口
 * @returns {void} 无返回值
 */
@Builder
export function TnStickyNav(): void {
  TnStickyPage();
}

/**
 * 导出包装后的构建器
 */
export const TnStickyNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnStickyNav);

/**
 * 瀑布流页面导航入口
 * @returns {void} 无返回值
 */
@Builder
export function TnWaterFallNav(): void {
  TnWaterFallPage();
}

/**
 * 导出包装后的构建器
 */
export const TnWaterFallNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnWaterFallNav);

/**
 * 选项卡切换页面导航入口
 * @returns {void} 无返回值
 */
@Builder
export function TnSwitchTabNav(): void {
  TnSwitchTabPage();
}

/**
 * 导出包装后的构建器
 */
export const TnSwitchTabNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnSwitchTabNav);

/**
 * 分段器页面导航入口
 * @returns {void} 无返回值
 */
@Builder
export function TnSubsectionNav(): void {
  TnSubsectionPage();
}

/**
 * 导出包装后的构建器
 */
export const TnSubsectionNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnSubsectionNav);

/**
 * 搜索框页面导航入口
 * @returns {void} 无返回值
 */
@Builder
export function TnSearchBoxNav(): void {
  TnSearchBoxPage();
}

/**
 * 导出包装后的构建器
 */
export const TnSearchBoxNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnSearchBoxNav);
