/**
 * @file 布局组件页面导航构建器
 * @description TuniaoUI 布局组件（List 等）展示页面路由注册
 * @author JunBin.Yang
 */

import { TnListPage } from '../view/TnListPage';

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
