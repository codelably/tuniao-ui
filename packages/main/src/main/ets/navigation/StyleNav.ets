/**
 * @file 样式页面导航构建器
 * @description 样式相关页面路由注册（主题颜色、内置颜色、渐变背景、字体、间距、尺寸）
 * @author JunBin.Yang
 */

import { StylePage } from '../view/StylePage';
import { BuiltInColorPage } from '../view/BuiltInColorPage';
import { GradientBackgroundPage } from '../view/GradientBackgroundPage';
import { FontSizePage } from '../view/FontSizePage';
import { SpacingPage } from '../view/SpacingPage';
import { SizePage } from '../view/SizePage';
import { TnThemePage } from '../view/TnThemePage';
import { ShadowPage } from '../view/ShadowPage';
import { BlurEffectPage } from '../view/BlurEffectPage';

/**
 * 主题颜色页面导航入口
 * @returns {void} 无返回值
 */
@Builder
export function ThemeColorNav(): void {
  StylePage();
}

/**
 * 内置颜色页面导航入口
 * @returns {void} 无返回值
 */
@Builder
export function BuiltInColorNav(): void {
  BuiltInColorPage();
}

/**
 * 渐变背景页面导航入口
 * @returns {void} 无返回值
 */
@Builder
export function GradientBackgroundNav(): void {
  GradientBackgroundPage();
}

/**
 * 字体大小页面导航入口
 * @returns {void} 无返回值
 */
@Builder
export function FontSizeNav(): void {
  FontSizePage();
}

/**
 * 间距页面导航入口
 * @returns {void} 无返回值
 */
@Builder
export function SpacingNav(): void {
  SpacingPage();
}

/**
 * 尺寸页面导航入口
 * @returns {void} 无返回值
 */
@Builder
export function SizeNav(): void {
  SizePage();
}

/**
 * 主题切换页面导航入口
 * @returns {void} 无返回值
 */
@Builder
export function TnThemeNav(): void {
  TnThemePage();
}

/**
 * 阴影页面导航入口
 * @returns {void} 无返回值
 */
@Builder
export function ShadowNav(): void {
  ShadowPage();
}

/**
 * 毛玻璃效果页面导航入口
 * @returns {void} 无返回值
 */
@Builder
export function BlurEffectNav(): void {
  BlurEffectPage();
}

/**
 * 导出包装后的构建器
 */
export const ThemeColorNavWrapper: WrappedBuilder<[]> = wrapBuilder(ThemeColorNav);
export const BuiltInColorNavWrapper: WrappedBuilder<[]> = wrapBuilder(BuiltInColorNav);
export const GradientBackgroundNavWrapper: WrappedBuilder<[]> = wrapBuilder(GradientBackgroundNav);
export const FontSizeNavWrapper: WrappedBuilder<[]> = wrapBuilder(FontSizeNav);
export const SpacingNavWrapper: WrappedBuilder<[]> = wrapBuilder(SpacingNav);
export const SizeNavWrapper: WrappedBuilder<[]> = wrapBuilder(SizeNav);
export const TnThemeNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnThemeNav);
export const ShadowNavWrapper: WrappedBuilder<[]> = wrapBuilder(ShadowNav);
export const BlurEffectNavWrapper: WrappedBuilder<[]> = wrapBuilder(BlurEffectNav);
