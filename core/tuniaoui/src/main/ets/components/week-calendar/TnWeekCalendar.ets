/**
 * @file TnWeekCalendar 周日历组件
 * @description 横向滑动切换周的日历组件，支持自定义数据
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { getThemeColor, getFontSizeByKey } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { TnWeekCalendarCustomData, TnWeekCalendarDateItem, TnWeekCalendarChangeData } from "./TnWeekCalendarTypes";
import { convertDimensionsWidthUnit } from "../../utils/Utils";

/** 星期标题 */
const WEEK_LABELS: string[] = ["日", "一", "二", "三", "四", "五", "六"];

/** 每周天数 */
const DAYS_PER_WEEK: number = 7;

/**
 * 格式化日期为字符串
 * @param year 年
 * @param month 月
 * @param day 日
 * @returns YYYY-MM-DD
 */
function formatDate(year: number, month: number, day: number): string {
  const m: string = month < 10 ? `0${month}` : month.toString();
  const d: string = day < 10 ? `0${day}` : day.toString();
  return `${year}-${m}-${d}`;
}

/**
 * TnWeekCalendar 周日历组件
 *
 * @example
 * TnWeekCalendar({
 *   year: 2024,
 *   month: 1,
 *   modelValue: 15,
 *   onChange: (data) => { console.log(data.day, data.dayOfWeek); }
 * })
 */
@ComponentV2
export struct TnWeekCalendar {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  /** 选中的日期（日） */
  @Param modelValue: number = 0;
  /** 年份 */
  @Param year: number = 0;
  /** 月份 */
  @Param month: number = 0;
  /** 选中背景色 */
  @Param activeBgColor: string = "";
  /** 选中文字颜色 */
  @Param activeTextColor: string = "";
  /** 最小日 */
  @Param minDate: number = 0;
  /** 最大日 */
  @Param maxDate: number = 0;
  /** 自定义数据 */
  @Param customData: TnWeekCalendarCustomData[] = [];

  /** 变化回调，返回选中日期的年、月、日、星期几 */
  @Event onChange: (data: TnWeekCalendarChangeData) => void = (_data: TnWeekCalendarChangeData): void => {};
  /** 周切换回调 */
  @Event onWeekChange: (weekStart: string) => void = (_weekStart: string): void => {};

  /** 实际使用的年份 */
  @Local private actualYear: number = 0;
  /** 实际使用的月份 */
  @Local private actualMonth: number = 0;
  /** 实际选中日 */
  @Local private selectedDay: number = 0;
  /** 当前周索引 */
  @Local private currentWeekIndex: number = 0;
  /** 所有周数据 */
  @Local private weeksData: TnWeekCalendarDateItem[][] = [];
  /** 版本号，用于强制刷新 ForEach */
  @Local private dataVersion: number = 0;

  aboutToAppear(): void {
    this.initWeekCalendar();
  }

  /**
   * 初始化周日历
   */
  private initWeekCalendar(): void {
    const now: Date = new Date();
    this.actualYear = this.year > 0 ? this.year : now.getFullYear();
    this.actualMonth = this.month > 0 ? this.month : (now.getMonth() + 1);
    this.selectedDay = this.modelValue > 0 ? this.modelValue : now.getDate();

    this.generateWeeks();
    this.locateCurrentWeek();
  }

  /**
   * 生成当月所有周的数据
   */
  private generateWeeks(): void {
    const daysInMonth: number = new Date(this.actualYear, this.actualMonth, 0).getDate();
    const firstDayOfWeek: number = new Date(this.actualYear, this.actualMonth - 1, 1).getDay();
    const today: Date = new Date();
    const todayYear: number = today.getFullYear();
    const todayMonth: number = today.getMonth() + 1;
    const todayDay: number = today.getDate();

    const allDays: TnWeekCalendarDateItem[] = [];

    // 上月补位
    const prevMonth: number = this.actualMonth === 1 ? 12 : this.actualMonth - 1;
    const prevYear: number = this.actualMonth === 1 ? this.actualYear - 1 : this.actualYear;
    const prevMonthDays: number = new Date(prevYear, prevMonth, 0).getDate();

    for (let i: number = 0; i < firstDayOfWeek; i++) {
      const day: number = prevMonthDays - firstDayOfWeek + 1 + i;
      const dayOfWeek: number = i;
      const item: TnWeekCalendarDateItem = {
        year: prevYear,
        month: prevMonth,
        day: day,
        dayOfWeek: dayOfWeek,
        isToday: false,
        isSelected: false,
        isDisabled: true,
        customText: "",
        customColor: ""
      };
      allDays.push(item);
    }

    // 当月日期
    for (let day: number = 1; day <= daysInMonth; day++) {
      const dateObj: Date = new Date(this.actualYear, this.actualMonth - 1, day);
      const dayOfWeek: number = dateObj.getDay();
      const isToday: boolean = this.actualYear === todayYear &&
        this.actualMonth === todayMonth && day === todayDay;
      const isDisabled: boolean = (this.minDate > 0 && day < this.minDate) ||
        (this.maxDate > 0 && day > this.maxDate);

      let customText: string = "";
      let customColor: string = "";
      for (let ci: number = 0; ci < this.customData.length; ci++) {
        if (this.customData[ci].day === day) {
          customText = this.customData[ci].text;
          customColor = this.customData[ci].color !== undefined ? this.customData[ci].color! : "";
          break;
        }
      }

      const item: TnWeekCalendarDateItem = {
        year: this.actualYear,
        month: this.actualMonth,
        day: day,
        dayOfWeek: dayOfWeek,
        isToday: isToday,
        isSelected: day === this.selectedDay,
        isDisabled: isDisabled,
        customText: customText,
        customColor: customColor
      };
      allDays.push(item);
    }

    // 下月补位
    const nextMonth: number = this.actualMonth === 12 ? 1 : this.actualMonth + 1;
    const nextYear: number = this.actualMonth === 12 ? this.actualYear + 1 : this.actualYear;
    const totalCells: number = Math.ceil(allDays.length / DAYS_PER_WEEK) * DAYS_PER_WEEK;
    const remaining: number = totalCells - allDays.length;

    for (let day: number = 1; day <= remaining; day++) {
      const dateObj: Date = new Date(nextYear, nextMonth - 1, day);
      const dayOfWeek: number = dateObj.getDay();
      const item: TnWeekCalendarDateItem = {
        year: nextYear,
        month: nextMonth,
        day: day,
        dayOfWeek: dayOfWeek,
        isToday: false,
        isSelected: false,
        isDisabled: true,
        customText: "",
        customColor: ""
      };
      allDays.push(item);
    }

    // 按周分组
    const weeks: TnWeekCalendarDateItem[][] = [];
    for (let i: number = 0; i < allDays.length; i += DAYS_PER_WEEK) {
      const week: TnWeekCalendarDateItem[] = [];
      for (let j: number = 0; j < DAYS_PER_WEEK && (i + j) < allDays.length; j++) {
        week.push(allDays[i + j]);
      }
      weeks.push(week);
    }
    this.weeksData = weeks;
    this.dataVersion = this.dataVersion + 1;
  }

  /**
   * 定位当前选中日所在的周
   */
  private locateCurrentWeek(): void {
    for (let wi: number = 0; wi < this.weeksData.length; wi++) {
      const week: TnWeekCalendarDateItem[] = this.weeksData[wi];
      for (let di: number = 0; di < week.length; di++) {
        if (week[di].month === this.actualMonth && week[di].day === this.selectedDay) {
          this.currentWeekIndex = wi;
          return;
        }
      }
    }
  }

  /**
   * 点击日期
   * @param item 日期项
   */
  private onDayClick(item: TnWeekCalendarDateItem): void {
    if (item.isDisabled) {
      return;
    }
    this.selectedDay = item.day;
    this.generateWeeks();
    const changeData: TnWeekCalendarChangeData = {
      year: item.year,
      month: item.month,
      day: item.day,
      dayOfWeek: item.dayOfWeek
    };
    this.onChange(changeData);
  }

  /**
   * 获取选中背景颜色
   * @returns 颜色值
   */
  private getActiveBg(): ResourceColor {
    if (this.activeBgColor.length > 0) {
      return this.activeBgColor;
    }
    return getThemeColor(this.baseStyle, "primary");
  }

  /**
   * 获取选中文字颜色
   * @returns 颜色值
   */
  private getActiveText(): ResourceColor {
    if (this.activeTextColor.length > 0) {
      return this.activeTextColor;
    }
    return $r("app.color.tn_color_white");
  }

  build() {
    Column() {
      // 星期标题行
      this.WeekHeaderBuilder();
      // 周滑动区域
      if (this.weeksData.length > 0) {
        Swiper() {
          ForEach(
            this.weeksData,
            (week: TnWeekCalendarDateItem[], weekIdx: number) => {
              this.WeekRowBuilder(week);
            },
            (_week: TnWeekCalendarDateItem[], weekIdx: number): string =>
              `week_${weekIdx}_v${this.dataVersion}`
          );
        }
        .index(this.currentWeekIndex)
        .indicator(false)
        .loop(false)
        .onChange((index: number) => {
          this.currentWeekIndex = index;
          if (this.weeksData.length > index && this.weeksData[index].length > 0) {
            const firstDay: TnWeekCalendarDateItem = this.weeksData[index][0];
            this.onWeekChange(formatDate(firstDay.year, firstDay.month, firstDay.day));
          }
        });
      }
    }
    .width("100%")
    .backgroundColor($r("app.color.tn_bg_color"));
  }

  /**
   * 星期标题构建器
   */
  @Builder
  private WeekHeaderBuilder(): void {
    Row() {
      ForEach(
        WEEK_LABELS,
        (label: string) => {
          Text(label)
            .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
            .fontColor($r("app.color.tn_text_color_secondary"))
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
            .height(convertDimensionsWidthUnit(28));
        },
        (label: string, index: number): string => `wh_${index}_${label}`
      );
    }
    .width("100%");
  }

  /**
   * 周行构建器
   * @param week 一周的日期数据
   */
  @Builder
  private WeekRowBuilder(week: TnWeekCalendarDateItem[]): void {
    Row() {
      ForEach(
        week,
        (item: TnWeekCalendarDateItem) => {
          this.DayCellBuilder(item);
        },
        (item: TnWeekCalendarDateItem): string =>
          `day_${item.year}_${item.month}_${item.day}_${item.isSelected}_v${this.dataVersion}`
      );
    }
    .width("100%")
    .height(convertDimensionsWidthUnit(56));
  }

  /**
   * 日期单元格构建器
   * @param item 日期项
   */
  @Builder
  private DayCellBuilder(item: TnWeekCalendarDateItem): void {
    Column() {
      Text(item.day.toString())
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
        .fontColor(this.getDayCellTextColor(item))
        .textAlign(TextAlign.Center);

      if (item.customText.length > 0) {
        Text(item.customText)
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXxs"))
          .fontColor(item.customColor.length > 0 ? item.customColor :
            (item.isSelected ? this.getActiveText() : $r("app.color.tn_text_color_secondary")))
          .textAlign(TextAlign.Center)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ top: convertDimensionsWidthUnit(2) });
      } else if (item.isToday && !item.isSelected) {
        Text("今天")
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXxs"))
          .fontColor(getThemeColor(this.baseStyle, "primary"))
          .textAlign(TextAlign.Center)
          .margin({ top: convertDimensionsWidthUnit(2) });
      }
    }
    .layoutWeight(1)
    .height(convertDimensionsWidthUnit(48))
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(item.isSelected ? this.getActiveBg() : Color.Transparent)
    .borderRadius(item.isSelected ? this.baseStyle.borderRadiusLg : 0)
    .animation({ duration: this.baseStyle.animationDuration })
    .stateStyles({
      normal: {
        .opacity(1.0)
      },
      pressed: {
        .opacity(item.isDisabled ? 1.0 : 0.7)
      }
    })
    .margin(convertDimensionsWidthUnit(2))
    .onClick(() => {
      this.onDayClick(item);
    });
  }

  /**
   * 获取日期文字颜色
   * @param item 日期项
   * @returns 颜色值
   */
  private getDayCellTextColor(item: TnWeekCalendarDateItem): ResourceColor {
    if (item.isDisabled) {
      return $r("app.color.tn_color_gray_disabled");
    }
    if (item.isSelected) {
      return this.getActiveText();
    }
    if (item.isToday) {
      return getThemeColor(this.baseStyle, "primary");
    }
    return $r("app.color.tn_text_color_primary");
  }
}
