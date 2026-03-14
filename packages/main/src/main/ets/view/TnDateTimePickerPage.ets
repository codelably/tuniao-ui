/**
 * @file TnDateTimePicker 日期时间选择器展示页面视图
 * @description 使用 TnPopup 从底部弹出日期时间选择器，展示各种模式
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
import { TnButton, TnDateTimePicker, TnPopup } from "@tuniao/tn-ui";
import TnDateTimePickerViewModel from "../viewmodel/TnDateTimePickerViewModel";

@ComponentV2
export struct TnDateTimePickerPage {
  @Local private vm: TnDateTimePickerViewModel = new TnDateTimePickerViewModel();
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  build() {
    AppNavDestination({
      title: "日期时间选择器",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.PageContent();
      // 日期选择
      TnPopup({
        visible: this.vm.datePickerOpen,
        $visible: (val: boolean) => { this.vm.datePickerOpen = val; },
        openDirection: "bottom",
        radius: 0,
        contentBuilder: () => { this.DatePickerContent(); }
      });
      // 时间选择
      TnPopup({
        visible: this.vm.timePickerOpen,
        $visible: (val: boolean) => { this.vm.timePickerOpen = val; },
        openDirection: "bottom",
        radius: 0,
        contentBuilder: () => { this.TimePickerContent(); }
      });
      // 年月选择
      TnPopup({
        visible: this.vm.yearMonthPickerOpen,
        $visible: (val: boolean) => { this.vm.yearMonthPickerOpen = val; },
        openDirection: "bottom",
        radius: 0,
        contentBuilder: () => { this.YearMonthPickerContent(); }
      });
      // 日期时间组合
      TnPopup({
        visible: this.vm.datetimePickerOpen,
        $visible: (val: boolean) => { this.vm.datetimePickerOpen = val; },
        openDirection: "bottom",
        radius: 0,
        contentBuilder: () => { this.DatetimePickerContent(); }
      });
    }
  }

  /**
   * 日期选择器内容
   */
  @Builder private DatePickerContent(): void {
    TnDateTimePicker({
      open: true,
      mode: "date",
      onConfirm: (value: string) => { this.vm.onDateConfirm(value); },
      onCancel: () => { this.vm.closeDatePicker(); },
      onClose: () => { this.vm.closeDatePicker(); }
    });
  }

  /**
   * 时间选择器内容
   */
  @Builder private TimePickerContent(): void {
    TnDateTimePicker({
      open: true,
      mode: "time",
      onConfirm: (value: string) => { this.vm.onTimeConfirm(value); },
      onCancel: () => { this.vm.closeTimePicker(); },
      onClose: () => { this.vm.closeTimePicker(); }
    });
  }

  /**
   * 年月选择器内容
   */
  @Builder private YearMonthPickerContent(): void {
    TnDateTimePicker({
      open: true,
      mode: "yearmonth",
      onConfirm: (value: string) => { this.vm.onYearMonthConfirm(value); },
      onCancel: () => { this.vm.yearMonthPickerOpen = false; },
      onClose: () => { this.vm.yearMonthPickerOpen = false; }
    });
  }

  /**
   * 日期时间组合选择器内容
   */
  @Builder private DatetimePickerContent(): void {
    TnDateTimePicker({
      open: true,
      mode: "datetime",
      onConfirm: (value: string) => { this.vm.onDatetimeConfirm(value); },
      onCancel: () => { this.vm.datetimePickerOpen = false; },
      onClose: () => { this.vm.datetimePickerOpen = false; }
    });
  }

  @Builder private PageContent(): void {
    MediumPaddingVerticalScroll() {
      ColumnBase({ widthValue: P100 }) {
        // 日期选择
        this.SectionTitle("日期选择");
        SpaceVerticalMedium();
        Column() {
          TnButton({
            content: "选择日期",
            onBtnClick: () => { this.vm.toggleDatePicker(); }
          });
          SpaceVerticalMedium();
          Text(`已选日期：${this.vm.selectedDate || "（未选择）"}`)
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_secondary"));
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 时间选择
        this.SectionTitle("时间选择");
        SpaceVerticalMedium();
        Column() {
          TnButton({
            content: "选择时间",
            onBtnClick: () => { this.vm.toggleTimePicker(); }
          });
          SpaceVerticalMedium();
          Text(`已选时间：${this.vm.selectedTime || "（未选择）"}`)
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_secondary"));
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 选择年月
        this.SectionTitle("选择年月");
        SpaceVerticalMedium();
        Column() {
          TnButton({
            content: "选择年月",
            onBtnClick: () => { this.vm.toggleYearMonthPicker(); }
          });
          SpaceVerticalMedium();
          Text(`已选年月：${this.vm.selectedYearMonth || "（未选择）"}`)
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_secondary"));
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 日期和时间组合
        this.SectionTitle("日期和时间组合");
        SpaceVerticalMedium();
        Column() {
          TnButton({
            content: "选择日期和时间",
            onBtnClick: () => { this.vm.toggleDatetimePicker(); }
          });
          SpaceVerticalMedium();
          Text(`已选日期时间：${this.vm.selectedDatetime || "（未选择）"}`)
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_secondary"));
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();
      };
    };
  }

  @Builder private SectionTitle(title: string): void {
    Text(title)
      .fontSize($r("app.float.headline_medium"))
      .fontColor($r("app.color.text_primary"))
      .fontWeight(FontWeight.Bold);
  }
}
