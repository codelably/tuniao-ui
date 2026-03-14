/**
 * @file TnRadio 单选框组件类型定义
 * @author JunBin.Yang
 */

/**
 * 单选框值类型
 */
export type TnRadioValueType = string | number | boolean;

/**
 * TnRadio 组件属性接口
 */
export interface TnRadioProps {
  /** 分组标识，与 TnRadioGroup 的 group 保持一致 */
  group?: string;
  /** 单选框的值 */
  label?: TnRadioValueType;
  /** 禁用 */
  disabled?: boolean;
  /** 禁用标签点击切换 */
  labelDisabled?: boolean;
  /** 激活颜色（主题色名或 hex） */
  activeColor?: string;
  /** 尺寸(vp)，0 为默认 */
  radioSize?: number;
  /** 显示边框 */
  showBorder?: boolean;
  /** 值变化回调 */
  onChange?: (value: TnRadioValueType) => void;
}

/**
 * TnRadioGroup 组件属性接口
 */
export interface TnRadioGroupProps {
  /** 分组标识，子项 TnRadio 需传入相同的 group 值 */
  group?: string;
  /** 当前选中值 */
  modelValue?: TnRadioValueType;
  /** 禁用所有子项 */
  disabled?: boolean;
  /** 是否换行排列 */
  wrap?: boolean;
  /** 激活颜色 */
  activeColor?: string;
  /** 尺寸(vp)，0 为默认 */
  groupSize?: number;
  /** 值变化回调 */
  onChange?: (value: TnRadioValueType) => void;
}

/**
 * RadioGroup 事件名称
 */
export enum TN_RADIO_GROUP_EVENT {
  /** 组选中值变更 */
  VALUE_CHANGE = "VALUE_CHANGE",
  /** 子项点击上报 */
  ITEM_CLICK = "ITEM_CLICK",
  /** 组配置下发 */
  CONFIG = "CONFIG"
}

/**
 * RadioGroup 事件名称前缀
 */
export const TN_RADIO_GROUP_PREFIX: string = "TN_RADIO_GROUP";

/**
 * 构建 RadioGroup 事件名称
 * @param event 事件类型
 * @param groupId 组唯一标识
 * @returns 格式化后的事件名称
 */
export function getTnRadioGroupEventName(event: TN_RADIO_GROUP_EVENT, groupId: string): string {
  return `${TN_RADIO_GROUP_PREFIX}_${event}_${groupId}`;
}

/**
 * RadioGroup 下发给 Radio 的配置
 */
export interface TnRadioGroupConfig {
  /** 当前选中值 */
  selectedValue: TnRadioValueType;
  /** 是否禁用 */
  disabled: boolean;
  /** 激活颜色 */
  activeColor: string;
  /** 尺寸 */
  size: number;
}
