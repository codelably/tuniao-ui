/**
 * @file TnWaterFall 瀑布流组件
 * @description 基于 HarmonyOS WaterFlow 封装的瀑布流布局组件，简化使用
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";

/**
 * TnWaterFall 瀑布流组件
 *
 * 基于 HarmonyOS 原生 WaterFlow 组件封装，提供简化的瀑布流布局能力。
 * 支持自定义列数、间距、懒加载等特性。
 *
 * @example
 * // 基础用法
 * TnWaterFall({
 *   dataSource: this.dataSource,
 *   columnCount: 2,
 *   itemBuilder: (item: Object, index: number) => {
 *     this.WaterFallItem(item as MyItem, index);
 *   }
 * })
 */
@ComponentV2
export struct TnWaterFall {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType =
    AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /**
   * 数据源（支持 LazyForEach 懒加载）
   */
  @Param dataSource: IDataSource | null = null;
  /**
   * 列数
   */
  @Param columnCount: number = 2;
  /**
   * 列间距（单位 vp）
   */
  @Param columnsGap: number = -1;
  /**
   * 行间距（单位 vp）
   */
  @Param rowsGap: number = -1;
  /**
   * 是否显示滚动条
   */
  @Param showScrollBar: boolean = false;
  /**
   * 触底加载阈值距离（单位 vp）
   */
  @Param loadMoreOffset: number = 50;
  /**
   * 组件宽度
   */
  @Param waterFallWidth: Length = "100%";
  /**
   * 组件高度
   */
  @Param waterFallHeight: Length = "100%";
  /**
   * 背景色
   */
  @Param bgColor: ResourceColor = Color.Transparent;
  /**
   * 内边距
   */
  @Param waterFallPadding: Padding = {};
  /**
   * 触底加载回调
   */
  @Event onLoadMore: () => void = () => {};
  /**
   * 滚动事件回调
   */
  @Event onScroll: (scrollOffset: number) => void = (_offset: number) => {};
  /**
   * 每个 FlowItem 的渲染构建器
   */
  @BuilderParam itemBuilder: (item: Object, index: number) => void = this.defaultItemBuilder;
  /**
   * 滚动控制器
   */
  @Param scroller: Scroller | null = null;
  /**
   * 内部滚动控制器
   */
  @Local private innerScroller: Scroller = new Scroller();
  /**
   * 计算后的列模板
   */
  @Local private columnsTemplate: string = "1fr 1fr";

  @Builder
  private defaultItemBuilder(_item: Object, _index: number): void {}

  @Monitor("columnCount")
  onColumnCountChange(): void {
    this.updateColumnsTemplate();
  }

  aboutToAppear(): void {
    this.updateColumnsTemplate();
    if (this.scroller) {
      this.innerScroller = this.scroller;
    }
  }

  /**
   * 根据列数生成列模板字符串
   */
  private updateColumnsTemplate(): void {
    const count = Math.max(1, Math.min(this.columnCount, 6));
    const parts: string[] = [];
    for (let i = 0; i < count; i++) {
      parts.push("1fr");
    }
    this.columnsTemplate = parts.join(" ");
  }

  /**
   * 获取实际列间距
   */
  private getColumnsGap(): Length {
    if (this.columnsGap >= 0) {
      return this.columnsGap;
    }
    return this.baseStyle.spaceXsm;
  }

  /**
   * 获取实际行间距
   */
  private getRowsGap(): Length {
    if (this.rowsGap >= 0) {
      return this.rowsGap;
    }
    return this.baseStyle.spaceXsm;
  }

  build() {
    WaterFlow({ scroller: this.innerScroller, layoutMode: WaterFlowLayoutMode.SLIDING_WINDOW }) {
      if (this.dataSource) {
        LazyForEach(this.dataSource, (item: Object, index: number) => {
          FlowItem() {
            this.itemBuilder(item, index);
          }
          .width("100%")
        }, (item: Object, index: number) => `${index}_${JSON.stringify(item)}`)
      }
    }
    .columnsTemplate(this.columnsTemplate)
    .columnsGap(this.getColumnsGap())
    .rowsGap(this.getRowsGap())
    .scrollBar(this.showScrollBar ? BarState.Auto : BarState.Off)
    .width(this.waterFallWidth)
    .height(this.waterFallHeight)
    .backgroundColor(this.bgColor)
    .padding(this.waterFallPadding)
    .onReachEnd(() => {
      this.onLoadMore();
    })
    .onDidScroll((_scrollOffset: number, _scrollState: ScrollState) => {
      const offset = this.innerScroller.currentOffset();
      this.onScroll(offset.yOffset);
    })
  }
}
