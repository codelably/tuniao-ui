/**
 * @file TnRate 评分展示页面视图
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
import { LengthMetrics } from "@kit.ArkUI";
import { TnRate } from "@tuniao/tn-ui";
import TnRateViewModel from "../viewmodel/TnRateViewModel";

/**
 * TnRate 评分展示页面
 */
@ComponentV2
export struct TnRatePage {
  /**
   * 评分展示页面 ViewModel
   */
  @Local
  private vm: TnRateViewModel = new TnRateViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  /**
   * 构建评分展示页面
   */
  build() {
    AppNavDestination({
      title: "评分",
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

        // 2. 半星
        this.SectionTitle("半星");
        SpaceVerticalMedium();
        this.HalfStarSection();

        SpaceVerticalLarge();

        // 3. 自定义图标
        this.SectionTitle("自定义图标");
        SpaceVerticalMedium();
        this.CustomIconSection();

        SpaceVerticalLarge();

        // 4. 自定义颜色
        this.SectionTitle("自定义颜色");
        SpaceVerticalMedium();
        this.CustomColorSection();

        SpaceVerticalLarge();

        // 5. 只读
        this.SectionTitle("只读");
        SpaceVerticalMedium();
        this.ReadonlySection();

        SpaceVerticalLarge();

        // 6. 自定义数量
        this.SectionTitle("自定义数量");
        SpaceVerticalMedium();
        this.CustomCountSection();
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
        Text("通过 modelValue 绑定当前评分值，onChange 监听评分变化，默认满分 5 分")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnRate({
          modelValue: this.vm.rateValue1,
          onChange: (value: number) => {
            this.vm.setRateValue1(value);
          }
        });

        SpaceVerticalMedium();

        Text(`当前评分: ${this.vm.rateValue1} 分`)
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
   * 2. 半星展示区
   */
  @Builder
  private HalfStarSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 allowHalf 开启半星评分，评分精度提升到 0.5")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnRate({
          modelValue: this.vm.rateValue2,
          allowHalf: true,
          onChange: (value: number) => {
            this.vm.setRateValue2(value);
          }
        });

        SpaceVerticalMedium();

        Text(`当前评分: ${this.vm.rateValue2} 分`)
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
   * 3. 自定义图标展示区
   */
  @Builder
  private CustomIconSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 activeIcon 和 inactiveIcon 替换默认的星形图标为自定义图标")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnRate({
          modelValue: this.vm.rateValue1,
          activeIcon: "like-fill",
          inactiveIcon: "like",
          onChange: (value: number) => {
            this.vm.setRateValue1(value);
          }
        });

        SpaceVerticalMedium();

        Text(`当前评分: ${this.vm.rateValue1} 分`)
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
        Text("使用 activeColor 设置评分激活时的颜色，支持内置色值关键字如 danger")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          direction: FlexDirection.Column,
          space: { main: LengthMetrics.vp(12), cross: LengthMetrics.vp(8) }
        }) {
          Row() {
            Text("danger: ")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_secondary"))
              .width(80);
            TnRate({
              modelValue: this.vm.rateValue1,
              activeColor: "danger",
              onChange: (value: number) => {
                this.vm.setRateValue1(value);
              }
            });
          }
          .width(P100)
          .alignItems(VerticalAlign.Center);

          Row() {
            Text("success: ")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_secondary"))
              .width(80);
            TnRate({
              modelValue: this.vm.rateValue1,
              activeColor: "success",
              onChange: (value: number) => {
                this.vm.setRateValue1(value);
              }
            });
          }
          .width(P100)
          .alignItems(VerticalAlign.Center);

          Row() {
            Text("#ff6700: ")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_secondary"))
              .width(80);
            TnRate({
              modelValue: this.vm.rateValue1,
              activeColor: "#ff6700",
              onChange: (value: number) => {
                this.vm.setRateValue1(value);
              }
            });
          }
          .width(P100)
          .alignItems(VerticalAlign.Center);
        }
        .width(P100);
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 5. 只读展示区
   */
  @Builder
  private ReadonlySection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 readonly 为只读模式，仅展示评分结果，不可交互")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(12), cross: LengthMetrics.vp(8) }
        }) {
          TnRate({
            modelValue: 4,
            readonly: true
          });
          Text("（只读 4 分）")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_secondary"));
        }
        .width(P100);

        SpaceVerticalMedium();

        Flex({
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(12), cross: LengthMetrics.vp(8) }
        }) {
          TnRate({
            modelValue: 3.5,
            allowHalf: true,
            readonly: true
          });
          Text("（只读半星 3.5 分）")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_secondary"));
        }
        .width(P100);
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 6. 自定义数量展示区
   */
  @Builder
  private CustomCountSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 max 设置评分图标的总数量，默认为 5，可自定义为其他数值如 10")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnRate({
          modelValue: this.vm.rateValue1,
          max: 10,
          onChange: (value: number) => {
            this.vm.setRateValue1(value);
          }
        });

        SpaceVerticalMedium();

        Text(`当前评分: ${this.vm.rateValue1} / 10 分`)
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
