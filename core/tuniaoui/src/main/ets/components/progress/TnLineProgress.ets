/**
 * @file TnLineProgress 线形进度条组件
 * @description 线形进度条，支持主题色、进度文字内外显示、自定义高度等
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { TnComponentColorType, getThemeColor, THEME_COLOR_NAMES, getFontSizeByKey } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { convertDimensionsWidthUnit, getSizeByUnit } from "../../utils/Utils";

/**
 * TnLineProgress 线形进度条组件
 *
 * @example
 * // 基础用法
 * TnLineProgress({ percent: 50 })
 *
 * // 显示进度文字
 * TnLineProgress({ percent: 30, showPercent: true })
 *
 * // 进度文字在内部
 * TnLineProgress({ percent: 70, showPercent: true, textInside: true, height: 20 })
 */
@ComponentV2
export struct TnLineProgress {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  /** 当前进度百分比，0-100 */
  @Param percent: number = 0;
  /** 激活时的颜色（主题色名或自定义颜色值） */
  @Param activeColor: string = "";
  /** 未激活时的颜色 */
  @Param inactiveColor: string = "";
  /** 是否显示进度文字 */
  @Param showPercent: boolean = false;
  /** 进度文字显示在进度条内部 */
  @Param textInside: boolean = false;
  /** 进度条高度(vp) */
  @Param barHeight: number = 12;
  /** 动画执行时间(ms)，0 表示使用主题默认值 */
  @Param duration: number = 0;
  /** 格式化进度文本函数 */
  @Param format: ((percent: number) => string) | null = null;
  /** 进度到达 100 时的回调 */
  @Event onComplete: () => void = () => {};

  /**
   * 获取安全的进度值（限制在 0-100）
   * @returns 规范化后的进度值
   */
  private getSafePercent(): number {
    return Math.min(100, Math.max(0, this.percent));
  }

  /**
   * 获取激活色
   * @returns 激活颜色值
   */
  private getActiveColor(): ResourceColor {
    if (this.activeColor.length > 0) {
      if (THEME_COLOR_NAMES.includes(this.activeColor)) {
        return getThemeColor(this.baseStyle, this.activeColor as TnComponentColorType);
      }
      return this.activeColor;
    }
    return getThemeColor(this.baseStyle, "primary");
  }

  /**
   * 获取未激活色
   * @returns 未激活颜色值
   */
  private getInactiveColor(): ResourceColor {
    if (this.inactiveColor.length > 0) {
      return this.inactiveColor;
    }
    return $r("app.color.tn_color_gray_disabled");
  }

  /**
   * 获取进度文本
   * @returns 格式化后的进度文本
   */
  private getText(): string {
    const safePercent: number = this.getSafePercent();
    if (this.format !== null) {
      return this.format(safePercent);
    }
    return `${safePercent}%`;
  }

  /**
   * 获取进度条宽度百分比
   * @returns 进度条宽度百分比字符串
   */
  private getProgressWidth(): string {
    return `${this.getSafePercent()}%`;
  }

  @Monitor("percent")
  onPercentChange(): void {
    if (this.getSafePercent() >= 100) {
      this.onComplete();
    }
  }

  build() {
    Row() {
      // 进度条轨道
      Stack({ alignContent: Alignment.Start }) {
        // 背景轨道
        Row()
          .width("100%")
          .height("100%")
          .backgroundColor(this.getInactiveColor());

        // 激活进度
        Stack({ alignContent: Alignment.End }) {
          Row()
            .width("100%")
            .height("100%")
            .backgroundColor(this.getActiveColor());

          // 内部文字
          if (this.showPercent && this.textInside && this.getSafePercent() > 0) {
            Text(this.getText())
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXxs"))
              .fontColor($r("app.color.tn_color_white"))
              .margin({ right: this.baseStyle.spaceBase })
              .maxLines(1);
          }
        }
        .width(this.getProgressWidth())
        .height("100%")
        .borderRadius(this.baseStyle.borderRadiusMax)
        .clip(true)
        .animation({
          duration: this.duration > 0 ? this.duration : this.baseStyle.animationDuration,
          curve: Curve.EaseOut
        });
      }
      .layoutWeight(1)
      .height(getSizeByUnit(this.barHeight))
      .borderRadius(this.baseStyle.borderRadiusMax)
      .clip(true);

      // 外部文字
      if (this.showPercent && !this.textInside) {
        Text(this.getText())
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
          .fontColor($r("app.color.tn_text_color_secondary"))
          .constraintSize({ minWidth: convertDimensionsWidthUnit(36) })
          .textAlign(TextAlign.End)
          .margin({ left: this.baseStyle.spaceXsm });
      }
    }
    .width("100%");
  }
}
