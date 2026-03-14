/**
 * @file 字体大小展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";
import { TnUIGetUIBaseStyle } from "@tuniao/tn-ui";

/**
 * 字体大小项数据模型
 */
export class FontSizeItem {
  /**
   * 字体大小名称
   */
  name: string;
  /**
   * 字体大小描述
   */
  description: string;
  /**
   * 字体大小值
   */
  size: string;

  constructor(name: string, description: string, size: string) {
    this.name = name;
    this.description = description;
    this.size = size;
  }
}

/**
 * 字体大小展示页面 ViewModel
 */
@ObservedV2
export default class FontSizeViewModel extends BaseViewModel {
  /**
   * 获取字体大小列表
   * @returns {FontSizeItem[]} 字体大小项数组
   */
  getFontSizeItems(): FontSizeItem[] {
    const baseStyle = TnUIGetUIBaseStyle();

    return [
      new FontSizeItem("font-size-xs", "超小字体", baseStyle.fontSizeXs),
      new FontSizeItem("font-size-sm", "小字体", baseStyle.fontSizeSm),
      new FontSizeItem("font-size", "默认字体", baseStyle.fontSize),
      new FontSizeItem("font-size-lg", "大字体", baseStyle.fontSizeLg),
      new FontSizeItem("font-size-xl", "超大字体", baseStyle.fontSizeXl),
      new FontSizeItem("font-size-xxl", "特大字体", baseStyle.fontSizeXXl),
      new FontSizeItem("font-size-xxxl", "巨大字体", baseStyle.fontSizeXXXl),
      new FontSizeItem("font-size-xxxxl", "超巨大字体", baseStyle.fontSizeXXXXl)
    ];
  }
}
