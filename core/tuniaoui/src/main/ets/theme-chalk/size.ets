import { TnUIInitializer } from "..";
import { getSizeByUnit } from "../utils/Utils";

/**
 * 生成百分比字符串（如 "33.33%"），不使用 calc()
 * @param n 分子（整数）
 * @param d 分母（正整数）
 * @param precision 小数位数，默认 2（CSS 中 2 位足够）
 * @returns 百分比字符串，如 "50.00%", "33.33%"
 */
function widthPercent(n: number, d: number, precision: number = 2): string {
  if (d <= 0) throw new Error("Denominator must be positive");
  if (!Number.isInteger(n) || !Number.isInteger(d)) {
    throw new Error("Numerator and denominator must be integers");
  }

  const value = (n / d) * 100;
  // toFixed 返回字符串，且会四舍五入
  return `${value.toFixed(precision)}%`;
}

/**
 * Tuniao UI 内置的宽度和高度
 */
export const tn_w_full = "100%";
export const tn_w_auto = "auto";
export const tn_w_screen = () => {
  return getSizeByUnit(TnUIInitializer.screenWidth);
};
export const tn_w = widthPercent;

export const tn_h_full = "100%";
export const tn_h_auto = "auto";
export const tn_h_screen = () => {
  return getSizeByUnit(TnUIInitializer.screenHeight);
};
export const tn_h = widthPercent;