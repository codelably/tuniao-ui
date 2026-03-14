/**
 * @file TnWeekCalendar 周日历展示页面视图
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
import { TnWeekCalendar, TnWeekCalendarChangeData } from "@tuniao/tn-ui";
import TnWeekCalendarViewModel from "../viewmodel/TnWeekCalendarViewModel";

/**
 * TnWeekCalendar 周日历展示页面
 */
@ComponentV2
export struct TnWeekCalendarPage {
  /**
   * 周日历展示页面 ViewModel
   */
  @Local
  private vm: TnWeekCalendarViewModel = new TnWeekCalendarViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  /**
   * 构建周日历展示页面
   */
  build() {
    AppNavDestination({
      title: "周日历",
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
        // 1. 基础用法
        this.SectionTitle("基础用法");
        SpaceVerticalMedium();
        this.BasicSection();

        SpaceVerticalLarge();

        // 2. 自定义颜色
        this.SectionTitle("自定义颜色");
        SpaceVerticalMedium();
        this.CustomColorSection();
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
   * 1. 基础用法展示区
   */
  @Builder
  private BasicSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("通过 modelValue 绑定当前选中日期（几号），year 和 month 控制显示的年月，onChange 返回选中日期的完整信息")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnWeekCalendar({
          modelValue: this.vm.selectedDay,
          year: this.vm.currentYear,
          month: this.vm.currentMonth,
          onChange: (data: TnWeekCalendarChangeData) => {
            this.vm.setSelectedDate(data.year, data.month, data.day, data.dayOfWeek);
          }
        });

        SpaceVerticalMedium();

        Text(`当前选中：${this.vm.selectedText}`)
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
   * 2. 自定义颜色展示区
   */
  @Builder
  private CustomColorSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("通过 activeBgColor 和 activeTextColor 自定义选中日期的背景色与文字颜色")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnWeekCalendar({
          modelValue: this.vm.selectedDay,
          year: this.vm.currentYear,
          month: this.vm.currentMonth,
          activeBgColor: "#ff6700",
          activeTextColor: "#ffffff",
          onChange: (data: TnWeekCalendarChangeData) => {
            this.vm.setSelectedDate(data.year, data.month, data.day, data.dayOfWeek);
          }
        });

        SpaceVerticalMedium();

        Text(`当前选中：${this.vm.selectedText}`)
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
