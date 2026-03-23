/**
 * @file TnModal 模态框组件类型定义
 * @description 定义模态框按钮操作类型、按钮样式、前置拦截回调等类型
 * @author JunBin.Yang
 */

/**
 * 模态框按钮操作类型
 * - cancel: 取消操作
 * - confirm: 确认操作
 */
export type TnModalAction = "cancel" | "confirm";

/**
 * 标题文本对齐方式
 * - left: 左对齐
 * - center: 居中对齐
 * - right: 右对齐
 */
export type TnModalTextAlign = "left" | "center" | "right";

/**
 * 模态框关闭前拦截回调类型
 * 返回 false 或 Promise<false> 可阻止模态框关闭
 * @param action 当前触发的操作类型（cancel 或 confirm）
 * @returns boolean 或 Promise<boolean>，false 时阻止关闭
 */
export type TnModalBeforeClose = (action: TnModalAction) => boolean | Promise<boolean>;
