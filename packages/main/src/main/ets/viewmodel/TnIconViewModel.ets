/**
 * @file TnIcon 图标展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";
import { TN_ICON_NAMES } from "@tuniao/tn-ui";

/**
 * 图标展示项数据模型
 */
export class IconDemoItem {
  /**
   * 图标名称
   */
  name: string;
  /**
   * 展示描述
   */
  description: string;

  constructor(name: string, description: string) {
    this.name = name;
    this.description = description;
  }
}

/**
 * 主题颜色类型展示项
 */
export class IconTypeItem {
  /**
   * 颜色类型名称
   */
  typeName: string;
  /**
   * 展示用图标名
   */
  iconName: string;

  constructor(typeName: string, iconName: string) {
    this.typeName = typeName;
    this.iconName = iconName;
  }
}

/**
 * 图标尺寸展示项
 */
export class IconSizeItem {
  /**
   * 尺寸描述
   */
  label: string;
  /**
   * 尺寸值
   */
  size: number;

  constructor(label: string, size: number) {
    this.label = label;
    this.size = size;
  }
}

/**
 * 图标网格懒加载数据源
 */
export class IconGridDataSource implements IDataSource {
  private dataArray: string[] = [];
  private listeners: DataChangeListener[] = [];

  constructor(data: string[]) {
    this.dataArray = data;
  }

  /**
   * 获取数据总数
   * @returns 数据总数
   */
  totalCount(): number {
    return this.dataArray.length;
  }

  /**
   * 获取指定索引的数据
   * @param index 索引
   * @returns 图标名称
   */
  getData(index: number): string {
    return this.dataArray[index];
  }

  /**
   * 注册数据变化监听
   * @param listener 监听器
   */
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener);
    }
  }

  /**
   * 注销数据变化监听
   * @param listener 监听器
   */
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos: number = this.listeners.indexOf(listener);
    if (pos >= 0) {
      this.listeners.splice(pos, 1);
    }
  }

  /**
   * 替换全部数据并通知刷新
   * @param data 新数据
   */
  reloadData(data: string[]): void {
    this.dataArray = data;
    this.listeners.forEach((listener: DataChangeListener) => {
      listener.onDataReloaded();
    });
  }
}

/**
 * TnIcon 图标展示页面 ViewModel
 */
@ObservedV2
export default class TnIconViewModel extends BaseViewModel {
  /**
   * 搜索关键字
   */
  @Trace searchKeyword: string = "";
  /**
   * 图标网格懒加载数据源
   */
  readonly iconDataSource: IconGridDataSource = new IconGridDataSource(TN_ICON_NAMES);

  /**
   * 获取基础展示图标列表
   * @returns {IconDemoItem[]} 基础图标项数组
   */
  getBasicIcons(): IconDemoItem[] {
    return [
      new IconDemoItem("home", "首页"),
      new IconDemoItem("user", "用户"),
      new IconDemoItem("set-fill", "设置"),
      new IconDemoItem("search", "搜索"),
      new IconDemoItem("camera", "相机"),
      new IconDemoItem("image", "图片"),
    ];
  }

  /**
   * 获取主题颜色类型展示列表
   * @returns {IconTypeItem[]} 主题颜色类型项数组
   */
  getTypeIcons(): IconTypeItem[] {
    return [
      new IconTypeItem("primary", "home-capsule-fill"),
      new IconTypeItem("success", "success-circle-fill"),
      new IconTypeItem("warning", "warning-fill"),
      new IconTypeItem("danger", "close-circle"),
      new IconTypeItem("info", "notice-fill"),
    ];
  }

  /**
   * 获取尺寸展示列表
   * @returns {IconSizeItem[]} 尺寸项数组
   */
  getSizeIcons(): IconSizeItem[] {
    return [
      new IconSizeItem("20", 20),
      new IconSizeItem("28", 28),
      new IconSizeItem("36", 36),
      new IconSizeItem("48", 48),
      new IconSizeItem("64", 64),
    ];
  }

  /**
   * 获取过滤后的全部图标名称列表
   * @returns {string[]} 图标名称数组
   */
  getFilteredIconNames(): string[] {
    if (this.searchKeyword.length === 0) {
      return TN_ICON_NAMES;
    }
    const keyword: string = this.searchKeyword.toLowerCase();
    return TN_ICON_NAMES.filter((name: string) => name.indexOf(keyword) >= 0);
  }

  /**
   * 获取全部图标总数
   * @returns {number} 图标总数
   */
  getTotalIconCount(): number {
    return TN_ICON_NAMES.length;
  }

  /**
   * 更新搜索关键字并刷新数据源
   * @param keyword 搜索关键字
   */
  updateSearchKeyword(keyword: string): void {
    this.searchKeyword = keyword;
    const filtered: string[] = this.getFilteredIconNames();
    this.iconDataSource.reloadData(filtered);
  }
}
