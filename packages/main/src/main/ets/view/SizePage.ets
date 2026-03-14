/**
 * @file 尺寸展示页面视图
 * @author JunBin.Yang
 */

import { AppNavDestination } from "@core/components";
import {
  ColumnBase,
  MediumPaddingVerticalScroll,
  P100,
  RowBase,
  SpaceVerticalLarge,
  SpaceVerticalMedium,
  SpaceVerticalSmall
} from "@core/designsystem";
import { getWindowSafeAreaState, WindowSafeAreaState } from "@core/layoutstate";
import SizeViewModel, { FixedSizeItem, FunctionSizeItem } from "../viewmodel/SizeViewModel";
import { tn_w, tn_w_full, tn_w_auto, tn_w_screen, tn_h, tn_h_full, tn_h_auto, tn_h_screen } from "@tuniao/tn-ui";

/**
 * 尺寸展示页面
 */
@ComponentV2
export struct SizePage {
  /**
   * 尺寸展示页面 ViewModel
   */
  @Local
  private vm: SizeViewModel = new SizeViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  /**
   * 构建尺寸展示页面
   * @returns {void} 无返回值
   */
  build() {
    AppNavDestination({
      title: "尺寸",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.SizeContent();
    }
  }

  /**
   * 尺寸内容视图
   * @returns {void} 无返回值
   */
  @Builder
  private SizeContent() {
    MediumPaddingVerticalScroll() {
      ColumnBase({ widthValue: P100 }) {
        Text("尺寸")
          .fontSize($r("app.float.headline_medium"))
          .fontColor($r("app.color.text_primary"))
          .fontWeight(FontWeight.Bold);

        SpaceVerticalMedium();

        Text("固定宽度")
          .fontSize($r("app.float.body_large"))
          .fontColor($r("app.color.text_primary"))
          .fontWeight(FontWeight.Medium);

        SpaceVerticalSmall();

        ForEach(this.vm.getFixedWidthItems(), (item: FixedSizeItem, index: number) => {
          this.FixedWidthCard(item);
          if (index < this.vm.getFixedWidthItems().length - 1) {
            SpaceVerticalLarge();
          }
        }, (item: FixedSizeItem) => item.name);

        SpaceVerticalLarge();
        SpaceVerticalLarge();

        Text("函数宽度 tn_w(分子, 分母)")
          .fontSize($r("app.float.body_large"))
          .fontColor($r("app.color.text_primary"))
          .fontWeight(FontWeight.Medium);

        SpaceVerticalSmall();

        ForEach(this.vm.getFunctionWidthItems(), (item: FunctionSizeItem, index: number) => {
          this.FunctionWidthCard(item);
          if (index < this.vm.getFunctionWidthItems().length - 1) {
            SpaceVerticalLarge();
          }
        }, (item: FunctionSizeItem) => item.example);

        SpaceVerticalLarge();
        SpaceVerticalLarge();

        Text("固定高度")
          .fontSize($r("app.float.body_large"))
          .fontColor($r("app.color.text_primary"))
          .fontWeight(FontWeight.Medium);

        SpaceVerticalSmall();

        ForEach(this.vm.getFixedHeightItems(), (item: FixedSizeItem, index: number) => {
          this.FixedHeightCard(item);
          if (index < this.vm.getFixedHeightItems().length - 1) {
            SpaceVerticalLarge();
          }
        }, (item: FixedSizeItem) => item.name);

        SpaceVerticalLarge();
        SpaceVerticalLarge();

        Text("函数高度 tn_h(分子, 分母)")
          .fontSize($r("app.float.body_large"))
          .fontColor($r("app.color.text_primary"))
          .fontWeight(FontWeight.Medium);

        SpaceVerticalSmall();

        ForEach(this.vm.getFunctionHeightItems(), (item: FunctionSizeItem, index: number) => {
          this.FunctionHeightCard(item);
          if (index < this.vm.getFunctionHeightItems().length - 1) {
            SpaceVerticalLarge();
          }
        }, (item: FunctionSizeItem) => item.example);
      };
    };
  }

  /**
   * 固定宽度卡片
   * @param {FixedSizeItem} item - 固定尺寸项
   * @returns {void} 无返回值
   */
  @Builder
  private FixedWidthCard(item: FixedSizeItem): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text(item.name)
          .fontSize($r("app.float.body_large"))
          .fontColor($r("app.color.text_primary"))
          .fontWeight(FontWeight.Medium);

        SpaceVerticalSmall();

        Text(item.description)
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Column() {
          Text("TuniaoUI")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_primary"));
        }
        .width(item.name === "tn_w_full" ? tn_w_full : (item.name === "tn_w_auto" ? tn_w_auto : tn_w_screen()))
        .height(60)
        .backgroundColor($r("app.color.primary"))
        .justifyContent(FlexAlign.Center)
        .borderRadius($r("app.float.radius_small"));
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 函数宽度卡片
   * @param {FunctionSizeItem} item - 函数尺寸项
   * @returns {void} 无返回值
   */
  @Builder
  private FunctionWidthCard(item: FunctionSizeItem): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        RowBase({ widthValue: P100 }) {
          Text(item.example)
            .fontSize($r("app.float.body_large"))
            .fontColor($r("app.color.text_primary"))
            .fontWeight(FontWeight.Medium)
            .layoutWeight(1);

          Text(tn_w(item.numerator, item.denominator))
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
        };

        SpaceVerticalMedium();

        Column() {
          Text("TuniaoUI")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_primary"));
        }
        .width(tn_w(item.numerator, item.denominator))
        .height(60)
        .backgroundColor($r("app.color.success"))
        .justifyContent(FlexAlign.Center)
        .borderRadius($r("app.float.radius_small"));
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 固定高度卡片
   * @param {FixedSizeItem} item - 固定尺寸项
   * @returns {void} 无返回值
   */
  @Builder
  private FixedHeightCard(item: FixedSizeItem): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text(item.name)
          .fontSize($r("app.float.body_large"))
          .fontColor($r("app.color.text_primary"))
          .fontWeight(FontWeight.Medium);

        SpaceVerticalSmall();

        Text(item.description)
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Column() {
          Column() {
            Text("TuniaoUI")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_primary"));
          }
          .width(200)
          .height(item.name === "tn_h_full" ? tn_h_full : (item.name === "tn_h_auto" ? tn_h_auto : tn_h_screen()))
          .backgroundColor($r("app.color.warning"))
          .justifyContent(FlexAlign.Center)
          .borderRadius($r("app.float.radius_small"));
        }
        .width(P100)
        .height(200)
        .backgroundColor($r("app.color.bg_content"))
        .justifyContent(FlexAlign.Center)
        .borderRadius($r("app.float.radius_small"));
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 函数高度卡片
   * @param {FunctionSizeItem} item - 函数尺寸项
   * @returns {void} 无返回值
   */
  @Builder
  private FunctionHeightCard(item: FunctionSizeItem): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        RowBase({ widthValue: P100 }) {
          Text(item.example)
            .fontSize($r("app.float.body_large"))
            .fontColor($r("app.color.text_primary"))
            .fontWeight(FontWeight.Medium)
            .layoutWeight(1);

          Text(tn_h(item.numerator, item.denominator))
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
        };

        SpaceVerticalMedium();

        Column() {
          Column() {
            Text("TuniaoUI")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_primary"));
          }
          .width(200)
          .height(tn_h(item.numerator, item.denominator))
          .backgroundColor($r("app.color.danger"))
          .justifyContent(FlexAlign.Center)
          .borderRadius($r("app.float.radius_small"));
        }
        .width(P100)
        .height(200)
        .backgroundColor($r("app.color.bg_content"))
        .justifyContent(FlexAlign.Center)
        .borderRadius($r("app.float.radius_small"));
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }
}
