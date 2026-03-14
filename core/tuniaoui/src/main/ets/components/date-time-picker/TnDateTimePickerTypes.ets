/**
 * @file TnDateTimePicker 日期时间选择器类型定义
 * @author JunBin.Yang
 */

/**
 * 日期时间选择器模式
 */
export type TnDateTimePickerMode = "year" | "yearmonth" | "date" | "datetime" | "time";

/**
 * TnDateTimePicker 组件属性接口
 */
export interface TnDateTimePickerProps {
  /** 绑定值（日期字符串） */
  modelValue?: string;
  /** 显示/隐藏 */
  open?: boolean;
  /** 模式 */
  mode?: TnDateTimePickerMode;
  /** 最小时间 */
  minTime?: string;
  /** 最大时间 */
  maxTime?: string;
  /** 格式化字符串 */
  format?: string;
  /** 空值时初始化为当前时间 */
  initCurrentDateTime?: boolean;
  /** 标题 */
  title?: string;
  /** 确认回调 */
  onConfirm?: (value: string) => void;
  /** 取消回调 */
  onCancel?: () => void;
  /** 关闭回调 */
  onClose?: () => void;
  /** 变化回调 */
  onChange?: (value: string) => void;
}
