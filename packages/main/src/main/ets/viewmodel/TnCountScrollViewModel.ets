/**
 * @file TnCountScroll 数字滚动展示页面 ViewModel
 * @author JunBin.Yang
 */
import { BaseViewModel } from "@core/base";

@ObservedV2
export default class TnCountScrollViewModel extends BaseViewModel {
  /** 基础用法 */
  @Trace basicValue: string = "7865";

  /** 带小数 */
  @Trace decimalValue: string = "7865.23";

  /** 带千分位 */
  @Trace thousandsValue: string = "123,542,7645.23";

  /** 不带千分位 */
  @Trace noThousandsValue: string = "9876543";

  /** 慢速动画 */
  @Trace slowValue: string = "12345";

  /** 快速动画 */
  @Trace fastValue: string = "6789";

  /** 动态变化的值 */
  @Trace dynamicValue: string = "1000";

  /** 动态变化状态文字 */
  @Trace dynamicStatusText: string = "当前值：1000";

  /**
   * 随机更新动态值
   */
  randomUpdateValue(): void {
    const newVal: number = Math.floor(Math.random() * 99999);
    this.dynamicValue = newVal.toString();
    this.dynamicStatusText = `当前值：${this.dynamicValue}`;
  }

  /**
   * 增加动态值
   */
  increaseValue(): void {
    const current: number = parseInt(this.dynamicValue, 10) || 0;
    const newVal: number = current + Math.floor(Math.random() * 1000) + 100;
    this.dynamicValue = newVal.toString();
    this.dynamicStatusText = `当前值：${this.dynamicValue}`;
  }

  /**
   * 重置动态值
   */
  resetValue(): void {
    this.dynamicValue = "1000";
    this.dynamicStatusText = "当前值：1000";
  }
}
