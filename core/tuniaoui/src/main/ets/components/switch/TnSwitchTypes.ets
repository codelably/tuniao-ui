/**
 * @file TnSwitch 开关组件类型定义
 * @author JunBin.Yang
 */

import { TnComponentColorType } from "../../common/theme_helpers";

/**
 * 开关形状类型
 */
export type TnSwitchShapeType = "square" | "round";

/**
 * 开关值类型
 */
export type TnSwitchValueType = string | number | boolean;

/**
 * TnSwitch 组件属性接口
 */
export interface TnSwitchProps {
  /** 绑定值，默认 false */
  modelValue?: TnSwitchValueType;
  /** 激活时的值，默认 true */
  activeValue?: TnSwitchValueType;
  /** 未激活时的值，默认 false */
  inactiveValue?: TnSwitchValueType;
  /** 激活颜色（主题色名或 hex） */
  activeColor?: TnComponentColorType | string;
  /** 未激活颜色 */
  inactiveColor?: string;
  /** 激活文字 */
  activeText?: string;
  /** 未激活文字 */
  inactiveText?: string;
  /** 激活图标 */
  activeIcon?: string;
  /** 未激活图标 */
  inactiveIcon?: string;
  /** 形状，默认 "round" */
  shape?: TnSwitchShapeType;
  /** 尺寸(vp)，0 表示默认 */
  switchSize?: number;
  /** 禁用状态 */
  disabled?: boolean;
  /** 加载状态 */
  loading?: boolean;
  /** 值变化回调 */
  onChange?: (value: TnSwitchValueType) => void;
}
