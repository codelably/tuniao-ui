/**
 * @file TnCountTo 数字跳转展示页面视图
 * @author JunBin.Yang
 */
import { AppNavDestination } from "@core/components";
import {
  ColumnBase,
  MediumPaddingVerticalScroll,
  P100,
  SpaceVerticalLarge,
  SpaceVerticalMedium,
  SpaceVerticalSmall
} from "@core/designsystem";
import { getWindowSafeAreaState, WindowSafeAreaState } from "@core/layoutstate";
import { TnCountTo, TnButton } from "@tuniao/tn-ui";
import TnCountToViewModel from "../viewmodel/TnCountToViewModel";

@ComponentV2
export struct TnCountToPage {
  @Local private vm: TnCountToViewModel = new TnCountToViewModel();
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  build() {
    AppNavDestination({
      title: "数字跳转",
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

  @Builder private PageContent() {
    MediumPaddingVerticalScroll() {
      ColumnBase({ widthValue: P100 }) {
        // ===== 基础用法 =====
        this.SectionTitle("基础用法");
        SpaceVerticalMedium();
        Column() {
          Text("从 0 到 1000")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountTo({ endValue: this.vm.basicEndValue });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 大数值 =====
        this.SectionTitle("大数值");
        SpaceVerticalMedium();
        Column() {
          Text("从 0 到 999999")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountTo({ endValue: this.vm.largeEndValue });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 小数位数 =====
        this.SectionTitle("小数位数");
        SpaceVerticalMedium();
        Column() {
          Text("decimals = 2（0 → 186.55）")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountTo({ endValue: this.vm.decimalEndValue, decimals: 2 });
          SpaceVerticalMedium();

          Text("自定义小数分隔符（decimalSeparator = '*'）")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountTo({ endValue: this.vm.decimalEndValue, decimals: 2, decimalSeparator: '*' });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 千分位分隔符 =====
        this.SectionTitle("千分位分隔符");
        SpaceVerticalMedium();
        Column() {
          Text("thousandsSeparator = ','（0 → 1,234,567.89）")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountTo({
            endValue: this.vm.thousandsEndValue,
            decimals: 2,
            thousandsSeparator: ','
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 自定义持续时间 =====
        this.SectionTitle("自定义持续时间");
        SpaceVerticalMedium();
        Column() {
          Text("duration = 3000ms（0 → 5000）")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountTo({ endValue: this.vm.durationEndValue, duration: 3000 });
          SpaceVerticalMedium();

          Text("duration = 500ms（快速动画）")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountTo({ endValue: this.vm.durationEndValue, duration: 500 });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 倒数 =====
        this.SectionTitle("倒数（从大到小）");
        SpaceVerticalMedium();
        Column() {
          Text("从 1000 到 0")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountTo({
            startValue: this.vm.countDownStartValue,
            endValue: this.vm.countDownEndValue
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 关闭缓动 =====
        this.SectionTitle("关闭缓动");
        SpaceVerticalMedium();
        Column() {
          Text("useEasing = false（匀速动画）")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountTo({ endValue: this.vm.noEasingEndValue, useEasing: false });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 自定义颜色 =====
        this.SectionTitle("自定义颜色");
        SpaceVerticalMedium();
        Column() {
          Text("主题色 - primary")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountTo({ endValue: this.vm.basicEndValue, textColor: "primary" });
          SpaceVerticalMedium();

          Text("主题色 - danger")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountTo({ endValue: this.vm.basicEndValue, textColor: "danger" });
          SpaceVerticalMedium();

          Text("主题色 - success")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountTo({ endValue: this.vm.basicEndValue, textColor: "success" });
          SpaceVerticalMedium();

          Text("自定义 hex 色值")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountTo({ endValue: this.vm.basicEndValue, textColor: "#01beff" });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 自定义字体大小和字重 =====
        this.SectionTitle("自定义字体大小和字重");
        SpaceVerticalMedium();
        Column() {
          Text("fontSize = 12")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountTo({ endValue: this.vm.basicEndValue, fontSize: 12 });
          SpaceVerticalMedium();

          Text("fontSize = 20")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountTo({ endValue: this.vm.basicEndValue, fontSize: 20 });
          SpaceVerticalMedium();

          Text("fontSize = 30, fontWeight = Bold")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountTo({
            endValue: this.vm.basicEndValue,
            fontSize: 30,
            fontWeight: FontWeight.Bold
          });
          SpaceVerticalMedium();

          Text("fontSize = 30, fontWeight = Bold, 主题色")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountTo({
            endValue: this.vm.basicEndValue,
            fontSize: 30,
            fontWeight: FontWeight.Bold,
            textColor: "primary"
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 手动控制 =====
        this.SectionTitle("手动控制（控制器）");
        SpaceVerticalMedium();
        Column() {
          Text(`状态：${this.vm.controlStatusText}`)
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountTo({
            endValue: this.vm.controlEndValue,
            autoPlay: false,
            controller: this.vm.controlController,
            textColor: "primary",
            fontSize: 24,
            fontWeight: FontWeight.Bold,
            thousandsSeparator: ',',
            onEnd: () => {
              this.vm.onControlEnd();
            }
          });
          SpaceVerticalMedium();
          Row({ space: 12 }) {
            TnButton({
              content: "开始",
              btnSize: "sm",
              type: "primary",
              onBtnClick: () => {
                this.vm.startControl();
              }
            });
            TnButton({
              content: "暂停",
              btnSize: "sm",
              type: "warning",
              onBtnClick: () => {
                this.vm.pauseControl();
              }
            });
            TnButton({
              content: "继续",
              btnSize: "sm",
              type: "success",
              onBtnClick: () => {
                this.vm.resumeControl();
              }
            });
            TnButton({
              content: "重置",
              btnSize: "sm",
              type: "info",
              onBtnClick: () => {
                this.vm.resetControl();
              }
            });
          };
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
