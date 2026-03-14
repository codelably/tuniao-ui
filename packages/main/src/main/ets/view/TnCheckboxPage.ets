/**
 * @file TnCheckbox 复选框展示页面视图
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
import { TnCheckbox, TnCheckboxGroup, TnCheckboxShape, SPACE } from "@tuniao/tn-ui";
import TnCheckboxViewModel from "../viewmodel/TnCheckboxViewModel";

/**
 * TnCheckbox 复选框展示页面
 */
@ComponentV2
export struct TnCheckboxPage {
  /**
   * 复选框展示页面 ViewModel
   */
  @Local
  private vm: TnCheckboxViewModel = new TnCheckboxViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  /**
   * 构建复选框展示页面
   */
  build() {
    AppNavDestination({
      title: "复选框",
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

        // 2. 最大选择数
        this.SectionTitle("最大选择数");
        SpaceVerticalMedium();
        this.MaxSection();

        SpaceVerticalLarge();

        // 3. 自定义颜色
        this.SectionTitle("自定义颜色");
        SpaceVerticalMedium();
        this.CustomColorSection();

        SpaceVerticalLarge();

        // 4. 带边框
        this.SectionTitle("带边框");
        SpaceVerticalMedium();
        this.BorderSection();

        SpaceVerticalLarge();

        // 5. 自定义大小
        this.SectionTitle("自定义大小");
        SpaceVerticalMedium();
        this.CustomSizeSection();

        SpaceVerticalLarge();

        // 6. 自定义形状
        this.SectionTitle("自定义形状");
        SpaceVerticalMedium();
        this.CustomShapeSection();

        SpaceVerticalLarge();

        // 7. 禁用状态
        this.SectionTitle("禁用状态");
        SpaceVerticalMedium();
        this.DisabledSection();
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
        Text("通过 TnCheckboxGroup 管理一组 TnCheckbox，modelValue 绑定当前选中的值数组")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnCheckboxGroup({
          group: "basic",
          modelValue: this.vm.checkboxValues1,
          onChange: (values: Array<string | number>) => {
            this.vm.setCheckboxValues1(values);
          }
        }) {
          Flex({
            wrap: FlexWrap.Wrap,
            space: { main: LengthMetrics.vp(SPACE.XSM), cross: LengthMetrics.vp(SPACE.XSM) }
          }) {
            TnCheckbox({ group: "basic", label: "a" }) {
              Text("选项A");
            };
            TnCheckbox({ group: "basic", label: "b" }) {
              Text("选项B");
            };
            TnCheckbox({ group: "basic", label: "c" }) {
              Text("选项C");
            };
            TnCheckbox({ group: "basic", label: "d" }) {
              Text("选项D");
            };
          }
          .width(P100);
        };

        SpaceVerticalMedium();

        Text(`已选中: ${this.vm.checkboxValues1.length > 0 ? this.vm.checkboxValues1.join(", ") : "未选择"}`)
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
   * 2. 最大选择数展示区
   */
  @Builder
  private MaxSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 max 限制最多可以选中的数量，超出限制后其余选项不可选")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnCheckboxGroup({
          group: "maxLimit",
          modelValue: this.vm.checkboxValues2,
          max: 2,
          onChange: (values: Array<string | number>) => {
            this.vm.setCheckboxValues2(values);
          }
        }) {
          Flex({
            wrap: FlexWrap.Wrap,
            space: { main: LengthMetrics.vp(SPACE.XSM), cross: LengthMetrics.vp(SPACE.XSM) }
          }) {
            TnCheckbox({ group: "maxLimit", label: "football" }) {
              Text("足球");
            };
            TnCheckbox({ group: "maxLimit", label: "basketball" }) {
              Text("篮球");
            };
            TnCheckbox({ group: "maxLimit", label: "volleyball" }) {
              Text("排球");
            };
            TnCheckbox({ group: "maxLimit", label: "pingpong" }) {
              Text("乒乓球");
            };
          }
          .width(P100);
        };

        SpaceVerticalMedium();

        Text(`已选中（最多2项）: ${this.vm.checkboxValues2.length > 0 ? this.vm.checkboxValues2.join(", ") : "未选择"}`)
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
   * 3. 自定义颜色展示区
   */
  @Builder
  private CustomColorSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 activeColor 设置复选框选中时的颜色，支持内置色值关键字如 danger")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnCheckboxGroup({
          group: "customColor",
          modelValue: this.vm.checkboxValues3,
          activeColor: "danger",
          onChange: (values: Array<string | number>) => {
            this.vm.setCheckboxValues3(values);
          }
        }) {
          Flex({
            wrap: FlexWrap.Wrap,
            space: { main: LengthMetrics.vp(SPACE.XSM), cross: LengthMetrics.vp(SPACE.XSM) }
          }) {
            TnCheckbox({ group: "customColor", label: "a" }) {
              Text("选项A");
            };
            TnCheckbox({ group: "customColor", label: "b" }) {
              Text("选项B");
            };
            TnCheckbox({ group: "customColor", label: "c" }) {
              Text("选项C");
            };
            TnCheckbox({ group: "customColor", label: "d" }) {
              Text("选项D");
            };
          }
          .width(P100);
        };

        SpaceVerticalMedium();

        Text(`已选中: ${this.vm.checkboxValues3.length > 0 ? this.vm.checkboxValues3.join(", ") : "未选择"}`)
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
   * 4. 带边框展示区
   */
  @Builder
  private BorderSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 showBorder 显示复选框外边框，选中时边框颜色随激活色变化")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnCheckboxGroup({
          group: "border",
          modelValue: this.vm.checkboxValues4,
          onChange: (values: Array<string | number>) => {
            this.vm.setCheckboxValues4(values);
          }
        }) {
          Flex({
            wrap: FlexWrap.Wrap,
            space: { main: LengthMetrics.vp(SPACE.XSM), cross: LengthMetrics.vp(SPACE.XSM) }
          }) {
            TnCheckbox({ group: "border", label: "a", showBorder: true }) {
              Text("选项A");
            };
            TnCheckbox({ group: "border", label: "b", showBorder: true }) {
              Text("选项B");
            };
            TnCheckbox({ group: "border", label: "c", showBorder: true }) {
              Text("选项C");
            };
            TnCheckbox({ group: "border", label: "d", showBorder: true }) {
              Text("选项D");
            };
          }
          .width(P100);
        };

        SpaceVerticalMedium();

        Text(`已选中: ${this.vm.checkboxValues4.length > 0 ? this.vm.checkboxValues4.join(", ") : "未选择"}`)
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
   * 5. 自定义大小展示区
   */
  @Builder
  private CustomSizeSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("通过 checkboxSize 自定义复选框图标大小，或通过 groupSize 统一设置组内所有复选框大小")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnCheckboxGroup({
          group: "customSize",
          modelValue: this.vm.checkboxValues5,
          onChange: (values: Array<string | number>) => {
            this.vm.setCheckboxValues5(values);
          }
        }) {
          Flex({
            wrap: FlexWrap.Wrap,
            space: { main: LengthMetrics.vp(SPACE.MD), cross: LengthMetrics.vp(SPACE.MD) }
          }) {
            TnCheckbox({ group: "customSize", label: "small", checkboxSize: 16 }) {
              Text("小号 16");
            };
            TnCheckbox({ group: "customSize", label: "default", checkboxSize: 20 }) {
              Text("默认 20");
            };
            TnCheckbox({ group: "customSize", label: "large", checkboxSize: 28 }) {
              Text("大号 28");
            };
            TnCheckbox({ group: "customSize", label: "xlarge", checkboxSize: 36 }) {
              Text("超大 36");
            };
          }
          .width(P100);
        };

        SpaceVerticalMedium();

        Text(`已选中: ${this.vm.checkboxValues5.length > 0 ? this.vm.checkboxValues5.join(", ") : "未选择"}`)
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
   * 6. 自定义形状展示区
   */
  @Builder
  private CustomShapeSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("通过 shape 设置选中图标形状，支持方形打勾(square)和圆形圆点(circle)两种形状")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnCheckboxGroup({
          group: "shape",
          modelValue: this.vm.checkboxValues6,
          onChange: (values: Array<string | number>) => {
            this.vm.setCheckboxValues6(values);
          }
        }) {
          Flex({
            wrap: FlexWrap.Wrap,
            space: { main: LengthMetrics.vp(SPACE.XSM), cross: LengthMetrics.vp(SPACE.MLG) }
          }) {
            TnCheckbox({ group: "shape", label: "a", shape: TnCheckboxShape.SQUARE }) {
              Text("方形打勾");
            };
            TnCheckbox({ group: "shape", label: "b", shape: TnCheckboxShape.SQUARE }) {
              Text("方形打勾");
            };
            TnCheckbox({ group: "shape", label: "c", shape: TnCheckboxShape.CIRCLE }) {
              Text("圆形圆点");
            };
            TnCheckbox({ group: "shape", label: "d", shape: TnCheckboxShape.CIRCLE }) {
              Text("圆形圆点");
            };
          }
          .width(P100);
        };

        SpaceVerticalMedium();

        Text(`已选中: ${this.vm.checkboxValues6.length > 0 ? this.vm.checkboxValues6.join(", ") : "未选择"}`)
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
   * 7. 禁用状态展示区
   */
  @Builder
  private DisabledSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("在 TnCheckboxGroup 上设置 disabled 可禁用整组复选框，禁用后无法勾选或取消")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnCheckboxGroup({
          group: "disabled",
          modelValue: ["a", "c"],
          disabled: true
        }) {
          Flex({
            wrap: FlexWrap.Wrap,
            space: { main: LengthMetrics.vp(SPACE.XSM), cross: LengthMetrics.vp(SPACE.XSM) }
          }) {
            TnCheckbox({ group: "disabled", label: "a" }) {
              Text("选项A（已选）");
            };
            TnCheckbox({ group: "disabled", label: "b" }) {
              Text("选项B（未选）");
            };
            TnCheckbox({ group: "disabled", label: "c" }) {
              Text("选项C（已选）");
            };
            TnCheckbox({ group: "disabled", label: "d" }) {
              Text("选项D（未选）");
            };
          }
          .width(P100);
        };
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }
}
