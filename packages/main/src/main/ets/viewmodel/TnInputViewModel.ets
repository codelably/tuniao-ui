/**
 * @file TnInput 展示页面 ViewModel
 * @author JunBin.Yang
 */
import { BaseViewModel } from "@core/base";

@ObservedV2
export default class TnInputViewModel extends BaseViewModel {
  /** 输入框1的文本内容 */
  @Trace inputValue1: string = "";

  /** 输入框2的文本内容（可清除） */
  @Trace inputValue2: string = "";

  /** 多行文本域的内容 */
  @Trace textareaValue: string = "";

  /** 密码输入框的内容 */
  @Trace passwordValue: string = "";

  /** 小尺寸输入框的内容 */
  @Trace sizeSmValue: string = "";

  /** 大尺寸输入框的内容 */
  @Trace sizeLgValue: string = "";

  /** 居中对齐输入框的内容 */
  @Trace alignCenterValue: string = "";

  /** 右对齐输入框的内容 */
  @Trace alignRightValue: string = "";

  /** 带前后插槽输入框的内容 */
  @Trace slotValue: string = "";

  /**
   * 设置输入框1的文本内容
   * @param value 新的输入值
   */
  setInputValue1(value: string): void {
    this.inputValue1 = value;
  }

  /**
   * 设置输入框2的文本内容
   * @param value 新的输入值
   */
  setInputValue2(value: string): void {
    this.inputValue2 = value;
  }

  /**
   * 设置多行文本域的内容
   * @param value 新的文本域内容
   */
  setTextareaValue(value: string): void {
    this.textareaValue = value;
  }

  /**
   * 设置密码输入框的内容
   * @param value 新的密码输入值
   */
  setPasswordValue(value: string): void {
    this.passwordValue = value;
  }

  /**
   * 设置小尺寸输入框的内容
   * @param value 新的输入值
   */
  setSizeSmValue(value: string): void {
    this.sizeSmValue = value;
  }

  /**
   * 设置大尺寸输入框的内容
   * @param value 新的输入值
   */
  setSizeLgValue(value: string): void {
    this.sizeLgValue = value;
  }

  /**
   * 设置居中对齐输入框的内容
   * @param value 新的输入值
   */
  setAlignCenterValue(value: string): void {
    this.alignCenterValue = value;
  }

  /**
   * 设置右对齐输入框的内容
   * @param value 新的输入值
   */
  setAlignRightValue(value: string): void {
    this.alignRightValue = value;
  }

  /**
   * 设置带插槽输入框的内容
   * @param value 新的输入值
   */
  setSlotValue(value: string): void {
    this.slotValue = value;
  }
}
