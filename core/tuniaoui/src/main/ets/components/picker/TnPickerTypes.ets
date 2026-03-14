/**
 * @file TnPicker 选择器组件类型定义
 * @author JunBin.Yang
 */

/**
 * Picker 列数据项
 */
export interface TnPickerColumnItem {
  /** 显示文字 */
  label: string;
  /** 值 */
  value: string | number;
  /** 子项（级联模式） */
  children?: TnPickerColumnItem[];
}

/**
 * Picker 值类型
 */
export type TnPickerValueType = string | number | Array<string | number>;

/**
 * TnPicker 组件属性接口
 */
export interface TnPickerProps {
  /** 绑定值 */
  modelValue?: TnPickerValueType;
  /** 显示/隐藏 */
  open?: boolean;
  /** 列数据 */
  data?: TnPickerColumnItem[][];
  /** 显示取消按钮 */
  showCancel?: boolean;
  /** 取消按钮文字 */
  cancelText?: string;
  /** 显示确认按钮 */
  showConfirm?: boolean;
  /** 确认按钮文字 */
  confirmText?: string;
  /** 标题 */
  title?: string;
  /** 级联数据（联动选择器） */
  cascadeData?: TnPickerColumnItem[];
  /** 确认回调 */
  onConfirm?: (value: TnPickerValueType, index: number | number[]) => void;
  /** 取消回调 */
  onCancel?: () => void;
  /** 关闭回调 */
  onClose?: () => void;
  /** 列值变化回调 */
  onChange?: (value: TnPickerValueType, index: number | number[]) => void;
}
