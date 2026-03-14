/**
 * @file 农历计算工具
 * @description 基于 IBest-UI lunar.ts 改写为 ArkTS 兼容语法，支持 1900-2100 年农历计算
 * @author JunBin.Yang
 */

/** 农历数据表（1900-2100年） */
const LUNAR_INFO: number[] = [
  0x04bd8, 0x04ae0, 0x0a570, 0x054d5, 0x0d260, 0x0d950, 0x16554, 0x056a0, 0x09ad0, 0x055d2, // 1900-1909
  0x04ae0, 0x0a5b6, 0x0a4d0, 0x0d250, 0x1d255, 0x0b540, 0x0d6a0, 0x0ada2, 0x095b0, 0x14977, // 1910-1919
  0x04970, 0x0a4b0, 0x0b4b5, 0x06a50, 0x06d40, 0x1ab54, 0x02b60, 0x09570, 0x052f2, 0x04970, // 1920-1929
  0x06566, 0x0d4a0, 0x0ea50, 0x06e95, 0x05ad0, 0x02b60, 0x186e3, 0x092e0, 0x1c8d7, 0x0c950, // 1930-1939
  0x0d4a0, 0x1d8a6, 0x0b550, 0x056a0, 0x1a5b4, 0x025d0, 0x092d0, 0x0d2b2, 0x0a950, 0x0b557, // 1940-1949
  0x06ca0, 0x0b550, 0x15355, 0x04da0, 0x0a5b0, 0x14573, 0x052b0, 0x0a9a8, 0x0e950, 0x06aa0, // 1950-1959
  0x0aea6, 0x0ab50, 0x04b60, 0x0aae4, 0x0a570, 0x05260, 0x0f263, 0x0d950, 0x05b57, 0x056a0, // 1960-1969
  0x096d0, 0x04dd5, 0x04ad0, 0x0a4d0, 0x0d4d4, 0x0d250, 0x0d558, 0x0b540, 0x0b6a0, 0x195a6, // 1970-1979
  0x095b0, 0x049b0, 0x0a974, 0x0a4b0, 0x0b27a, 0x06a50, 0x06d40, 0x0af46, 0x0ab60, 0x09570, // 1980-1989
  0x04af5, 0x04970, 0x064b0, 0x074a3, 0x0ea50, 0x06b58, 0x055c0, 0x0ab60, 0x096d5, 0x092e0, // 1990-1999
  0x0c960, 0x0d954, 0x0d4a0, 0x0da50, 0x07552, 0x056a0, 0x0abb7, 0x025d0, 0x092d0, 0x0cab5, // 2000-2009
  0x0a950, 0x0b4a0, 0x0baa4, 0x0ad50, 0x055d9, 0x04ba0, 0x0a5b0, 0x15176, 0x052b0, 0x0a930, // 2010-2019
  0x07954, 0x06aa0, 0x0ad50, 0x05b52, 0x04b60, 0x0a6e6, 0x0a4e0, 0x0d260, 0x0ea65, 0x0d530, // 2020-2029
  0x05aa0, 0x076a3, 0x096d0, 0x04bd7, 0x04ad0, 0x0a4d0, 0x1d0b6, 0x0d250, 0x0d520, 0x0dd45, // 2030-2039
  0x0b5a0, 0x056d0, 0x055b2, 0x049b0, 0x0a577, 0x0a4b0, 0x0aa50, 0x1b255, 0x06d20, 0x0ada0, // 2040-2049
  0x14b63, 0x09370, 0x049f8, 0x04970, 0x064b0, 0x168a6, 0x0ea50, 0x06b20, 0x1a6c4, 0x0aae0, // 2050-2059
  0x092e0, 0x0d2e3, 0x0c960, 0x0d557, 0x0d4a0, 0x0da50, 0x05d55, 0x056a0, 0x0a6d0, 0x055d4, // 2060-2069
  0x052d0, 0x0a9b8, 0x0a950, 0x0b4a0, 0x0b6a6, 0x0ad50, 0x055a0, 0x0aba4, 0x0a5b0, 0x052b0, // 2070-2079
  0x0b273, 0x06930, 0x07337, 0x06aa0, 0x0ad50, 0x14b55, 0x04b60, 0x0a570, 0x054e4, 0x0d160, // 2080-2089
  0x0e968, 0x0d520, 0x0daa0, 0x16aa6, 0x056d0, 0x04ae0, 0x0a9d4, 0x0a2d0, 0x0d150, 0x0f252, // 2090-2099
  0x0d520 // 2100
];

/** 农历月份中文名称 */
const LUNAR_MONTH_NAMES: string[] = ["正", "二", "三", "四", "五", "六", "七", "八", "九", "十", "冬", "腊"];

/** 农历日期中文名称 */
const LUNAR_DAY_NAMES: string[] = [
  "初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十",
  "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十",
  "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十"
];

/**
 * 农历日期类
 * @description 封装农历年月日及闰月信息，提供中文格式化方法
 */
export class Lunar {
  private lunarYear: number;
  private lunarMonth: number;
  private lunarDay: number;
  private leapMonth: boolean;

  constructor(year: number, month: number, day: number, isLeapMonth: boolean = false) {
    this.lunarYear = year;
    this.lunarMonth = month;
    this.lunarDay = day;
    this.leapMonth = isLeapMonth;
  }

  /**
   * 从公历日期创建农历对象
   * @param date 公历日期
   * @returns 农历对象
   */
  static fromDate(date: Date): Lunar {
    const baseDate: Date = new Date(1900, 0, 31);
    const timeDiff: number = date.getTime() - baseDate.getTime();
    let offset: number = Math.floor(timeDiff / (24 * 60 * 60 * 1000));

    let year: number = 1900;
    let daysInYear: number = 0;
    while (true) {
      daysInYear = Lunar.getLunarYearDays(year);
      if (offset < daysInYear) {
        break;
      }
      offset -= daysInYear;
      year++;
    }

    let month: number = 1;
    let isLeap: boolean = false;
    while (true) {
      const daysInMonth: number = Lunar.getLunarMonthDays(year, month, isLeap);
      if (offset >= daysInMonth) {
        offset -= daysInMonth;
        const leapM: number = Lunar.getLeapMonth(year);
        if (!isLeap && leapM === month) {
          isLeap = true;
        } else {
          isLeap = false;
          month++;
          if (month > 12) {
            month = 1;
            year++;
          }
        }
      } else {
        break;
      }
    }

    const day: number = offset + 1;
    return new Lunar(year, month, day, isLeap);
  }

  /**
   * 获取农历年的总天数
   * @param lunarYear 农历年
   * @returns 总天数
   */
  static getLunarYearDays(lunarYear: number): number {
    const info: number = LUNAR_INFO[lunarYear - 1900];
    let totalDays: number = 0;
    for (let i: number = 1; i <= 12; i++) {
      const bitPosition: number = 16 - i;
      totalDays += (info >> bitPosition) & 0x01 ? 30 : 29;
    }
    const leapMonth: number = info & 0x0F;
    if (leapMonth > 0) {
      totalDays += (info >> 16) & 0x01 ? 30 : 29;
    }
    return totalDays;
  }

  /**
   * 获取农历年某月的天数
   * @param lunarYear 农历年
   * @param lunarMonth 农历月
   * @param isLeapMonth 是否闰月
   * @returns 月天数
   */
  static getLunarMonthDays(lunarYear: number, lunarMonth: number, isLeapMonth: boolean): number {
    const info: number = LUNAR_INFO[lunarYear - 1900];
    const leapMonth: number = info & 0x0F;
    if (isLeapMonth && lunarMonth === leapMonth) {
      return (info >> 16) & 0x01 ? 30 : 29;
    }
    const bitPosition: number = 16 - lunarMonth;
    return (info >> bitPosition) & 0x01 ? 30 : 29;
  }

  /**
   * 获取农历年的闰月（0 表示无闰月）
   * @param lunarYear 农历年
   * @returns 闰月月份，0 表示无闰月
   */
  static getLeapMonth(lunarYear: number): number {
    const info: number = LUNAR_INFO[lunarYear - 1900];
    return info & 0x0F;
  }

  /**
   * 获取农历月份的中文名称
   * @returns 月份中文名称（如"正"、"闰二"）
   */
  getMonthInChinese(): string {
    let monthName: string = LUNAR_MONTH_NAMES[this.lunarMonth - 1];
    if (this.leapMonth) {
      monthName = "闰" + monthName;
    }
    return monthName;
  }

  /**
   * 获取农历日期的中文名称
   * @returns 日期中文名称（如"初一"、"十五"）
   */
  getDayInChinese(): string {
    return LUNAR_DAY_NAMES[this.lunarDay - 1];
  }

  /**
   * 获取农历日期数字
   * @returns 农历日期（1-30）
   */
  getDay(): number {
    return this.lunarDay;
  }
}

/**
 * 从公历日期获取农历对象的便捷函数
 * @param date 公历日期，默认为当天
 * @returns 农历对象
 */
export function lunar(date?: Date): Lunar {
  return Lunar.fromDate(date !== undefined ? date : new Date());
}
