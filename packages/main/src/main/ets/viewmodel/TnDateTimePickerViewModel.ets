/**
 * @file TnDateTimePicker 日期时间选择器展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

/**
 * TnDateTimePicker 日期时间选择器展示页面 ViewModel
 */
@ObservedV2
export default class TnDateTimePickerViewModel extends BaseViewModel {
  /**
   * 日期选择器弹出层是否打开
   */
  @Trace datePickerOpen: boolean = false;

  /**
   * 时间选择器弹出层是否打开
   */
  @Trace timePickerOpen: boolean = false;

  /**
   * 年月选择器弹出层是否打开
   */
  @Trace yearMonthPickerOpen: boolean = false;

  /**
   * 日期时间组合选择器弹出层是否打开
   */
  @Trace datetimePickerOpen: boolean = false;

  /**
   * 当前选中的日期值，格式如 "2024-01-01"
   */
  @Trace dateValue: string = "";

  /**
   * 当前选中的时间值，格式如 "12:00"
   */
  @Trace timeValue: string = "";

  /**
   * 选中日期的显示文本
   */
  @Trace selectedDate: string = "";

  /**
   * 选中时间的显示文本
   */
  @Trace selectedTime: string = "";

  /**
   * 选中年月的显示文本
   */
  @Trace selectedYearMonth: string = "";

  /**
   * 选中日期时间组合的显示文本
   */
  @Trace selectedDatetime: string = "";

  /**
   * 切换日期选择器弹出层显示状态
   */
  toggleDatePicker(): void {
    this.datePickerOpen = !this.datePickerOpen;
  }

  /**
   * 切换时间选择器弹出层显示状态
   */
  toggleTimePicker(): void {
    this.timePickerOpen = !this.timePickerOpen;
  }

  /**
   * 切换年月选择器弹出层显示状态
   */
  toggleYearMonthPicker(): void {
    this.yearMonthPickerOpen = !this.yearMonthPickerOpen;
  }

  /**
   * 切换日期时间组合选择器弹出层显示状态
   */
  toggleDatetimePicker(): void {
    this.datetimePickerOpen = !this.datetimePickerOpen;
  }

  /**
   * 设置选中的日期值
   * @param value 日期字符串
   */
  setDateValue(value: string): void {
    this.dateValue = value;
    this.selectedDate = value;
  }

  /**
   * 设置选中的时间值
   * @param value 时间字符串
   */
  setTimeValue(value: string): void {
    this.timeValue = value;
    this.selectedTime = value;
  }

  /**
   * 日期选择确认回调
   * @param value 选中的日期
   */
  onDateConfirm(value: string): void {
    this.dateValue = value;
    this.selectedDate = value;
    this.datePickerOpen = false;
  }

  /**
   * 时间选择确认回调
   * @param value 选中的时间
   */
  onTimeConfirm(value: string): void {
    this.timeValue = value;
    this.selectedTime = value;
    this.timePickerOpen = false;
  }

  /**
   * 年月选择确认回调
   * @param value 选中的年月
   */
  onYearMonthConfirm(value: string): void {
    this.selectedYearMonth = value;
    this.yearMonthPickerOpen = false;
  }

  /**
   * 日期时间组合选择确认回调
   * @param value 选中的日期时间
   */
  onDatetimeConfirm(value: string): void {
    this.selectedDatetime = value;
    this.datetimePickerOpen = false;
  }

  /**
   * 关闭日期选择器弹出层
   */
  closeDatePicker(): void {
    this.datePickerOpen = false;
  }

  /**
   * 关闭时间选择器弹出层
   */
  closeTimePicker(): void {
    this.timePickerOpen = false;
  }
}
