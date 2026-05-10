/**
 * @file TnSwitchTab 选项卡切换展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";

@ObservedV2
export default class TnSwitchTabViewModel extends BaseViewModel {
  /**
   * 基础用法当前选中索引
   */
  @Trace basicIndex: number = 0;
  /**
   * 基础选项卡标签
   */
  @Trace basicTabs: string[] = ["选项一", "选项二", "选项三"];
  /**
   * 自定义颜色当前选中索引
   */
  @Trace colorIndex: number = 0;
  /**
   * 自定义颜色选项卡标签
   */
  @Trace colorTabs: string[] = ["推荐", "热门", "最新"];
  /**
   * 两个选项卡当前选中索引
   */
  @Trace twoTabIndex: number = 0;
  /**
   * 两个选项卡标签
   */
  @Trace twoTabs: string[] = ["左侧", "右侧"];
  /**
   * 多选项卡当前选中索引
   */
  @Trace multiTabIndex: number = 0;
  /**
   * 多选项卡标签
   */
  @Trace multiTabs: string[] = ["首页", "分类", "发现", "购物车", "我的"];
  /**
   * 禁用状态当前选中索引
   */
  @Trace disabledIndex: number = 1;
  /**
   * 禁用状态选项卡标签
   */
  @Trace disabledTabs: string[] = ["选项A", "选项B", "选项C"];
  /**
   * 自定义背景色当前选中索引
   */
  @Trace bgColorIndex: number = 0;
  /**
   * 自定义背景色选项卡标签
   */
  @Trace bgColorTabs: string[] = ["全部", "进行中", "已完成"];
}
