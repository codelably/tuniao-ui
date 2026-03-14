/**
 * @file TnRegionPicker 地区选择器展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

/**
 * TnRegionPicker 地区选择器展示页面 ViewModel
 */
@ObservedV2
export default class TnRegionPickerViewModel extends BaseViewModel {
  /**
   * 内置数据选择器弹出层是否打开
   */
  @Trace regionOpen: boolean = false;

  /**
   * 当前选中的地区值数组，依次为省、市、区
   */
  @Trace regionValue: string[] = [];

  /**
   * 地区选择结果的显示文本
   */
  @Trace regionDisplayText: string = "";

  /**
   * 地区选择结果的编码文本
   */
  @Trace regionCodeText: string = "";

  /**
   * 自定义数据选择器弹出层是否打开
   */
  @Trace customRegionOpen: boolean = false;

  /**
   * 自定义数据选择结果的显示文本
   */
  @Trace customRegionDisplayText: string = "";

  /**
   * 自定义数据选择结果的编码文本
   */
  @Trace customRegionCodeText: string = "";

  /**
   * 切换内置数据选择器弹出层显示状态
   */
  toggleRegionPicker(): void {
    this.regionOpen = !this.regionOpen;
  }

  /**
   * 内置数据选择确认回调
   * @param names 地区名称数组
   * @param codes 区域编码数组
   */
  onRegionConfirm(names: string[], codes: string[]): void {
    this.regionValue = [...names];
    this.regionDisplayText = names.join(" / ");
    this.regionCodeText = codes.join(" / ");
    this.regionOpen = false;
  }

  /**
   * 关闭内置数据选择器弹出层
   */
  closeRegionPicker(): void {
    this.regionOpen = false;
  }

  /**
   * 切换自定义数据选择器弹出层显示状态
   */
  toggleCustomRegionPicker(): void {
    this.customRegionOpen = !this.customRegionOpen;
  }

  /**
   * 自定义数据选择确认回调
   * @param names 地区名称数组
   * @param codes 区域编码数组
   */
  onCustomRegionConfirm(names: string[], codes: string[]): void {
    this.customRegionDisplayText = names.join(" / ");
    this.customRegionCodeText = codes.join(" / ");
    this.customRegionOpen = false;
  }
}
