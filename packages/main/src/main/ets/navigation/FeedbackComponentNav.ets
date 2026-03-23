/**
 * @file 反馈组件页面导航构建器
 * @description TuniaoUI 反馈组件（Popup、Modal、Notify 等）展示页面路由注册
 * @author JunBin.Yang
 */

import { TnPopupPage } from '../view/TnPopupPage';
import { TnModalPage } from '../view/TnModalPage';
import { TnNotifyPage } from '../view/TnNotifyPage';

/**
 * 弹出框页面导航入口
 */
@Builder
export function TnPopupNav(): void {
  TnPopupPage();
}

export const TnPopupNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnPopupNav);

/**
 * 模态框页面导航入口
 */
@Builder
export function TnModalNav(): void {
  TnModalPage();
}

export const TnModalNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnModalNav);

/**
 * 消息通知页面导航入口
 */
@Builder
export function TnNotifyNav(): void {
  TnNotifyPage();
}

export const TnNotifyNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnNotifyNav);
