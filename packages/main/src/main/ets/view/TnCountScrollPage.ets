/**
 * @file TnCountScroll 数字滚动展示页面视图
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
import { TnCountScroll, TnButton } from "@tuniao/tn-ui";
import TnCountScrollViewModel from "../viewmodel/TnCountScrollViewModel";

@ComponentV2
export struct TnCountScrollPage {
  @Local private vm: TnCountScrollViewModel = new TnCountScrollViewModel();
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  build() {
    AppNavDestination({
      title: "数字滚动",
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
          Text("整数值：7865")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountScroll({ value: this.vm.basicValue });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 带小数 =====
        this.SectionTitle("带小数");
        SpaceVerticalMedium();
        Column() {
          Text("小数值：7865.23")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountScroll({ value: this.vm.decimalValue });
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
          Text("带千分位：123,542,7645.23")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountScroll({ value: this.vm.thousandsValue });
          SpaceVerticalMedium();

          Text("不使用千分位：9876543")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountScroll({
            value: this.vm.noThousandsValue,
            thousandsSeparator: ''
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 自定义分隔符 =====
        this.SectionTitle("自定义分隔符");
        SpaceVerticalMedium();
        Column() {
          Text("小数分隔符 '*'，千分位分隔符 '-'")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountScroll({
            value: "12-345-678*99",
            decimalSeparator: '*',
            thousandsSeparator: '-'
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
          Text("慢速动画 duration = 3000ms")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountScroll({ value: this.vm.slowValue, duration: 3000 });
          SpaceVerticalMedium();

          Text("快速动画 duration = 500ms")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountScroll({ value: this.vm.fastValue, duration: 500 });
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
          TnCountScroll({ value: "7865", textColor: "primary" });
          SpaceVerticalMedium();

          Text("主题色 - danger")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountScroll({ value: "7865", textColor: "danger" });
          SpaceVerticalMedium();

          Text("主题色 - success")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountScroll({ value: "7865", textColor: "success" });
          SpaceVerticalMedium();

          Text("自定义 hex 色值")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountScroll({ value: "7865", textColor: "#01beff" });
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
          TnCountScroll({ value: "7865", fontSize: 12 });
          SpaceVerticalMedium();

          Text("fontSize = 20")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountScroll({ value: "7865", fontSize: 20 });
          SpaceVerticalMedium();

          Text("fontSize = 30, fontWeight = Bold")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountScroll({
            value: "7865",
            fontSize: 30,
            fontWeight: FontWeight.Bold
          });
          SpaceVerticalMedium();

          Text("fontSize = 30, fontWeight = Bold, 主题色")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountScroll({
            value: "7865",
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

        // ===== 动态值变化 =====
        this.SectionTitle("动态值变化");
        SpaceVerticalMedium();
        Column() {
          Text(this.vm.dynamicStatusText)
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountScroll({
            value: this.vm.dynamicValue,
            textColor: "primary",
            fontSize: 30,
            fontWeight: FontWeight.Bold,
            thousandsSeparator: ''
          });
          SpaceVerticalMedium();
          Row({ space: 12 }) {
            TnButton({
              content: "随机值",
              btnSize: "sm",
              type: "primary",
              onBtnClick: () => {
                this.vm.randomUpdateValue();
              }
            });
            TnButton({
              content: "增加",
              btnSize: "sm",
              type: "success",
              onBtnClick: () => {
                this.vm.increaseValue();
              }
            });
            TnButton({
              content: "重置",
              btnSize: "sm",
              type: "info",
              onBtnClick: () => {
                this.vm.resetValue();
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
