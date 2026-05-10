/**
 * @file TnWaterFall 瀑布流组件类型定义
 * @description 瀑布流组件的属性接口和数据源定义
 * @author JunBin.Yang
 */

/**
 * TnWaterFall 组件属性接口
 */
export interface TnWaterFallProps {
  /**
   * 列数
   */
  columnCount?: number;
  /**
   * 列间距（单位 vp）
   */
  columnsGap?: number;
  /**
   * 行间距（单位 vp）
   */
  rowsGap?: number;
  /**
   * 是否显示滚动条
   */
  showScrollBar?: boolean;
  /**
   * 触底加载阈值距离（单位 vp）
   */
  loadMoreOffset?: number;
  /**
   * 触底加载回调
   */
  onLoadMore?: () => void;
  /**
   * 滚动事件回调
   * @param scrollOffset 当前滚动偏移量
   */
  onScroll?: (scrollOffset: number) => void;
}

/**
 * 瀑布流数据源接口
 * 用于 LazyForEach 懒加载
 */
export interface IWaterFallDataSource extends IDataSource {
  /**
   * 获取数据总数
   */
  totalCount(): number;
  /**
   * 获取指定索引的数据
   */
  getData(index: number): Object;
}

/**
 * 瀑布流基础数据源实现
 * 提供 LazyForEach 所需的 IDataSource 接口实现
 */
export class TnWaterFallDataSource implements IDataSource {
  private dataArray: Object[] = [];
  private listeners: DataChangeListener[] = [];

  /**
   * 获取数据总数
   * @returns 数据总数
   */
  totalCount(): number {
    return this.dataArray.length;
  }

  /**
   * 获取指定索引的数据
   * @param index 数据索引
   * @returns 数据对象
   */
  getData(index: number): Object {
    return this.dataArray[index];
  }

  /**
   * 注册数据变化监听器
   * @param listener 监听器
   */
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener);
    }
  }

  /**
   * 注销数据变化监听器
   * @param listener 监听器
   */
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      this.listeners.splice(pos, 1);
    }
  }

  /**
   * 追加单条数据
   * @param item 数据项
   */
  pushData(item: Object): void {
    this.dataArray.push(item);
    this.notifyDataAdd(this.dataArray.length - 1);
  }

  /**
   * 批量追加数据
   * @param items 数据项数组
   */
  pushDataArray(items: Object[]): void {
    const startIndex = this.dataArray.length;
    for (let i = 0; i < items.length; i++) {
      this.dataArray.push(items[i]);
    }
    this.notifyDatasetChange();
  }

  /**
   * 重置数据
   * @param items 新数据数组
   */
  resetData(items: Object[]): void {
    this.dataArray = items;
    this.notifyDatasetChange();
  }

  /**
   * 删除指定索引的数据
   * @param index 数据索引
   */
  deleteData(index: number): void {
    if (index >= 0 && index < this.dataArray.length) {
      this.dataArray.splice(index, 1);
      this.notifyDataDelete(index);
    }
  }

  /**
   * 获取所有数据
   * @returns 数据数组副本
   */
  getAllData(): Object[] {
    return this.dataArray.slice();
  }

  private notifyDataAdd(index: number): void {
    for (const listener of this.listeners) {
      listener.onDataAdd(index);
    }
  }

  private notifyDataDelete(index: number): void {
    for (const listener of this.listeners) {
      listener.onDataDelete(index);
    }
  }

  private notifyDatasetChange(): void {
    for (const listener of this.listeners) {
      listener.onDataReloaded();
    }
  }
}
