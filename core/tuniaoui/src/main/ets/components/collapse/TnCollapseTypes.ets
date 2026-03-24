/**
 * @file TnCollapse 折叠面板类型定义
 * @description 折叠面板组件的事件枚举与辅助函数
 * @author JunBin.Yang
 */

/**
 * 组件标识
 */
const COMPONENT_NAME = "TN_COLLAPSE";

/**
 * 折叠面板事件枚举
 */
export enum TN_COLLAPSE_EVENT {
  /** 父组件初始化/更新子组件展开状态 */
  INIT_ITEM = "INIT_ITEM",
  /** 子组件通知父组件切换展开状态 */
  ITEM_TOGGLE = "ITEM_TOGGLE"
}

/**
 * 拼接折叠面板事件名
 * @param event 事件类型
 * @param groupId 分组标识
 * @returns 完整事件名
 */
export function getTnCollapseEventName(event: TN_COLLAPSE_EVENT, groupId: string): string {
  return `${COMPONENT_NAME}_${event}_${groupId}`;
}
