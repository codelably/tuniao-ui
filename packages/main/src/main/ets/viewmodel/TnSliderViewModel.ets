/**
 * @file TnSlider 展示页面 ViewModel
 * @author JunBin.Yang
 */
import { BaseViewModel } from "@core/base";

@ObservedV2
export default class TnSliderViewModel extends BaseViewModel {
  /** 滑块组件1的当前值 */
  @Trace sliderValue1: number = 30;

  /** 滑块组件2的当前值 */
  @Trace sliderValue2: number = 50;

  /** 滑块组件3的当前值（自定义颜色） */
  @Trace sliderValue3: number = 40;

  /** 滑块组件4的当前值（禁用状态） */
  @Trace sliderValue4: number = 60;

  /**
   * 设置滑块组件1的当前值
   * @param value 新的滑块值
   */
  setSliderValue1(value: number): void {
    this.sliderValue1 = value;
  }

  /**
   * 设置滑块组件2的当前值
   * @param value 新的滑块值
   */
  setSliderValue2(value: number): void {
    this.sliderValue2 = value;
  }
}
