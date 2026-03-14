/**
 * @file TnTheme 主题切换展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";
import {
  TnUISetUIBaseStyle,
  ResourceColorWrapper,
  CustomColorWrapper,
  COLOR_TYPE,
  getRandomHexColor
} from "@tuniao/tn-ui";

/**
 * TnTheme 主题切换展示页面 ViewModel
 */
@ObservedV2
export default class TnThemeViewModel extends BaseViewModel {
  /**
   * 当前自定义颜色值
   */
  @Trace customColor: string = "";

  /**
   * 是否处于自定义主题模式
   */
  @Trace isCustomTheme: boolean = false;

  /**
   * 应用自定义颜色作为 primary 主色
   * @param hex 十六进制颜色字符串，如 "#FF6B6B"
   */
  applyCustomColor(hex: string): void {
    const cleaned = hex.startsWith("#") ? hex : `#${hex}`;
    if (cleaned.length !== 7) {
      return;
    }
    this.customColor = cleaned;
    this.isCustomTheme = true;
    TnUISetUIBaseStyle({
      primary: new CustomColorWrapper(cleaned),
      success: new ResourceColorWrapper(COLOR_TYPE.SUCCESS),
      warning: new ResourceColorWrapper(COLOR_TYPE.WARNING),
      danger: new ResourceColorWrapper(COLOR_TYPE.DANGER),
      error: new ResourceColorWrapper(COLOR_TYPE.ERROR),
      info: new ResourceColorWrapper(COLOR_TYPE.INFO)
    });
  }

  /**
   * 生成并应用随机颜色
   */
  applyRandomColor(): void {
    const randomHex = getRandomHexColor();
    this.applyCustomColor(randomHex);
  }

  /**
   * 恢复默认主题
   */
  restoreDefaultTheme(): void {
    this.isCustomTheme = false;
    this.customColor = "";
    TnUISetUIBaseStyle();
  }
}
