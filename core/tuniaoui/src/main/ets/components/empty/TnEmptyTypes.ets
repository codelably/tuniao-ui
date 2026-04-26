/**
 * @file TnEmpty 组件类型定义
 * @description 空白页组件的参数类型定义
 * @author JunBin.Yang
 */

/**
 * 空白页模式类型
 * - cart: 购物车为空
 * - page: 页面不存在
 * - search: 搜索结果为空
 * - address: 地址为空
 * - network: 网络不通
 * - order: 订单为空
 * - coupon: 优惠券为空
 * - favor: 暂无收藏
 * - permission: 无权限
 * - history: 历史记录为空
 * - message: 暂无消息
 * - list: 列表为空
 * - data: 暂无数据
 * - comment: 暂无评论
 */
export type TnEmptyMode =
  "cart" | "page" | "search" | "address" | "network" |
  "order" | "coupon" | "favor" | "permission" | "history" |
  "message" | "list" | "data" | "comment";

/**
 * 空白页预设尺寸类型
 * - sm: 小尺寸
 * - lg: 大尺寸
 * - xl: 超大尺寸
 */
export type TnEmptySizeType = "sm" | "lg" | "xl";

/**
 * 各模式对应的默认提示文案
 */
export const TN_EMPTY_DEFAULT_TIPS: Record<string, string> = {
  "cart": "购物车为空",
  "page": "页面不存在",
  "search": "搜索结果为空",
  "address": "地址为空",
  "network": "网络不通",
  "order": "订单为空",
  "coupon": "优惠券为空",
  "favor": "暂无收藏",
  "permission": "无权限",
  "history": "历史记录为空",
  "message": "暂无消息",
  "list": "列表为空",
  "data": "暂无数据",
  "comment": "暂无评论",
};

/**
 * TnEmpty 组件参数接口
 */
export interface TnEmptyProps {
  /**
   * 空白提示类型
   */
  mode?: TnEmptyMode;
  /**
   * 内容颜色
   */
  color?: ResourceColor;
  /**
   * 内容尺寸（预设值 "sm" | "lg" | "xl" 或自定义数值）
   */
  emptySize?: TnEmptySizeType | number;
  /**
   * 是否显示提示文字
   */
  showTips?: boolean;
  /**
   * 自定义提示文案（优先于默认提示）
   */
  tips?: string;
}
