/**
 * @file 毛玻璃效果展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";
import { BLUR_LEVEL } from "@tuniao/tn-ui";

/**
 * 毛玻璃项数据模型
 */
export class BlurItem {
  /** 级别名称 */
  name: string;
  /** 级别描述 */
  description: string;
  /** 模糊值 */
  blurValue: number;

  constructor(name: string, description: string, blurValue: number) {
    this.name = name;
    this.description = description;
    this.blurValue = blurValue;
  }
}

/**
 * 毛玻璃效果展示页面 ViewModel
 */
@ObservedV2
export default class BlurEffectViewModel extends BaseViewModel {
  /**
   * 获取模糊级别列表
   * @returns 模糊项数组
   */
  getBlurItems(): BlurItem[] {
    return [
      new BlurItem("blur-sm", "轻微模糊", BLUR_LEVEL.SM),
      new BlurItem("blur-default", "默认模糊", BLUR_LEVEL.DEFAULT),
      new BlurItem("blur-md", "中等模糊", BLUR_LEVEL.MD),
      new BlurItem("blur-lg", "强模糊", BLUR_LEVEL.LG),
    ];
  }
}
