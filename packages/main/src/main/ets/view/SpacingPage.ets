/**
 * @file 间距展示页面视图
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
import SpacingViewModel, { SpacingItem } from "../viewmodel/SpacingViewModel";

/**
 * 间距展示页面
 */
@ComponentV2
export struct SpacingPage {
  /**
   * 间距展示页面 ViewModel
   */
  @Local
  private vm: SpacingViewModel = new SpacingViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  /**
   * 构建间距展示页面
   * @returns {void} 无返回值
   */
  build() {
    AppNavDestination({
      title: "间距",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.SpacingContent();
    }
  }

  /**
   * 间距内容视图
   * @returns {void} 无返回值
   */
  @Builder
  private SpacingContent() {
    MediumPaddingVerticalScroll() {
      ColumnBase({ widthValue: P100 }) {
        Text("间距")
          .fontSize($r("app.float.headline_medium"))
          .fontColor($r("app.color.text_primary"))
          .fontWeight(FontWeight.Bold);

        SpaceVerticalMedium();

        Text("内边距示例")
          .fontSize($r("app.float.body_large"))
          .fontColor($r("app.color.text_primary"))
          .fontWeight(FontWeight.Medium);

        SpaceVerticalSmall();

        ForEach(this.vm.getSpacingItems(), (item: SpacingItem, index: number) => {
          this.PaddingCard(item);
          if (index < this.vm.getSpacingItems().length - 1) {
            SpaceVerticalLarge();
          }
        }, (item: SpacingItem) => "padding-" + item.name);

        SpaceVerticalLarge();
        SpaceVerticalLarge();

        Text("外边距示例")
          .fontSize($r("app.float.body_large"))
          .fontColor($r("app.color.text_primary"))
          .fontWeight(FontWeight.Medium);

        SpaceVerticalSmall();

        ForEach(this.vm.getSpacingItems(), (item: SpacingItem, index: number) => {
          this.MarginCard(item);
          if (index < this.vm.getSpacingItems().length - 1) {
            SpaceVerticalLarge();
          }
        }, (item: SpacingItem) => "margin-" + item.name);
      };
    };
  }

  /**
   * 内边距卡片
   * @param {SpacingItem} item - 间距项
   * @returns {void} 无返回值
   */
  @Builder
  private PaddingCard(item: SpacingItem): void {
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
        .padding(item.size)
        .backgroundColor($r("app.color.bg_content"))
        .border({
          width: 1,
          color: $r("app.color.primary"),
          style: BorderStyle.Dashed
        });
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 外边距卡片
   * @param {SpacingItem} item - 间距项
   * @returns {void} 无返回值
   */
  @Builder
  private MarginCard(item: SpacingItem): void {
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
          .margin(item.size)
          .padding($r("app.float.space_padding_small"))
          .backgroundColor($r("app.color.bg_content"))
          .border({
            width: 1,
            color: $r("app.color.success"),
            style: BorderStyle.Solid
          });
        }
        .width(P100)
        .backgroundColor($r("app.color.bg_grey"))
        .border({
          width: 1,
          color: $r("app.color.primary"),
          style: BorderStyle.Dashed
        });
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }
}
