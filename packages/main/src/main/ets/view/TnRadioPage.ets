/**
 * @file TnRadio 单选框展示页面视图
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
import { TnRadio, TnRadioGroup, TnRadioValueType } from "@tuniao/tn-ui";
import TnRadioViewModel from "../viewmodel/TnRadioViewModel";

/**
 * TnRadio 单选框展示页面
 */
@ComponentV2
export struct TnRadioPage {
  /**
   * 单选框展示页面 ViewModel
   */
  @Local
  private vm: TnRadioViewModel = new TnRadioViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  /**
   * 构建单选框展示页面
   */
  build() {
    AppNavDestination({
      title: "单选框",
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

        // 3. 自定义大小
        this.SectionTitle("自定义大小");
        SpaceVerticalMedium();
        this.CustomSizeSection();

        SpaceVerticalLarge();

        // 4. 禁用状态
        this.SectionTitle("禁用状态");
        SpaceVerticalMedium();
        this.DisabledSection();

        SpaceVerticalLarge();

        // 5. 边框模式
        this.SectionTitle("边框模式");
        SpaceVerticalMedium();
        this.BorderSection();
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
        Text("通过 TnRadioGroup 管理一组 TnRadio，modelValue 绑定当前选中的值")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnRadioGroup({
          group: "basic",
          modelValue: this.vm.radioValue1,
          onChange: (value: TnRadioValueType) => {
            this.vm.setRadioValue1(value as string);
          }
        }) {
          Flex({
            wrap: FlexWrap.Wrap,
            space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) }
          }) {
            TnRadio({ group: "basic", label: "1" }) {
              Text("选项1");
            };
            TnRadio({ group: "basic", label: "2" }) {
              Text("选项2");
            };
            TnRadio({ group: "basic", label: "3" }) {
              Text("选项3");
            };
          }
          .width(P100);
        };

        SpaceVerticalMedium();

        Text(`当前选中: ${this.vm.radioValue1 || "未选择"}`)
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
        Text("使用 activeColor 设置单选框选中时的主题颜色，支持内置色值关键字")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnRadioGroup({
          group: "color",
          modelValue: this.vm.radioValue2,
          activeColor: "success",
          onChange: (value: TnRadioValueType) => {
            this.vm.setRadioValue2(value as string);
          }
        }) {
          Flex({
            wrap: FlexWrap.Wrap,
            space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) }
          }) {
            TnRadio({ group: "color", label: "apple" }) {
              Text("苹果");
            };
            TnRadio({ group: "color", label: "banana" }) {
              Text("香蕉");
            };
            TnRadio({ group: "color", label: "orange" }) {
              Text("橙子");
            };
          }
          .width(P100);
        };

        SpaceVerticalMedium();

        Text(`当前选中: ${this.vm.radioValue2 || "未选择"}`)
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
   * 3. 自定义大小展示区
   */
  @Builder
  private CustomSizeSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("通过 groupSize 或单个 radioSize 设置单选框的尺寸(vp)")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnRadioGroup({
          group: "size",
          modelValue: this.vm.radioValue3,
          onChange: (value: TnRadioValueType) => {
            this.vm.setRadioValue3(value as string);
          }
        }) {
          Flex({
            wrap: FlexWrap.Wrap,
            space: { main: LengthMetrics.vp(12), cross: LengthMetrics.vp(12) }
          }) {
            TnRadio({ group: "size", label: "small", radioSize: 14 }) {
              Text("小(14vp)");
            };
            TnRadio({ group: "size", label: "default", radioSize: 20 }) {
              Text("默认(20vp)");
            };
            TnRadio({ group: "size", label: "large", radioSize: 28 }) {
              Text("大(28vp)");
            };
            TnRadio({ group: "size", label: "xlarge", radioSize: 36 }) {
              Text("超大(36vp)");
            };
          }
          .width(P100);
        };

        SpaceVerticalMedium();

        Text(`当前选中: ${this.vm.radioValue3 || "未选择"}`)
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
   * 4. 禁用状态展示区
   */
  @Builder
  private DisabledSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("在 TnRadioGroup 上设置 disabled 可禁用整组单选框，禁用后无法选择")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnRadioGroup({
          group: "disabled",
          modelValue: "1",
          disabled: true
        }) {
          Flex({
            wrap: FlexWrap.Wrap,
            space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) }
          }) {
            TnRadio({ group: "disabled", label: "1" }) {
              Text("选项1（已选）");
            };
            TnRadio({ group: "disabled", label: "2" }) {
              Text("选项2（禁用）");
            };
            TnRadio({ group: "disabled", label: "3" }) {
              Text("选项3（禁用）");
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

  /**
   * 5. 边框模式展示区
   */
  @Builder
  private BorderSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("在 TnRadio 上设置 showBorder 显示带边框样式的单选框，选中时边框高亮")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnRadioGroup({
          group: "border",
          modelValue: this.vm.radioValue4,
          onChange: (value: TnRadioValueType) => {
            this.vm.setRadioValue4(value as string);
          }
        }) {
          Flex({
            wrap: FlexWrap.Wrap,
            space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) }
          }) {
            TnRadio({ group: "border", label: "1", showBorder: true }) {
              Text("边框选项1");
            };
            TnRadio({ group: "border", label: "2", showBorder: true }) {
              Text("边框选项2");
            };
            TnRadio({ group: "border", label: "3", showBorder: true }) {
              Text("边框选项3");
            };
          }
          .width(P100);
        };

        SpaceVerticalMedium();

        Text(`当前选中: ${this.vm.radioValue4 || "未选择"}`)
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
