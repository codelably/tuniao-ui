/**
 * @file TnCalendar 日历展示页面视图
 * @author JunBin.Yang
 */
import { AppNavDestination } from "@core/components";
import {
  ColumnBase,
  MediumPaddingVerticalScroll,
  P100,
  SpaceVerticalLarge,
  SpaceVerticalMedium
} from "@core/designsystem";
import { getWindowSafeAreaState, WindowSafeAreaState } from "@core/layoutstate";
import { TnCalendar } from "@tuniao/tn-ui";
import TnCalendarViewModel from "../viewmodel/TnCalendarViewModel";

/**
 * TnCalendar 日历展示页面
 */
@ComponentV2
export struct TnCalendarPage {
  /**
   * 日历展示页面 ViewModel
   */
  @Local
  private vm: TnCalendarViewModel = new TnCalendarViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  /**
   * 构建日历展示页面
   */
  build() {
    AppNavDestination({
      title: "日历",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.PageContent();
    }
  }

  /**
   * 页面内容视图
   */
  @Builder
  private PageContent() {
    MediumPaddingVerticalScroll() {
      ColumnBase({ widthValue: P100 }) {
        // 1. 单选模式
        this.SectionTitle("单选模式");
        SpaceVerticalMedium();
        this.SingleSection();

        SpaceVerticalLarge();

        // 2. 多选模式
        this.SectionTitle("多选模式");
        SpaceVerticalMedium();
        this.MultiSection();

        SpaceVerticalLarge();

        // 3. 范围选择
        this.SectionTitle("范围选择");
        SpaceVerticalMedium();
        this.RangeSection();

        SpaceVerticalLarge();

        // 4. 自定义颜色
        this.SectionTitle("自定义颜色");
        SpaceVerticalMedium();
        this.CustomColorSection();

        SpaceVerticalLarge();

        // 5. 农历显示
        this.SectionTitle("农历显示");
        SpaceVerticalMedium();
        this.LunarSection();

        SpaceVerticalLarge();

        // 6. 周末红色
        this.SectionTitle("周末红色");
        SpaceVerticalMedium();
        this.WeekendColorSection();

        SpaceVerticalLarge();

        // 7. 法定节假日与补班日
        this.SectionTitle("法定节假日与补班日");
        SpaceVerticalMedium();
        this.HolidaySection();
      };
    };
  }

  /**
   * 区域标题
   * @param title 标题文本
   */
  @Builder
  private SectionTitle(title: string): void {
    Text(title)
      .fontSize($r("app.float.headline_medium"))
      .fontColor($r("app.color.text_primary"))
      .fontWeight(FontWeight.Bold);
  }

  /**
   * 1. 单选模式展示区
   */
  @Builder
  private SingleSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("mode 设置为 date 启用单选模式，点击日期单独选中，modelValue 绑定选中日期字符串")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnCalendar({
          mode: "date",
          modelValue: this.vm.selectedDate,
          onChange: (value: string | string[]) => {
            this.vm.setSelectedDate(value as string);
          }
        });

        SpaceVerticalMedium();

        Text(`已选日期：${this.vm.selectedDate || "未选择"}`)
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_secondary"));
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 2. 多选模式展示区
   */
  @Builder
  private MultiSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("mode 设置为 multi 启用多选模式，可同时选中多个日期，modelValue 绑定日期数组")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnCalendar({
          mode: "multi",
          modelValue: this.vm.selectedDates,
          onChange: (value: string | string[]) => {
            this.vm.setSelectedDates(value as string[]);
          }
        });

        SpaceVerticalMedium();

        Text(`已选 ${this.vm.selectedDates.length} 个日期`)
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_secondary"));
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 3. 范围选择展示区
   */
  @Builder
  private RangeSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("mode 设置为 range 启用范围选择，点击两个日期确定开始和结束日期区间")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnCalendar({
          mode: "range",
          modelValue: (this.vm.rangeStart && this.vm.rangeEnd) ? [this.vm.rangeStart, this.vm.rangeEnd] : [],
          onChange: (value: string | string[]) => {
            const rangeArr: string[] = value as string[];
            this.vm.setRange(rangeArr[0] ?? "", rangeArr[1] ?? "");
          }
        });

        SpaceVerticalMedium();

        Text(`开始：${this.vm.rangeStart || "未选择"}  结束：${this.vm.rangeEnd || "未选择"}`)
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_secondary"));
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 4. 自定义颜色展示区
   */
  @Builder
  private CustomColorSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("通过 activeBgColor 自定义选中日期的背景颜色，支持 hex 色值")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnCalendar({
          mode: "date",
          modelValue: this.vm.selectedDate,
          activeBgColor: "#ff6700",
          onChange: (value: string | string[]) => {
            this.vm.setSelectedDate(value as string);
          }
        });

        SpaceVerticalMedium();

        Text(`已选日期：${this.vm.selectedDate || "未选择"}`)
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_secondary"));
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 5. 农历显示展示区
   */
  @Builder
  private LunarSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 showLunar 为 true 在日期下方显示农历信息，初一显示农历月名，其余显示农历日名")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnCalendar({
          mode: "date",
          modelValue: this.vm.lunarSelectedDate,
          showLunar: true,
          onChange: (value: string | string[]) => {
            this.vm.setLunarSelectedDate(value as string);
          }
        });

        SpaceVerticalMedium();

        Text(`已选日期：${this.vm.lunarSelectedDate || "未选择"}`)
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_secondary"));
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 6. 周末红色展示区
   */
  @Builder
  private WeekendColorSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 showWeekendColor 为 true，周六和周日的日期文字及星期标题将显示为红色")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnCalendar({
          mode: "date",
          modelValue: this.vm.lunarSelectedDate,
          showWeekendColor: true,
          showLunar: true,
          onChange: (value: string | string[]) => {
            this.vm.setLunarSelectedDate(value as string);
          }
        });
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 7. 法定节假日与补班日展示区
   */
  @Builder
  private HolidaySection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("传入 holidays 数组配置法定节假日和补班日，节假日显示红色文字及\"休\"徽标，补班日显示\"班\"徽标")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnCalendar({
          mode: "date",
          modelValue: this.vm.lunarSelectedDate,
          showLunar: true,
          showWeekendColor: true,
          holidays: this.vm.holidays,
          onChange: (value: string | string[]) => {
            this.vm.setLunarSelectedDate(value as string);
          }
        });

        SpaceVerticalMedium();

        Text(`已选日期：${this.vm.lunarSelectedDate || "未选择"}`)
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_secondary"));
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }
}
