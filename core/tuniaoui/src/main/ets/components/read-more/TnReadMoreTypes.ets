/**
 * @file TnReadMore 组件类型定义
 * @description 阅读更多组件的参数类型、回调类型定义
 * @author JunBin.Yang
 */

import { TnComponentColorType } from "../../common/theme_helpers";

/**
 * 展开前回调函数类型
 * - 返回 Promise<boolean> 或 boolean
 * - 返回 false 或 Promise resolve(false) 则阻止展开
 */
export type TnReadMoreBeforeExpand = () => Promise<boolean> | boolean;

/**
 * TnReadMore 组件参数接口
 */
export interface TnReadMoreProps {
  /**
   * 是否展开
   */
  expand?: boolean;
  /**
   * 收起时显示内容的高度，单位 vp
   */
  collapseHeight?: number;
  /**
   * 是否显示收起按钮
   */
  showFold?: boolean;
  /**
   * 展开时操作文案
   */
  expandText?: string;
  /**
   * 展开时显示的图标名称
   */
  expandIcon?: string;
  /**
   * 收起时操作文案
   */
  foldText?: string;
  /**
   * 收起时显示的图标名称
   */
  foldIcon?: string;
  /**
   * 操作区域文字颜色
   */
  tipColor?: ResourceColor;
  /**
   * 主题颜色类型（不设置 tipColor 时生效）
   */
  colorType?: TnComponentColorType;
  /**
   * 动画时长，单位 ms（不设置则使用 baseStyle.animationDuration）
   */
  duration?: number;
  /**
   * 是否一次性展开（展开后不再显示收起按钮）
   */
  once?: boolean;
  /**
   * 展开前回调
   */
  beforeExpand?: TnReadMoreBeforeExpand;
}
