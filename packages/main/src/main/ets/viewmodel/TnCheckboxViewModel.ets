/**
 * @file TnCheckbox 展示页面 ViewModel
 * @author JunBin.Yang
 */
import { BaseViewModel } from "@core/base";

@ObservedV2
export default class TnCheckboxViewModel extends BaseViewModel {
  /** 复选框组1的选中值集合（基础用法） */
  @Trace checkboxValues1: Array<string | number> = ["a"];

  /** 复选框组2的选中值集合（最大选择数） */
  @Trace checkboxValues2: Array<string | number> = ["pingpong"];

  /** 复选框组3的选中值集合（自定义颜色） */
  @Trace checkboxValues3: Array<string | number> = ["c"];

  /** 复选框组4的选中值集合（带边框） */
  @Trace checkboxValues4: Array<string | number> = ["c"];

  /** 复选框组5的选中值集合（自定义大小） */
  @Trace checkboxValues5: Array<string | number> = [];

  /** 复选框组6的选中值集合（圆形形状） */
  @Trace checkboxValues6: Array<string | number> = [];

  /**
   * 设置复选框组1的选中值集合
   * @param values 新的选中值数组
   */
  setCheckboxValues1(values: Array<string | number>): void {
    this.checkboxValues1 = values;
  }

  /**
   * 设置复选框组2的选中值集合
   * @param values 新的选中值数组
   */
  setCheckboxValues2(values: Array<string | number>): void {
    this.checkboxValues2 = values;
  }

  /**
   * 设置复选框组3的选中值集合
   * @param values 新的选中值数组
   */
  setCheckboxValues3(values: Array<string | number>): void {
    this.checkboxValues3 = values;
  }

  /**
   * 设置复选框组4的选中值集合
   * @param values 新的选中值数组
   */
  setCheckboxValues4(values: Array<string | number>): void {
    this.checkboxValues4 = values;
  }

  /**
   * 设置复选框组5的选中值集合
   * @param values 新的选中值数组
   */
  setCheckboxValues5(values: Array<string | number>): void {
    this.checkboxValues5 = values;
  }

  /**
   * 设置复选框组6的选中值集合
   * @param values 新的选中值数组
   */
  setCheckboxValues6(values: Array<string | number>): void {
    this.checkboxValues6 = values;
  }
}
