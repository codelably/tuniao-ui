/**
 * @file TnCheckbox 复选框组件类型定义
 * @author JunBin.Yang
 */

/**
 * 复选框值类型
 */
export type TnCheckboxValueType = string | number | boolean;

/**
 * 复选框选中图标形状
 */
export enum TnCheckboxShape {
  /** 方形，选中显示勾 */
  SQUARE = "square",
  /** 圆形，选中显示圆点 */
  CIRCLE = "circle"
}

/**
 * TnCheckbox 组件属性接口
 */
export interface TnCheckboxProps {
  /** 分组标识，与 TnCheckboxGroup 的 group 保持一致 */
  group?: string;
  /** 复选框的值 */
  label?: TnCheckboxValueType;
  /** 禁用 */
  disabled?: boolean;
  /** 禁用标签点击切换 */
  labelDisabled?: boolean;
  /** 激活颜色（主题色名或 hex） */
  activeColor?: string;
  /** 尺寸(vp)，0 为默认 */
  checkboxSize?: number;
  /** 显示边框 */
  showBorder?: boolean;
  /** 半选状态（用于全选） */
  indeterminate?: boolean;
  /** 选中图标形状 */
  shape?: TnCheckboxShape;
  /** 值变化回调 */
  onChange?: (value: TnCheckboxValueType) => void;
}

/**
 * TnCheckboxGroup 组件属性接口
 */
export interface TnCheckboxGroupProps {
  /** 分组标识，子项 TnCheckbox 需传入相同的 group 值 */
  group?: string;
  /** 选中值数组 */
  modelValue?: Array<string | number>;
  /** 禁用所有子项 */
  disabled?: boolean;
  /** 是否换行排列 */
  wrap?: boolean;
  /** 激活颜色 */
  activeColor?: string;
  /** 尺寸(vp) */
  groupSize?: number;
  /** 最少选择数 */
  min?: number;
  /** 最多选择数 */
  max?: number;
  /** 值变化回调 */
  onChange?: (value: Array<string | number>) => void;
}

/**
 * CheckboxGroup 事件名称
 */
export enum TN_CHECKBOX_GROUP_EVENT {
  /** 组选中值变更 */
  VALUE_CHANGE = "VALUE_CHANGE",
  /** 子项点击上报 */
  ITEM_CLICK = "ITEM_CLICK",
  /** 组配置下发 */
  CONFIG = "CONFIG"
}

/**
 * CheckboxGroup 事件名称前缀
 */
export const TN_CHECKBOX_GROUP_PREFIX: string = "TN_CHECKBOX_GROUP";

/**
 * 构建 CheckboxGroup 事件名称
 * @param event 事件类型
 * @param groupId 组唯一标识
 * @returns 格式化后的事件名称
 */
export function getTnCheckboxGroupEventName(event: TN_CHECKBOX_GROUP_EVENT, groupId: string): string {
  return `${TN_CHECKBOX_GROUP_PREFIX}_${event}_${groupId}`;
}

/**
 * CheckboxGroup 下发给 Checkbox 的配置
 */
export interface TnCheckboxGroupConfig {
  /** 当前选中值数组 */
  selectedValues: Array<string | number>;
  /** 是否禁用 */
  disabled: boolean;
  /** 激活颜色 */
  activeColor: string;
  /** 尺寸 */
  size: number;
  /** 最小选择数 */
  min: number;
  /** 最大选择数 */
  max: number;
}
