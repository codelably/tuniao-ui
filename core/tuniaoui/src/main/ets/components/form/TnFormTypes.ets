/**
 * @file 表单类型定义
 * @description 提供表单系统核心类型：验证规则、字段值类型、验证结果、表单控制器等
 * @author JunBin.Yang
 */

/**
 * 表单验证规则项
 */
export interface TnFormRuleItem {
  /** 是否必填 */
  required?: boolean;
  /** 验证失败提示消息 */
  message?: ResourceStr;
  /** 正则表达式校验 */
  pattern?: RegExp;
  /** 自定义验证器（返回 true 表示通过，字符串为错误消息） */
  validator?: (value: string) => boolean | string | Promise<boolean | string>;
  /** 触发时机 */
  trigger?: "blur" | "change";
  /** 最小长度/最小值 */
  min?: number;
  /** 最大长度/最大值 */
  max?: number;
}

/**
 * 表单验证规则集合（按字段名索引）
 */
export type TnFormRules = Record<string, TnFormRuleItem[]>;

/**
 * 表单字段值类型
 */
export type TnFieldValueType = string | number | boolean | Array<string | number> | Array<Resource>;

/**
 * 字段验证错误信息
 */
export interface TnFieldValidateInfo {
  /** 字段标签 */
  label: string;
  /** 字段名称 */
  name: string;
  /** 错误消息 */
  message: string;
}

/**
 * 表单验证结果
 */
export interface TnFormValidateResult {
  /** 验证是否通过 */
  valid: boolean;
  /** 验证失败的字段信息列表 */
  fields: TnFieldValidateInfo[];
}

/**
 * 单个字段验证结果
 */
export interface TnFieldValidateResult {
  /** 验证是否通过 */
  valid: boolean;
  /** 验证失败的字段信息 */
  field: TnFieldValidateInfo;
}

/**
 * 表单项注册信息（FormItem 向 Form 注册时使用）
 */
export interface TnFieldItem {
  /** 唯一标识 */
  uniId: string;
  /** 字段名称 */
  prop: string;
  /** 验证方法 */
  validate: () => Promise<TnFieldValidateInfo>;
  /** 重置验证 */
  resetValidation: () => void;
  /** 获取当前值 */
  getValue: () => TnFieldValueType;
  /** 设置值 */
  setValue: (value: TnFieldValueType) => void;
}

/**
 * 标签位置类型
 */
export type TnLabelPosition = "left" | "top";

/**
 * 必填星号位置
 */
export type TnRequireAsteriskPosition = "left" | "right";

/**
 * Form 向 FormItem 下发的配置
 */
export interface TnFormSendFieldCallResult {
  /** 验证规则 */
  rules: TnFormRuleItem[];
  /** 标签宽度(vp) */
  labelWidth: number;
  /** 标签位置 */
  labelPosition: TnLabelPosition;
  /** 是否显示冒号 */
  colon: boolean;
  /** 必填星号位置 */
  requireAsteriskPosition: TnRequireAsteriskPosition;
  /** 是否显示验证消息 */
  showMessage: boolean;
  /** 是否禁用 */
  disabled: boolean;
}

/**
 * 表单事件名称枚举
 */
export enum TN_FORM_EVENT {
  /** FormItem 向 Form 注册 */
  SEND_FIELD = "SEND_FIELD",
  /** 验证整个表单 */
  VALIDATE = "VALIDATE",
  /** 验证某个字段 */
  VALIDATE_FIELD = "VALIDATE_FIELD",
  /** 重置验证 */
  RESET_VALIDATE = "RESET_VALIDATE",
  /** 获取所有值 */
  GET_VALUES = "GET_VALUES",
  /** 设置表单值 */
  SET_VALUES = "SET_VALUES",
  /** 删除表单项 */
  DELETE_FIELD = "DELETE_FIELD"
}

/**
 * 表单组件名称常量（用于事件名称拼接）
 */
export const TN_FORM_COMPONENT_NAME: string = "TN_FORM";

/**
 * 构建表单事件名称
 * @param event 事件类型
 * @param formId 表单唯一标识
 * @returns 格式化后的事件名称
 */
export function getTnFormEventName(event: TN_FORM_EVENT, formId: string): string {
  return `${TN_FORM_COMPONENT_NAME}_${event}_${formId}`;
}

/**
 * 表单控制器
 * @description 提供外部操作表单的能力，包括验证、重置、获取/设置值等
 */
export class TnFormController {
  /**
   * 验证整个表单
   * @param callBack 回调函数
   * @returns 验证结果 Promise
   */
  public validate: (callBack?: (valid: boolean, fields: TnFieldValidateInfo[]) => void) => Promise<TnFormValidateResult> =
    (): Promise<TnFormValidateResult> => {
      const res: TnFormValidateResult = { valid: true, fields: [] };
      return Promise.resolve(res);
    };

  /**
   * 验证某个字段
   * @param name 字段名
   * @param callBack 回调函数
   * @returns 验证结果 Promise
   */
  public validateField: (name: string, callBack?: (valid: boolean, field?: TnFieldValidateInfo) => void) => Promise<TnFieldValidateResult> =
    (): Promise<TnFieldValidateResult> => {
      const res: TnFieldValidateResult = {
        valid: true,
        field: { label: "", name: "", message: "" }
      };
      return Promise.resolve(res);
    };

  /**
   * 重置校验结果
   * @param name 字段名或字段名数组（不传则重置所有）
   */
  public resetValidation: (name?: string | string[]) => void = (): void => {};

  /**
   * 获取表单所有值
   * @returns 字段名到值的映射
   */
  public getFormValues: () => Record<string, TnFieldValueType> = (): Record<string, TnFieldValueType> => {
    const res: Record<string, TnFieldValueType> = {};
    return res;
  };

  /**
   * 设置表单值
   * @param values 字段名到值的映射
   */
  public setFormValues: (values: Record<string, TnFieldValueType>) => void = (): void => {};
}
