/**
 * @file TnRegionPicker 地区选择器类型定义
 * @author JunBin.Yang
 */

import { RegionItem } from "./data/region";

/**
 * TnRegionPicker 组件属性接口
 */
export interface TnRegionPickerProps {
  /** 绑定值（地区名称数组 [省, 市, 区]） */
  modelValue?: string[];
  /** 显示/隐藏 */
  open?: boolean;
  /** 标题 */
  title?: string;
  /** 自定义地区数据，不传则使用内置 REGION_DATA */
  customData?: RegionItem[];
  /** 确认回调，names 为地区名称数组，codes 为区域编码数组 */
  onConfirm?: (names: string[], codes: string[]) => void;
  /** 取消回调 */
  onCancel?: () => void;
  /** 关闭回调 */
  onClose?: () => void;
  /** 变化回调，names 为地区名称数组，codes 为区域编码数组 */
  onChange?: (names: string[], codes: string[]) => void;
}
