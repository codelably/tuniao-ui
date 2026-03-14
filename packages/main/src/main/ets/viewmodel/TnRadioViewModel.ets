/**
 * @file TnRadio 展示页面 ViewModel
 * @author JunBin.Yang
 */
import { BaseViewModel } from "@core/base";

@ObservedV2
export default class TnRadioViewModel extends BaseViewModel {
  /** 单选框组1（基础用法）的选中值 */
  @Trace radioValue1: string = "";

  /** 单选框组2（自定义颜色）的选中值 */
  @Trace radioValue2: string = "";

  /** 单选框组3（自定义大小）的选中值 */
  @Trace radioValue3: string = "";

  /** 单选框组4（边框模式）的选中值 */
  @Trace radioValue4: string = "";

  /**
   * 设置单选框组1的选中值
   * @param value 新的选中值
   */
  setRadioValue1(value: string): void {
    this.radioValue1 = value;
  }

  /**
   * 设置单选框组2的选中值
   * @param value 新的选中值
   */
  setRadioValue2(value: string): void {
    this.radioValue2 = value;
  }

  /**
   * 设置单选框组3的选中值
   * @param value 新的选中值
   */
  setRadioValue3(value: string): void {
    this.radioValue3 = value;
  }

  /**
   * 设置单选框组4的选中值
   * @param value 新的选中值
   */
  setRadioValue4(value: string): void {
    this.radioValue4 = value;
  }
}
