/**
 * @file 渐变背景展示页面视图
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
import GradientBackgroundViewModel, { GradientBackgroundItem } from "../viewmodel/GradientBackgroundViewModel";

/**
 * 渐变背景展示页面
 */
@ComponentV2
export struct GradientBackgroundPage {
  /**
   * 渐变背景展示页面 ViewModel
   */
  @Local
  private vm: GradientBackgroundViewModel = new GradientBackgroundViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  /**
   * 构建渐变背景展示页面
   * @returns {void} 无返回值
   */
  build() {
    AppNavDestination({
      title: "背景",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.BackgroundContent();
    }
  }

  /**
   * 背景内容视图
   * @returns {void} 无返回值
   */
  @Builder
  private BackgroundContent() {
    MediumPaddingVerticalScroll() {
      ColumnBase({ widthValue: P100 }) {
        Text("普通渐变背景")
          .fontSize($r("app.float.headline_medium"))
          .fontColor($r("app.color.text_primary"))
          .fontWeight(FontWeight.Bold);

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
          ForEach(this.vm.getNormalGradientItems(), (item: GradientBackgroundItem) => {
            this.GradientCard(item);
          }, (item: GradientBackgroundItem) => item.type);
        }
        .width(P100);

        SpaceVerticalLarge();
        SpaceVerticalLarge();

        Text("酷炫渐变背景")
          .fontSize($r("app.float.headline_medium"))
          .fontColor($r("app.color.text_primary"))
          .fontWeight(FontWeight.Bold);

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
          ForEach(this.vm.getCoolGradientItems(), (item: GradientBackgroundItem) => {
            this.GradientCard(item);
          }, (item: GradientBackgroundItem) => item.type);
        }
        .width(P100);
      };
    };
  }

  /**
   * 渐变背景卡片
   * @param {GradientBackgroundItem} item - 渐变背景项
   * @returns {void} 无返回值
   */
  @Builder
  private GradientCard(item: GradientBackgroundItem): void {
    Column() {
      Column()
        .width(P100)
        .height(100)
        .linearGradient(item.gradient)
        .borderRadius($r("app.float.radius_small"));

      SpaceVerticalSmall();

      Text(item.name)
        .fontSize($r("app.float.body_medium"))
        .fontColor($r("app.color.text_primary"))
        .fontWeight(FontWeight.Medium)
        .textAlign(TextAlign.Center);

      SpaceVerticalSmall();

      Text(item.description)
        .fontSize($r("app.float.body_medium"))
        .fontColor($r("app.color.text_subtitle"))
        .textAlign(TextAlign.Center);
    }
    .width("48%")
    .padding($r("app.float.space_padding_small"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"))
    .margin({ bottom: 12 });
  }
}
