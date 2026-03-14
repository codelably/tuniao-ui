/**
 * @file TnLoading 加载组件类型定义
 * @description 定义 TnLoading 组件的所有类型、接口和配置
 * @author JunBin.Yang
 */

import { TnComponentColorType } from "../../common/theme_helpers";

/**
 * 加载动画颜色类型
 * 复用通用组件颜色类型
 */
export type TnLoadingColorType = TnComponentColorType;

/**
 * 加载动画模式类型
 * - circle: 圆圈旋转动画（默认）
 * - flower: 花瓣步进动画
 * - semicircle: 半圆旋转动画
 */
export type TnLoadingModeType = "circle" | "flower" | "semicircle";

/**
 * 加载组件尺寸类型
 * - sm: 小尺寸
 * - lg: 大尺寸
 * - xl: 超大尺寸
 */
export type TnLoadingSizeType = "sm" | "lg" | "xl";

/**
 * 尺寸配置接口
 */
export interface TnLoadingSizeConfig {
  /**
   * 加载图标尺寸（vp）
   */
  iconSize: number;
  /**
   * 花瓣条宽度（vp）
   */
  flowerBarWidth: number;
  /**
   * 边框宽度（vp）
   */
  borderWidth: number;
}

/**
 * TnLoading 组件属性接口
 */
export interface TnLoadingProps {
  /**
   * 是否显示加载动画
   */
  show?: boolean;
  /**
   * 加载动画模式
   */
  mode?: TnLoadingModeType;
  /**
   * 颜色类型
   */
  type?: TnLoadingColorType;
  /**
   * 自定义颜色
   */
  color?: ResourceColor;
  /**
   * 加载图标尺寸
   */
  loadingSize?: TnLoadingSizeType;
  /**
   * 自定义尺寸数值（vp）
   */
  customSize?: number;
  /**
   * 动画持续时间（毫秒）
   */
  duration?: number;
  /**
   * 动画缓动函数
   */
  timingCurve?: Curve;
  /**
   * 加载提示文字
   */
  text?: string;
  /**
   * 文字颜色
   */
  textColor?: ResourceColor;
  /**
   * 文字大小
   */
  textSize?: number | string;
}
