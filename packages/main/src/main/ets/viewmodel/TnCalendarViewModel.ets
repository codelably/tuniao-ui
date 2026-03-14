/**
 * @file TnCalendar 日历展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";
import { TnCalendarHolidayItem } from "@tuniao/tn-ui";

/**
 * TnCalendar 日历展示页面 ViewModel
 */
@ObservedV2
export default class TnCalendarViewModel extends BaseViewModel {
  /**
   * 单选模式下当前选中的日期，格式如 "2024-01-01"
   */
  @Trace selectedDate: string = "";

  /**
   * 多选模式下当前选中的日期数组
   */
  @Trace selectedDates: string[] = [];

  /**
   * 范围选择模式下的开始日期
   */
  @Trace rangeStart: string = "";

  /**
   * 范围选择模式下的结束日期
   */
  @Trace rangeEnd: string = "";

  /**
   * 农历模式下当前选中的日期
   */
  @Trace lunarSelectedDate: string = "";

  /**
   * 是否显示农历
   */
  @Trace showLunar: boolean = true;

  /**
   * 是否显示周末红色
   */
  @Trace showWeekendColor: boolean = true;

  /**
   * 2026年示例节假日数据
   */
  holidays: TnCalendarHolidayItem[] = [
    // 清明节
    { date: "2026-04-04", type: "holiday" },
    { date: "2026-04-05", type: "holiday" },
    { date: "2026-04-06", type: "holiday" },
    // 劳动节
    { date: "2026-05-01", type: "holiday" },
    { date: "2026-05-02", type: "holiday" },
    { date: "2026-05-03", type: "holiday" },
    { date: "2026-05-04", type: "holiday" },
    { date: "2026-05-05", type: "holiday" },
    // 补班
    { date: "2026-04-26", type: "workday" },
    { date: "2026-05-09", type: "workday" }
  ];

  /**
   * 设置单选模式下的选中日期
   * @param date 日期字符串，格式如 "2024-01-01"
   */
  setSelectedDate(date: string): void {
    this.selectedDate = date;
  }

  /**
   * 设置多选模式下的选中日期数组（不可变方式）
   * @param dates 日期字符串数组
   */
  setSelectedDates(dates: string[]): void {
    this.selectedDates = [...dates];
  }

  /**
   * 设置范围选择模式下的开始和结束日期
   * @param start 开始日期字符串
   * @param end 结束日期字符串
   */
  setRange(start: string, end: string): void {
    this.rangeStart = start;
    this.rangeEnd = end;
  }

  /**
   * 设置农历模式下的选中日期
   * @param date 日期字符串
   */
  setLunarSelectedDate(date: string): void {
    this.lunarSelectedDate = date;
  }
}
