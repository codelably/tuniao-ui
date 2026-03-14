/**
 * @file TnInput 输入框组件类型定义
 * @author JunBin.Yang
 */

/**
 * 输入框类型
 */
export type TnInputType = "text" | "number" | "password" | "textarea" | "digit" | "idcard";

/**
 * 输入框文本对齐方式
 */
export type TnInputTextAlign = "left" | "center" | "right";

/**
 * 输入框预设尺寸
 * - "sm": 小尺寸（高度 24vp，字体 12）
 * - "": 默认尺寸（高度 32vp，字体 14）
 * - "lg": 大尺寸（高度 40vp，字体 16）
 */
export type TnInputSize = "sm" | "" | "lg";

/**
 * 尺寸配置项
 */
export interface TnInputSizeConfig {
  /** 输入框高度(vp) */
  height: number;
  /** 字体大小 key（baseStyle 属性名） */
  fontSizeKey: string;
  /** 内边距(vp) */
  padding: number;
}

/**
 * TnInput 组件属性接口
 */
export interface TnInputProps {
  /** 绑定值 */
  modelValue?: string | number;
  /** 输入类型，默认 "text" */
  type?: TnInputType;
  /** 占位文本 */
  placeholder?: string;
  /** 占位文本颜色 */
  placeholderColor?: ResourceColor;
  /** 禁用 */
  disabled?: boolean;
  /** 只读 */
  readonly?: boolean;
  /** 显示清除按钮 */
  clearable?: boolean;
  /** 密码可见切换 */
  showPassword?: boolean;
  /** 最大输入长度（-1 无限制） */
  maxlength?: number;
  /** 显示字数统计 */
  showWordLimit?: boolean;
  /** textarea 自适应高度 */
  autoHeight?: boolean;
  /** 显示边框 */
  border?: boolean;
  /** 边框颜色 */
  borderColor?: ResourceColor;
  /** 下划线风格 */
  underline?: boolean;
  /** 文本对齐 */
  textAlign?: TnInputTextAlign;
  /** 自动去首尾空格 */
  trim?: boolean;
  /** 输入框高度(vp) */
  height?: number;
  /** 右侧图标 */
  rightIcon?: string;
  /** 键盘确认按钮文字 */
  confirmType?: string;
  /** 预设尺寸 */
  inputSize?: TnInputSize;
  /** 输入回调 */
  onInput?: (value: string) => void;
  /** 变化回调 */
  onChange?: (value: string) => void;
  /** 获取焦点回调 */
  onFocus?: () => void;
  /** 失去焦点回调 */
  onBlur?: () => void;
  /** 清除回调 */
  onClear?: () => void;
  /** 确认回调 */
  onConfirm?: (value: string) => void;
  /** 点击回调 */
  onClick?: () => void;
}
