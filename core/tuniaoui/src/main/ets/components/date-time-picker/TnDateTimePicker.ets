/**
 * @file TnDateTimePicker 日期时间选择器组件
 * @description 基于系统 DatePicker/TimePicker 组件封装，支持多种模式
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { getThemeColor, getFontSizeByKey } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { TnDateTimePickerMode } from "./TnDateTimePickerTypes";
import { convertDimensionsWidthUnit } from "../../utils/Utils";
import { getHexColorByResoure, mixWithBlack } from "../../utils/ColorUtils";

/**
 * TnDateTimePicker 日期时间选择器
 *
 * @example
 * TnDateTimePicker({
 *   open: true,
 *   mode: "date",
 *   onConfirm: (value) => {},
 *   onClose: () => {}
 * })
 */
@ComponentV2
export struct TnDateTimePicker {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  /** 绑定值 */
  @Param modelValue: string = "";
  /** 显示/隐藏 */
  @Param open: boolean = false;
  /** 模式 */
  @Param mode: TnDateTimePickerMode = "date";
  /** 最小时间 */
  @Param minTime: string = "";
  /** 最大时间 */
  @Param maxTime: string = "";
  /** 格式化字符串 */
  @Param format: string = "";
  /** 空值时初始化为当前时间 */
  @Param initCurrentDateTime: boolean = true;
  /** 标题 */
  @Param title: string = "";

  /** 确认回调 */
  @Event onConfirm: (value: string) => void = (_value: string): void => {};
  /** 取消回调 */
  @Event onCancel: () => void = (): void => {};
  /** 关闭回调 */
  @Event onClose: () => void = (): void => {};
  /** 变化回调 */
  @Event onChange: (value: string) => void = (_value: string): void => {};

  /** 当前选择的日期 */
  @Local private selectedDate: Date = new Date();
  /** datetime 模式当前步骤（1=选日期，2=选时间） */
  @Local private datetimeStep: number = 1;
  /** datetime 模式暂存的日期 */
  @Local private tempDate: Date = new Date();
  /** yearmonth 模式：年列数据 */
  @Local private yearRange: string[] = [];
  /** yearmonth 模式：月列数据 */
  @Local private monthRange: string[] = [];
  /** yearmonth 模式：选中的年索引 */
  @Local private selectedYearIndex: number = 0;
  /** yearmonth 模式：选中的月索引 */
  @Local private selectedMonthIndex: number = 0;

  aboutToAppear(): void {
    if (this.modelValue.length > 0) {
      this.selectedDate = new Date(this.modelValue);
    } else if (this.initCurrentDateTime) {
      this.selectedDate = new Date();
    }
    if (this.mode === "yearmonth") {
      this.initYearMonthRange();
    }
  }

  /**
   * 初始化年月选择器的列数据和默认选中项
   */
  private initYearMonthRange(): void {
    const startYear: number = this.minTime.length > 0 ? new Date(this.minTime).getFullYear() : 1970;
    const endYear: number = this.maxTime.length > 0 ? new Date(this.maxTime).getFullYear() : 2100;
    const years: string[] = [];
    for (let y = startYear; y <= endYear; y++) {
      years.push(`${y}年`);
    }
    this.yearRange = years;
    const months: string[] = [];
    for (let m = 1; m <= 12; m++) {
      months.push(`${m}月`);
    }
    this.monthRange = months;
    const currentYear: number = this.selectedDate.getFullYear();
    const currentMonth: number = this.selectedDate.getMonth();
    this.selectedYearIndex = currentYear >= startYear && currentYear <= endYear ? currentYear - startYear : 0;
    this.selectedMonthIndex = currentMonth;
  }

  /**
   * 格式化日期为字符串
   * @param date 日期对象
   * @returns 格式化后的字符串
   */
  private formatDate(date: Date): string {
    const year: string = `${date.getFullYear()}`;
    const month: string = `${date.getMonth() + 1}`.padStart(2, "0");
    const day: string = `${date.getDate()}`.padStart(2, "0");
    const hours: string = `${date.getHours()}`.padStart(2, "0");
    const minutes: string = `${date.getMinutes()}`.padStart(2, "0");

    if (this.format.length > 0) {
      return this.format
        .replace("YYYY", year)
        .replace("MM", month)
        .replace("DD", day)
        .replace("HH", hours)
        .replace("mm", minutes);
    }

    switch (this.mode) {
      case "year":
        return year;
      case "yearmonth":
        return `${year}-${month}`;
      case "date":
        return `${year}-${month}-${day}`;
      case "datetime":
        return `${year}-${month}-${day} ${hours}:${minutes}`;
      case "time":
        return `${hours}:${minutes}`;
      default:
        return `${year}-${month}-${day}`;
    }
  }

  /**
   * 获取当前工具栏标题
   * @returns 显示的标题文本
   */
  private getToolbarTitle(): string {
    if (this.mode === "datetime") {
      if (this.datetimeStep === 1) {
        return this.title.length > 0 ? this.title : "选择日期";
      }
      return "选择时间";
    }
    return this.title;
  }

  /**
   * 处理 datetime 模式的确认操作
   */
  private handleDatetimeConfirm(): void {
    if (this.datetimeStep === 1) {
      // 暂存日期，进入第二步选时间
      this.tempDate = new Date(
        this.selectedDate.getFullYear(),
        this.selectedDate.getMonth(),
        this.selectedDate.getDate(),
        this.selectedDate.getHours(),
        this.selectedDate.getMinutes()
      );
      this.datetimeStep = 2;
    } else {
      // 合并日期+时间，输出结果
      const finalDate: Date = new Date(
        this.tempDate.getFullYear(),
        this.tempDate.getMonth(),
        this.tempDate.getDate(),
        this.selectedDate.getHours(),
        this.selectedDate.getMinutes()
      );
      this.onConfirm(this.formatDate(finalDate));
      this.datetimeStep = 1;
      this.onClose();
    }
  }

  /**
   * 处理 datetime 模式的取消操作
   */
  private handleDatetimeCancel(): void {
    this.datetimeStep = 1;
    this.onCancel();
    this.onClose();
  }

  build() {
    Column() {
      if (this.open) {
        Column() {
          // 工具栏
          this.ToolbarBuilder();
          // 选择器
          if (this.mode === "time") {
            this.TimePickerBuilder();
          } else if (this.mode === "datetime") {
            this.DatetimePickerBuilder();
          } else if (this.mode === "yearmonth") {
            this.YearMonthPickerBuilder();
          } else {
            this.DatePickerBuilder();
          }
        }
        .width("100%")
        .backgroundColor($r("app.color.tn_bg_color"))
        .borderRadius({
          topLeft: this.baseStyle.borderRadiusXxl,
          topRight: this.baseStyle.borderRadiusXxl
        })
        .padding({ bottom: this.baseStyle.spaceLg });
      }
    }
    .width("100%");
  }

  /**
   * 年月选择器（仅显示年、月两列）
   */
  @Builder
  private YearMonthPickerBuilder(): void {
    if (this.yearRange.length > 0) {
      TextPicker({
        range: [this.yearRange, this.monthRange],
        selected: [this.selectedYearIndex, this.selectedMonthIndex]
      })
        .width("100%")
        .height(convertDimensionsWidthUnit(220))
        .onChange((_value: string | string[], index: number | number[]) => {
          if (typeof index !== "number") {
            const indices: number[] = index as number[];
            this.selectedYearIndex = indices[0];
            this.selectedMonthIndex = indices[1];
            const startYear: number = this.minTime.length > 0
              ? new Date(this.minTime).getFullYear() : 1970;
            const year: number = startYear + this.selectedYearIndex;
            const month: number = this.selectedMonthIndex;
            this.selectedDate = new Date(year, month, 1);
            this.onChange(this.formatDate(this.selectedDate));
          }
        });
    }
  }

  /**
   * 日期选择器
   */
  @Builder
  private DatePickerBuilder(): void {
    DatePicker({
      start: this.minTime.length > 0 ? new Date(this.minTime) : new Date("1970-01-01"),
      end: this.maxTime.length > 0 ? new Date(this.maxTime) : new Date("2100-12-31"),
      selected: this.selectedDate
    })
      .width("100%")
      .height(convertDimensionsWidthUnit(220))
      .lunar(false)
      .onChange((value: DatePickerResult) => {
        this.selectedDate = new Date(value.year ?? 2024, value.month ?? 0, value.day ?? 1);
        this.onChange(this.formatDate(this.selectedDate));
      });
  }

  /**
   * 时间选择器
   */
  @Builder
  private TimePickerBuilder(): void {
    TimePicker({
      selected: this.selectedDate
    })
      .width("100%")
      .height(convertDimensionsWidthUnit(220))
      .useMilitaryTime(true)
      .onChange((value: TimePickerResult) => {
        this.selectedDate.setHours(value.hour);
        this.selectedDate.setMinutes(value.minute);
        this.onChange(this.formatDate(this.selectedDate));
      });
  }

  /**
   * datetime 模式两步选择器
   */
  @Builder
  private DatetimePickerBuilder(): void {
    if (this.datetimeStep === 1) {
      // 第一步：选择日期
      DatePicker({
        start: this.minTime.length > 0 ? new Date(this.minTime) : new Date("1970-01-01"),
        end: this.maxTime.length > 0 ? new Date(this.maxTime) : new Date("2100-12-31"),
        selected: this.selectedDate
      })
        .width("100%")
        .height(convertDimensionsWidthUnit(220))
        .lunar(false)
        .onChange((value: DatePickerResult) => {
          this.selectedDate = new Date(value.year ?? 2024, value.month ?? 0, value.day ?? 1,
            this.selectedDate.getHours(), this.selectedDate.getMinutes());
        });
    } else {
      // 第二步：选择时间
      TimePicker({
        selected: this.selectedDate
      })
        .width("100%")
        .height(convertDimensionsWidthUnit(220))
        .useMilitaryTime(true)
        .onChange((value: TimePickerResult) => {
          this.selectedDate.setHours(value.hour);
          this.selectedDate.setMinutes(value.minute);
        });
    }
  }

  /**
   * 工具栏构建器
   */
  @Builder
  private ToolbarBuilder(): void {
    Row() {
      Text("取消")
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
        .fontColor($r("app.color.tn_text_color_secondary"))
        .lineHeight(this.baseStyle.lineHeightSm)
        .padding({
          left: this.baseStyle.spaceMlg,
          right: this.baseStyle.spaceMlg,
          top: this.baseStyle.spaceMd,
          bottom: this.baseStyle.spaceMd
        })
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
          if (this.mode === "datetime") {
            this.handleDatetimeCancel();
          } else {
            this.onCancel();
            this.onClose();
          }
        });

      // 标题
      if (this.mode === "datetime") {
        Text(this.getToolbarTitle())
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeLg"))
          .fontColor($r("app.color.tn_text_color_primary"))
          .fontWeight(FontWeight.Medium)
          .lineHeight(this.baseStyle.lineHeightMd)
          .layoutWeight(1)
          .textAlign(TextAlign.Center);
      } else if (this.title.length > 0) {
        Text(this.title)
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeLg"))
          .fontColor($r("app.color.tn_text_color_primary"))
          .fontWeight(FontWeight.Medium)
          .lineHeight(this.baseStyle.lineHeightMd)
          .layoutWeight(1)
          .textAlign(TextAlign.Center);
      } else {
        Blank().layoutWeight(1);
      }

      Text(this.mode === "datetime" && this.datetimeStep === 1 ? "下一步" : "确定")
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
        .fontColor(getThemeColor(this.baseStyle, "primary"))
        .lineHeight(this.baseStyle.lineHeightSm)
        .padding({
          left: this.baseStyle.spaceMlg,
          right: this.baseStyle.spaceMlg,
          top: this.baseStyle.spaceMd,
          bottom: this.baseStyle.spaceMd
        })
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
          if (this.mode === "datetime") {
            this.handleDatetimeConfirm();
          } else {
            this.onConfirm(this.formatDate(this.selectedDate));
            this.onClose();
          }
        });
    }
    .width("100%")
    .height(convertDimensionsWidthUnit(48))
    .alignItems(VerticalAlign.Center);
  }
}
