/**
 * @file TnPopup 弹出框组件类型定义
 * @description 定义弹出方向、关闭按钮位置、内部控制器等类型
 * @author JunBin.Yang
 */

/**
 * 弹出框打开方向
 * - center: 中心弹出
 * - top: 从顶部弹出
 * - bottom: 从底部弹出
 * - left: 从左侧弹出
 * - right: 从右侧弹出
 */
export type TnPopupOpenDirection = "center" | "top" | "bottom" | "left" | "right";

/**
 * 关闭按钮位置
 * - left-top: 左上角
 * - right-top: 右上角
 * - left-bottom: 左下角
 * - right-bottom: 右下角
 */
export type TnPopupCloseBtnPosition = "left-top" | "right-top" | "left-bottom" | "right-bottom";

/**
 * 弹出框内部控制器，用于在容器层触发内容层的隐藏动画
 */
export class TnPopupBaseController {
  /**
   * 触发内容层隐藏动画（回到初始位置）
   */
  hide: () => void = () => {};
}
