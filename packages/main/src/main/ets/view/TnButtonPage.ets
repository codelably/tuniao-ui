/**
 * @file TnButton 按钮展示页面视图
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
import { TnButton } from "@tuniao/tn-ui";
import TnButtonViewModel from "../viewmodel/TnButtonViewModel";

/**
 * TnButton 按钮展示页面
 */
@ComponentV2
export struct TnButtonPage {
  /**
   * 按钮展示页面 ViewModel
   */
  @Local
  private vm: TnButtonViewModel = new TnButtonViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  /**
   * 构建按钮展示页面
   */
  build() {
    AppNavDestination({
      title: "按钮",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.ButtonContent();
    }
  }

  /**
   * 按钮内容视图
   */
  @Builder
  private ButtonContent() {
    MediumPaddingVerticalScroll() {
      ColumnBase({ widthValue: P100 }) {
        // 1. 基础类型
        this.SectionTitle("基础类型");
        SpaceVerticalMedium();
        this.BasicTypeSection();

        SpaceVerticalLarge();

        // 2. 朴素按钮
        this.SectionTitle("朴素按钮");
        SpaceVerticalMedium();
        this.PlainSection();

        SpaceVerticalLarge();

        // 3. 文本按钮
        this.SectionTitle("文本按钮");
        SpaceVerticalMedium();
        this.TextModeSection();

        SpaceVerticalLarge();

        // 4. 按钮形状
        this.SectionTitle("按钮形状");
        SpaceVerticalMedium();
        this.ShapeSection();

        SpaceVerticalLarge();

        // 5. 按钮尺寸
        this.SectionTitle("按钮尺寸");
        SpaceVerticalMedium();
        this.SizeSection();

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

        // 8. 图标按钮
        this.SectionTitle("图标按钮");
        SpaceVerticalMedium();
        this.IconSection();

        SpaceVerticalLarge();

        // 9. 自定义颜色
        this.SectionTitle("自定义颜色");
        SpaceVerticalMedium();
        this.CustomColorSection();

        SpaceVerticalLarge();

        // 10. 阴影效果
        this.SectionTitle("阴影效果");
        SpaceVerticalMedium();
        this.ShadowSection();

        SpaceVerticalLarge();

        // 11. 点击事件
        this.SectionTitle("点击事件");
        SpaceVerticalMedium();
        this.ClickEventSection();
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
   * 1. 基础类型展示区
   */
  @Builder
  private BasicTypeSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 type 设置按钮颜色类型")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) } }) {
          TnButton({ content: "Primary", type: "primary" });
          TnButton({ content: "Success", type: "success" });
          TnButton({ content: "Warning", type: "warning" });
          TnButton({ content: "Danger", type: "danger" });
          TnButton({ content: "Info", type: "info" });
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
   * 2. 朴素按钮展示区
   */
  @Builder
  private PlainSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 plain 显示朴素按钮（边框 + 浅色背景）")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) } }) {
          TnButton({ content: "Primary", type: "primary", plain: true });
          TnButton({ content: "Success", type: "success", plain: true });
          TnButton({ content: "Warning", type: "warning", plain: true });
          TnButton({ content: "Danger", type: "danger", plain: true });
          TnButton({ content: "Info", type: "info", plain: true });
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
   * 3. 文本按钮展示区
   */
  @Builder
  private TextModeSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 textMode 显示文本按钮（透明背景）")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) } }) {
          TnButton({ content: "Primary", type: "primary", textMode: true });
          TnButton({ content: "Success", type: "success", textMode: true });
          TnButton({ content: "Warning", type: "warning", textMode: true });
          TnButton({ content: "Danger", type: "danger", textMode: true });
          TnButton({ content: "Info", type: "info", textMode: true });
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
   * 4. 按钮形状展示区
   */
  @Builder
  private ShapeSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 shape 设置按钮形状")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) } }) {
          TnButton({ content: "默认", type: "primary" });
          TnButton({ content: "胶囊形", type: "success", shape: "round" });
          TnButton({ content: "圆", type: "warning", shape: "circle" });
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
   * 5. 按钮尺寸展示区
   */
  @Builder
  private SizeSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 btnSize 设置按钮尺寸")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          wrap: FlexWrap.Wrap,
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) }
        }) {
          TnButton({ content: "小 sm", type: "primary", btnSize: "sm" });
          TnButton({ content: "默认", type: "primary" });
          TnButton({ content: "大 lg", type: "primary", btnSize: "lg" });
          TnButton({ content: "超大 xl", type: "primary", btnSize: "xl" });
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
   * 6. 加载状态展示区
   */
  @Builder
  private LoadingSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 loading 显示加载状态")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) } }) {
          TnButton({ content: "加载中", type: "primary", loading: true });
          TnButton({
            content: this.vm.isLoading ? "加载中..." : "点击切换",
            type: "success",
            loading: this.vm.isLoading,
            onBtnClick: () => {
              this.vm.toggleLoading();
            }
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
   * 7. 禁用状态展示区
   */
  @Builder
  private DisabledSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 disabled 禁用按钮")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) } }) {
          TnButton({ content: "Primary", type: "primary", disabled: true });
          TnButton({ content: "Success", type: "success", disabled: true });
          TnButton({ content: "Warning", type: "warning", disabled: true });
          TnButton({ content: "Danger", type: "danger", disabled: true });
          TnButton({ content: "Info", type: "info", disabled: true });
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
   * 8. 图标按钮展示区
   */
  @Builder
  private IconSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 icon 设置图标按钮")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) } }) {
          TnButton({ content: "搜索", icon: "search", type: "primary" });
          TnButton({ content: "设置", icon: "set-fill", type: "success" });
          TnButton({ icon: "home-capsule-fill", type: "warning", shape: "circle" });
          TnButton({ content: "拍照", icon: "camera", type: "danger", shape: "round" });
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
   * 9. 自定义颜色展示区
   */
  @Builder
  private CustomColorSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 bgColor / textColor / btnBorderColor 自定义颜色")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) } }) {
          TnButton({ content: "自定义背景", bgColor: "#7232dd", textColor: "#ffffff" });
          TnButton({ content: "自定义文字", type: "primary", textColor: "#ff6700" });
          TnButton({ content: "自定义边框", plain: true, btnBorderColor: "#7232dd", textColor: "#7232dd" });
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
   * 10. 阴影效果展示区
   */
  @Builder
  private ShadowSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 showShadow 显示按钮阴影")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(12) } }) {
          TnButton({ content: "主题阴影", type: "primary", showShadow: true });
          TnButton({ content: "成功阴影", type: "success", showShadow: true });
          TnButton({
            content: "自定义阴影",
            type: "danger",
            showShadow: true,
            shadowColor: "rgba(245,108,108,0.5)"
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
   * 11. 点击事件展示区
   */
  @Builder
  private ClickEventSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("点击按钮触发回调，支持防抖")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) } }) {
          TnButton({
            content: `点击计数: ${this.vm.clickCount}`,
            type: "primary",
            onBtnClick: () => {
              this.vm.incrementClickCount();
            }
          });
          TnButton({
            content: "防抖按钮",
            type: "warning",
            debounce: true,
            onBtnClick: () => {
              this.vm.incrementClickCount();
            }
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
}
