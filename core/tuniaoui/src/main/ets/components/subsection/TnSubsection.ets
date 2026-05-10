/**
 * @file TnSubsection 分段器组件
 * @description 分段器组件，支持 default（滑块）和 button（按钮）两种模式
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { getFontSizeByKey, getThemeColor, getTnShadow } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { convertDimensionsWidthUnit } from "../../utils/Utils";
import { TnSubsectionMode } from "./TnSubsectionTypes";

/** 分段器高度(vp) */
const SUBSECTION_HEIGHT: number = 32;

@ComponentV2
export struct TnSubsection {
  @Local baseStyle: TnUIBaseStyleType =
    AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /** 当前选中项索引 */
  @Param modelValue: number = 0;
  /** 分段选项列表 */
  @Param items: string[] = [];
  /** 分段器模式 */
  @Param mode: TnSubsectionMode = "default";
  /** 是否禁用 */
  @Param disabled: boolean = false;
  /** 激活项颜色 */
  @Param activeColor: ResourceColor | undefined = undefined;
  /** 未激活项文字颜色 */
  @Param color: ResourceColor | undefined = undefined;
  /** 选中项变化回调 */
  @Event onChange: (index: number) => void = () => {};
  /** 内部激活索引 */
  @Local private currentIndex: number = 0;
  /** 每个选项的宽度比例（均分） */
  @Local private itemWidthPercent: string = "0%";
  /** 滑块偏移量 */
  @Local private sliderOffsetX: number = 0;
  /** 是否已完成首次渲染（控制动画） */
  @Local private isReady: boolean = false;

  aboutToAppear(): void {
    this.currentIndex = this.modelValue;
    this.updateLayout();
  }

  @Monitor("modelValue")
  onModelValueChange(): void {
    this.currentIndex = this.modelValue;
    this.updateSliderOffset();
  }

  @Monitor("items")
  onItemsChange(): void {
    this.updateLayout();
  }

  /**
   * 更新布局参数
   */
  private updateLayout(): void {
    if (this.items.length > 0) {
      const percent: number = 100 / this.items.length;
      this.itemWidthPercent = `${percent}%`;
    }
    this.updateSliderOffset();
  }

  /**
   * 更新滑块偏移量
   */
  private updateSliderOffset(): void {
    if (this.items.length === 0) {
      this.sliderOffsetX = 0;
      return;
    }
    this.sliderOffsetX = this.currentIndex * (100 / this.items.length);
  }

  /**
   * 获取激活项颜色
   * @returns 激活颜色
   */
  private getActiveColor(): ResourceColor {
    if (this.activeColor !== undefined) {
      return this.activeColor;
    }
    return getThemeColor(this.baseStyle, "primary");
  }

  /**
   * 获取未激活项文字颜色
   * @returns 文字颜色
   */
  private getInactiveTextColor(): ResourceColor {
    if (this.color !== undefined) {
      return this.color;
    }
    if (this.mode === "default") {
      return getThemeColor(this.baseStyle, "primary");
    }
    return $r("app.color.tn_text_color_primary");
  }

  /**
   * 获取激活项文字颜色
   * @returns 文字颜色
   */
  private getActiveTextColor(): ResourceColor {
    if (this.mode === "default") {
      return $r("app.color.tn_color_white");
    }
    return this.getActiveColor();
  }

  /**
   * 获取容器背景色
   * @returns 背景色
   */
  private getContainerBgColor(): ResourceColor {
    if (this.mode === "button") {
      return $r("app.color.tn_color_gray_disabled");
    }
    return Color.Transparent;
  }

  /**
   * 获取滑块背景色
   * @returns 背景色
   */
  private getSliderBgColor(): ResourceColor {
    if (this.mode === "button") {
      return $r("app.color.tn_color_white");
    }
    return this.getActiveColor();
  }

  /**
   * 处理选项点击
   * @param index 点击的选项索引
   */
  private handleItemClick(index: number): void {
    if (this.disabled) {
      return;
    }
    if (index === this.currentIndex) {
      return;
    }
    this.currentIndex = index;
    this.updateSliderOffset();
    this.onChange(index);
  }

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // 滑块层
      Row()
        .width(this.itemWidthPercent)
        .height("100%")
        .backgroundColor(this.getSliderBgColor())
        .borderRadius(this.mode === "button"
          ? this.baseStyle.borderRadiusLg
          : this.baseStyle.borderRadius)
        .shadow(this.mode === "button" ? getTnShadow(this.baseStyle, "sm") : undefined)
        .position({ left: `${this.sliderOffsetX}%`, top: 0 })
        .animation({
          duration: this.isReady ? this.baseStyle.animationDuration : 0,
          curve: Curve.EaseInOut
        })

      // 选项层
      Row() {
        ForEach(this.items, (item: string, index: number) => {
          this.SubsectionItem(item, index);
        }, (item: string, index: number) => `${index}_${item}`)
      }
      .width("100%")
      .height("100%")
    }
    .width("100%")
    .height(convertDimensionsWidthUnit(SUBSECTION_HEIGHT))
    .padding(this.mode === "button" ? this.baseStyle.spaceMini : 0)
    .backgroundColor(this.getContainerBgColor())
    .borderRadius(this.mode === "button"
      ? this.baseStyle.borderRadiusLg
      : this.baseStyle.borderRadius)
    .border(this.mode === "default" ? {
      width: 1,
      color: this.getActiveColor()
    } : undefined)
    .clip(true)
    .opacity(this.disabled ? 0.6 : 1)
    .onAppear(() => {
      setTimeout(() => {
        this.isReady = true;
      }, 50);
    })
  }

  @Builder
  private SubsectionItem(item: string, index: number): void {
    Column() {
      Text(item)
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
        .lineHeight(this.baseStyle.lineHeightSm)
        .fontColor(this.currentIndex === index
          ? this.getActiveTextColor()
          : this.getInactiveTextColor())
        .fontWeight(this.currentIndex === index ? FontWeight.Medium : FontWeight.Normal)
        .textAlign(TextAlign.Center)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .animation({
          duration: this.isReady ? this.baseStyle.animationDuration : 0
        })
    }
    .layoutWeight(1)
    .height("100%")
    .justifyContent(FlexAlign.Center)
    .stateStyles({
      pressed: {
        .opacity(0.7)
      },
      normal: {
        .opacity(1)
      }
    })
    .onClick(() => {
      this.handleItemClick(index);
    })
  }
}
