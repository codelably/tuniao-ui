/**
 * @file TnSwitchTab 选项卡切换组件类型定义
 * @description 定义 TnSwitchTab 组件的属性接口和类型别名
 * @author JunBin.Yang
 */

/**
 * TnSwitchTab 组件属性接口
 */
export interface TnSwitchTabProps {
  /**
   * 当前激活的选项卡索引
   * @default 0
   */
  modelValue?: number;
  /**
   * 选项卡标签数组
   * @default []
   */
  tabs?: string[];
  /**
   * 是否禁用切换
   * @default false
   */
  disabled?: boolean;
  /**
   * 非激活选项卡背景色
   * @default 主题色浅色变种
   */
  inactiveBgColor?: ResourceColor;
  /**
   * 激活选项卡背景色
   * @default 白色
   */
  activeBgColor?: ResourceColor;
  /**
   * 非激活选项卡文字颜色
   * @default 主要文字色
   */
  inactiveTextColor?: ResourceColor;
  /**
   * 激活选项卡文字颜色
   * @default 主要文字色
   */
  activeTextColor?: ResourceColor;
}
