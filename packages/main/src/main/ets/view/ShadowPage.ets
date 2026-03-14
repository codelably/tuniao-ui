/**
 * @file 阴影展示页面视图
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
import ShadowViewModel, { ShadowItem } from "../viewmodel/ShadowViewModel";

/**
 * 阴影展示页面
 */
@ComponentV2
export struct ShadowPage {
  /**
   * 阴影展示页面 ViewModel
   */
  @Local
  private vm: ShadowViewModel = new ShadowViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  build() {
    AppNavDestination({
      title: "阴影",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.ShadowContent();
    }
  }

  /**
   * 阴影内容视图
   */
  @Builder
  private ShadowContent() {
    MediumPaddingVerticalScroll() {
      ColumnBase({ widthValue: P100 }) {
        Text("阴影分级")
          .fontSize($r("app.float.headline_medium"))
          .fontColor($r("app.color.text_primary"))
          .fontWeight(FontWeight.Bold);

        SpaceVerticalMedium();

        Text("4 级阴影对比展示")
          .fontSize($r("app.float.body_large"))
          .fontColor($r("app.color.text_primary"))
          .fontWeight(FontWeight.Medium);

        SpaceVerticalSmall();

        ForEach(this.vm.getShadowItems(), (item: ShadowItem, index: number) => {
          this.ShadowCard(item);
          if (index < this.vm.getShadowItems().length - 1) {
            SpaceVerticalLarge();
          }
        }, (item: ShadowItem) => item.name);
      };
    };
  }

  /**
   * 阴影卡片
   * @param item 阴影项
   */
  @Builder
  private ShadowCard(item: ShadowItem): void {
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

        SpaceVerticalSmall();

        Text(`radius: ${item.config.radius}  offsetX: ${item.config.offsetX}  offsetY: ${item.config.offsetY}`)
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Column() {
          Text("TuniaoUI")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_primary"));
        }
        .width(200)
        .height(80)
        .justifyContent(FlexAlign.Center)
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"))
        .shadow({
          radius: item.config.radius,
          color: $r("app.color.tn_shadow_light"),
          offsetX: item.config.offsetX,
          offsetY: item.config.offsetY
        });
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_content"))
    .borderRadius($r("app.float.radius_medium"));
  }
}
