/**
 * @file TnNoticeBar 通知栏组件类型定义
 * @description 定义通知栏方向、模式、事件等类型
 * @author JunBin.Yang
 */

/**
 * 滚动方向
 * - horizontal: 水平滚动
 * - vertical: 垂直滚动
 */
export type TnNoticeBarDirection = "horizontal" | "vertical";

/**
 * 通知栏模式
 * - closeable: 可关闭模式（右侧显示关闭图标）
 * - link: 链接模式（右侧显示箭头图标）
 */
export type TnNoticeBarMode = "closeable" | "link";
