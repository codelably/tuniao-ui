/**
 * @file TnFormItem 组件类型定义
 * @description 表单项容器组件的属性接口
 * @author JunBin.Yang
 */

import { TnFormRuleItem, TnLabelPosition, TnRequireAsteriskPosition } from "./TnFormTypes";

/**
 * TnFormItem 组件属性接口
 */
export interface TnFormItemProps {
  /** 关联的 Form ID */
  formId?: string;
  /** 字段名称（用于验证规则匹配） */
  prop?: string;
  /** 标签文字 */
  label?: ResourceStr;
  /** 标签宽度(vp)，默认继承 Form */
  labelWidth?: number;
  /** 标签位置，默认继承 Form */
  labelPosition?: TnLabelPosition;
  /** 是否必填（undefined 时从 rules 推断） */
  required?: boolean;
  /** 字段级验证规则（优先于 Form 级） */
  rules?: TnFormRuleItem[];
  /** 是否显示错误消息，默认继承 Form */
  showMessage?: boolean;
}
