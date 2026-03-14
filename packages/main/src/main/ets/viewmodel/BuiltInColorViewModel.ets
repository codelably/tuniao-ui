/**
 * @file 内置颜色展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

/**
 * 内置颜色项数据模型
 */
export class BuiltInColorItem {
  /**
   * 颜色名称
   */
  name: string;
  /**
   * 颜色值
   */
  color: ResourceColor;
  /**
   * 颜色描述
   */
  description: string;
  /**
   * 颜色变种
   */
  variants: ColorVariantItem[];

  constructor(name: string, color: ResourceColor, description: string, variants: ColorVariantItem[]) {
    this.name = name;
    this.color = color;
    this.description = description;
    this.variants = variants;
  }
}

/**
 * 颜色变种项
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

@ObservedV2
export default class BuiltInColorViewModel extends BaseViewModel {
  /**
   * 获取内置颜色列表
   * @returns {BuiltInColorItem[]} 颜色数组
   */
  getColorItems(): BuiltInColorItem[] {
    return [
      new BuiltInColorItem(
        "Red",
        $r("app.color.tn_color_red"),
        "红色",
        [
          new ColorVariantItem("dark", $r("app.color.tn_color_red_dark")),
          new ColorVariantItem("light", $r("app.color.tn_color_red_light")),
          new ColorVariantItem("disabled", $r("app.color.tn_color_red_disabled"))
        ]
      ),
      new BuiltInColorItem(
        "PurpleRed",
        $r("app.color.tn_color_purplered"),
        "紫红色",
        [
          new ColorVariantItem("dark", $r("app.color.tn_color_purplered_dark")),
          new ColorVariantItem("light", $r("app.color.tn_color_purplered_light")),
          new ColorVariantItem("disabled", $r("app.color.tn_color_purplered_disabled"))
        ]
      ),
      new BuiltInColorItem(
        "Purple",
        $r("app.color.tn_color_purple"),
        "紫色",
        [
          new ColorVariantItem("dark", $r("app.color.tn_color_purple_dark")),
          new ColorVariantItem("light", $r("app.color.tn_color_purple_light")),
          new ColorVariantItem("disabled", $r("app.color.tn_color_purple_disabled"))
        ]
      ),
      new BuiltInColorItem(
        "BluePurple",
        $r("app.color.tn_color_bluepurple"),
        "蓝紫色",
        [
          new ColorVariantItem("dark", $r("app.color.tn_color_bluepurple_dark")),
          new ColorVariantItem("light", $r("app.color.tn_color_bluepurple_light")),
          new ColorVariantItem("disabled", $r("app.color.tn_color_bluepurple_disabled"))
        ]
      ),
      new BuiltInColorItem(
        "AquaBlue",
        $r("app.color.tn_color_aquablue"),
        "水蓝色",
        [
          new ColorVariantItem("dark", $r("app.color.tn_color_aquablue_dark")),
          new ColorVariantItem("light", $r("app.color.tn_color_aquablue_light")),
          new ColorVariantItem("disabled", $r("app.color.tn_color_aquablue_disabled"))
        ]
      ),
      new BuiltInColorItem(
        "Blue",
        $r("app.color.tn_color_blue"),
        "蓝色",
        [
          new ColorVariantItem("dark", $r("app.color.tn_color_blue_dark")),
          new ColorVariantItem("light", $r("app.color.tn_color_blue_light")),
          new ColorVariantItem("disabled", $r("app.color.tn_color_blue_disabled"))
        ]
      ),
      new BuiltInColorItem(
        "Indigo",
        $r("app.color.tn_color_indigo"),
        "靛蓝色",
        [
          new ColorVariantItem("dark", $r("app.color.tn_color_indigo_dark")),
          new ColorVariantItem("light", $r("app.color.tn_color_indigo_light")),
          new ColorVariantItem("disabled", $r("app.color.tn_color_indigo_disabled"))
        ]
      ),
      new BuiltInColorItem(
        "Cyan",
        $r("app.color.tn_color_cyan"),
        "青色",
        [
          new ColorVariantItem("dark", $r("app.color.tn_color_cyan_dark")),
          new ColorVariantItem("light", $r("app.color.tn_color_cyan_light")),
          new ColorVariantItem("disabled", $r("app.color.tn_color_cyan_disabled"))
        ]
      ),
      new BuiltInColorItem(
        "Teal",
        $r("app.color.tn_color_teal"),
        "蓝绿色",
        [
          new ColorVariantItem("dark", $r("app.color.tn_color_teal_dark")),
          new ColorVariantItem("light", $r("app.color.tn_color_teal_light")),
          new ColorVariantItem("disabled", $r("app.color.tn_color_teal_disabled"))
        ]
      ),
      new BuiltInColorItem(
        "Green",
        $r("app.color.tn_color_green"),
        "绿色",
        [
          new ColorVariantItem("dark", $r("app.color.tn_color_green_dark")),
          new ColorVariantItem("light", $r("app.color.tn_color_green_light")),
          new ColorVariantItem("disabled", $r("app.color.tn_color_green_disabled"))
        ]
      ),
      new BuiltInColorItem(
        "YellowGreen",
        $r("app.color.tn_color_yellowgreen"),
        "黄绿色",
        [
          new ColorVariantItem("dark", $r("app.color.tn_color_yellowgreen_dark")),
          new ColorVariantItem("light", $r("app.color.tn_color_yellowgreen_light")),
          new ColorVariantItem("disabled", $r("app.color.tn_color_yellowgreen_disabled"))
        ]
      ),
      new BuiltInColorItem(
        "Lime",
        $r("app.color.tn_color_lime"),
        "青柠色",
        [
          new ColorVariantItem("dark", $r("app.color.tn_color_lime_dark")),
          new ColorVariantItem("light", $r("app.color.tn_color_lime_light")),
          new ColorVariantItem("disabled", $r("app.color.tn_color_lime_disabled"))
        ]
      ),
      new BuiltInColorItem(
        "Yellow",
        $r("app.color.tn_color_yellow"),
        "黄色",
        [
          new ColorVariantItem("dark", $r("app.color.tn_color_yellow_dark")),
          new ColorVariantItem("light", $r("app.color.tn_color_yellow_light")),
          new ColorVariantItem("disabled", $r("app.color.tn_color_yellow_disabled"))
        ]
      ),
      new BuiltInColorItem(
        "OrangeYellow",
        $r("app.color.tn_color_orangeyellow"),
        "橙黄色",
        [
          new ColorVariantItem("dark", $r("app.color.tn_color_orangeyellow_dark")),
          new ColorVariantItem("light", $r("app.color.tn_color_orangeyellow_light")),
          new ColorVariantItem("disabled", $r("app.color.tn_color_orangeyellow_disabled"))
        ]
      ),
      new BuiltInColorItem(
        "Orange",
        $r("app.color.tn_color_orange"),
        "橙色",
        [
          new ColorVariantItem("dark", $r("app.color.tn_color_orange_dark")),
          new ColorVariantItem("light", $r("app.color.tn_color_orange_light")),
          new ColorVariantItem("disabled", $r("app.color.tn_color_orange_disabled"))
        ]
      ),
      new BuiltInColorItem(
        "OrangeRed",
        $r("app.color.tn_color_orangered"),
        "橙红色",
        [
          new ColorVariantItem("dark", $r("app.color.tn_color_orangered_dark")),
          new ColorVariantItem("light", $r("app.color.tn_color_orangered_light")),
          new ColorVariantItem("disabled", $r("app.color.tn_color_orangered_disabled"))
        ]
      ),
      new BuiltInColorItem(
        "Brown",
        $r("app.color.tn_color_brown"),
        "棕色",
        [
          new ColorVariantItem("dark", $r("app.color.tn_color_brown_dark")),
          new ColorVariantItem("light", $r("app.color.tn_color_brown_light")),
          new ColorVariantItem("disabled", $r("app.color.tn_color_brown_disabled"))
        ]
      ),
      new BuiltInColorItem(
        "Grey",
        $r("app.color.tn_color_grey"),
        "灰色",
        [
          new ColorVariantItem("dark", $r("app.color.tn_color_grey_dark")),
          new ColorVariantItem("light", $r("app.color.tn_color_grey_light")),
          new ColorVariantItem("disabled", $r("app.color.tn_color_grey_disabled"))
        ]
      ),
      new BuiltInColorItem(
        "Gray",
        $r("app.color.tn_color_gray"),
        "灰色",
        [
          new ColorVariantItem("dark", $r("app.color.tn_color_gray_dark")),
          new ColorVariantItem("light", $r("app.color.tn_color_gray_light")),
          new ColorVariantItem("disabled", $r("app.color.tn_color_gray_disabled"))
        ]
      )
    ];
  }
}
