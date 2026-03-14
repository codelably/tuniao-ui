/**
 * @file 阴影分级枚举
 * @description 定义组件阴影的 4 个级别（sm / default / md / lg）
 * @author JunBin.Yang
 */

export enum SHADOW {
  /** 微小阴影（开关滑块、小按钮） */
  SM = 0,
  /** 默认阴影（卡片、浮层） */
  DEFAULT = 1,
  /** 中等阴影（弹窗、下拉菜单） */
  MD = 2,
  /** 大阴影（模态面板、底部弹出） */
  LG = 3,
}
