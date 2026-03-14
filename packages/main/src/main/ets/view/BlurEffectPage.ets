/**
 * @file 毛玻璃效果展示页面视图
 * @description 展示 4 级 backdropBlur 效果对比，含丰富背景内容以凸显模糊差异
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
import BlurEffectViewModel, { BlurItem } from "../viewmodel/BlurEffectViewModel";

/**
 * 毛玻璃效果展示页面
 */
@ComponentV2
export struct BlurEffectPage {
  /**
   * 毛玻璃效果展示页面 ViewModel
   */
  @Local
  private vm: BlurEffectViewModel = new BlurEffectViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  build() {
    AppNavDestination({
      title: "毛玻璃",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.BlurContent();
    }
  }

  /**
   * 毛玻璃内容视图
   */
  @Builder
  private BlurContent() {
    MediumPaddingVerticalScroll() {
      ColumnBase({ widthValue: P100 }) {
        Text("毛玻璃效果")
          .fontSize($r("app.float.headline_medium"))
          .fontColor($r("app.color.text_primary"))
          .fontWeight(FontWeight.Bold);

        SpaceVerticalMedium();

        Text("backdropBlur 在丰富背景上的 4 级对比")
          .fontSize($r("app.float.body_large"))
          .fontColor($r("app.color.text_primary"))
          .fontWeight(FontWeight.Medium);

        SpaceVerticalSmall();

        // 无模糊对照组
        this.BlurCard(new BlurItem("无模糊", "对照组，无 backdropBlur", 0));

        SpaceVerticalLarge();

        ForEach(this.vm.getBlurItems(), (item: BlurItem, index: number) => {
          this.BlurCard(item);
          if (index < this.vm.getBlurItems().length - 1) {
            SpaceVerticalLarge();
          }
        }, (item: BlurItem) => item.name);

        SpaceVerticalLarge();
        SpaceVerticalLarge();

        Text("同一背景横向对比")
          .fontSize($r("app.float.body_large"))
          .fontColor($r("app.color.text_primary"))
          .fontWeight(FontWeight.Medium);

        SpaceVerticalSmall();

        this.HorizontalCompare();
      };
    };
  }

  /**
   * 构建丰富的背景内容（文字、色块、图标混排）
   */
  @Builder
  private RichBackground(): void {
    Column() {
      // 多行文字和色块混排，提供足够的视觉细节
      Row({ space: 8 }) {
        Column()
          .width(40)
          .height(40)
          .backgroundColor($r("app.color.primary"))
          .borderRadius(8);
        Column()
          .width(40)
          .height(40)
          .backgroundColor($r("app.color.success"))
          .borderRadius(20);
        Column()
          .width(40)
          .height(40)
          .backgroundColor($r("app.color.warning"))
          .borderRadius(4);
        Column()
          .width(40)
          .height(40)
          .backgroundColor($r("app.color.danger"))
          .borderRadius(8);
      }

      Text("TuniaoUI HarmonyOS")
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor($r("app.color.text_primary"))
        .margin({ top: 8 });

      Text("图鸟UI鸿蒙版 - 组件库演示文字")
        .fontSize(13)
        .fontColor($r("app.color.text_subtitle"))
        .margin({ top: 4 });

      Row({ space: 6 }) {
        Column()
          .width(24)
          .height(12)
          .backgroundColor($r("app.color.primary"));
        Column()
          .width(24)
          .height(12)
          .backgroundColor($r("app.color.success"));
        Column()
          .width(24)
          .height(12)
          .backgroundColor($r("app.color.warning"));
        Column()
          .width(24)
          .height(12)
          .backgroundColor($r("app.color.danger"));
        Column()
          .width(24)
          .height(12)
          .backgroundColor("#FF9500");
        Column()
          .width(24)
          .height(12)
          .backgroundColor("#AF52DE");
      }
      .margin({ top: 8 });

      Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        .fontSize(11)
        .fontColor($r("app.color.text_primary"))
        .margin({ top: 4 });
    }
    .width(P100)
    .height(160)
    .padding(12)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      angle: 135,
      colors: [
        ["#F0F4FF", 0.0],
        ["#FFF0F0", 0.5],
        ["#F0FFF4", 1.0]
      ]
    });
  }

  /**
   * 毛玻璃卡片（单个级别展示）
   * @param item 模糊项
   */
  @Builder
  private BlurCard(item: BlurItem): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text(item.name)
          .fontSize($r("app.float.body_large"))
          .fontColor($r("app.color.text_primary"))
          .fontWeight(FontWeight.Medium);

        SpaceVerticalSmall();

        Text(`${item.description}  (backdropBlur: ${item.blurValue})`)
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Stack() {
          // 丰富背景层
          this.RichBackground();

          // 毛玻璃遮罩层 - 覆盖大部分区域以凸显效果
          Column() {
            Text("毛玻璃遮罩")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_primary"));
          }
          .width(P100)
          .height(100)
          .justifyContent(FlexAlign.Center)
          .borderRadius($r("app.float.radius_medium"))
          .backgroundColor("#33FFFFFF")
          .backdropBlur(item.blurValue);
        }
        .width(P100)
        .height(160)
        .borderRadius($r("app.float.radius_medium"))
        .clip(true);
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 横向对比展示：同一背景上 4 级毛玻璃并排
   */
  @Builder
  private HorizontalCompare(): void {
    Column() {
      Stack() {
        // 背景层
        this.RichBackground();

        // 4 个并排的毛玻璃条
        Row({ space: 4 }) {
          ForEach(this.vm.getBlurItems(), (item: BlurItem) => {
            Column() {
              Text(`${item.blurValue}`)
                .fontSize(11)
                .fontColor($r("app.color.text_primary"))
                .fontWeight(FontWeight.Bold);
            }
            .layoutWeight(1)
            .height(120)
            .justifyContent(FlexAlign.End)
            .padding({ bottom: 8 })
            .backgroundColor("#33FFFFFF")
            .backdropBlur(item.blurValue)
            .borderRadius(4);
          }, (item: BlurItem) => "h-" + item.name);
        }
        .width(P100)
        .height(160)
        .padding(8);
      }
      .width(P100)
      .height(160)
      .borderRadius($r("app.float.radius_medium"))
      .clip(true);
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }
}
