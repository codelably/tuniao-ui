/**
 * @file 样式展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";
import { TnUIGetUIBaseStyle } from "@tuniao/tn-ui";
import { TnUIBaseStyleType } from "@tuniao/tn-ui";

/**
 * 颜色变种数据模型
 */
export class ColorVariantItem {
  /**
   * 变种名称
   */
  name: string;
  /**
   * 变种颜色值
   */
  color: ResourceColor;

  constructor(name: string, color: ResourceColor) {
    this.name = name;
    this.color = color;
  }
}

/**
 * 颜色项数据模型
 */
export class ColorItem {
  /**
   * 颜色名称
   */
  name: string;
  /**
   * 颜色描述
   */
  description: string;
  /**
   * 颜色值
   */
  color: ResourceColor;
  /**
   * 浅色变种
   */
  variants: ColorVariantItem[];

  constructor(name: string, description: string, color: ResourceColor, variants: ColorVariantItem[]) {
    this.name = name;
    this.description = description;
    this.color = color;
    this.variants = variants;
  }
}

@ObservedV2
export default class StyleViewModel extends BaseViewModel {
  /**
   * 样式数据
   */
  @Trace
  private baseStyle: TnUIBaseStyleType = TnUIGetUIBaseStyle();

  /**
   * 获取颜色列表
   * @returns {ColorItem[]} 颜色项数组
   */
  getColorItems(): ColorItem[] {
    return [
      new ColorItem(
        "Primary",
        "主要色",
        this.baseStyle.primary.value(),
        [
          new ColorVariantItem("light-3", this.baseStyle.primary.variant("light_3")),
          new ColorVariantItem("light-5", this.baseStyle.primary.variant("light_5")),
          new ColorVariantItem("light-7", this.baseStyle.primary.variant("light_7")),
          new ColorVariantItem("light-8", this.baseStyle.primary.variant("light_8")),
          new ColorVariantItem("light-9", this.baseStyle.primary.variant("light_9")),
          new ColorVariantItem("dark-2", this.baseStyle.primary.variant("dark_2"))
        ]
      ),
      new ColorItem(
        "Success",
        "成功色",
        this.baseStyle.success.value(),
        [
          new ColorVariantItem("light-3", this.baseStyle.success.variant("light_3")),
          new ColorVariantItem("light-5", this.baseStyle.success.variant("light_5")),
          new ColorVariantItem("light-7", this.baseStyle.success.variant("light_7")),
          new ColorVariantItem("light-8", this.baseStyle.success.variant("light_8")),
          new ColorVariantItem("light-9", this.baseStyle.success.variant("light_9")),
          new ColorVariantItem("dark-2", this.baseStyle.success.variant("dark_2"))
        ]
      ),
      new ColorItem(
        "Warning",
        "警告色",
        this.baseStyle.warning.value(),
        [
          new ColorVariantItem("light-3", this.baseStyle.warning.variant("light_3")),
          new ColorVariantItem("light-5", this.baseStyle.warning.variant("light_5")),
          new ColorVariantItem("light-7", this.baseStyle.warning.variant("light_7")),
          new ColorVariantItem("light-8", this.baseStyle.warning.variant("light_8")),
          new ColorVariantItem("light-9", this.baseStyle.warning.variant("light_9")),
          new ColorVariantItem("dark-2", this.baseStyle.warning.variant("dark_2"))
        ]
      ),
      new ColorItem(
        "Danger",
        "危险色",
        this.baseStyle.danger.value(),
        [
          new ColorVariantItem("light-3", this.baseStyle.danger.variant("light_3")),
          new ColorVariantItem("light-5", this.baseStyle.danger.variant("light_5")),
          new ColorVariantItem("light-7", this.baseStyle.danger.variant("light_7")),
          new ColorVariantItem("light-8", this.baseStyle.danger.variant("light_8")),
          new ColorVariantItem("light-9", this.baseStyle.danger.variant("light_9")),
          new ColorVariantItem("dark-2", this.baseStyle.danger.variant("dark_2"))
        ]
      ),
      new ColorItem(
        "Error",
        "错误色",
        this.baseStyle.error.value(),
        [
          new ColorVariantItem("light-3", this.baseStyle.error.variant("light_3")),
          new ColorVariantItem("light-5", this.baseStyle.error.variant("light_5")),
          new ColorVariantItem("light-7", this.baseStyle.error.variant("light_7")),
          new ColorVariantItem("light-8", this.baseStyle.error.variant("light_8")),
          new ColorVariantItem("light-9", this.baseStyle.error.variant("light_9")),
          new ColorVariantItem("dark-2", this.baseStyle.error.variant("dark_2"))
        ]
      ),
      new ColorItem(
        "Info",
        "信息色",
        this.baseStyle.info.value(),
        [
          new ColorVariantItem("light-3", this.baseStyle.info.variant("light_3")),
          new ColorVariantItem("light-5", this.baseStyle.info.variant("light_5")),
          new ColorVariantItem("light-7", this.baseStyle.info.variant("light_7")),
          new ColorVariantItem("light-8", this.baseStyle.info.variant("light_8")),
          new ColorVariantItem("light-9", this.baseStyle.info.variant("light_9")),
          new ColorVariantItem("dark-2", this.baseStyle.info.variant("dark_2"))
        ]
      )
    ];
  }
}
