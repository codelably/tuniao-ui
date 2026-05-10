/**
 * @file TnWaterFall 瀑布流展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";
import { TnWaterFallDataSource } from "@tuniao/tn-ui";

/**
 * 瀑布流演示数据项
 */
@ObservedV2
export class WaterFallDemoItem {
  @Trace id: number = 0;
  @Trace height: number = 0;
  @Trace color: string = "";
  @Trace title: string = "";

  constructor(id: number, height: number, color: string, title: string) {
    this.id = id;
    this.height = height;
    this.color = color;
    this.title = title;
  }
}

@ObservedV2
export default class TnWaterFallViewModel extends BaseViewModel {
  /**
   * 基础用法数据源
   */
  @Trace basicDataSource: TnWaterFallDataSource = new TnWaterFallDataSource();
  /**
   * 三列数据源
   */
  @Trace threeColDataSource: TnWaterFallDataSource = new TnWaterFallDataSource();
  /**
   * 自定义间距数据源
   */
  @Trace gapDataSource: TnWaterFallDataSource = new TnWaterFallDataSource();
  /**
   * 加载更多数据源
   */
  @Trace loadMoreDataSource: TnWaterFallDataSource = new TnWaterFallDataSource();
  /**
   * 加载更多状态
   */
  @Trace isLoading: boolean = false;
  /**
   * 加载更多计数
   */
  @Trace loadMoreCount: number = 0;
  /**
   * 预设颜色列表
   */
  private readonly colors: string[] = [
    "#FF6B6B", "#4ECDC4", "#45B7D1", "#96CEB4",
    "#FFEAA7", "#DDA0DD", "#98D8C8", "#F7DC6F",
    "#BB8FCE", "#85C1E9", "#F1948A", "#82E0AA"
  ];

  aboutToAppear(): void {
    this.initBasicData();
    this.initThreeColData();
    this.initGapData();
    this.initLoadMoreData();
  }

  /**
   * 初始化基础用法数据
   */
  private initBasicData(): void {
    const items: Object[] = [];
    for (let i = 0; i < 20; i++) {
      const height = 100 + Math.floor(Math.random() * 120);
      const color = this.colors[i % this.colors.length];
      items.push(new WaterFallDemoItem(i, height, color, `Item ${i + 1}`));
    }
    this.basicDataSource.resetData(items);
  }

  /**
   * 初始化三列数据
   */
  private initThreeColData(): void {
    const items: Object[] = [];
    for (let i = 0; i < 18; i++) {
      const height = 80 + Math.floor(Math.random() * 100);
      const color = this.colors[(i + 3) % this.colors.length];
      items.push(new WaterFallDemoItem(i, height, color, `Col3-${i + 1}`));
    }
    this.threeColDataSource.resetData(items);
  }

  /**
   * 初始化自定义间距数据
   */
  private initGapData(): void {
    const items: Object[] = [];
    for (let i = 0; i < 16; i++) {
      const height = 90 + Math.floor(Math.random() * 110);
      const color = this.colors[(i + 6) % this.colors.length];
      items.push(new WaterFallDemoItem(i, height, color, `Gap-${i + 1}`));
    }
    this.gapDataSource.resetData(items);
  }

  /**
   * 初始化加载更多数据
   */
  private initLoadMoreData(): void {
    const items: Object[] = [];
    for (let i = 0; i < 10; i++) {
      const height = 100 + Math.floor(Math.random() * 120);
      const color = this.colors[i % this.colors.length];
      items.push(new WaterFallDemoItem(i, height, color, `Load-${i + 1}`));
    }
    this.loadMoreDataSource.resetData(items);
  }

  /**
   * 模拟加载更多数据
   */
  handleLoadMore(): void {
    if (this.isLoading) {
      return;
    }
    this.isLoading = true;
    this.loadMoreCount++;
    setTimeout(() => {
      const startIndex = this.loadMoreDataSource.totalCount();
      const items: Object[] = [];
      for (let i = 0; i < 6; i++) {
        const idx = startIndex + i;
        const height = 100 + Math.floor(Math.random() * 120);
        const color = this.colors[idx % this.colors.length];
        items.push(new WaterFallDemoItem(idx, height, color, `Load-${idx + 1}`));
      }
      this.loadMoreDataSource.pushDataArray(items);
      this.isLoading = false;
    }, 1000);
  }
}
