/**
 * @file TnPicker 选择器展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

/**
 * TnPicker 选择器展示页面 ViewModel
 */
@ObservedV2
export default class TnPickerViewModel extends BaseViewModel {
  /**
   * 基础选择器弹出层是否打开
   */
  @Trace pickerOpen: boolean = false;

  /**
   * 当前选中的值
   */
  @Trace pickerValue: string = "";

  /**
   * 选中项的显示标签
   */
  @Trace selectedLabel: string = "";

  /**
   * 多列数组选择器弹出层是否打开
   */
  @Trace multiColumnOpen: boolean = false;

  /**
   * 多列数组选择器显示标签
   */
  @Trace multiColumnLabel: string = "";

  /**
   * 多列对象数组选择器弹出层是否打开
   */
  @Trace multiObjOpen: boolean = false;

  /**
   * 多列对象数组选择器显示标签
   */
  @Trace multiObjLabel: string = "";

  /**
   * 联动选择器弹出层是否打开
   */
  @Trace cascadeOpen: boolean = false;

  /**
   * 联动选择器显示标签
   */
  @Trace cascadeLabel: string = "";

  /**
   * 切换基础选择器弹出层显示状态
   */
  togglePicker(): void {
    this.pickerOpen = !this.pickerOpen;
  }

  /**
   * 选择器确认回调
   * @param values 选中值数组
   */
  onPickerConfirm(values: string | string[]): void {
    if (typeof values === "string") {
      this.pickerValue = values;
      this.selectedLabel = values;
    } else if (Array.isArray(values) && values.length > 0) {
      this.pickerValue = values[0];
      this.selectedLabel = values.join(", ");
    }
    this.pickerOpen = false;
  }

  /**
   * 设置选择器选中值
   * @param value 选中的值
   */
  setPickerValue(value: string): void {
    this.pickerValue = value;
  }

  /**
   * 关闭基础选择器弹出层
   */
  closePicker(): void {
    this.pickerOpen = false;
  }

  /**
   * 切换多列数组选择器显示状态
   */
  toggleMultiColumn(): void {
    this.multiColumnOpen = !this.multiColumnOpen;
  }

  /**
   * 多列数组选择器确认回调
   * @param values 各列选中值
   */
  onMultiColumnConfirm(values: Array<string | number>): void {
    const labels: string[] = [];
    for (let i = 0; i < values.length; i++) {
      labels.push(String(values[i]));
    }
    this.multiColumnLabel = labels.join(" - ");
    this.multiColumnOpen = false;
  }

  /**
   * 切换多列对象数组选择器显示状态
   */
  toggleMultiObj(): void {
    this.multiObjOpen = !this.multiObjOpen;
  }

  /**
   * 多列对象数组选择器确认回调
   * @param values 各列选中值
   */
  onMultiObjConfirm(values: Array<string | number>): void {
    const labels: string[] = [];
    for (let i = 0; i < values.length; i++) {
      labels.push(String(values[i]));
    }
    this.multiObjLabel = labels.join(" - ");
    this.multiObjOpen = false;
  }

  /**
   * 切换联动选择器显示状态
   */
  toggleCascade(): void {
    this.cascadeOpen = !this.cascadeOpen;
  }

  /**
   * 联动选择器确认回调
   * @param values 各级选中值
   */
  onCascadeConfirm(values: Array<string | number>): void {
    const labels: string[] = [];
    for (let i = 0; i < values.length; i++) {
      labels.push(String(values[i]));
    }
    this.cascadeLabel = labels.join(" - ");
    this.cascadeOpen = false;
  }
}
