/**
 * @file TnSwitchTab 选项卡切换组件
 * @description 支持多选项卡切换，激活选项卡凸起效果，相邻选项卡圆角过渡
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { getFontSizeByKey, getThemeColorLight } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { convertDimensionsWidthUnit } from "../../utils/Utils";

/** 选项卡行高度(vp) */
const TAB_ROW_HEIGHT: number = 42;
/** 激活选项卡顶部填充高度(vp) */
const ACTIVE_FILLER_HEIGHT: number = 0;
/** 非激活选项卡顶部填充高度(vp) */
const INACTIVE_FILLER_HEIGHT: number = 16;

/**
 * TnSwitchTab 选项卡切换组件
 *
 * @example
 * TnSwitchTab({
 *   modelValue: this.currentTab,
 *   tabs: ["选项一", "选项二", "选项三"],
 *   onChange: (index: number) => { this.currentTab = index; }
 * }) {
 *   // 内容区域
 * }
 */
@ComponentV2
export struct TnSwitchTab {
  @Local baseStyle: TnUIBaseStyleType =
    AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /**
   * 当前激活的选项卡索引
   */
  @Param modelValue: number = 0;
  /**
   * 选项卡标签数组
   */
  @Param tabs: string[] = [];
  /**
   * 是否禁用切换
   */
  @Param disabled: boolean = false;
  /**
   * 非激活选项卡背景色
   */
  @Param inactiveBgColor: ResourceColor | undefined = undefined;
  /**
   * 激活选项卡背景色
   */
  @Param activeBgColor: ResourceColor | undefined = undefined;
  /**
   * 非激活选项卡文字颜色
   */
  @Param inactiveTextColor: ResourceColor | undefined = undefined;
  /**
   * 激活选项卡文字颜色
   */
  @Param activeTextColor: ResourceColor | undefined = undefined;
  /**
   * 选项卡切换回调
   */
  @Event onChange: (index: number) => void = () => {};
  /**
   * 内容插槽
   */
  @BuilderParam defaultBuilder: CustomBuilder;
  /**
   * 内部激活索引
   */
  @Local private currentIndex: number = 0;

  aboutToAppear(): void {
    this.currentIndex = this.modelValue;
  }

  @Monitor("modelValue")
  onModelValueChange(): void {
    this.currentIndex = this.modelValue;
  }

  /**
   * 获取非激活选项卡背景色
   * @returns 背景色
   */
  private getInactiveBgColor(): ResourceColor {
    if (this.inactiveBgColor !== undefined) {
      return this.inactiveBgColor;
    }
    return getThemeColorLight(this.baseStyle, "primary", "light_8");
  }

  /**
   * 获取激活选项卡背景色
   * @returns 背景色
   */
  private getActiveBgColor(): ResourceColor {
    if (this.activeBgColor !== undefined) {
      return this.activeBgColor;
    }
    return $r("app.color.tn_color_white");
  }

  /**
   * 获取非激活选项卡文字颜色
   * @returns 文字颜色
   */
  private getInactiveTextColor(): ResourceColor {
    if (this.inactiveTextColor !== undefined) {
      return this.inactiveTextColor;
    }
    return $r("app.color.tn_text_color_primary");
  }

  /**
   * 获取激活选项卡文字颜色
   * @returns 文字颜色
   */
  private getActiveTextColor(): ResourceColor {
    if (this.activeTextColor !== undefined) {
      return this.activeTextColor;
    }
    return $r("app.color.tn_text_color_primary");
  }

  /**
   * 处理选项卡点击
   * @param index 点击的选项卡索引
   */
  private handleTabClick(index: number): void {
    if (this.disabled) {
      return;
    }
    if (index === this.currentIndex) {
      return;
    }
    this.currentIndex = index;
    this.onChange(index);
  }

  build() {
    Column() {
      this.TabsRow();
      Column() {
        if (this.defaultBuilder) {
          this.defaultBuilder();
        }
      }
      .width("100%")
      .backgroundColor(this.getActiveBgColor())
      .borderRadius({
        bottomLeft: this.baseStyle.borderRadiusXl,
        bottomRight: this.baseStyle.borderRadiusXl
      })
      .clip(true)
    }
    .width("100%")
  }

  @Builder
  private TabsRow(): void {
    Row() {
      ForEach(this.tabs, (tab: string, index: number) => {
        this.TabItem(tab, index);
      }, (tab: string, index: number) => `${index}_${tab}`)
    }
    .width("100%")
    .height(convertDimensionsWidthUnit(TAB_ROW_HEIGHT))
    .backgroundColor(this.getInactiveBgColor())
    .borderRadius({
      topLeft: this.baseStyle.borderRadiusXl,
      topRight: this.baseStyle.borderRadiusXl
    })
    .clip(true)
  }

  @Builder
  private TabItem(tab: string, index: number): void {
    Stack({ alignContent: Alignment.Bottom }) {
      // 底层：彩色背景（让激活项顶部圆角可见）
      Column()
        .width("100%")
        .height("100%")
        .backgroundColor(this.getInactiveBgColor())

      // 中层：白色底部条（让相邻选项卡底部圆角形成外弧）
      Column()
        .width("100%")
        .height(this.baseStyle.borderRadiusXxl)
        .backgroundColor(this.getActiveBgColor())

      // 顶层：选项卡主体
      Column() {
        Text(tab)
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
          .lineHeight(this.baseStyle.lineHeightSm)
          .fontWeight(this.currentIndex === index ? FontWeight.Bold : FontWeight.Normal)
          .fontColor(this.currentIndex === index ? this.getActiveTextColor() : this.getInactiveTextColor())
          .textAlign(TextAlign.Center)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .width("100%")
      .height(convertDimensionsWidthUnit(TAB_ROW_HEIGHT - (this.currentIndex === index ? ACTIVE_FILLER_HEIGHT : INACTIVE_FILLER_HEIGHT)))
      .justifyContent(FlexAlign.Center)
      .backgroundColor(this.currentIndex === index ? this.getActiveBgColor() : this.getInactiveBgColor())
      .borderRadius(this.getTabBorderRadius(index))
    }
    .layoutWeight(1)
    .height(convertDimensionsWidthUnit(TAB_ROW_HEIGHT))
    .animation({ duration: this.baseStyle.animationDuration })
    .stateStyles({
      pressed: {
        .opacity(0.8)
      },
      normal: {
        .opacity(1)
      }
    })
    .onClick(() => {
      this.handleTabClick(index);
    })
  }

  /**
   * 获取选项卡圆角配置
   * @param index 选项卡索引
   * @returns 圆角配置
   */
  private getTabBorderRadius(index: number): BorderRadiuses {
    const isActive: boolean = this.currentIndex === index;
    const isLeftOfActive: boolean = index === this.currentIndex - 1;
    const isRightOfActive: boolean = index === this.currentIndex + 1;

    return {
      topLeft: isActive ? this.baseStyle.borderRadiusXl : 0,
      topRight: isActive ? this.baseStyle.borderRadiusXl : 0,
      bottomLeft: isRightOfActive ? this.baseStyle.borderRadiusXxl : 0,
      bottomRight: isLeftOfActive ? this.baseStyle.borderRadiusXxl : 0
    };
  }
}
