/**
 * @file 样式展示页面视图
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
  SpaceVerticalSmall,
  SpaceHorizontalSmall
} from "@core/designsystem";
import { getWindowSafeAreaState, WindowSafeAreaState } from "@core/layoutstate";
import StyleViewModel, { ColorItem, ColorVariantItem } from "../viewmodel/StyleViewModel";

/**
 * 样式展示页面
 */
@ComponentV2
export struct StylePage {
  /**
   * 样式展示页面 ViewModel
   */
  @Local
  private vm: StyleViewModel = new StyleViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  /**
   * 构建样式展示页面
   * @returns {void} 无返回值
   */
  build() {
    AppNavDestination({
      title: "样式",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.StyleContent();
    }
  }

  /**
   * 样式内容视图
   * @returns {void} 无返回值
   */
  @Builder
  private StyleContent() {
    MediumPaddingVerticalScroll() {
      ColumnBase({ widthValue: P100 }) {
        Text("主题颜色")
          .fontSize($r("app.float.headline_medium"))
          .fontColor($r("app.color.text_primary"))
          .fontWeight(FontWeight.Bold);

        SpaceVerticalMedium();

        ForEach(this.vm.getColorItems(), (item: ColorItem) => {
          this.ColorCard(item);
          SpaceVerticalLarge();
        }, (item: ColorItem) => item.name);
      };
    };
  }

  /**
   * 颜色卡片
   * @param {ColorItem} item - 颜色项
   * @returns {void} 无返回值
   */
  @Builder
  private ColorCard(item: ColorItem): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        // 主色块
        RowBase({ widthValue: P100 }) {
          Column() {
            Text(item.name)
              .fontSize($r("app.float.body_large"))
              .fontColor($r("app.color.text_primary"))
              .fontWeight(FontWeight.Medium);

            SpaceVerticalSmall();

            Text(item.description)
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1);

          SpaceHorizontalSmall();

          // 主色块展示
          Column()
            .width(60)
            .height(60)
            .backgroundColor(item.color)
            .borderRadius($r("app.float.radius_small"));
        };

        SpaceVerticalMedium();

        // 变种色块
        Text("颜色变种")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalSmall();

        // 变种色块网格
        Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
          ForEach(item.variants, (variant: ColorVariantItem) => {
            Column() {
              Column()
                .width(50)
                .height(50)
                .backgroundColor(variant.color)
                .borderRadius($r("app.float.radius_small"));

              SpaceVerticalSmall();

              Text(variant.name)
                .fontSize($r("app.float.body_medium"))
                .fontColor($r("app.color.text_subtitle"))
                .textAlign(TextAlign.Center);
            }
            .width("30%")
            .margin({ bottom: 12 });
          }, (variant: ColorVariantItem) => variant.name);
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
