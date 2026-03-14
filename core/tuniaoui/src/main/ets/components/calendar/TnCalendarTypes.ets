/**
 * @file TnCalendar 日历组件类型定义
 * @author JunBin.Yang
 */

/**
 * 日历选择模式
 */
export type TnCalendarMode = "date" | "multi" | "range";

/**
 * 节假日类型
 * - holiday: 法定假日
 * - workday: 补班日
 */
export type TnCalendarHolidayType = "holiday" | "workday";

/**
 * 节假日配置项
 */
export interface TnCalendarHolidayItem {
  /** 日期字符串 YYYY-MM-DD */
  date: string;
  /** 类型：holiday=法定假日, workday=补班日 */
  type: TnCalendarHolidayType;
}

/**
 * 日历日期项
 */
export interface TnCalendarDateItem {
  /** 年 */
  year: number;
  /** 月 */
  month: number;
  /** 日 */
  day: number;
  /** 是否当月 */
  isCurrentMonth: boolean;
  /** 是否今天 */
  isToday: boolean;
  /** 是否选中 */
  isSelected: boolean;
  /** 是否在范围内 */
  isInRange: boolean;
  /** 是否范围起点 */
  isRangeStart: boolean;
  /** 是否范围终点 */
  isRangeEnd: boolean;
  /** 是否禁用 */
  isDisabled: boolean;
  /** 描述文字（如"开始"、"结束"） */
  desc: string;
  /** 农历显示文本（初一时显示月名，其余显示日名） */
  lunarText: string;
  /** 是否为周末（周六或周日） */
  isWeekend: boolean;
  /** 节假日类型（"holiday"/"workday"/""） */
  holidayType: string;
}

/**
 * TnCalendar 组件属性接口
 */
export interface TnCalendarProps {
  /** 绑定日期（单选为 string，多选/范围为 string[]） */
  modelValue?: string | string[];
  /** 选择模式 */
  mode?: TnCalendarMode;
  /** 最小日期 (YYYY-MM-DD) */
  minDate?: string;
  /** 最大日期 (YYYY-MM-DD) */
  maxDate?: string;
  /** 允许切换年份 */
  allowChangeYear?: boolean;
  /** 允许切换月份 */
  allowChangeMonth?: boolean;
  /** 选中背景色 */
  activeBgColor?: string;
  /** 选中文字颜色 */
  activeTextColor?: string;
  /** 范围背景色 */
  rangeBgColor?: string;
  /** 范围文字颜色 */
  rangeTextColor?: string;
  /** 范围开始描述 */
  rangeStartDesc?: string;
  /** 范围结束描述 */
  rangeEndDesc?: string;
  /** 是否显示农历 */
  showLunar?: boolean;
  /** 周末是否显示红色 */
  showWeekendColor?: boolean;
  /** 法定节假日和补班日列表 */
  holidays?: TnCalendarHolidayItem[];
  /** 变化回调 */
  onChange?: (value: string | string[]) => void;
  /** 年份变化回调 */
  onChangeYear?: (year: number) => void;
  /** 月份变化回调 */
  onChangeMonth?: (month: number) => void;
}
