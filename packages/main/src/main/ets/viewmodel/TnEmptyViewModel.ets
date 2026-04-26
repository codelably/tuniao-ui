/**
 * @file TnEmpty 空白页展示页面 ViewModel
 * @author JunBin.Yang
 */
import { BaseViewModel } from "@core/base";
import { TnEmptyMode } from "@tuniao/tn-ui";

@ObservedV2
export default class TnEmptyViewModel extends BaseViewModel {
  /** 所有模式列表 */
  readonly allModes: TnEmptyMode[] = [
    "cart", "page", "search", "address", "network",
    "order", "coupon", "favor", "permission", "history",
    "message", "list", "data", "comment"
  ];

  /** 模式对应的中文名称 */
  readonly modeLabels: Record<string, string> = {
    "cart": "购物车",
    "page": "页面",
    "search": "搜索",
    "address": "地址",
    "network": "网络",
    "order": "订单",
    "coupon": "优惠券",
    "favor": "收藏",
    "permission": "权限",
    "history": "历史",
    "message": "消息",
    "list": "列表",
    "data": "数据",
    "comment": "评论"
  };

  /** 当前选中的模式（用于切换演示） */
  @Trace currentMode: TnEmptyMode = "data";

  /** 当前选中的尺寸索引 */
  @Trace currentSizeIndex: number = 0;

  /** 尺寸选项 */
  readonly sizeOptions: string[] = ["默认", "sm", "lg", "xl"];
}
