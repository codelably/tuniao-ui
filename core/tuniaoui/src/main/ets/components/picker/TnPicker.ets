/**
 * @file TnPicker 选择器组件
 * @description 基于 BindSheet 半模态面板 + TextPicker 系统组件实现的选择器，支持单列、多列和联动模式
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { getThemeColor, getFontSizeByKey } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { TnPickerColumnItem, TnPickerValueType } from "./TnPickerTypes";
import { convertDimensionsWidthUnit } from "../../utils/Utils";
import { getHexColorByResoure, mixWithBlack } from "../../utils/ColorUtils";

/**
 * TnPicker 选择器组件
 *
 * @example
 * // 单列
 * TnPicker({
 *   open: true,
 *   data: [[{ label: "A", value: "a" }]],
 *   onConfirm: (value, index) => {},
 *   onClose: () => {}
 * })
 * // 多列
 * TnPicker({
 *   open: true,
 *   data: [[{ label: "A", value: "a" }], [{ label: "X", value: "x" }]],
 *   onConfirm: (value, index) => {},
 *   onClose: () => {}
 * })
 * // 联动
 * TnPicker({
 *   open: true,
 *   cascadeData: [{ label: "省", value: "p", children: [...] }],
 *   onConfirm: (value, index) => {},
 *   onClose: () => {}
 * })
 */
@ComponentV2
export struct TnPicker {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  /** 绑定值 */
  @Param modelValue: TnPickerValueType = "";
  /** 显示/隐藏 */
  @Param open: boolean = false;
  /** 列数据（单列或多列） */
  @Param data: TnPickerColumnItem[][] = [];
  /** 级联数据（联动选择器） */
  @Param cascadeData: TnPickerColumnItem[] = [];
  /** 显示取消按钮 */
  @Param showCancel: boolean = true;
  /** 取消按钮文字 */
  @Param cancelText: string = "取消";
  /** 显示确认按钮 */
  @Param showConfirm: boolean = true;
  /** 确认按钮文字 */
  @Param confirmText: string = "确定";
  /** 标题 */
  @Param title: string = "";

  /** 确认回调 */
  @Event onConfirm: (value: TnPickerValueType, index: number | number[]) => void =
    (_value: TnPickerValueType, _index: number | number[]): void => {};
  /** 取消回调 */
  @Event onCancel: () => void = (): void => {};
  /** 关闭回调 */
  @Event onClose: () => void = (): void => {};
  /** 列值变化回调 */
  @Event onChange: (value: TnPickerValueType, index: number | number[]) => void =
    (_value: TnPickerValueType, _index: number | number[]): void => {};

  /** 当前选中的索引（单列模式） */
  @Local private selectedIndex: number = 0;
  /** 当前选中的索引（多列模式） */
  @Local private selectedIndices: number[] = [];

  aboutToAppear(): void {
    this.initSelectedIndices();
  }

  /**
   * 监听 data 变化，重新初始化多列选中索引
   */
  @Monitor("data")
  onDataChange(): void {
    this.initSelectedIndices();
  }

  /**
   * 判断是否为联动模式
   * @returns 是否为联动模式
   */
  private isCascadeMode(): boolean {
    return this.cascadeData.length > 0;
  }

  /**
   * 判断是否为多列模式
   * @returns 是否为多列模式
   */
  private isMultiColumnMode(): boolean {
    return this.data.length > 1;
  }

  /**
   * 获取单列 TextPicker 的 range 数据
   * @returns 字符串数组
   */
  private getSingleRangeData(): string[] {
    if (this.data.length === 0) {
      return [];
    }
    return this.data[0].map((item: TnPickerColumnItem): string => item.label);
  }

  /**
   * 获取多列 TextPicker 的 range 数据
   * @returns 二维字符串数组
   */
  private getMultiRangeData(): string[][] {
    const result: string[][] = [];
    for (let i = 0; i < this.data.length; i++) {
      const col: string[] = this.data[i].map((item: TnPickerColumnItem): string => item.label);
      result.push(col);
    }
    return result;
  }

  /**
   * 递归转换级联数据为 TextCascadePickerRangeContent
   * @param items 级联数据项数组
   * @returns TextCascadePickerRangeContent 数组
   */
  private convertCascadeData(items: TnPickerColumnItem[]): TextCascadePickerRangeContent[] {
    const result: TextCascadePickerRangeContent[] = [];
    for (let i = 0; i < items.length; i++) {
      const item: TnPickerColumnItem = items[i];
      const rangeItem: TextCascadePickerRangeContent = { text: item.label };
      if (item.children !== undefined && item.children.length > 0) {
        rangeItem.children = this.convertCascadeData(item.children);
      }
      result.push(rangeItem);
    }
    return result;
  }

  /**
   * 获取单列选中值
   * @param index 选中索引
   * @returns 选中的值
   */
  private getValueByIndex(index: number): TnPickerValueType {
    if (this.data.length === 0 || index < 0) {
      return "";
    }
    const column: TnPickerColumnItem[] = this.data[0];
    if (index < column.length) {
      return column[index].value;
    }
    return "";
  }

  /**
   * 获取多列选中值
   * @param indices 各列选中索引
   * @returns 选中值数组
   */
  private getMultiValueByIndices(indices: number[]): Array<string | number> {
    const values: Array<string | number> = [];
    for (let i = 0; i < indices.length; i++) {
      if (i < this.data.length) {
        const colIndex: number = indices[i];
        const column: TnPickerColumnItem[] = this.data[i];
        if (colIndex >= 0 && colIndex < column.length) {
          values.push(column[colIndex].value);
        }
      }
    }
    return values;
  }

  /**
   * 获取联动选中值（递归查找）
   * @param indices 各级选中索引
   * @returns 选中值数组
   */
  private getCascadeValueByIndices(indices: number[]): Array<string | number> {
    const values: Array<string | number> = [];
    let currentItems: TnPickerColumnItem[] = this.cascadeData;
    for (let i = 0; i < indices.length; i++) {
      const idx: number = indices[i];
      if (idx >= 0 && idx < currentItems.length) {
        values.push(currentItems[idx].value);
        if (currentItems[idx].children !== undefined && currentItems[idx].children!.length > 0) {
          currentItems = currentItems[idx].children!;
        } else {
          break;
        }
      } else {
        break;
      }
    }
    return values;
  }

  /**
   * 初始化多列选中索引，确保长度与列数一致
   */
  private initSelectedIndices(): void {
    if (this.data.length > 1 && this.selectedIndices.length !== this.data.length) {
      const indices: number[] = [];
      for (let i = 0; i < this.data.length; i++) {
        indices.push(0);
      }
      this.selectedIndices = indices;
    }
  }

  build() {
    Column() {
      if (this.open) {
        Column() {
          // 工具栏
          this.ToolbarBuilder();
          // 选择器内容
          if (this.isCascadeMode()) {
            this.CascadePickerBuilder();
          } else if (this.isMultiColumnMode()) {
            this.MultiColumnPickerBuilder();
          } else {
            this.SingleColumnPickerBuilder();
          }
        }
        .width("100%")
        .backgroundColor($r("app.color.tn_bg_color"))
        .borderRadius({
          topLeft: this.baseStyle.borderRadiusXxl,
          topRight: this.baseStyle.borderRadiusXxl
        })
        .padding({ bottom: this.baseStyle.spaceLg });
      }
    }
    .width("100%");
  }

  /**
   * 单列选择器
   */
  @Builder
  private SingleColumnPickerBuilder(): void {
    if (this.getSingleRangeData().length > 0) {
      TextPicker({ range: this.getSingleRangeData(), selected: this.selectedIndex })
        .width("100%")
        .height(convertDimensionsWidthUnit(220))
        .onChange((value: string | string[], index: number | number[]) => {
          const idx: number = typeof index === "number" ? index : (index as number[])[0];
          this.selectedIndex = idx;
          this.onChange(this.getValueByIndex(idx), idx);
        });
    }
  }

  /**
   * 多列选择器
   */
  @Builder
  private MultiColumnPickerBuilder(): void {
    if (this.getMultiRangeData().length > 0) {
      TextPicker({ range: this.getMultiRangeData(), selected: this.selectedIndices })
        .width("100%")
        .height(convertDimensionsWidthUnit(220))
        .onChange((value: string | string[], index: number | number[]) => {
          if (typeof index === "number") {
            this.selectedIndices = [index];
          } else {
            this.selectedIndices = index as number[];
          }
          const values: Array<string | number> = this.getMultiValueByIndices(this.selectedIndices);
          this.onChange(values, this.selectedIndices);
        });
    }
  }

  /**
   * 联动选择器
   */
  @Builder
  private CascadePickerBuilder(): void {
    TextPicker({ range: this.convertCascadeData(this.cascadeData) })
      .width("100%")
      .height(convertDimensionsWidthUnit(220))
      .onChange((value: string | string[], index: number | number[]) => {
        if (typeof index === "number") {
          this.selectedIndices = [index];
        } else {
          this.selectedIndices = index as number[];
        }
        const values: Array<string | number> = this.getCascadeValueByIndices(this.selectedIndices);
        this.onChange(values, this.selectedIndices);
      });
  }

  /**
   * 工具栏构建器
   */
  @Builder
  private ToolbarBuilder(): void {
    Row() {
      // 取消按钮
      if (this.showCancel) {
        Text(this.cancelText)
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
          .fontColor($r("app.color.tn_text_color_secondary"))
          .lineHeight(this.baseStyle.lineHeightSm)
          .padding({
            left: this.baseStyle.spaceMlg,
            right: this.baseStyle.spaceMlg,
            top: this.baseStyle.spaceMd,
            bottom: this.baseStyle.spaceMd
          })
          .borderRadius(this.baseStyle.borderRadius)
          .stateStyles({
            normal: {
              .backgroundColor(Color.Transparent)
            },
            pressed: {
              .backgroundColor(mixWithBlack(getHexColorByResoure($r("app.color.tn_bg_color"))))
            }
          })
          .animation({ duration: this.baseStyle.animationDuration })
          .onClick(() => {
            this.onCancel();
            this.onClose();
          });
      } else {
        Blank();
      }

      // 标题
      if (this.title.length > 0) {
        Text(this.title)
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeLg"))
          .fontColor($r("app.color.tn_text_color_primary"))
          .fontWeight(FontWeight.Medium)
          .lineHeight(this.baseStyle.lineHeightMd)
          .layoutWeight(1)
          .textAlign(TextAlign.Center);
      } else {
        Blank().layoutWeight(1);
      }

      // 确认按钮
      if (this.showConfirm) {
        Text(this.confirmText)
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
          .fontColor(getThemeColor(this.baseStyle, "primary"))
          .lineHeight(this.baseStyle.lineHeightSm)
          .padding({
            left: this.baseStyle.spaceMlg,
            right: this.baseStyle.spaceMlg,
            top: this.baseStyle.spaceMd,
            bottom: this.baseStyle.spaceMd
          })
          .borderRadius(this.baseStyle.borderRadius)
          .stateStyles({
            normal: {
              .backgroundColor(Color.Transparent)
            },
            pressed: {
              .backgroundColor(mixWithBlack(getHexColorByResoure($r("app.color.tn_bg_color"))))
            }
          })
          .animation({ duration: this.baseStyle.animationDuration })
          .onClick(() => {
            if (this.isCascadeMode()) {
              const values: Array<string | number> = this.getCascadeValueByIndices(this.selectedIndices);
              this.onConfirm(values, this.selectedIndices);
            } else if (this.isMultiColumnMode()) {
              this.initSelectedIndices();
              const values: Array<string | number> = this.getMultiValueByIndices(this.selectedIndices);
              this.onConfirm(values, this.selectedIndices);
            } else {
              this.onConfirm(this.getValueByIndex(this.selectedIndex), this.selectedIndex);
            }
            this.onClose();
          });
      } else {
        Blank();
      }
    }
    .width("100%")
    .height(convertDimensionsWidthUnit(48))
    .alignItems(VerticalAlign.Center);
  }
}
