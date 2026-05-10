/**
 * @file TnSubsection 分段器示例 ViewModel
 * @description 管理分段器示例页面的状态数据
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

@ObservedV2
export default class TnSubsectionViewModel extends BaseViewModel {
  /** 基础用法 - 当前索引 */
  @Trace basicIndex: number = 0;
  /** 基础用法 - 选项 */
  basicItems: string[] = ["选项一", "选项二", "选项三"];

  /** 两个选项 - 当前索引 */
  @Trace twoItemIndex: number = 0;
  /** 两个选项 - 选项 */
  twoItems: string[] = ["已支付", "未支付"];

  /** 多个选项 - 当前索引 */
  @Trace multiIndex: number = 0;
  /** 多个选项 - 选项 */
  multiItems: string[] = ["全部", "待付款", "待发货", "待收货", "已完成"];

  /** button 模式 - 当前索引 */
  @Trace buttonModeIndex: number = 0;
  /** button 模式 - 选项 */
  buttonModeItems: string[] = ["日", "周", "月", "年"];

  /** 自定义颜色 - 当前索引 */
  @Trace colorIndex: number = 0;
  /** 自定义颜色 - 选项 */
  colorItems: string[] = ["推荐", "热门", "最新"];

  /** 自定义颜色 button 模式 - 当前索引 */
  @Trace colorButtonIndex: number = 0;
  /** 自定义颜色 button 模式 - 选项 */
  colorButtonItems: string[] = ["图文", "视频", "音频"];

  /** 禁用状态 - 当前索引 */
  @Trace disabledIndex: number = 1;
  /** 禁用状态 - 选项 */
  disabledItems: string[] = ["选项一", "选项二", "选项三"];
}
