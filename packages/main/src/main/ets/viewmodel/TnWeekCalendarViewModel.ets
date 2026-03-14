/**
 * @file TnWeekCalendar 周历展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

/** 星期中文映射 */
const WEEK_DAY_NAMES: string[] = ["日", "一", "二", "三", "四", "五", "六"];

/**
 * TnWeekCalendar 周历展示页面 ViewModel
 */
@ObservedV2
export default class TnWeekCalendarViewModel extends BaseViewModel {
  /**
   * 当前选中的日期（几号）
   */
  @Trace selectedDay: number = 0;

  /**
   * 当前选中的星期几（0=周日, 1-6=周一至周六）
   */
  @Trace selectedDayOfWeek: number = -1;

  /**
   * 当前显示的年份
   */
  @Trace currentYear: number = new Date().getFullYear();

  /**
   * 当前显示的月份，取值范围 1~12
   */
  @Trace currentMonth: number = new Date().getMonth() + 1;

  /**
   * 选中日期的显示文本
   */
  get selectedText(): string {
    if (this.selectedDay <= 0) {
      return "未选择";
    }
    const weekName: string = this.selectedDayOfWeek >= 0 ? WEEK_DAY_NAMES[this.selectedDayOfWeek] : "";
    return `${this.currentMonth}月${this.selectedDay}日 星期${weekName}`;
  }

  /**
   * 设置选中的日期
   * @param year 年
   * @param month 月
   * @param day 几号
   * @param dayOfWeek 星期几
   */
  setSelectedDate(year: number, month: number, day: number, dayOfWeek: number): void {
    this.currentYear = year;
    this.currentMonth = month;
    this.selectedDay = day;
    this.selectedDayOfWeek = dayOfWeek;
  }
}
