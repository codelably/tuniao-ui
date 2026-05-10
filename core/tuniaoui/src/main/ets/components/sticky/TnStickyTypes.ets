/**
 * @file TnSticky 吸顶组件类型定义
 * @description 吸顶组件的属性接口定义
 * @author JunBin.Yang
 */

/**
 * TnSticky 组件属性接口
 */
export interface TnStickyProps {
  /**
   * 是否开启粘性布局
   */
  stickyEnabled?: boolean;
  /**
   * 父级 Scroll 容器的当前滚动偏移量（yOffset）
   */
  scrollTop?: number;
  /**
   * 吸顶时距离顶部的距离（单位 vp）
   */
  offsetTop?: number;
  /**
   * 吸顶时的 z-index 层级
   */
  stickyZIndex?: number;
  /**
   * 吸顶时的背景色
   */
  bgColor?: ResourceColor;
  /**
   * 吸顶状态变化回调
   * @param fixed 是否已吸顶
   */
  onChange?: (fixed: boolean) => void;
}
