/**
 * @file 间距展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";
import { TnUIGetUIBaseStyle } from "@tuniao/tn-ui";

/**
 * 间距项数据模型
 */
export class SpacingItem {
  /**
   * 间距名称
   */
  name: string;
  /**
   * 间距描述
   */
  description: string;
  /**
   * 间距值
   */
  size: string;

  constructor(name: string, description: string, size: string) {
    this.name = name;
    this.description = description;
    this.size = size;
  }
}

/**
 * 间距展示页面 ViewModel
 */
@ObservedV2
export default class SpacingViewModel extends BaseViewModel {
  /**
   * 获取间距列表
   * @returns {SpacingItem[]} 间距项数组
   */
  getSpacingItems(): SpacingItem[] {
    const baseStyle = TnUIGetUIBaseStyle();

    return [
      new SpacingItem("space-xs", "超小间距", baseStyle.spaceXs),
      new SpacingItem("space-sm", "小间距", baseStyle.spaceSm),
      new SpacingItem("space", "默认间距", baseStyle.space),
      new SpacingItem("space-lg", "大间距", baseStyle.spaceLg),
      new SpacingItem("space-xl", "超大间距", baseStyle.spaceXl)
    ];
  }
}
