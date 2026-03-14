/**
 * @file TnLoading 加载展示页面视图
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
import { TnLoading, TnButton } from "@tuniao/tn-ui";
import TnLoadingViewModel from "../viewmodel/TnLoadingViewModel";

/**
 * TnLoading 加载展示页面
 */
@ComponentV2
export struct TnLoadingPage {
  /**
   * 加载展示页面 ViewModel
   */
  @Local
  private vm: TnLoadingViewModel = new TnLoadingViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  /**
   * 构建加载展示页面
   */
  build() {
    AppNavDestination({
      title: "加载",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.LoadingContent();
    }
  }

  /**
   * 加载内容视图
   */
  @Builder
  private LoadingContent() {
    MediumPaddingVerticalScroll() {
      ColumnBase({ widthValue: P100 }) {
        // 1. 基础用法
        this.SectionTitle("基础用法");
        SpaceVerticalMedium();
        this.BasicSection();

        SpaceVerticalLarge();

        // 2. 动画模式
        this.SectionTitle("动画模式");
        SpaceVerticalMedium();
        this.ModeSection();

        SpaceVerticalLarge();

        // 3. 颜色类型
        this.SectionTitle("颜色类型");
        SpaceVerticalMedium();
        this.ColorTypeSection();

        SpaceVerticalLarge();

        // 4. 自定义颜色
        this.SectionTitle("自定义颜色");
        SpaceVerticalMedium();
        this.CustomColorSection();

        SpaceVerticalLarge();

        // 5. 尺寸
        this.SectionTitle("尺寸");
        SpaceVerticalMedium();
        this.SizeSection();

        SpaceVerticalLarge();

        // 6. 自定义尺寸
        this.SectionTitle("自定义尺寸");
        SpaceVerticalMedium();
        this.CustomSizeSection();

        SpaceVerticalLarge();

        // 7. 动画速度
        this.SectionTitle("动画速度");
        SpaceVerticalMedium();
        this.DurationSection();

        SpaceVerticalLarge();

        // 8. 缓动函数
        this.SectionTitle("缓动函数");
        SpaceVerticalMedium();
        this.TimingCurveSection();

        SpaceVerticalLarge();

        // 9. 带文字
        this.SectionTitle("带文字");
        SpaceVerticalMedium();
        this.TextSection();

        SpaceVerticalLarge();

        // 10. 自定义文字样式
        this.SectionTitle("自定义文字样式");
        SpaceVerticalMedium();
        this.CustomTextSection();

        SpaceVerticalLarge();

        // 11. 动态显示/隐藏
        this.SectionTitle("动态显示/隐藏");
        SpaceVerticalMedium();
        this.DynamicSection();
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
        Text("显示加载动画")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          wrap: FlexWrap.Wrap,
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(30), cross: LengthMetrics.vp(12) }
        }) {
          TnLoading();
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
   * 2. 动画模式展示区
   */
  @Builder
  private ModeSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 mode 切换加载动画模式：circle（圆圈）、flower（花瓣）、semicircle（半圆）")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          wrap: FlexWrap.Wrap,
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(40), cross: LengthMetrics.vp(16) }
        }) {
          Column({ space: 8 }) {
            TnLoading({ mode: "circle" });
            Text("circle")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);

          Column({ space: 8 }) {
            TnLoading({ mode: "flower" });
            Text("flower")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);

          Column({ space: 8 }) {
            TnLoading({ mode: "semicircle" });
            Text("semicircle")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);
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
   * 3. 颜色类型展示区
   */
  @Builder
  private ColorTypeSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 type 设置加载动画的颜色类型")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          wrap: FlexWrap.Wrap,
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(30), cross: LengthMetrics.vp(16) }
        }) {
          Column({ space: 6 }) {
            TnLoading({ type: "primary" });
            Text("primary")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);

          Column({ space: 6 }) {
            TnLoading({ type: "success" });
            Text("success")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);

          Column({ space: 6 }) {
            TnLoading({ type: "warning" });
            Text("warning")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);

          Column({ space: 6 }) {
            TnLoading({ type: "danger" });
            Text("danger")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);

          Column({ space: 6 }) {
            TnLoading({ type: "info" });
            Text("info")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);
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
   * 4. 自定义颜色展示区
   */
  @Builder
  private CustomColorSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 color 自定义加载动画颜色，优先级高于 type")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          wrap: FlexWrap.Wrap,
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(30), cross: LengthMetrics.vp(16) }
        }) {
          TnLoading({ color: "#7232dd" });
          TnLoading({ color: "#1989fa", mode: "flower" });
          TnLoading({ color: $r("app.color.tn_color_orange"), mode: "semicircle" });
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
   * 5. 尺寸展示区
   */
  @Builder
  private SizeSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 loadingSize 设置加载图标的预设尺寸")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          wrap: FlexWrap.Wrap,
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(30), cross: LengthMetrics.vp(16) }
        }) {
          Column({ space: 6 }) {
            TnLoading({ loadingSize: "sm" });
            Text("sm")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);

          Column({ space: 6 }) {
            TnLoading();
            Text("default")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);

          Column({ space: 6 }) {
            TnLoading({ loadingSize: "lg" });
            Text("lg")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);

          Column({ space: 6 }) {
            TnLoading({ loadingSize: "xl" });
            Text("xl")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);
        }
        .width(P100);

        SpaceVerticalMedium();

        Text("花瓣模式尺寸对比")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          wrap: FlexWrap.Wrap,
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(30), cross: LengthMetrics.vp(16) }
        }) {
          TnLoading({ mode: "flower", loadingSize: "sm" });
          TnLoading({ mode: "flower" });
          TnLoading({ mode: "flower", loadingSize: "lg" });
          TnLoading({ mode: "flower", loadingSize: "xl" });
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
   * 6. 自定义尺寸展示区
   */
  @Builder
  private CustomSizeSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 customSize 传入数值自定义尺寸（vp）")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          wrap: FlexWrap.Wrap,
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(30), cross: LengthMetrics.vp(16) }
        }) {
          Column({ space: 6 }) {
            TnLoading({ customSize: 16 });
            Text("16vp")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);

          Column({ space: 6 }) {
            TnLoading({ customSize: 40 });
            Text("40vp")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);

          Column({ space: 6 }) {
            TnLoading({ customSize: 60, mode: "semicircle" });
            Text("60vp")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);
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
   * 7. 动画速度展示区
   */
  @Builder
  private DurationSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 duration 设置动画时长（毫秒），数值越小旋转越快")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          wrap: FlexWrap.Wrap,
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(30), cross: LengthMetrics.vp(16) }
        }) {
          Column({ space: 6 }) {
            TnLoading({ duration: 500 });
            Text("500ms")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);

          Column({ space: 6 }) {
            TnLoading({ duration: 1000 });
            Text("1000ms")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);

          Column({ space: 6 }) {
            TnLoading({ duration: 2000 });
            Text("2000ms")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);

          Column({ space: 6 }) {
            TnLoading({ duration: 500, mode: "flower" });
            Text("flower 500ms")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);
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
   * 8. 缓动函数展示区
   */
  @Builder
  private TimingCurveSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 timingCurve 设置动画缓动函数（仅对 circle 和 semicircle 有效）")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          wrap: FlexWrap.Wrap,
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(30), cross: LengthMetrics.vp(16) }
        }) {
          Column({ space: 6 }) {
            TnLoading({ timingCurve: Curve.Linear });
            Text("Linear")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);

          Column({ space: 6 }) {
            TnLoading({ timingCurve: Curve.EaseInOut });
            Text("EaseInOut")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);

          Column({ space: 6 }) {
            TnLoading({ timingCurve: Curve.EaseInOut, mode: "semicircle" });
            Text("EaseInOut")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);
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
   * 9. 带文字展示区
   */
  @Builder
  private TextSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 text 设置加载提示文字")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          wrap: FlexWrap.Wrap,
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(40), cross: LengthMetrics.vp(16) }
        }) {
          TnLoading({ text: "加载中..." });
          TnLoading({ text: "请稍候", mode: "flower" });
          TnLoading({ text: "Loading", mode: "semicircle" });
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
   * 10. 自定义文字样式展示区
   */
  @Builder
  private CustomTextSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 textColor 和 textSize 自定义文字样式")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          wrap: FlexWrap.Wrap,
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(40), cross: LengthMetrics.vp(16) }
        }) {
          TnLoading({
            text: "加载中",
            textColor: "#7232dd",
            color: "#7232dd"
          });
          TnLoading({
            text: "自定义字号",
            textSize: 16,
            type: "danger"
          });
          TnLoading({
            text: "大图标",
            loadingSize: "xl",
            textColor: $r("app.color.tn_color_orange"),
            color: $r("app.color.tn_color_orange"),
            mode: "flower"
          });
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
   * 11. 动态显示/隐藏展示区
   */
  @Builder
  private DynamicSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("动态切换 show 控制加载动画的显示与隐藏")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Row({ space: 20 }) {
          TnLoading({
            show: this.vm.showLoading,
            text: "加载中..."
          });
          TnLoading({
            show: this.vm.showLoading,
            mode: "flower",
            type: "success"
          });
          TnLoading({
            show: this.vm.showLoading,
            mode: "semicircle",
            type: "warning"
          });
        }
        .alignItems(VerticalAlign.Center);

        SpaceVerticalMedium();

        TnButton({
          content: this.vm.showLoading ? "隐藏加载" : "显示加载",
          type: this.vm.showLoading ? "danger" : "primary",
          btnSize: "sm",
          onBtnClick: () => {
            this.vm.toggleLoading();
          }
        });
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }
}
