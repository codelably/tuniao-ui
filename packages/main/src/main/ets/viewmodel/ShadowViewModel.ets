/**
 * @file 阴影展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";
import { TnUIGetUIBaseStyle, TnShadowLevelType } from "@tuniao/tn-ui";
import { ShadowLevelConfig } from "@tuniao/tn-ui/src/main/ets/theme-chalk/shadow.type";

/**
 * 阴影项数据模型
 */
export class ShadowItem {
  /** 阴影级别名称 */
  name: string;
  /** 阴影级别描述 */
  description: string;
  /** 阴影级别标识 */
  level: TnShadowLevelType;
  /** 阴影配置 */
  config: ShadowLevelConfig;

  constructor(name: string, description: string, level: TnShadowLevelType, config: ShadowLevelConfig) {
    this.name = name;
    this.description = description;
    this.level = level;
    this.config = config;
  }
}

/**
 * 阴影展示页面 ViewModel
 */
@ObservedV2
export default class ShadowViewModel extends BaseViewModel {
  /**
   * 获取阴影级别列表
   * @returns 阴影项数组
   */
  getShadowItems(): ShadowItem[] {
    const baseStyle = TnUIGetUIBaseStyle();

    return [
      new ShadowItem("shadow-sm", "微小阴影，适用于开关滑块、小按钮", "sm", baseStyle.shadowSm),
      new ShadowItem("shadow-default", "默认阴影，适用于卡片、浮层", "default", baseStyle.shadowDefault),
      new ShadowItem("shadow-md", "中等阴影，适用于弹窗、下拉菜单", "md", baseStyle.shadowMd),
      new ShadowItem("shadow-lg", "大阴影，适用于模态面板、底部弹出", "lg", baseStyle.shadowLg),
    ];
  }
}
