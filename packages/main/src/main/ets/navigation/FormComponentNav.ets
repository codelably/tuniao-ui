/**
 * @file 表单组件页面导航构建器
 * @description TuniaoUI 表单组件展示页面路由注册
 * @author JunBin.Yang
 */

import { TnSwitchPage } from '../view/TnSwitchPage';
import { TnRadioPage } from '../view/TnRadioPage';
import { TnCheckboxPage } from '../view/TnCheckboxPage';
import { TnRatePage } from '../view/TnRatePage';
import { TnInputPage } from '../view/TnInputPage';
import { TnNumberBoxPage } from '../view/TnNumberBoxPage';
import { TnSliderPage } from '../view/TnSliderPage';
import { TnPickerPage } from '../view/TnPickerPage';
import { TnDateTimePickerPage } from '../view/TnDateTimePickerPage';
import { TnRegionPickerPage } from '../view/TnRegionPickerPage';
import { TnImageUploadPage } from '../view/TnImageUploadPage';
import { TnCalendarPage } from '../view/TnCalendarPage';
import { TnWeekCalendarPage } from '../view/TnWeekCalendarPage';
import { TnFormPage } from '../view/TnFormPage';
import { TnImagePreviewPage } from '../view/TnImagePreviewPage';

/**
 * 开关页面导航入口
 */
@Builder
export function TnSwitchNav(): void {
  TnSwitchPage();
}

export const TnSwitchNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnSwitchNav);

/**
 * 单选框页面导航入口
 */
@Builder
export function TnRadioNav(): void {
  TnRadioPage();
}

export const TnRadioNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnRadioNav);

/**
 * 复选框页面导航入口
 */
@Builder
export function TnCheckboxNav(): void {
  TnCheckboxPage();
}

export const TnCheckboxNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnCheckboxNav);

/**
 * 评分页面导航入口
 */
@Builder
export function TnRateNav(): void {
  TnRatePage();
}

export const TnRateNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnRateNav);

/**
 * 输入框页面导航入口
 */
@Builder
export function TnInputNav(): void {
  TnInputPage();
}

export const TnInputNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnInputNav);

/**
 * 步进器页面导航入口
 */
@Builder
export function TnNumberBoxNav(): void {
  TnNumberBoxPage();
}

export const TnNumberBoxNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnNumberBoxNav);

/**
 * 滑块页面导航入口
 */
@Builder
export function TnSliderNav(): void {
  TnSliderPage();
}

export const TnSliderNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnSliderNav);

/**
 * 选择器页面导航入口
 */
@Builder
export function TnPickerNav(): void {
  TnPickerPage();
}

export const TnPickerNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnPickerNav);

/**
 * 日期时间选择器页面导航入口
 */
@Builder
export function TnDateTimePickerNav(): void {
  TnDateTimePickerPage();
}

export const TnDateTimePickerNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnDateTimePickerNav);

/**
 * 地区选择器页面导航入口
 */
@Builder
export function TnRegionPickerNav(): void {
  TnRegionPickerPage();
}

export const TnRegionPickerNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnRegionPickerNav);

/**
 * 图片上传页面导航入口
 */
@Builder
export function TnImageUploadNav(): void {
  TnImageUploadPage();
}

export const TnImageUploadNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnImageUploadNav);

/**
 * 日历页面导航入口
 */
@Builder
export function TnCalendarNav(): void {
  TnCalendarPage();
}

export const TnCalendarNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnCalendarNav);

/**
 * 周日历页面导航入口
 */
@Builder
export function TnWeekCalendarNav(): void {
  TnWeekCalendarPage();
}

export const TnWeekCalendarNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnWeekCalendarNav);

/**
 * 表单页面导航入口
 */
@Builder
export function TnFormNav(): void {
  TnFormPage();
}

export const TnFormNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnFormNav);

/**
 * 图片预览页面导航入口
 */
@Builder
export function TnImagePreviewNav(): void {
  TnImagePreviewPage();
}

export const TnImagePreviewNavWrapper: WrappedBuilder<[]> = wrapBuilder(TnImagePreviewNav);
