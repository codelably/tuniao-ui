/**
 * @file TnRegionPicker 地区选择器组件
 * @description 三级联动地区选择器（省/市/区），支持内置数据和自定义数据，返回名称与区域编码
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { getThemeColor, getFontSizeByKey } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { REGION_DATA, RegionItem } from "./data/region";
import { convertDimensionsWidthUnit } from "../../utils/Utils";
import { getHexColorByResoure, mixWithBlack } from "../../utils/ColorUtils";

/**
 * TnRegionPicker 地区选择器
 *
 * @example
 * // 使用内置数据
 * TnRegionPicker({
 *   open: true,
 *   onConfirm: (names, codes) => { console.log(names, codes); },
 *   onClose: () => {}
 * })
 * // 使用自定义数据
 * TnRegionPicker({
 *   open: true,
 *   customData: myRegionData,
 *   onConfirm: (names, codes) => { console.log(names, codes); },
 *   onClose: () => {}
 * })
 */
@ComponentV2
export struct TnRegionPicker {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  /** 绑定值 */
  @Param modelValue: string[] = [];
  /** 显示/隐藏 */
  @Param open: boolean = false;
  /** 标题 */
  @Param title: string = "选择地区";
  /** 自定义地区数据，不传则使用内置 REGION_DATA */
  @Param customData: RegionItem[] = [];

  /** 确认回调，names 为名称数组，codes 为编码数组 */
  @Event onConfirm: (names: string[], codes: string[]) => void =
    (_names: string[], _codes: string[]): void => {};
  /** 取消回调 */
  @Event onCancel: () => void = (): void => {};
  /** 关闭回调 */
  @Event onClose: () => void = (): void => {};
  /** 变化回调，names 为名称数组，codes 为编码数组 */
  @Event onChange: (names: string[], codes: string[]) => void =
    (_names: string[], _codes: string[]): void => {};

  /** 当前省份索引 */
  @Local private provinceIndex: number = 0;
  /** 当前城市索引 */
  @Local private cityIndex: number = 0;
  /** 当前区县索引 */
  @Local private districtIndex: number = 0;

  aboutToAppear(): void {
    this.initSelection();
  }

  /**
   * 获取实际使用的地区数据源
   * @returns 地区数据数组
   */
  private getDataSource(): RegionItem[] {
    if (this.customData.length > 0) {
      return this.customData;
    }
    return REGION_DATA;
  }

  /**
   * 初始化选中状态
   */
  private initSelection(): void {
    const data: RegionItem[] = this.getDataSource();
    if (this.modelValue.length >= 1) {
      const pIdx: number = data.findIndex((item: RegionItem): boolean => item.name === this.modelValue[0]);
      if (pIdx >= 0) {
        this.provinceIndex = pIdx;
      }
    }
    if (this.modelValue.length >= 2) {
      const cities: RegionItem[] = this.getCities();
      const cIdx: number = cities.findIndex((item: RegionItem): boolean => item.name === this.modelValue[1]);
      if (cIdx >= 0) {
        this.cityIndex = cIdx;
      }
    }
    if (this.modelValue.length >= 3) {
      const districts: RegionItem[] = this.getDistricts();
      const dIdx: number = districts.findIndex((item: RegionItem): boolean => item.name === this.modelValue[2]);
      if (dIdx >= 0) {
        this.districtIndex = dIdx;
      }
    }
  }

  /**
   * 获取省份列表
   * @returns 省份名称数组
   */
  private getProvinces(): string[] {
    return this.getDataSource().map((item: RegionItem): string => item.name);
  }

  /**
   * 获取当前省份下的城市列表
   * @returns 城市列表
   */
  private getCities(): RegionItem[] {
    const data: RegionItem[] = this.getDataSource();
    const province: RegionItem | undefined =
      this.provinceIndex < data.length ? data[this.provinceIndex] : undefined;
    if (province !== undefined && province.children !== undefined) {
      return province.children!;
    }
    return [];
  }

  /**
   * 获取城市名称列表
   * @returns 城市名称数组
   */
  private getCityNames(): string[] {
    return this.getCities().map((item: RegionItem): string => item.name);
  }

  /**
   * 获取当前城市下的区县列表
   * @returns 区县列表
   */
  private getDistricts(): RegionItem[] {
    const cities: RegionItem[] = this.getCities();
    if (this.cityIndex < cities.length && cities[this.cityIndex].children !== undefined) {
      return cities[this.cityIndex].children!;
    }
    return [];
  }

  /**
   * 获取区县名称列表
   * @returns 区县名称数组
   */
  private getDistrictNames(): string[] {
    return this.getDistricts().map((item: RegionItem): string => item.name);
  }

  /**
   * 获取当前选中的名称数组
   * @returns [省, 市, 区] 名称数组
   */
  private getCurrentNames(): string[] {
    const provinces: string[] = this.getProvinces();
    const cityNames: string[] = this.getCityNames();
    const districtNames: string[] = this.getDistrictNames();
    const result: string[] = [];
    if (this.provinceIndex < provinces.length) {
      result.push(provinces[this.provinceIndex]);
    }
    if (this.cityIndex < cityNames.length) {
      result.push(cityNames[this.cityIndex]);
    }
    if (this.districtIndex < districtNames.length) {
      result.push(districtNames[this.districtIndex]);
    }
    return result;
  }

  /**
   * 获取当前选中的编码数组
   * @returns [省编码, 市编码, 区编码] 编码数组
   */
  private getCurrentCodes(): string[] {
    const data: RegionItem[] = this.getDataSource();
    const codes: string[] = [];
    if (this.provinceIndex < data.length) {
      const province: RegionItem = data[this.provinceIndex];
      codes.push(province.code ?? "");
      if (province.children !== undefined) {
        const cities: RegionItem[] = province.children!;
        if (this.cityIndex < cities.length) {
          const city: RegionItem = cities[this.cityIndex];
          codes.push(city.code ?? "");
          if (city.children !== undefined) {
            const districts: RegionItem[] = city.children!;
            if (this.districtIndex < districts.length) {
              codes.push(districts[this.districtIndex].code ?? "");
            }
          }
        }
      }
    }
    return codes;
  }

  build() {
    Column() {
      if (this.open) {
        Column() {
          // 工具栏
          this.ToolbarBuilder();
          // 三列选择器
          Row() {
            // 省份
            TextPicker({ range: this.getProvinces(), selected: this.provinceIndex })
              .layoutWeight(1)
              .height(convertDimensionsWidthUnit(220))
              .onChange((_value: string | string[], index: number | number[]) => {
                const idx: number = typeof index === "number" ? index : (index as number[])[0];
                this.provinceIndex = idx;
                this.cityIndex = 0;
                this.districtIndex = 0;
                this.onChange(this.getCurrentNames(), this.getCurrentCodes());
              });
            // 城市
            TextPicker({ range: this.getCityNames(), selected: this.cityIndex })
              .layoutWeight(1)
              .height(convertDimensionsWidthUnit(220))
              .onChange((_value: string | string[], index: number | number[]) => {
                const idx: number = typeof index === "number" ? index : (index as number[])[0];
                this.cityIndex = idx;
                this.districtIndex = 0;
                this.onChange(this.getCurrentNames(), this.getCurrentCodes());
              });
            // 区县
            TextPicker({ range: this.getDistrictNames(), selected: this.districtIndex })
              .layoutWeight(1)
              .height(convertDimensionsWidthUnit(220))
              .onChange((_value: string | string[], index: number | number[]) => {
                const idx: number = typeof index === "number" ? index : (index as number[])[0];
                this.districtIndex = idx;
                this.onChange(this.getCurrentNames(), this.getCurrentCodes());
              });
          }
          .width("100%");
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
   * 工具栏构建器
   */
  @Builder
  private ToolbarBuilder(): void {
    Row() {
      Text("取消")
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

      Text(this.title)
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeLg"))
        .fontColor($r("app.color.tn_text_color_primary"))
        .fontWeight(FontWeight.Medium)
        .lineHeight(this.baseStyle.lineHeightMd)
        .layoutWeight(1)
        .textAlign(TextAlign.Center);

      Text("确定")
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
          this.onConfirm(this.getCurrentNames(), this.getCurrentCodes());
          this.onClose();
        });
    }
    .width("100%")
    .height(convertDimensionsWidthUnit(48))
    .alignItems(VerticalAlign.Center);
  }
}
