/**
 * @file 阴影分级类型定义
 * @description 阴影级别配置接口和数据接口
 * @author JunBin.Yang
 */

/**
 * 单个阴影级别的配置
 */
export interface ShadowLevelConfig {
  /** 模糊半径 */
  radius: number;
  /** 水平偏移 */
  offsetX: number;
  /** 垂直偏移 */
  offsetY: number;
}

/**
 * 阴影数据接口，包含 4 个级别
 */
export interface ShadowData {
  /** 微小阴影 */
  shadowSm: ShadowLevelConfig;
  /** 默认阴影 */
  shadowDefault: ShadowLevelConfig;
  /** 中等阴影 */
  shadowMd: ShadowLevelConfig;
  /** 大阴影 */
  shadowLg: ShadowLevelConfig;
}
