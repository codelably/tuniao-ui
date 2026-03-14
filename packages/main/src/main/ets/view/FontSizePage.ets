/**
 * @file 字体大小展示页面视图
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
import FontSizeViewModel, { FontSizeItem } from "../viewmodel/FontSizeViewModel";

/**
 * 字体大小展示页面
 */
@ComponentV2
export struct FontSizePage {
  /**
   * 字体大小展示页面 ViewModel
   */
  @Local
  private vm: FontSizeViewModel = new FontSizeViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  /**
   * 构建字体大小展示页面
   * @returns {void} 无返回值
   */
  build() {
    AppNavDestination({
      title: "字体大小",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.FontSizeContent();
    }
  }

  /**
   * 字体大小内容视图
   * @returns {void} 无返回值
   */
  @Builder
  private FontSizeContent() {
    MediumPaddingVerticalScroll() {
      ColumnBase({ widthValue: P100 }) {
        Text("字体大小")
          .fontSize($r("app.float.headline_medium"))
          .fontColor($r("app.color.text_primary"))
          .fontWeight(FontWeight.Bold);

        SpaceVerticalMedium();

        ForEach(this.vm.getFontSizeItems(), (item: FontSizeItem, index: number) => {
          this.FontSizeCard(item);
          if (index < this.vm.getFontSizeItems().length - 1) {
            SpaceVerticalLarge();
          }
        }, (item: FontSizeItem) => item.name);
      };
    };
  }

  /**
   * 字体大小卡片
   * @param {FontSizeItem} item - 字体大小项
   * @returns {void} 无返回值
   */
  @Builder
  private FontSizeCard(item: FontSizeItem): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text(item.name)
          .fontSize($r("app.float.body_large"))
          .fontColor($r("app.color.text_primary"))
          .fontWeight(FontWeight.Medium);

        SpaceVerticalMedium();

        Text(item.description)
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Text(`TuniaoUI`)
          .fontSize(item.size)
          .fontColor($r("app.color.text_primary"));
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }
}
