/**
 * @file TnActionSheet 操作面板组件类型定义
 * @description 定义操作面板选项、关闭动作、前置拦截回调等类型
 * @author JunBin.Yang
 */

/**
 * 操作面板单个选项
 */
export class TnActionSheetItem {
  /** 选项文本 */
  text: string = "";
  /** 选项描述 */
  desc: string = "";
  /** 选项标识值 */
  value: string = "";
  /** 是否禁用 */
  disabled: boolean = false;
  /** 自定义文字颜色 */
  color: ResourceColor = "";

  constructor(text: string, desc?: string, value?: string, disabled?: boolean, color?: ResourceColor) {
    this.text = text;
    if (desc !== undefined) {
      this.desc = desc;
    }
    if (value !== undefined) {
      this.value = value;
    }
    if (disabled !== undefined) {
      this.disabled = disabled;
    }
    if (color !== undefined) {
      this.color = color;
    }
  }
}

/**
 * 操作面板关闭动作类型
 * - select: 选择了某个选项
 * - cancel: 点击了取消按钮
 */
export type TnActionSheetCloseAction = "select" | "cancel";

/**
 * 操作面板关闭前拦截回调类型
 * 返回 false 或 Promise<false> 可阻止面板关闭
 * @param action 触发的操作类型
 * @param index 当 action 为 select 时，选中项的索引
 * @param value 当 action 为 select 时，选中项的标识值
 * @returns boolean 或 Promise<boolean>，false 时阻止关闭
 */
export type TnActionSheetBeforeClose =
  (action: TnActionSheetCloseAction, index?: number, value?: string) => boolean | Promise<boolean>;
