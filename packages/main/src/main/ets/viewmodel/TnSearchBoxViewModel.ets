/**
 * @file TnSearchBox 搜索框示例 ViewModel
 * @description 管理搜索框示例页面的状态数据
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

@ObservedV2
export default class TnSearchBoxViewModel extends BaseViewModel {
  /** 基础用法 - 输入值 */
  @Trace basicValue: string = "";

  /** 圆形搜索框 - 输入值 */
  @Trace roundValue: string = "";

  /** 自定义占位文本 - 输入值 */
  @Trace placeholderValue: string = "";

  /** 禁用状态 - 输入值 */
  @Trace disabledValue: string = "禁用状态";

  /** 无边框 - 输入值 */
  @Trace noBorderValue: string = "";

  /** 无搜索按钮 - 输入值 */
  @Trace noButtonValue: string = "";

  /** 自定义搜索按钮 - 输入值 */
  @Trace customButtonValue: string = "";

  /** 自定义颜色 - 输入值 */
  @Trace customColorValue: string = "";

  /** 不同尺寸 sm - 输入值 */
  @Trace smValue: string = "";

  /** 不同尺寸 lg - 输入值 */
  @Trace lgValue: string = "";

  /** 不同尺寸 xl - 输入值 */
  @Trace xlValue: string = "";

  /** 清除按钮始终显示 - 输入值 */
  @Trace clearAlwaysValue: string = "可清除内容";

  /** 文字居中 - 输入值 */
  @Trace centerValue: string = "";

  /** 搜索结果 */
  @Trace searchResult: string = "";
}
