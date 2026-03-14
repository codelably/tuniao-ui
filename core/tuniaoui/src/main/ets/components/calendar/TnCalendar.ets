/**
 * @file TnCalendar 日历组件
 * @description 支持单选、多选、范围选择的日历组件，可显示农历、周末红色、节假日/补班日徽标
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { getThemeColor, getThemeColorLight, getFontSizeByKey } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { TnIcon } from "../icon/TnIcon";
import { TnBadge } from "../badge/TnBadge";
import { TnCalendarMode, TnCalendarDateItem, TnCalendarHolidayItem } from "./TnCalendarTypes";
import { convertDimensionsWidthUnit } from "../../utils/Utils";
import { lunar } from "../../utils/lunar";
import { getHexColorByResoure, mixWithBlack } from "../../utils/ColorUtils";

/** 星期标题 */
const WEEK_LABELS: string[] = ["日", "一", "二", "三", "四", "五", "六"];

/** 日历网格列数 */
const GRID_COLUMNS: number = 7;

/** 日历网格每格大小(vp) */
const CELL_SIZE: number = 48;

/**
 * 解析日期字符串为年月日
 * @param dateStr 日期字符串 YYYY-MM-DD
 * @returns [year, month, day]
 */
function parseDateStr(dateStr: string): number[] {
  const parts: string[] = dateStr.split("-");
  if (parts.length >= 3) {
    return [parseInt(parts[0]), parseInt(parts[1]), parseInt(parts[2])];
  }
  return [0, 0, 0];
}

/**
 * 格式化日期为字符串
 * @param year 年
 * @param month 月
 * @param day 日
 * @returns YYYY-MM-DD
 */
function formatDateStr(year: number, month: number, day: number): string {
  const y: string = year.toString();
  const m: string = month < 10 ? `0${month}` : month.toString();
  const d: string = day < 10 ? `0${day}` : day.toString();
  return `${y}-${m}-${d}`;
}

/**
 * 获取某月天数
 * @param year 年
 * @param month 月（1-12）
 * @returns 天数
 */
function getDaysInMonth(year: number, month: number): number {
  return new Date(year, month, 0).getDate();
}

/**
 * 获取某月第一天是星期几
 * @param year 年
 * @param month 月（1-12）
 * @returns 0-6（周日-周六）
 */
function getFirstDayOfWeek(year: number, month: number): number {
  return new Date(year, month - 1, 1).getDay();
}

/**
 * 获取农历显示文本
 * @param year 年
 * @param month 月
 * @param day 日
 * @returns 农历文本（初一时显示月名，其余显示日名）
 */
function getLunarText(year: number, month: number, day: number): string {
  const date: Date = new Date(year, month - 1, day);
  const lunarInfo = lunar(date);
  if (lunarInfo.getDay() === 1) {
    return lunarInfo.getMonthInChinese() + "月";
  }
  return lunarInfo.getDayInChinese();
}

/**
 * 查找节假日类型
 * @param dateStr 日期字符串 YYYY-MM-DD
 * @param holidays 节假日列表
 * @returns 节假日类型（"holiday"/"workday"/""）
 */
function findHolidayType(dateStr: string, holidays: TnCalendarHolidayItem[]): string {
  for (let i: number = 0; i < holidays.length; i++) {
    if (holidays[i].date === dateStr) {
      return holidays[i].type;
    }
  }
  return "";
}

/**
 * TnCalendar 日历组件
 *
 * @example
 * TnCalendar({
 *   modelValue: "2024-01-15",
 *   mode: "date",
 *   showLunar: true,
 *   showWeekendColor: true,
 *   onChange: (value) => { console.log(value); }
 * })
 */
@ComponentV2
export struct TnCalendar {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  /** 绑定日期 */
  @Param modelValue: string | string[] = "";
  /** 选择模式 */
  @Param mode: TnCalendarMode = "date";
  /** 最小日期 */
  @Param minDate: string = "";
  /** 最大日期 */
  @Param maxDate: string = "";
  /** 允许切换年份 */
  @Param allowChangeYear: boolean = true;
  /** 允许切换月份 */
  @Param allowChangeMonth: boolean = true;
  /** 选中背景色 */
  @Param activeBgColor: string = "";
  /** 选中文字颜色 */
  @Param activeTextColor: string = "";
  /** 范围背景色 */
  @Param rangeBgColor: string = "";
  /** 范围文字颜色 */
  @Param rangeTextColor: string = "";
  /** 范围开始描述 */
  @Param rangeStartDesc: string = "开始";
  /** 范围结束描述 */
  @Param rangeEndDesc: string = "结束";
  /** 是否显示农历 */
  @Param showLunar: boolean = false;
  /** 周末是否显示红色 */
  @Param showWeekendColor: boolean = false;
  /** 法定节假日和补班日列表 */
  @Param holidays: TnCalendarHolidayItem[] = [];

  /** 变化回调 */
  @Event onChange: (value: string | string[]) => void = (_value: string | string[]): void => {};
  /** 年份变化回调 */
  @Event onChangeYear: (year: number) => void = (_year: number): void => {};
  /** 月份变化回调 */
  @Event onChangeMonth: (month: number) => void = (_month: number): void => {};

  /** 当前显示年份 */
  @Local private currentYear: number = 0;
  /** 当前显示月份 */
  @Local private currentMonth: number = 0;
  /** 选中日期集合（用于 date/multi 模式） */
  @Local private selectedDates: string[] = [];
  /** 范围选择起始日期 */
  @Local private rangeStart: string = "";
  /** 范围选择结束日期 */
  @Local private rangeEnd: string = "";

  aboutToAppear(): void {
    this.initCalendar();
  }

  /**
   * 初始化日历状态
   */
  private initCalendar(): void {
    const now: Date = new Date();
    this.currentYear = now.getFullYear();
    this.currentMonth = now.getMonth() + 1;

    if (this.mode === "date" && typeof this.modelValue === "string" && this.modelValue.length > 0) {
      const parts: number[] = parseDateStr(this.modelValue as string);
      if (parts[0] > 0) {
        this.currentYear = parts[0];
        this.currentMonth = parts[1];
        this.selectedDates = [this.modelValue as string];
      }
    } else if (this.mode === "multi" && Array.isArray(this.modelValue)) {
      this.selectedDates = [...(this.modelValue as string[])];
      if (this.selectedDates.length > 0) {
        const parts: number[] = parseDateStr(this.selectedDates[0]);
        if (parts[0] > 0) {
          this.currentYear = parts[0];
          this.currentMonth = parts[1];
        }
      }
    } else if (this.mode === "range" && Array.isArray(this.modelValue)) {
      const rangeArr: string[] = this.modelValue as string[];
      if (rangeArr.length >= 1) {
        this.rangeStart = rangeArr[0];
        const parts: number[] = parseDateStr(rangeArr[0]);
        if (parts[0] > 0) {
          this.currentYear = parts[0];
          this.currentMonth = parts[1];
        }
      }
      if (rangeArr.length >= 2) {
        this.rangeEnd = rangeArr[1];
      }
    }
  }

  /**
   * 切换到上一月
   */
  private prevMonth(): void {
    if (!this.allowChangeMonth) {
      return;
    }
    if (this.currentMonth === 1) {
      if (this.allowChangeYear) {
        this.currentMonth = 12;
        this.currentYear = this.currentYear - 1;
        this.onChangeYear(this.currentYear);
      }
    } else {
      this.currentMonth = this.currentMonth - 1;
    }
    this.onChangeMonth(this.currentMonth);
  }

  /**
   * 切换到下一月
   */
  private nextMonth(): void {
    if (!this.allowChangeMonth) {
      return;
    }
    if (this.currentMonth === 12) {
      if (this.allowChangeYear) {
        this.currentMonth = 1;
        this.currentYear = this.currentYear + 1;
        this.onChangeYear(this.currentYear);
      }
    } else {
      this.currentMonth = this.currentMonth + 1;
    }
    this.onChangeMonth(this.currentMonth);
  }

  /**
   * 切换到上一年
   */
  private prevYear(): void {
    if (!this.allowChangeYear) {
      return;
    }
    this.currentYear = this.currentYear - 1;
    this.onChangeYear(this.currentYear);
  }

  /**
   * 切换到下一年
   */
  private nextYear(): void {
    if (!this.allowChangeYear) {
      return;
    }
    this.currentYear = this.currentYear + 1;
    this.onChangeYear(this.currentYear);
  }

  /**
   * 判断日期是否被禁用
   * @param dateStr 日期字符串
   * @returns 是否禁用
   */
  private isDateDisabled(dateStr: string): boolean {
    if (this.minDate.length > 0 && dateStr < this.minDate) {
      return true;
    }
    if (this.maxDate.length > 0 && dateStr > this.maxDate) {
      return true;
    }
    return false;
  }

  /**
   * 判断日期是否被选中
   * @param dateStr 日期字符串
   * @returns 是否选中
   */
  private isDateSelected(dateStr: string): boolean {
    if (this.mode === "date" || this.mode === "multi") {
      return this.selectedDates.indexOf(dateStr) >= 0;
    }
    if (this.mode === "range") {
      return dateStr === this.rangeStart || dateStr === this.rangeEnd;
    }
    return false;
  }

  /**
   * 判断日期是否在范围内
   * @param dateStr 日期字符串
   * @returns 是否在范围内
   */
  private isDateInRange(dateStr: string): boolean {
    if (this.mode !== "range" || this.rangeStart.length === 0 || this.rangeEnd.length === 0) {
      return false;
    }
    return dateStr > this.rangeStart && dateStr < this.rangeEnd;
  }

  /**
   * 点击日期
   * @param dateStr 日期字符串
   */
  private onDateClick(dateStr: string): void {
    if (this.isDateDisabled(dateStr)) {
      return;
    }

    if (this.mode === "date") {
      this.selectedDates = [dateStr];
      this.onChange(dateStr);
    } else if (this.mode === "multi") {
      const idx: number = this.selectedDates.indexOf(dateStr);
      if (idx >= 0) {
        const newDates: string[] = this.selectedDates.filter((d: string): boolean => d !== dateStr);
        this.selectedDates = newDates;
      } else {
        this.selectedDates = [...this.selectedDates, dateStr];
      }
      this.onChange([...this.selectedDates]);
    } else if (this.mode === "range") {
      if (this.rangeStart.length === 0 || (this.rangeStart.length > 0 && this.rangeEnd.length > 0)) {
        this.rangeStart = dateStr;
        this.rangeEnd = "";
      } else {
        if (dateStr < this.rangeStart) {
          this.rangeEnd = this.rangeStart;
          this.rangeStart = dateStr;
        } else {
          this.rangeEnd = dateStr;
        }
        this.onChange([this.rangeStart, this.rangeEnd]);
      }
    }
  }

  /**
   * 构建单个日期项数据
   * @param year 年
   * @param month 月
   * @param day 日
   * @param isCurrentMonth 是否当月
   * @param todayStr 今天日期字符串
   * @returns 日期项
   */
  private buildDateItem(year: number, month: number, day: number, isCurrentMonth: boolean,
    todayStr: string): TnCalendarDateItem {
    const dateStr: string = formatDateStr(year, month, day);
    const dayOfWeek: number = new Date(year, month - 1, day).getDay();
    const isWeekend: boolean = dayOfWeek === 0 || dayOfWeek === 6;

    let desc: string = "";
    if (this.mode === "range" && isCurrentMonth) {
      if (dateStr === this.rangeStart) {
        desc = this.rangeStartDesc;
      } else if (dateStr === this.rangeEnd) {
        desc = this.rangeEndDesc;
      }
    }

    let lunarText: string = "";
    if (this.showLunar) {
      lunarText = getLunarText(year, month, day);
    }

    let holidayType: string = "";
    if (this.holidays.length > 0) {
      holidayType = findHolidayType(dateStr, this.holidays);
    }

    const item: TnCalendarDateItem = {
      year: year,
      month: month,
      day: day,
      isCurrentMonth: isCurrentMonth,
      isToday: dateStr === todayStr,
      isSelected: this.isDateSelected(dateStr),
      isInRange: this.isDateInRange(dateStr),
      isRangeStart: dateStr === this.rangeStart,
      isRangeEnd: dateStr === this.rangeEnd,
      isDisabled: isCurrentMonth ? this.isDateDisabled(dateStr) : true,
      desc: desc,
      lunarText: lunarText,
      isWeekend: isWeekend,
      holidayType: holidayType
    };
    return item;
  }

  /**
   * 生成当月日期网格数据
   * @returns 日期项数组
   */
  private generateDateGrid(): TnCalendarDateItem[] {
    const result: TnCalendarDateItem[] = [];
    const daysInMonth: number = getDaysInMonth(this.currentYear, this.currentMonth);
    const firstDay: number = getFirstDayOfWeek(this.currentYear, this.currentMonth);
    const today: Date = new Date();
    const todayStr: string = formatDateStr(today.getFullYear(), today.getMonth() + 1, today.getDate());

    // 上月填充
    const prevMonth: number = this.currentMonth === 1 ? 12 : this.currentMonth - 1;
    const prevYear: number = this.currentMonth === 1 ? this.currentYear - 1 : this.currentYear;
    const prevMonthDays: number = getDaysInMonth(prevYear, prevMonth);

    for (let i: number = 0; i < firstDay; i++) {
      const day: number = prevMonthDays - firstDay + 1 + i;
      result.push(this.buildDateItem(prevYear, prevMonth, day, false, todayStr));
    }

    // 当月日期
    for (let day: number = 1; day <= daysInMonth; day++) {
      result.push(this.buildDateItem(this.currentYear, this.currentMonth, day, true, todayStr));
    }

    // 下月填充
    const nextMonth: number = this.currentMonth === 12 ? 1 : this.currentMonth + 1;
    const nextYear: number = this.currentMonth === 12 ? this.currentYear + 1 : this.currentYear;
    const totalCells: number = Math.ceil(result.length / GRID_COLUMNS) * GRID_COLUMNS;
    const remaining: number = totalCells - result.length;

    for (let day: number = 1; day <= remaining; day++) {
      result.push(this.buildDateItem(nextYear, nextMonth, day, false, todayStr));
    }

    return result;
  }

  /**
   * 获取选中背景颜色
   * @returns 颜色值
   */
  private getActiveBgColor(): ResourceColor {
    if (this.activeBgColor.length > 0) {
      return this.activeBgColor;
    }
    return getThemeColor(this.baseStyle, "primary");
  }

  /**
   * 获取选中文字颜色
   * @returns 颜色值
   */
  private getActiveTextColor(): ResourceColor {
    if (this.activeTextColor.length > 0) {
      return this.activeTextColor;
    }
    return $r("app.color.tn_color_white");
  }

  /**
   * 获取范围背景颜色
   * @returns 颜色值
   */
  private getRangeBgColor(): ResourceColor {
    if (this.rangeBgColor.length > 0) {
      return this.rangeBgColor;
    }
    return getThemeColorLight(this.baseStyle, "primary");
  }

  /**
   * 获取范围文字颜色
   * @returns 颜色值
   */
  private getRangeTextColor(): ResourceColor {
    if (this.rangeTextColor.length > 0) {
      return this.rangeTextColor;
    }
    return getThemeColor(this.baseStyle, "primary");
  }

  build() {
    Column() {
      // 头部导航
      this.HeaderBuilder();
      // 星期标题
      this.WeekHeaderBuilder();
      // 日期网格
      this.DateGridBuilder();
    }
    .width("100%")
    .backgroundColor($r("app.color.tn_bg_color"));
  }

  /**
   * 头部导航构建器
   */
  @Builder
  private HeaderBuilder(): void {
    Row() {
      if (this.allowChangeYear) {
        Row() {
          TnIcon({ name: "left-double", iconSize: 16, color: $r("app.color.tn_text_color_secondary") }).enabled(false);
        }
        .padding(convertDimensionsWidthUnit(8))
        .borderRadius(this.baseStyle.borderRadius)
        .stateStyles({
          normal: {
            .backgroundColor(Color.Transparent)
          },
          pressed: {
            .backgroundColor(mixWithBlack(getHexColorByResoure($r("app.color.tn_bg_color"))))
          }
        })
        .animation({ duration: this.baseStyle.animationDuration })
        .onClick(() => {
          this.prevYear();
        });
      }

      if (this.allowChangeMonth) {
        Row() {
          TnIcon({ name: "left", iconSize: 16, color: $r("app.color.tn_text_color_secondary") }).enabled(false);
        }
        .padding(convertDimensionsWidthUnit(8))
        .borderRadius(this.baseStyle.borderRadius)
        .stateStyles({
          normal: {
            .backgroundColor(Color.Transparent)
          },
          pressed: {
            .backgroundColor(mixWithBlack(getHexColorByResoure($r("app.color.tn_bg_color"))))
          }
        })
        .animation({ duration: this.baseStyle.animationDuration })
        .onClick(() => {
          this.prevMonth();
        });
      }

      Text(`${this.currentYear}年${this.currentMonth}月`)
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeLg"))
        .fontColor($r("app.color.tn_text_color_primary"))
        .fontWeight(FontWeight.Medium)
        .lineHeight(this.baseStyle.lineHeightMd)
        .layoutWeight(1)
        .textAlign(TextAlign.Center);

      if (this.allowChangeMonth) {
        Row() {
          TnIcon({ name: "right", iconSize: 16, color: $r("app.color.tn_text_color_secondary") }).enabled(false);
        }
        .padding(convertDimensionsWidthUnit(8))
        .borderRadius(this.baseStyle.borderRadius)
        .stateStyles({
          normal: {
            .backgroundColor(Color.Transparent)
          },
          pressed: {
            .backgroundColor(mixWithBlack(getHexColorByResoure($r("app.color.tn_bg_color"))))
          }
        })
        .animation({ duration: this.baseStyle.animationDuration })
        .onClick(() => {
          this.nextMonth();
        });
      }

      if (this.allowChangeYear) {
        Row() {
          TnIcon({ name: "right-double", iconSize: 16, color: $r("app.color.tn_text_color_secondary") }).enabled(false);
        }
        .padding(convertDimensionsWidthUnit(8))
        .borderRadius(this.baseStyle.borderRadius)
        .stateStyles({
          normal: {
            .backgroundColor(Color.Transparent)
          },
          pressed: {
            .backgroundColor(mixWithBlack(getHexColorByResoure($r("app.color.tn_bg_color"))))
          }
        })
        .animation({ duration: this.baseStyle.animationDuration })
        .onClick(() => {
          this.nextYear();
        });
      }
    }
    .width("100%")
    .height(convertDimensionsWidthUnit(48))
    .alignItems(VerticalAlign.Center)
    .padding({ left: convertDimensionsWidthUnit(8), right: convertDimensionsWidthUnit(8) });
  }

  /**
   * 星期标题构建器
   */
  @Builder
  private WeekHeaderBuilder(): void {
    Row() {
      ForEach(
        WEEK_LABELS,
        (label: string, index: number) => {
          Text(label)
            .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
            .fontColor(this.getWeekLabelColor(index))
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
            .height(convertDimensionsWidthUnit(32));
        },
        (label: string, index: number): string => `week_${index}_${label}`
      );
    }
    .width("100%");
  }

  /**
   * 获取星期标题颜色
   * @param index 星期索引（0=周日, 6=周六）
   * @returns 文字颜色
   */
  private getWeekLabelColor(index: number): ResourceColor {
    if (this.showWeekendColor && (index === 0 || index === 6)) {
      return $r("app.color.tn_color_danger");
    }
    return $r("app.color.tn_text_color_secondary");
  }

  /**
   * 日期网格构建器
   */
  @Builder
  private DateGridBuilder(): void {
    Flex({ wrap: FlexWrap.Wrap }) {
      ForEach(
        this.generateDateGrid(),
        (item: TnCalendarDateItem) => {
          this.DateCellBuilder(item);
        },
        (item: TnCalendarDateItem): string =>
          `cell_${this.currentYear}_${this.currentMonth}_${item.year}_${item.month}_${item.day}_${item.isCurrentMonth}_${item.isSelected}_${item.isInRange}_${item.holidayType}`
      );
    }
    .width("100%")
    .padding({
      left: convertDimensionsWidthUnit(4),
      right: convertDimensionsWidthUnit(4),
      bottom: convertDimensionsWidthUnit(8)
    });
  }

  /**
   * 日期单元格构建器
   * @param item 日期项
   */
  @Builder
  private DateCellBuilder(item: TnCalendarDateItem): void {
    Column() {
      // 日期数字（如果有节假日徽标则包裹 TnBadge）
      if (item.holidayType === "holiday") {
        TnBadge({
          value: "休",
          badgeSize: "sm",
          bgColor: $r("app.color.tn_color_danger"),
          absolute: true,
          badgePosition: "top-right",
          xOffset: -2,
          yOffset: -2
        }) {
          Text(item.day.toString())
            .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
            .fontColor(this.getDateTextColor(item))
            .textAlign(TextAlign.Center)
            .width(convertDimensionsWidthUnit(24))
            .height(convertDimensionsWidthUnit(20));
        }
      } else if (item.holidayType === "workday") {
        TnBadge({
          value: "班",
          badgeSize: "sm",
          bgColor: $r("app.color.tn_text_color_secondary"),
          absolute: true,
          badgePosition: "top-right",
          xOffset: -2,
          yOffset: -2
        }) {
          Text(item.day.toString())
            .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
            .fontColor(this.getDateTextColor(item))
            .textAlign(TextAlign.Center)
            .width(convertDimensionsWidthUnit(24))
            .height(convertDimensionsWidthUnit(20));
        }
      } else {
        Text(item.day.toString())
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
          .fontColor(this.getDateTextColor(item))
          .textAlign(TextAlign.Center);
      }

      // 农历文本 / 描述文本 / 今天标签
      if (item.desc.length > 0) {
        Text(item.desc)
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXxs"))
          .fontColor(this.getDateTextColor(item))
          .textAlign(TextAlign.Center)
          .margin({ top: convertDimensionsWidthUnit(1) });
      } else if (this.showLunar && item.lunarText.length > 0) {
        Text(item.lunarText)
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXxs"))
          .fontColor(this.getLunarTextColor(item))
          .textAlign(TextAlign.Center)
          .margin({ top: convertDimensionsWidthUnit(1) });
      } else if (item.isToday && !item.isSelected) {
        Text("今天")
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXxs"))
          .fontColor(getThemeColor(this.baseStyle, "primary"))
          .textAlign(TextAlign.Center)
          .margin({ top: convertDimensionsWidthUnit(1) });
      }
    }
    .width(`${100 / GRID_COLUMNS}%`)
    .height(convertDimensionsWidthUnit(CELL_SIZE))
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.getDateBgColor(item))
    .borderRadius(this.getDateBorderRadius(item))
    .animation({ duration: this.baseStyle.animationDuration })
    .stateStyles({
      normal: {
        .opacity(1.0)
      },
      pressed: {
        .opacity(item.isCurrentMonth && !item.isDisabled ? 0.7 : 1.0)
      }
    })
    .onClick(() => {
      if (item.isCurrentMonth) {
        const dateStr: string = formatDateStr(item.year, item.month, item.day);
        this.onDateClick(dateStr);
      }
    });
  }

  /**
   * 获取日期文字颜色
   * @param item 日期项
   * @returns 文字颜色
   */
  private getDateTextColor(item: TnCalendarDateItem): ResourceColor {
    if (!item.isCurrentMonth) {
      return $r("app.color.tn_color_gray_disabled");
    }
    if (item.isDisabled) {
      return $r("app.color.tn_color_gray_disabled");
    }
    if (item.isSelected || item.isRangeStart || item.isRangeEnd) {
      return this.getActiveTextColor();
    }
    if (item.isInRange) {
      return this.getRangeTextColor();
    }
    // 补班日使用工作日颜色，不受周末红色影响
    if (item.holidayType === "workday") {
      return $r("app.color.tn_text_color_primary");
    }
    // 法定节假日使用红色
    if (item.holidayType === "holiday") {
      return $r("app.color.tn_color_danger");
    }
    // 周末红色
    if (this.showWeekendColor && item.isWeekend) {
      return $r("app.color.tn_color_danger");
    }
    return $r("app.color.tn_text_color_primary");
  }

  /**
   * 获取农历文字颜色
   * @param item 日期项
   * @returns 文字颜色
   */
  private getLunarTextColor(item: TnCalendarDateItem): ResourceColor {
    if (!item.isCurrentMonth) {
      return $r("app.color.tn_color_gray_disabled");
    }
    if (item.isDisabled) {
      return $r("app.color.tn_color_gray_disabled");
    }
    if (item.isSelected || item.isRangeStart || item.isRangeEnd) {
      return this.getActiveTextColor();
    }
    if (item.isInRange) {
      return this.getRangeTextColor();
    }
    // 补班日使用工作日颜色
    if (item.holidayType === "workday") {
      return $r("app.color.tn_text_color_secondary");
    }
    // 法定节假日农历文字也用红色
    if (item.holidayType === "holiday") {
      return $r("app.color.tn_color_danger");
    }
    // 周末农历文字也用红色
    if (this.showWeekendColor && item.isWeekend) {
      return $r("app.color.tn_color_danger");
    }
    return $r("app.color.tn_text_color_secondary");
  }

  /**
   * 获取日期背景颜色
   * @param item 日期项
   * @returns 背景颜色
   */
  private getDateBgColor(item: TnCalendarDateItem): ResourceColor {
    if (item.isSelected || item.isRangeStart || item.isRangeEnd) {
      return this.getActiveBgColor();
    }
    if (item.isInRange) {
      return this.getRangeBgColor();
    }
    return Color.Transparent;
  }

  /**
   * 获取日期单元格圆角
   * @param item 日期项
   * @returns 圆角值
   */
  private getDateBorderRadius(item: TnCalendarDateItem): string | number | BorderRadiuses {
    if (item.isSelected && this.mode !== "range") {
      return this.baseStyle.borderRadiusMax;
    }
    if (item.isRangeStart) {
      return { topLeft: CELL_SIZE / 2, bottomLeft: CELL_SIZE / 2, topRight: 0, bottomRight: 0 };
    }
    if (item.isRangeEnd) {
      return { topLeft: 0, bottomLeft: 0, topRight: CELL_SIZE / 2, bottomRight: CELL_SIZE / 2 };
    }
    return 0;
  }
}
