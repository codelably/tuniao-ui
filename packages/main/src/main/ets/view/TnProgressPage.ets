/**
 * @file TnProgress 进度条展示页面视图
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
import { TnLineProgress, TnCircleProgress, TnButton } from "@tuniao/tn-ui";
import TnProgressViewModel from "../viewmodel/TnProgressViewModel";

@ComponentV2
export struct TnProgressPage {
  @Local private vm: TnProgressViewModel = new TnProgressViewModel();
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  build() {
    AppNavDestination({
      title: "进度条",
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
        // ===== 线形进度条 =====
        this.SectionTitle("线形进度条 - 基础用法");
        SpaceVerticalMedium();
        Column() {
          TnLineProgress({ percent: this.vm.linePercent1 });
          SpaceVerticalMedium();
          Text(`当前进度：${this.vm.linePercent1}%`)
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_secondary"));
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        this.SectionTitle("线形进度条 - 显示进度文字");
        SpaceVerticalMedium();
        Column() {
          TnLineProgress({ percent: this.vm.linePercent2, showPercent: true });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        this.SectionTitle("线形进度条 - 文字在内部");
        SpaceVerticalMedium();
        Column() {
          TnLineProgress({
            percent: this.vm.linePercent3,
            showPercent: true,
            textInside: true,
            barHeight: 20
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        this.SectionTitle("线形进度条 - 自定义颜色");
        SpaceVerticalMedium();
        Column() {
          TnLineProgress({
            percent: this.vm.linePercent4,
            activeColor: "success",
            showPercent: true
          });
          SpaceVerticalMedium();
          TnLineProgress({
            percent: this.vm.linePercent4,
            activeColor: "warning",
            showPercent: true
          });
          SpaceVerticalMedium();
          TnLineProgress({
            percent: this.vm.linePercent4,
            activeColor: "danger",
            showPercent: true
          });
          SpaceVerticalMedium();
          TnLineProgress({
            percent: this.vm.linePercent4,
            activeColor: "#01beff",
            inactiveColor: "rgba(1, 190, 255, 0.2)",
            showPercent: true
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        this.SectionTitle("线形进度条 - 自定义格式化文本");
        SpaceVerticalMedium();
        Column() {
          TnLineProgress({
            percent: this.vm.linePercent6,
            showPercent: true,
            format: (p: number): string => {
              if (p >= 100) {
                return "已完成";
              }
              return `${p}/100`;
            }
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        this.SectionTitle("线形进度条 - 不同高度");
        SpaceVerticalMedium();
        Column() {
          Text("barHeight = 4")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnLineProgress({ percent: 40, barHeight: 4 });
          SpaceVerticalMedium();

          Text("barHeight = 12（默认）")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnLineProgress({ percent: 60, barHeight: 12 });
          SpaceVerticalMedium();

          Text("barHeight = 24")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnLineProgress({ percent: 80, barHeight: 24 });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 动态控制线形进度条 =====
        this.SectionTitle("线形进度条 - 动态控制");
        SpaceVerticalMedium();
        Column() {
          TnLineProgress({
            percent: this.vm.dynamicPercent,
            showPercent: true,
            activeColor: "primary",
            barHeight: 16,
            onComplete: () => {}
          });
          SpaceVerticalMedium();
          Row({ space: 12 }) {
            TnButton({
              content: "- 10",
              btnSize: "sm",
              type: "danger",
              onBtnClick: () => {
                this.vm.decreaseDynamic(10);
              }
            });
            TnButton({
              content: "+ 10",
              btnSize: "sm",
              type: "primary",
              onBtnClick: () => {
                this.vm.increaseDynamic(10);
              }
            });
            TnButton({
              content: "重置",
              btnSize: "sm",
              type: "info",
              onBtnClick: () => {
                this.vm.dynamicPercent = 0;
              }
            });
          };
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 圆形进度条 =====
        this.SectionTitle("圆形进度条 - 基础用法");
        SpaceVerticalMedium();
        Column() {
          Row({ space: 20 }) {
            TnCircleProgress({ percent: this.vm.circlePercent1 });
            TnCircleProgress({ percent: this.vm.circlePercent1, showPercent: false });
          }
          .justifyContent(FlexAlign.Center);
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        this.SectionTitle("圆形进度条 - 自定义颜色");
        SpaceVerticalMedium();
        Column() {
          Row({ space: 20 }) {
            TnCircleProgress({
              percent: this.vm.circlePercent2,
              activeColor: "success"
            });
            TnCircleProgress({
              percent: this.vm.circlePercent2,
              activeColor: "warning"
            });
            TnCircleProgress({
              percent: this.vm.circlePercent2,
              activeColor: "danger"
            });
          }
          .justifyContent(FlexAlign.Center);
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        this.SectionTitle("圆形进度条 - 自定义尺寸");
        SpaceVerticalMedium();
        Column() {
          Row({ space: 20 }) {
            TnCircleProgress({
              percent: this.vm.circlePercent3,
              radius: 35,
              ringWidth: 4
            });
            TnCircleProgress({
              percent: this.vm.circlePercent3,
              radius: 50,
              ringWidth: 6
            });
            TnCircleProgress({
              percent: this.vm.circlePercent3,
              radius: 70,
              ringWidth: 10
            });
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center);
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        this.SectionTitle("圆形进度条 - 自定义格式化文本");
        SpaceVerticalMedium();
        Column() {
          Row({ space: 20 }) {
            TnCircleProgress({
              percent: this.vm.circlePercent3,
              format: (p: number): string => {
                if (p >= 100) {
                  return "满";
                }
                return `${p}`;
              }
            });
            TnCircleProgress({
              percent: 100,
              activeColor: "success",
              format: (_p: number): string => {
                return "完成";
              }
            });
          }
          .justifyContent(FlexAlign.Center);
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 动态控制圆形进度条 =====
        this.SectionTitle("圆形进度条 - 动态控制");
        SpaceVerticalMedium();
        Column() {
          Row() {
            TnCircleProgress({
              percent: this.vm.dynamicCirclePercent,
              radius: 60,
              ringWidth: 8,
              activeColor: "primary"
            });
          }
          .width(P100)
          .justifyContent(FlexAlign.Center);

          SpaceVerticalMedium();
          Row({ space: 12 }) {
            TnButton({
              content: "- 10",
              btnSize: "sm",
              type: "danger",
              onBtnClick: () => {
                this.vm.decreaseDynamicCircle(10);
              }
            });
            TnButton({
              content: "+ 10",
              btnSize: "sm",
              type: "primary",
              onBtnClick: () => {
                this.vm.increaseDynamicCircle(10);
              }
            });
            TnButton({
              content: "重置",
              btnSize: "sm",
              type: "info",
              onBtnClick: () => {
                this.vm.dynamicCirclePercent = 0;
              }
            });
          }
          .justifyContent(FlexAlign.Center);
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
