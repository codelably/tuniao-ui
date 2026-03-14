import { IBestCell, IBestCellGroup } from "@core/ibestui";
import {
  ColumnBase,
  MediumPaddingVerticalScroll,
  P100,
  P80,
  SpaceVerticalLarge,
  SpaceVerticalSmall
} from "@core/designsystem";
import { AppNavDestination } from "@core/components";
import TnComponentsViewModel from "../viewmodel/TnComponentsViewModel";
import { CoreCardItem } from "../models/CoreCardItem";
import { ComponentGroupItem } from "../models/ComponentGroupItem";
import { getWindowSafeAreaState, WindowSafeAreaState } from "@core/layoutstate";
import { DemoCounterState, getDemoCounterState } from "@shared/state";

/**
 * @file 组件演示页面视图
 * @author Joker.X
 */
@ComponentV2
export struct TnComponentsPage {
  /**
   * 组件演示页面 ViewModel
   */
  @Local
  private vm: TnComponentsViewModel = new TnComponentsViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();
  /**
   * 全局计数器状态
   */
  @Local
  private counterState: DemoCounterState = getDemoCounterState();

  /**
   * 构建核心页面
   * @returns {void} 无返回值
   */
  build() {
    AppNavDestination({
      title: $r("app.string.component"),
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.CoreContent();
    }
  }

  /**
   * 核心页面内容视图
   * @returns {void} 无返回值
   */
  @Builder
  private CoreContent() {
    MediumPaddingVerticalScroll() {
      ColumnBase({ widthValue: P100 }) {
        if (this.counterState.count > 0) {
          this.CounterCard();
          SpaceVerticalLarge();
        }

        ForEach(this.vm.groups, (group: ComponentGroupItem, groupIndex: number) => {
          this.GroupCard(group);
          if (groupIndex < this.vm.groups.length - 1) {
            SpaceVerticalLarge();
          }
        }, (group: ComponentGroupItem) => group.title);
      };
    };
  }

  /**
   * 分组卡片
   * @param {ComponentGroupItem} group - 分组项
   * @returns {void} 无返回值
   */
  @Builder
  private GroupCard(group: ComponentGroupItem): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        // 分组标题
        Text(group.title)
          .fontSize($r("app.float.headline_medium"))
          .fontColor($r("app.color.text_primary"))
          .fontWeight(FontWeight.Bold);

        SpaceVerticalSmall();

        Text(group.description)
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalSmall();
      };

      // 分组内的卡片列表
      IBestCellGroup({ inset: true, outerMargin: 0 }) {
        ForEach(group.cards, (item: CoreCardItem, index: number) => {
          IBestCell({
            title: item.title,
            label: item.description,
            isLink: true,
            leftContentWidth: P80,
            hasBorder: index !== group.cards.length - 1,
            onCellClick: () => item.onClick()
          });
        }, (item: CoreCardItem) => item.title);
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 计数器卡片
   * @returns {void} 无返回值
   */
  @Builder
  private CounterCard(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text($r("app.string.main_core_counter_label"))
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalSmall();

        Text(`${this.counterState.count}`)
          .fontSize($r("app.float.display_large"))
          .fontColor($r("app.color.text_primary"))
          .fontWeight(FontWeight.Bold);
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }
}
