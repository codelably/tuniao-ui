/**
 * @file TnWeekCalendar 周日历组件类型定义
 * @author JunBin.Yang
 */

/**
 * 周日历自定义数据
 */
export interface TnWeekCalendarCustomData {
  /** 日期（日） */
  day: number;
  /** 自定义文字 */
  text: string;
  /** 自定义颜色 */
  color?: string;
}

/**
 * 周日历日期项
 */
export interface TnWeekCalendarDateItem {
  /** 年 */
  year: number;
  /** 月 */
  month: number;
  /** 日 */
  day: number;
  /** 星期几（0=周日, 1-6=周一至周六） */
  dayOfWeek: number;
  /** 是否今天 */
  isToday: boolean;
  /** 是否选中 */
  isSelected: boolean;
  /** 是否禁用 */
  isDisabled: boolean;
  /** 自定义文字 */
  customText: string;
  /** 自定义颜色 */
  customColor: string;
}

/**
 * 周日历变化回调数据
 */
export interface TnWeekCalendarChangeData {
  /** 年 */
  year: number;
  /** 月 */
  month: number;
  /** 日（几号） */
  day: number;
  /** 星期几（0=周日, 1-6=周一至周六） */
  dayOfWeek: number;
}

/**
 * TnWeekCalendar 组件属性接口
 */
export interface TnWeekCalendarProps {
  /** 选中的日期（日） */
  modelValue?: number;
  /** 年份 */
  year?: number;
  /** 月份 */
  month?: number;
  /** 选中背景色 */
  activeBgColor?: string;
  /** 选中文字颜色 */
  activeTextColor?: string;
  /** 最小日 */
  minDate?: number;
  /** 最大日 */
  maxDate?: number;
  /** 自定义数据 */
  customData?: TnWeekCalendarCustomData[];
  /** 变化回调，返回选中日期的年、月、日、星期几 */
  onChange?: (data: TnWeekCalendarChangeData) => void;
  /** 周切换回调 */
  onWeekChange?: (weekStart: string) => void;
}
