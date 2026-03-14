/**
 * @file 颜色计算工具函数，用于自定义颜色的解析、混合和变种色生成
 * @author JunBin.Yang
 */

import { ContextUtil } from "./ContextUtil";

/**
 * RGB 颜色通道数组类型
 */
type RgbTuple = [number, number, number];

/**
 * 将 hex 颜色字符串解析为 RGB 通道数组
 * @param hex 十六进制颜色字符串，如 "#FF6B6B" 或 "FF6B6B"
 * @returns RGB 通道数组 [r, g, b]，解析失败返回 null
 */
export function hexToRgb(hex: string): RgbTuple | null {
  const cleaned = hex.replace(/^#/, "");
  if (cleaned.length !== 6) {
    return null;
  }
  const r = parseInt(cleaned.substring(0, 2), 16);
  const g = parseInt(cleaned.substring(2, 4), 16);
  const b = parseInt(cleaned.substring(4, 6), 16);
  if (isNaN(r) || isNaN(g) || isNaN(b)) {
    return null;
  }
  const result: RgbTuple = [r, g, b];
  return result;
}

/**
 * 将 RGB 通道值转换为 hex 颜色字符串
 * @param r 红色通道 0-255
 * @param g 绿色通道 0-255
 * @param b 蓝色通道 0-255
 * @returns 带 # 前缀的十六进制颜色字符串
 */
export function rgbToHex(r: number, g: number, b: number): string {
  const clamp = (v: number): number => Math.max(0, Math.min(255, Math.round(v)));
  const toHexPart = (v: number): string => {
    const hexStr = clamp(v).toString(16);
    return hexStr.length === 1 ? `0${hexStr}` : hexStr;
  };
  return `#${toHexPart(r)}${toHexPart(g)}${toHexPart(b)}`;
}

/**
 * 将颜色与白色按比例混合（生成浅色变种）
 * @param hex 基础颜色 hex 字符串
 * @param ratio 混合比例 0-1，值越大越接近白色
 * @returns 混合后的 hex 颜色字符串
 */
export function mixWithWhite(hex: string, ratio: number = 0.2): string {
  const rgb = hexToRgb(hex);
  if (rgb === null) {
    return hex;
  }
  const r = rgb[0] + (255 - rgb[0]) * ratio;
  const g = rgb[1] + (255 - rgb[1]) * ratio;
  const b = rgb[2] + (255 - rgb[2]) * ratio;
  return rgbToHex(r, g, b);
}

/**
 * 将颜色与黑色按比例混合（生成深色变种）
 * @param hex 基础颜色 hex 字符串
 * @param ratio 混合比例 0-1，值越大越接近黑色
 * @returns 混合后的 hex 颜色字符串
 */
export function mixWithBlack(hex: string, ratio: number = 0.2): string {
  const rgb = hexToRgb(hex);
  if (rgb === null) {
    return hex;
  }
  const r = rgb[0] * (1 - ratio);
  const g = rgb[1] * (1 - ratio);
  const b = rgb[2] * (1 - ratio);
  return rgbToHex(r, g, b);
}

/**
 * 生成随机 hex 颜色字符串
 * @returns 带 # 前缀的随机十六进制颜色字符串
 */
export function getRandomHexColor(): string {
  const r = Math.floor(Math.random() * 256);
  const g = Math.floor(Math.random() * 256);
  const b = Math.floor(Math.random() * 256);
  return rgbToHex(r, g, b);
}

export function convertToHex(decimalColor: number): string {
  const hexValue = decimalColor.toString(16).padStart(8, '0').toUpperCase();
  return `#${hexValue.slice(2)}`; // 去除透明度部分（前两位）
}

/**
 * 判断是否为资源引用类型
 * @returns 是否为资源引用类型
 */
function isResource(value: ResourceColor): boolean {
  return (value as Resource)?.id !== undefined;
}

/**
 * 安全获取资源颜色值
 * @returns 颜色字符串代码
 */
export function getHexColorByResoure(color: ResourceColor): string {
  // 直接传入字符串（如 "#FFFFF"）
  if (typeof color === 'string') {
    return color;
  }

  // 传入资源引用（如 $r("app.color.xxx")）
  if (isResource(color)) {
    const context = ContextUtil.getUIAbilityCtx();
    const decimalColor = context.resourceManager.getColorSync((color as Resource).id);
    return convertToHex(decimalColor);
  }

  // 默认回退值
  return '#000000';
}