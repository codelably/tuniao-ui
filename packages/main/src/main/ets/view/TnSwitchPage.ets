/**
 * @file TnSwitch 开关展示页面视图
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
import { TnSwitch, TnSwitchValueType } from "@tuniao/tn-ui";
import TnSwitchViewModel from "../viewmodel/TnSwitchViewModel";

/**
 * TnSwitch 开关展示页面
 */
@ComponentV2
export struct TnSwitchPage {
  /**
   * 开关展示页面 ViewModel
   */
  @Local
  private vm: TnSwitchViewModel = new TnSwitchViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  /**
   * 构建开关展示页面
   */
  build() {
    AppNavDestination({
      title: "开关",
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

        SpaceVerticalLarge();

        // 3. 自定义文字
        this.SectionTitle("自定义文字");
        SpaceVerticalMedium();
        this.CustomTextSection();

        SpaceVerticalLarge();

        // 4. 自定义图标
        this.SectionTitle("自定义图标");
        SpaceVerticalMedium();
        this.CustomIconSection();

        SpaceVerticalLarge();

        // 5. 形状
        this.SectionTitle("形状");
        SpaceVerticalMedium();
        this.ShapeSection();

        SpaceVerticalLarge();

        // 6. 加载状态
        this.SectionTitle("加载状态");
        SpaceVerticalMedium();
        this.LoadingSection();

        SpaceVerticalLarge();

        // 7. 禁用状态
        this.SectionTitle("禁用状态");
        SpaceVerticalMedium();
        this.DisabledSection();

        SpaceVerticalLarge();

        // 8. 自定义值
        this.SectionTitle("自定义值");
        SpaceVerticalMedium();
        this.CustomValueSection();
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
        Text("通过 modelValue 绑定开关状态，onChange 监听状态变化")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(12), cross: LengthMetrics.vp(8) }
        }) {
          TnSwitch({
            modelValue: this.vm.switchBasic,
            onChange: (value: TnSwitchValueType) => {
              this.vm.toggleBasic(value as boolean);
            }
          });
          Text(`当前值: ${this.vm.switchBasic}`)
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
   * 2. 自定义颜色展示区
   */
  @Builder
  private CustomColorSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 activeColor 设置激活状态的颜色，支持主题色关键字或十六进制色值")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          wrap: FlexWrap.Wrap,
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(16), cross: LengthMetrics.vp(12) }
        }) {
          Column() {
            TnSwitch({
              modelValue: this.vm.switchColorPrimary,
              activeColor: "primary",
              onChange: (value: TnSwitchValueType) => {
                this.vm.toggleColorPrimary(value as boolean);
              }
            });
            SpaceVerticalMedium();
            Text("主题色 primary")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_secondary"));
          };

          Column() {
            TnSwitch({
              modelValue: this.vm.switchColorHex,
              activeColor: "#ff6700",
              onChange: (value: TnSwitchValueType) => {
                this.vm.toggleColorHex(value as boolean);
              }
            });
            SpaceVerticalMedium();
            Text("#ff6700")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_secondary"));
          };

          Column() {
            TnSwitch({
              modelValue: this.vm.switchColorSuccess,
              activeColor: "success",
              onChange: (value: TnSwitchValueType) => {
                this.vm.toggleColorSuccess(value as boolean);
              }
            });
            SpaceVerticalMedium();
            Text("成功色 success")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_secondary"));
          };
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
   * 3. 自定义文字展示区
   */
  @Builder
  private CustomTextSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 activeText 和 inactiveText 设置开关两侧显示的文字")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnSwitch({
          modelValue: this.vm.switchText,
          activeText: "开",
          inactiveText: "关",
          onChange: (value: TnSwitchValueType) => {
            this.vm.toggleText(value as boolean);
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
   * 4. 自定义图标展示区
   */
  @Builder
  private CustomIconSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 activeIcon 和 inactiveIcon 设置开关按钮内部的图标")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnSwitch({
          modelValue: this.vm.switchIcon,
          activeIcon: "check",
          inactiveIcon: "close",
          onChange: (value: TnSwitchValueType) => {
            this.vm.toggleIcon(value as boolean);
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
   * 5. 形状展示区
   */
  @Builder
  private ShapeSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 shape 设置开关形状，支持圆角（round，默认）和方形（square）")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(24), cross: LengthMetrics.vp(8) }
        }) {
          Column() {
            TnSwitch({
              modelValue: this.vm.switchRound,
              shape: "round",
              onChange: (value: TnSwitchValueType) => {
                this.vm.toggleRound(value as boolean);
              }
            });
            SpaceVerticalMedium();
            Text("圆角 round")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_secondary"));
          };

          Column() {
            TnSwitch({
              modelValue: this.vm.switchSquare,
              shape: "square",
              onChange: (value: TnSwitchValueType) => {
                this.vm.toggleSquare(value as boolean);
              }
            });
            SpaceVerticalMedium();
            Text("方形 square")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_secondary"));
          };
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
   * 6. 加载状态展示区（点击后加载10秒再完成切换）
   */
  @Builder
  private LoadingSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("点击开关后进入加载状态，10秒后完成切换")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(16), cross: LengthMetrics.vp(8) }
        }) {
          TnSwitch({
            modelValue: this.vm.switchLoading,
            loading: this.vm.isLoading,
            onChange: (value: TnSwitchValueType) => {
              this.vm.toggleWithLoading(value as boolean);
            }
          });
          Text(this.vm.isLoading ? "加载中..." : `当前值: ${this.vm.switchLoading}`)
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
   * 7. 禁用状态展示区
   */
  @Builder
  private DisabledSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 disabled 禁用开关，禁用后无法通过点击改变状态")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(24), cross: LengthMetrics.vp(8) }
        }) {
          Column() {
            TnSwitch({
              modelValue: false,
              disabled: true
            });
            SpaceVerticalMedium();
            Text("关闭禁用")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_secondary"));
          };

          Column() {
            TnSwitch({
              modelValue: true,
              disabled: true
            });
            SpaceVerticalMedium();
            Text("开启禁用")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_secondary"));
          };
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
   * 8. 自定义值展示区
   */
  @Builder
  private CustomValueSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 activeValue 和 inactiveValue 自定义开关对应的值，支持字符串类型")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(12), cross: LengthMetrics.vp(8) }
        }) {
          TnSwitch({
            modelValue: this.vm.switchCustomValue,
            activeValue: "open",
            inactiveValue: "close",
            onChange: (value: TnSwitchValueType) => {
              this.vm.toggleCustomValue(value as string);
            }
          });
          Text(`当前值: ${this.vm.switchCustomValue}`)
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
}
