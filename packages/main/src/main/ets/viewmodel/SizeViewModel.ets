/**
 * @file 尺寸展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

/**
 * 固定尺寸项数据模型
 */
export class FixedSizeItem {
  /**
   * 尺寸名称
   */
  name: string;
  /**
   * 尺寸描述
   */
  description: string;
  /**
   * 尺寸值
   */
  value: string;

  constructor(name: string, description: string, value: string) {
    this.name = name;
    this.description = description;
    this.value = value;
  }
}

/**
 * 函数尺寸项数据模型
 */
export class FunctionSizeItem {
  /**
   * 函数调用示例
   */
  example: string;
  /**
   * 分子
   */
  numerator: number;
  /**
   * 分母
   */
  denominator: number;

  constructor(example: string, numerator: number, denominator: number) {
    this.example = example;
    this.numerator = numerator;
    this.denominator = denominator;
  }
}

/**
 * 尺寸展示页面 ViewModel
 */
@ObservedV2
export default class SizeViewModel extends BaseViewModel {
  /**
   * 获取固定宽度列表
   * @returns {FixedSizeItem[]} 固定宽度项数组
   */
  getFixedWidthItems(): FixedSizeItem[] {
    return [
      new FixedSizeItem("tn_w_full", "100% 宽度", "100%"),
      new FixedSizeItem("tn_w_auto", "自动宽度", "auto"),
      new FixedSizeItem("tn_w_screen", "屏幕宽度", "屏幕宽度")
    ];
  }

  /**
   * 获取固定高度列表
   * @returns {FixedSizeItem[]} 固定高度项数组
   */
  getFixedHeightItems(): FixedSizeItem[] {
    return [
      new FixedSizeItem("tn_h_full", "100% 高度", "100%"),
      new FixedSizeItem("tn_h_auto", "自动高度", "auto"),
      new FixedSizeItem("tn_h_screen", "屏幕高度", "屏幕高度")
    ];
  }

  /**
   * 获取函数宽度示例列表
   * @returns {FunctionSizeItem[]} 函数宽度示例数组
   */
  getFunctionWidthItems(): FunctionSizeItem[] {
    return [
      new FunctionSizeItem("tn_w(1, 2)", 1, 2),
      new FunctionSizeItem("tn_w(1, 3)", 1, 3),
      new FunctionSizeItem("tn_w(2, 3)", 2, 3),
      new FunctionSizeItem("tn_w(1, 4)", 1, 4),
      new FunctionSizeItem("tn_w(3, 4)", 3, 4),
      new FunctionSizeItem("tn_w(1, 5)", 1, 5),
      new FunctionSizeItem("tn_w(2, 5)", 2, 5),
      new FunctionSizeItem("tn_w(3, 5)", 3, 5),
      new FunctionSizeItem("tn_w(4, 5)", 4, 5),
      new FunctionSizeItem("tn_w(5, 6)", 5, 6)
    ];
  }

  /**
   * 获取函数高度示例列表
   * @returns {FunctionSizeItem[]} 函数高度示例数组
   */
  getFunctionHeightItems(): FunctionSizeItem[] {
    return [
      new FunctionSizeItem("tn_h(1, 2)", 1, 2),
      new FunctionSizeItem("tn_h(1, 3)", 1, 3),
      new FunctionSizeItem("tn_h(2, 3)", 2, 3),
      new FunctionSizeItem("tn_h(1, 4)", 1, 4),
      new FunctionSizeItem("tn_h(3, 4)", 3, 4),
      new FunctionSizeItem("tn_h(1, 5)", 1, 5)
    ];
  }
}
