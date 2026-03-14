/**
 * @file TnBadge 徽标展示页面视图
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
import { TnBadge, TnButton } from "@tuniao/tn-ui";
import TnBadgeViewModel from "../viewmodel/TnBadgeViewModel";

/**
 * 徽标演示用内容块构建器
 */
@Builder
function BadgeDemoBlock() {
  Row()
    .width(40)
    .height(40)
    .borderRadius(8)
    .backgroundColor("#f2f3f5");
}

/**
 * TnBadge 徽标展示页面
 */
@ComponentV2
export struct TnBadgePage {
  /**
   * 徽标展示页面 ViewModel
   */
  @Local
  private vm: TnBadgeViewModel = new TnBadgeViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  /**
   * 构建徽标展示页面
   */
  build() {
    AppNavDestination({
      title: "徽标",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.BadgeContent();
    }
  }

  /**
   * 徽标内容视图
   */
  @Builder
  private BadgeContent() {
    MediumPaddingVerticalScroll() {
      ColumnBase({ widthValue: P100 }) {
        // 1. 基础用法
        this.SectionTitle("基础用法");
        SpaceVerticalMedium();
        this.BasicSection();

        SpaceVerticalLarge();

        // 2. 圆点徽标
        this.SectionTitle("圆点徽标");
        SpaceVerticalMedium();
        this.DotSection();

        SpaceVerticalLarge();

        // 3. 最大值
        this.SectionTitle("最大值");
        SpaceVerticalMedium();
        this.MaxSection();

        SpaceVerticalLarge();

        // 4. 颜色类型
        this.SectionTitle("颜色类型");
        SpaceVerticalMedium();
        this.ColorTypeSection();

        SpaceVerticalLarge();

        // 5. 自定义颜色
        this.SectionTitle("自定义颜色");
        SpaceVerticalMedium();
        this.CustomColorSection();

        SpaceVerticalLarge();

        // 6. 徽标尺寸
        this.SectionTitle("徽标尺寸");
        SpaceVerticalMedium();
        this.SizeSection();

        SpaceVerticalLarge();

        // 7. 自定义字体大小
        this.SectionTitle("自定义字体大小");
        SpaceVerticalMedium();
        this.CustomFontSizeSection();

        SpaceVerticalLarge();

        // 8. 加粗文字
        this.SectionTitle("加粗文字");
        SpaceVerticalMedium();
        this.BoldSection();

        SpaceVerticalLarge();

        // 9. 字符串徽标
        this.SectionTitle("字符串徽标");
        SpaceVerticalMedium();
        this.StringSection();

        SpaceVerticalLarge();

        // 10. 图标徽标
        this.SectionTitle("图标徽标");
        SpaceVerticalMedium();
        this.IconSection();

        SpaceVerticalLarge();

        // 11. 定位方向
        this.SectionTitle("定位方向");
        SpaceVerticalMedium();
        this.PositionSection();

        SpaceVerticalLarge();

        // 12. 独立展示（非绝对定位）
        this.SectionTitle("独立展示");
        SpaceVerticalMedium();
        this.StandaloneSection();

        SpaceVerticalLarge();

        // 13. showZero 控制
        this.SectionTitle("显示零值");
        SpaceVerticalMedium();
        this.ShowZeroSection();

        SpaceVerticalLarge();

        // 14. 动态增减
        this.SectionTitle("动态增减");
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
        Text("设置 value 显示徽标内容，配合 absolute 在子内容上方展示")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(20), cross: LengthMetrics.vp(12) } }) {
          TnBadge({ value: 5, absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ value: 10, absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ value: "new", absolute: true }) {
            BadgeDemoBlock();
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
   * 2. 圆点徽标展示区
   */
  @Builder
  private DotSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 dot 显示为圆点模式，不展示具体数值")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(20), cross: LengthMetrics.vp(12) } }) {
          TnBadge({ dot: true, absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ dot: true, absolute: true, type: "primary" }) {
            BadgeDemoBlock();
          };
          TnBadge({ dot: true, absolute: true, type: "success" }) {
            BadgeDemoBlock();
          };
          TnBadge({ dot: true, absolute: true, type: "warning" }) {
            BadgeDemoBlock();
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
   * 3. 最大值展示区
   */
  @Builder
  private MaxSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 max 属性，当 value 超过 max 时显示 {max}+")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(20), cross: LengthMetrics.vp(12) } }) {
          TnBadge({ value: 20, max: 9, absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ value: 50, max: 20, absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ value: 200, max: 99, absolute: true }) {
            BadgeDemoBlock();
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
   * 4. 颜色类型展示区
   */
  @Builder
  private ColorTypeSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 type 设置徽标颜色类型")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(20), cross: LengthMetrics.vp(12) } }) {
          TnBadge({ value: 1, type: "primary", absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ value: 2, type: "success", absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ value: 3, type: "warning", absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ value: 4, type: "danger", absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ value: 5, type: "info", absolute: true }) {
            BadgeDemoBlock();
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
   * 5. 自定义颜色展示区
   */
  @Builder
  private CustomColorSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 bgColor / textColor 自定义徽标颜色")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(20), cross: LengthMetrics.vp(12) } }) {
          TnBadge({ value: 8, bgColor: "#7232dd", absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ value: "HOT", bgColor: "#1989fa", absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({
            value: 6,
            bgColor: $r("app.color.tn_color_orange"),
            textColor: "#000000",
            absolute: true
          }) {
            BadgeDemoBlock();
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
   * 6. 徽标尺寸展示区
   */
  @Builder
  private SizeSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 badgeSize 设置徽标尺寸")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          wrap: FlexWrap.Wrap,
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(20), cross: LengthMetrics.vp(12) }
        }) {
          TnBadge({ value: 1, badgeSize: "sm", absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ value: 2, absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ value: 3, badgeSize: "lg", absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ value: 4, badgeSize: "xl", absolute: true }) {
            BadgeDemoBlock();
          };
        }
        .width(P100);

        SpaceVerticalMedium();

        Text("圆点尺寸对比")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          wrap: FlexWrap.Wrap,
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(20), cross: LengthMetrics.vp(12) }
        }) {
          TnBadge({ dot: true, badgeSize: "sm", absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ dot: true, absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ dot: true, badgeSize: "lg", absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ dot: true, badgeSize: "xl", absolute: true }) {
            BadgeDemoBlock();
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
   * 7. 自定义字体大小展示区
   */
  @Builder
  private CustomFontSizeSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 fontSize 自定义徽标字体大小")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          wrap: FlexWrap.Wrap,
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(20), cross: LengthMetrics.vp(12) }
        }) {
          TnBadge({ value: 8, fontSize: 8, absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ value: 8, absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ value: 8, fontSize: 14, absolute: true }) {
            BadgeDemoBlock();
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
   * 8. 加粗文字展示区
   */
  @Builder
  private BoldSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 bold 加粗徽标文字")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(20), cross: LengthMetrics.vp(12) } }) {
          TnBadge({ value: 99, absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ value: 99, bold: true, absolute: true }) {
            BadgeDemoBlock();
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
   * 9. 字符串徽标展示区
   */
  @Builder
  private StringSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("value 支持传入字符串内容")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(20), cross: LengthMetrics.vp(12) } }) {
          TnBadge({ value: "new", absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ value: "HOT", type: "warning", absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ value: "VIP", type: "primary", bold: true, absolute: true }) {
            BadgeDemoBlock();
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
   * 10. 图标徽标展示区
   */
  @Builder
  private IconSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("value 以 icon- 前缀时渲染为图标徽标")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(20), cross: LengthMetrics.vp(12) } }) {
          TnBadge({ value: "icon-logo-tuniao", absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ value: "icon-star-fill", type: "warning", absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ value: "icon-heart-fill", type: "primary", absolute: true }) {
            BadgeDemoBlock();
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
   * 11. 定位方向展示区
   */
  @Builder
  private PositionSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 badgePosition 设置徽标在四角的定位")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(30), cross: LengthMetrics.vp(16) } }) {
          TnBadge({ value: 1, badgePosition: "top-left", absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ value: 2, badgePosition: "top-right", absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ value: 3, badgePosition: "bottom-left", absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ value: 4, badgePosition: "bottom-right", absolute: true }) {
            BadgeDemoBlock();
          };
        }
        .width(P100);

        SpaceVerticalMedium();

        Text("使用 xOffset / yOffset 微调偏移量")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(30), cross: LengthMetrics.vp(16) } }) {
          TnBadge({ value: 5, xOffset: 4, yOffset: 4, absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ dot: true, xOffset: 2, yOffset: 2, absolute: true }) {
            BadgeDemoBlock();
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
   * 12. 独立展示（非绝对定位）
   */
  @Builder
  private StandaloneSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 absolute 为 false 可独立展示徽标，不使用绝对定位")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          wrap: FlexWrap.Wrap,
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) }
        }) {
          TnBadge({ value: 5, absolute: false });
          TnBadge({ value: 99, type: "primary", absolute: false });
          TnBadge({ value: "new", type: "success", absolute: false });
          TnBadge({ dot: true, absolute: false });
          TnBadge({ value: "HOT", type: "warning", bold: true, absolute: false });
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
   * 13. showZero 控制展示区
   */
  @Builder
  private ShowZeroSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 showZero 为 false 时，value 为 0 不显示徽标")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(20), cross: LengthMetrics.vp(12) } }) {
          TnBadge({ value: 0, showZero: true, absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ value: 0, showZero: false, absolute: true }) {
            BadgeDemoBlock();
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
   * 14. 动态增减展示区
   */
  @Builder
  private DynamicSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("动态修改 value 的值，观察徽标变化")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Row({ space: 20 }) {
          TnBadge({ value: this.vm.badgeValue, max: 99, absolute: true }) {
            BadgeDemoBlock();
          };
          TnBadge({ dot: this.vm.badgeValue > 0, absolute: true }) {
            BadgeDemoBlock();
          };
        }

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) } }) {
          TnButton({
            content: "+1",
            type: "primary",
            btnSize: "sm",
            onBtnClick: () => {
              this.vm.incrementValue();
            }
          });
          TnButton({
            content: "-1",
            type: "danger",
            btnSize: "sm",
            onBtnClick: () => {
              this.vm.decrementValue();
            }
          });
          TnButton({
            content: "重置",
            type: "info",
            btnSize: "sm",
            onBtnClick: () => {
              this.vm.resetValue();
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
