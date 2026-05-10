/**
 * @file TnWaterFall 瀑布流展示页面视图
 * @author JunBin.Yang
 */

import { AppNavDestination } from "@core/components";
import { P100, SpaceVerticalLarge, SpaceVerticalMedium } from "@core/designsystem";
import { getWindowSafeAreaState, WindowSafeAreaState } from "@core/layoutstate";
import { TnWaterFall, getThemeColor, TnUIBaseStyle, TnUIBaseStyleType, getFontSizeByKey } from "@tuniao/tn-ui";
import { TnAppStorageKey } from "@tuniao/tn-ui/src/main/ets/common/storage_key";
import { AppStorageV2 } from "@kit.ArkUI";
import TnWaterFallViewModel, { WaterFallDemoItem } from "../viewmodel/TnWaterFallViewModel";

/**
 * TnWaterFall 瀑布流展示页面
 */
@ComponentV2
export struct TnWaterFallPage {
  @Local private vm: TnWaterFallViewModel = new TnWaterFallViewModel();
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();
  @Local private baseStyle: TnUIBaseStyleType =
    AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  build() {
    AppNavDestination({
      title: "瀑布流",
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

  @Builder
  private PageContent(): void {
    Scroll() {
      Column() {
        // 1. 基础用法（2列）
        this.SectionTitle("基础用法");
        this.SectionDesc("默认 2 列瀑布流布局，自动分配等宽不等高的元素");
        SpaceVerticalMedium();
        TnWaterFall({
          dataSource: this.vm.basicDataSource,
          columnCount: 2,
          itemBuilder: (item: Object, index: number) => {
            this.BasicItem(item as WaterFallDemoItem, index);
          },
          waterFallHeight: 400
        })

        SpaceVerticalLarge();

        // 2. 三列布局
        this.SectionTitle("三列布局");
        this.SectionDesc("设置 columnCount 为 3，展示三列瀑布流");
        SpaceVerticalMedium();
        TnWaterFall({
          dataSource: this.vm.threeColDataSource,
          columnCount: 3,
          itemBuilder: (item: Object, index: number) => {
            this.BasicItem(item as WaterFallDemoItem, index);
          },
          waterFallHeight: 350
        })

        SpaceVerticalLarge();

        // 3. 自定义间距
        this.SectionTitle("自定义间距");
        this.SectionDesc("设置 columnsGap 和 rowsGap 自定义列间距和行间距");
        SpaceVerticalMedium();
        TnWaterFall({
          dataSource: this.vm.gapDataSource,
          columnCount: 2,
          columnsGap: 16,
          rowsGap: 16,
          itemBuilder: (item: Object, index: number) => {
            this.RoundedItem(item as WaterFallDemoItem, index);
          },
          waterFallHeight: 380
        })

        SpaceVerticalLarge();

        // 4. 加载更多
        this.SectionTitle("加载更多");
        this.SectionDesc("滚动到底部自动触发加载更多数据");
        SpaceVerticalMedium();
        if (this.vm.loadMoreCount > 0) {
          Text(`已加载 ${this.vm.loadMoreCount} 次`)
            .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
            .fontColor(getThemeColor(this.baseStyle, "primary"))
            .margin({ bottom: this.baseStyle.spaceXsm });
        }
        TnWaterFall({
          dataSource: this.vm.loadMoreDataSource,
          columnCount: 2,
          onLoadMore: () => { this.vm.handleLoadMore(); },
          itemBuilder: (item: Object, index: number) => {
            this.BasicItem(item as WaterFallDemoItem, index);
          },
          waterFallHeight: 350
        })
        if (this.vm.isLoading) {
          Row() {
            Text("加载中...")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
              .fontColor($r("app.color.tn_text_color_secondary"))
          }
          .width(P100)
          .justifyContent(FlexAlign.Center)
          .padding({ top: this.baseStyle.spaceXsm, bottom: this.baseStyle.spaceXsm })
        }

        SpaceVerticalLarge();
      }
      .width(P100)
      .padding({
        left: this.baseStyle.space,
        right: this.baseStyle.space,
        bottom: this.baseStyle.spaceXl
      })
    }
    .width(P100)
    .height(P100)
    .scrollBar(BarState.Off)
  }

  /**
   * 基础瀑布流项
   */
  @Builder
  private BasicItem(item: WaterFallDemoItem, _index: number): void {
    Column() {
      Text(item.title)
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
        .fontColor($r("app.color.tn_color_white"))
    }
    .width(P100)
    .height(item.height)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(item.color)
    .borderRadius(this.baseStyle.borderRadius)
  }

  /**
   * 圆角瀑布流项
   */
  @Builder
  private RoundedItem(item: WaterFallDemoItem, _index: number): void {
    Column() {
      Text(item.title)
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
        .fontColor($r("app.color.tn_color_white"))
        .fontWeight(FontWeight.Medium)
    }
    .width(P100)
    .height(item.height)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(item.color)
    .borderRadius(this.baseStyle.borderRadiusLg)
    .shadow({
      radius: this.baseStyle.shadowSm.radius,
      color: $r("app.color.tn_shadow_light"),
      offsetX: this.baseStyle.shadowSm.offsetX,
      offsetY: this.baseStyle.shadowSm.offsetY
    })
  }

  /**
   * 区域标题
   */
  @Builder
  private SectionTitle(title: string): void {
    Text(title)
      .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeLg"))
      .fontColor($r("app.color.tn_text_color_primary"))
      .fontWeight(FontWeight.Bold)
      .width(P100);
  }

  /**
   * 区域描述
   */
  @Builder
  private SectionDesc(desc: string): void {
    Text(desc)
      .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
      .fontColor($r("app.color.tn_text_color_secondary"))
      .width(P100)
      .margin({ top: this.baseStyle.spaceBase });
  }
}