import { BaseViewModel } from "@core/base";
import { ExpandCardItem } from "../models/ExpandCardItem";

/**
 * @file 扩展页面 ViewModel
 * @author Joker.X
 */
@ObservedV2
export default class ExpandViewModel extends BaseViewModel {
  /**
   * 扩展模块卡片数据
   */
  @Trace
  readonly cards: ExpandCardItem[] = [
    {
      title: $r("app.string.main_expand_safe_area_title"),
      description: $r("app.string.main_expand_safe_area_desc"),
      onClick: () => {}
    },
    {
      title: $r("app.string.main_expand_screen_adapt_title"),
      description: $r("app.string.main_expand_screen_adapt_desc"),
      onClick: () => {}
    }
  ];
}
