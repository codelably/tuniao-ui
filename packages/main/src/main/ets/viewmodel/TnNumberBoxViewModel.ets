/**
 * @file TnNumberBox 展示页面 ViewModel
 * @author JunBin.Yang
 */
import { BaseViewModel } from "@core/base";

@ObservedV2
export default class TnNumberBoxViewModel extends BaseViewModel {
  /** 数字输入框1的当前数值 */
  @Trace numberValue1: number = 5;

  /** 数字输入框2的当前数值 */
  @Trace numberValue2: number = 0;

  /** 数字输入框3的当前数值（禁用状态） */
  @Trace numberValue3: number = 3;

  /** 数字输入框4的当前数值（禁用输入） */
  @Trace numberValue4: number = 5;

  /** 数字输入框5的当前数值（长按增减） */
  @Trace numberValue5: number = 0;

  /** 数字输入框6的当前数值（小尺寸） */
  @Trace numberValue6: number = 3;

  /** 数字输入框7的当前数值（大尺寸） */
  @Trace numberValue7: number = 5;

  /** 数字输入框8的当前数值（超大尺寸） */
  @Trace numberValue8: number = 10;
}
