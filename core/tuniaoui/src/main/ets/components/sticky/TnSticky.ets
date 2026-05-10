/**
 * @file TnSticky 吸顶组件
 * @description 将内容固定在容器顶部，当滚动超过组件位置时自动吸顶
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";

/**
 * TnSticky 吸顶组件
 *
 * 使用方式：将需要吸顶的内容放入 TnSticky 的 defaultBuilder 中，
 * 并将父级 Scroll 的 scrollTop 传入 scrollTop 参数。
 * 组件会在滚动到达其位置时自动吸顶。
 *
 * @example
 * // 基础用法
 * @Local scrollTop: number = 0;
 * Scroll(this.scroller) {
 *   Column() {
 *     Text("普通内容").height(200)
 *     TnSticky({ scrollTop: this.scrollTop }) {
 *       Text("吸顶内容")
 *     }
 *     Text("更多内容...").height(1000)
 *   }
 * }
 * .onDidScroll(() => { this.scrollTop = this.scroller.currentOffset().yOffset; })
 */
@ComponentV2
export struct TnSticky {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType =
    AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /**
   * 是否开启粘性布局
   */
  @Param stickyEnabled: boolean = true;
  /**
   * 父级 Scroll 容器的当前滚动偏移量（yOffset）
   */
  @Param scrollTop: number = 0;
  /**
   * 吸顶时距离顶部的距离（单位 vp）
   */
  @Param offsetTop: number = 0;
  /**
   * 吸顶时的 z-index 层级
   */
  @Param stickyZIndex: number = 10030;
  /**
   * 吸顶时的背景色（吸顶后需要背景色遮挡下方内容）
   */
  @Param bgColor: ResourceColor = $r("app.color.tn_bg_color");
  /**
   * 吸顶状态变化回调
   */
  @Event onChange: (fixed: boolean) => void = (_fixed: boolean) => {};
  /**
   * 默认插槽内容
   */
  @BuilderParam defaultBuilder: () => void = this.emptyBuilder;
  /**
   * 当前是否处于吸顶状态
   */
  @Local private isFixed: boolean = false;
  /**
   * 组件内容高度（用于占位）
   */
  @Local private contentHeight: number = 0;
  /**
   * 组件在滚动容器中的初始 Y 位置（相对于滚动内容顶部）
   */
  @Local private originTop: number = -1;
  /**
   * 吸顶时需要的 Y 轴偏移补偿
   */
  @Local private fixedTranslateY: number = 0;

  @Builder
  private emptyBuilder(): void {}

  @Monitor("scrollTop")
  onScrollTopChange(): void {
    this.updateStickyState();
  }

  @Monitor("stickyEnabled")
  onEnabledChange(): void {
    if (!this.stickyEnabled && this.isFixed) {
      this.isFixed = false;
      this.fixedTranslateY = 0;
      this.onChange(false);
    }
  }

  /**
   * 计算并更新吸顶状态
   */
  private updateStickyState(): void {
    if (!this.stickyEnabled || this.originTop < 0) {
      return;
    }
    const threshold: number = this.originTop - this.offsetTop;
    const shouldFixed: boolean = this.scrollTop >= threshold;
    if (shouldFixed) {
      this.fixedTranslateY = this.scrollTop - threshold;
    } else {
      this.fixedTranslateY = 0;
    }
    if (shouldFixed !== this.isFixed) {
      this.isFixed = shouldFixed;
      this.onChange(this.isFixed);
    }
  }

  build() {
    Column() {
      this.defaultBuilder();
    }
    .width("100%")
    .zIndex(this.isFixed ? this.stickyZIndex : 0)
    .backgroundColor(this.isFixed ? this.bgColor : undefined)
    .shadow(this.isFixed ? {
      radius: this.baseStyle.shadowSm.radius,
      color: $r("app.color.tn_shadow_light"),
      offsetX: this.baseStyle.shadowSm.offsetX,
      offsetY: this.baseStyle.shadowSm.offsetY
    } : { radius: 0, color: Color.Transparent, offsetX: 0, offsetY: 0 })
    .animation({ duration: this.baseStyle.animationDuration })
    .translate({ y: this.fixedTranslateY })
    .animation(null)
    .onAreaChange((_oldValue: Area, newValue: Area) => {
      const h = newValue.height as number;
      if (h > 0) {
        this.contentHeight = h;
      }
      if (this.originTop < 0 && !this.isFixed) {
        const pos = newValue.position;
        if (pos) {
          const y = pos.y as number;
          if (y >= 0) {
            this.originTop = y;
          }
        }
      }
    })
  }
}
