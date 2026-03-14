/**
 * @file 反馈组件页面导航构建器
 * @description TuniaoUI 反馈组件（Popup 等）展示页面路由注册
 * @author JunBin.Yang
 */

import { TnPopupPage } from '../view/TnPopupPage';

/**
 * 弹出框页面导航入口
 */
@Builder
export function TnPopupNav(): void {
  TnPopupPage();
}

export const TnPopupNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnPopupNav);
