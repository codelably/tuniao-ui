/**
 * @file 渐变背景展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";
import { TnGradientBackground } from "@tuniao/tn-ui";

/**
 * 渐变背景项数据模型
 */
export class GradientBackgroundItem {
  /**
   * 背景名称
   */
  name: string;
  /**
   * 背景描述
   */
  description: string;
  /**
   * 渐变背景配置
   */
  gradient: LinearGradientOptions;
  /**
   * 背景类型标识
   */
  type: string;

  constructor(name: string, description: string, gradient: LinearGradientOptions, type: string) {
    this.name = name;
    this.description = description;
    this.gradient = gradient;
    this.type = type;
  }
}

@ObservedV2
export default class GradientBackgroundViewModel extends BaseViewModel {
  /**
   * 获取普通渐变背景列表
   * @returns {GradientBackgroundItem[]} 渐变背景数组
   */
  getNormalGradientItems(): GradientBackgroundItem[] {
    return [
      new GradientBackgroundItem("Red", "红色渐变", TnGradientBackground("red"), "red"),
      new GradientBackgroundItem("Red Light", "红色浅色渐变", TnGradientBackground("red-light"), "red-light"),
      new GradientBackgroundItem("Red Single", "红色单色渐变", TnGradientBackground("red-single"), "red-single"),
      new GradientBackgroundItem("PurpleRed", "紫红色渐变", TnGradientBackground("purplered"), "purplered"),
      new GradientBackgroundItem("PurpleRed Light", "紫红色浅色渐变", TnGradientBackground("purplered-light"), "purplered-light"),
      new GradientBackgroundItem("PurpleRed Single", "紫红色单色渐变", TnGradientBackground("purplered-single"), "purplered-single"),
      new GradientBackgroundItem("Purple", "紫色渐变", TnGradientBackground("purple"), "purple"),
      new GradientBackgroundItem("Purple Light", "紫色浅色渐变", TnGradientBackground("purple-light"), "purple-light"),
      new GradientBackgroundItem("Purple Single", "紫色单色渐变", TnGradientBackground("purple-single"), "purple-single"),
      new GradientBackgroundItem("BluePurple", "蓝紫色渐变", TnGradientBackground("bluepurple"), "bluepurple"),
      new GradientBackgroundItem("BluePurple Light", "蓝紫色浅色渐变", TnGradientBackground("bluepurple-light"), "bluepurple-light"),
      new GradientBackgroundItem("BluePurple Single", "蓝紫色单色渐变", TnGradientBackground("bluepurple-single"), "bluepurple-single"),
      new GradientBackgroundItem("AquaBlue", "水蓝色渐变", TnGradientBackground("aquablue"), "aquablue"),
      new GradientBackgroundItem("AquaBlue Light", "水蓝色浅色渐变", TnGradientBackground("aquablue-light"), "aquablue-light"),
      new GradientBackgroundItem("AquaBlue Single", "水蓝色单色渐变", TnGradientBackground("aquablue-single"), "aquablue-single"),
      new GradientBackgroundItem("Blue", "蓝色渐变", TnGradientBackground("blue"), "blue"),
      new GradientBackgroundItem("Blue Light", "蓝色浅色渐变", TnGradientBackground("blue-light"), "blue-light"),
      new GradientBackgroundItem("Blue Single", "蓝色单色渐变", TnGradientBackground("blue-single"), "blue-single"),
      new GradientBackgroundItem("Indigo", "靛蓝色渐变", TnGradientBackground("indigo"), "indigo"),
      new GradientBackgroundItem("Indigo Light", "靛蓝色浅色渐变", TnGradientBackground("indigo-light"), "indigo-light"),
      new GradientBackgroundItem("Indigo Single", "靛蓝色单色渐变", TnGradientBackground("indigo-single"), "indigo-single"),
      new GradientBackgroundItem("Cyan", "青色渐变", TnGradientBackground("cyan"), "cyan"),
      new GradientBackgroundItem("Cyan Light", "青色浅色渐变", TnGradientBackground("cyan-light"), "cyan-light"),
      new GradientBackgroundItem("Cyan Single", "青色单色渐变", TnGradientBackground("cyan-single"), "cyan-single"),
      new GradientBackgroundItem("Teal", "蓝绿色渐变", TnGradientBackground("teal"), "teal"),
      new GradientBackgroundItem("Teal Light", "蓝绿色浅色渐变", TnGradientBackground("teal-light"), "teal-light"),
      new GradientBackgroundItem("Teal Single", "蓝绿色单色渐变", TnGradientBackground("teal-single"), "teal-single"),
      new GradientBackgroundItem("Green", "绿色渐变", TnGradientBackground("green"), "green"),
      new GradientBackgroundItem("Green Light", "绿色浅色渐变", TnGradientBackground("green-light"), "green-light"),
      new GradientBackgroundItem("Green Single", "绿色单色渐变", TnGradientBackground("green-single"), "green-single"),
      new GradientBackgroundItem("YellowGreen", "黄绿色渐变", TnGradientBackground("yellowgreen"), "yellowgreen"),
      new GradientBackgroundItem("YellowGreen Light", "黄绿色浅色渐变", TnGradientBackground("yellowgreen-light"), "yellowgreen-light"),
      new GradientBackgroundItem("YellowGreen Single", "黄绿色单色渐变", TnGradientBackground("yellowgreen-single"), "yellowgreen-single"),
      new GradientBackgroundItem("Lime", "青柠色渐变", TnGradientBackground("lime"), "lime"),
      new GradientBackgroundItem("Lime Light", "青柠色浅色渐变", TnGradientBackground("lime-light"), "lime-light"),
      new GradientBackgroundItem("Lime Single", "青柠色单色渐变", TnGradientBackground("lime-single"), "lime-single"),
      new GradientBackgroundItem("Yellow", "黄色渐变", TnGradientBackground("yellow"), "yellow"),
      new GradientBackgroundItem("Yellow Light", "黄色浅色渐变", TnGradientBackground("yellow-light"), "yellow-light"),
      new GradientBackgroundItem("Yellow Single", "黄色单色渐变", TnGradientBackground("yellow-single"), "yellow-single"),
      new GradientBackgroundItem("OrangeYellow", "橙黄色渐变", TnGradientBackground("orangeyellow"), "orangeyellow"),
      new GradientBackgroundItem("OrangeYellow Light", "橙黄色浅色渐变", TnGradientBackground("orangeyellow-light"), "orangeyellow-light"),
      new GradientBackgroundItem("OrangeYellow Single", "橙黄色单色渐变", TnGradientBackground("orangeyellow-single"), "orangeyellow-single"),
      new GradientBackgroundItem("Orange", "橙色渐变", TnGradientBackground("orange"), "orange"),
      new GradientBackgroundItem("Orange Light", "橙色浅色渐变", TnGradientBackground("orange-light"), "orange-light"),
      new GradientBackgroundItem("Orange Single", "橙色单色渐变", TnGradientBackground("orange-single"), "orange-single"),
      new GradientBackgroundItem("OrangeRed Single", "橙红色单色渐变", TnGradientBackground("orangered-single"), "orangered-single"),
      new GradientBackgroundItem("Brown Single", "棕色单色渐变", TnGradientBackground("brown-single"), "brown-single"),
      new GradientBackgroundItem("Grey", "灰色渐变", TnGradientBackground("grey"), "grey"),
      new GradientBackgroundItem("Grey Light", "灰色浅色渐变", TnGradientBackground("grey-light"), "grey-light"),
      new GradientBackgroundItem("Grey Single", "灰色单色渐变", TnGradientBackground("grey-single"), "grey-single"),
      new GradientBackgroundItem("Gray Single", "灰色单色渐变", TnGradientBackground("gray-single"), "gray-single")
    ];
  }

  /**
   * 获取酷炫渐变背景列表
   * @returns {GradientBackgroundItem[]} 酷炫渐变背景数组
   */
  getCoolGradientItems(): GradientBackgroundItem[] {
    return [
      new GradientBackgroundItem("Cool 1", "酷炫渐变 1", TnGradientBackground("cool-1"), "cool-1"),
      new GradientBackgroundItem("Cool 2", "酷炫渐变 2", TnGradientBackground("cool-2"), "cool-2"),
      new GradientBackgroundItem("Cool 3", "酷炫渐变 3", TnGradientBackground("cool-3"), "cool-3"),
      new GradientBackgroundItem("Cool 4", "酷炫渐变 4", TnGradientBackground("cool-4"), "cool-4"),
      new GradientBackgroundItem("Cool 5", "酷炫渐变 5", TnGradientBackground("cool-5"), "cool-5"),
      new GradientBackgroundItem("Cool 6", "酷炫渐变 6", TnGradientBackground("cool-6"), "cool-6"),
      new GradientBackgroundItem("Cool 7", "酷炫渐变 7", TnGradientBackground("cool-7"), "cool-7"),
      new GradientBackgroundItem("Cool 8", "酷炫渐变 8", TnGradientBackground("cool-8"), "cool-8"),
      new GradientBackgroundItem("Cool 9", "酷炫渐变 9", TnGradientBackground("cool-9"), "cool-9"),
      new GradientBackgroundItem("Cool 10", "酷炫渐变 10", TnGradientBackground("cool-10"), "cool-10"),
      new GradientBackgroundItem("Cool 11", "酷炫渐变 11", TnGradientBackground("cool-11"), "cool-11"),
      new GradientBackgroundItem("Cool 12", "酷炫渐变 12", TnGradientBackground("cool-12"), "cool-12"),
      new GradientBackgroundItem("Cool 13", "酷炫渐变 13", TnGradientBackground("cool-13"), "cool-13"),
      new GradientBackgroundItem("Cool 14", "酷炫渐变 14", TnGradientBackground("cool-14"), "cool-14"),
      new GradientBackgroundItem("Cool 15", "酷炫渐变 15", TnGradientBackground("cool-15"), "cool-15"),
      new GradientBackgroundItem("Cool 16", "酷炫渐变 16", TnGradientBackground("cool-16"), "cool-16")
    ];
  }
}
