/**
 * @file TnSearchBox 搜索框组件
 * @description 搜索框组件，支持方形/圆形、多尺寸、清除按钮、搜索按钮等功能
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { getFontSizeByKey, getThemeColor } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { convertDimensionsWidthUnit } from "../../utils/Utils";
import { TnSearchBoxClearTrigger, TnSearchBoxShape, TnSearchBoxSize } from "./TnSearchBoxTypes";

/** 搜索框各尺寸对应高度(vp) */
function getSizeHeight(size: string): number {
  switch (size) {
    case "sm":
      return 28;
    case "lg":
      return 40;
    case "xl":
      return 48;
    default:
      return 34;
  }
}

/** 搜索框各尺寸对应字体 key */
function getSizeFontKey(size: string): string {
  switch (size) {
    case "sm":
      return "fontSizeXs";
    case "lg":
      return "fontSizeLg";
    case "xl":
      return "fontSizeXl";
    default:
      return "fontSize";
  }
}

/** 搜索框各尺寸对应行高属性名 */
function getSizeLineHeightKey(size: string): string {
  switch (size) {
    case "sm":
      return "lineHeightXs";
    case "lg":
      return "lineHeightMd";
    case "xl":
      return "lineHeightLg";
    default:
      return "lineHeightSm";
  }
}

@ComponentV2
export struct TnSearchBox {
  @Local baseStyle: TnUIBaseStyleType =
    AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /** 搜索框输入值 */
  @Param modelValue: string = "";
  /** 占位文本 */
  @Param placeholder: string = "请输入搜索内容";
  /** 搜索框形状 */
  @Param shape: TnSearchBoxShape = "square";
  /** 搜索框尺寸 */
  @Param boxSize: TnSearchBoxSize = "default";
  /** 输入文字颜色 */
  @Param textColor: ResourceColor | undefined = undefined;
  /** 占位文字颜色 */
  @Param placeholderColor: ResourceColor | undefined = undefined;
  /** 文字对齐方式 */
  @Param textAlign: TextAlign = TextAlign.Start;
  /** 是否显示边框 */
  @Param showBorder: boolean = true;
  /** 边框颜色 */
  @Param inputBorderColor: ResourceColor | undefined = undefined;
  /** 是否禁用 */
  @Param disabled: boolean = false;
  /** 是否可清除 */
  @Param clearable: boolean = true;
  /** 清除按钮触发方式 */
  @Param clearTrigger: TnSearchBoxClearTrigger = "focus";
  /** 是否显示搜索按钮 */
  @Param searchButton: boolean = true;
  /** 搜索按钮文字 */
  @Param searchButtonText: string = "搜索";
  /** 搜索按钮文字颜色 */
  @Param searchButtonTextColor: ResourceColor | undefined = undefined;
  /** 搜索按钮背景色 */
  @Param searchButtonBgColor: ResourceColor | undefined = undefined;
  /** 搜索框背景色 */
  @Param bgColor: ResourceColor | undefined = undefined;
  /** 是否自动聚焦 */
  @Param focus: boolean = false;
  /** 输入值变化回调 */
  @Event onChange: (value: string) => void = () => {};
  /** 搜索按钮点击或键盘确认回调 */
  @Event onSearch: (value: string) => void = () => {};
  /** 清除按钮点击回调 */
  @Event onClear: () => void = () => {};
  /** 聚焦回调 */
  @Event onInputFocus: () => void = () => {};
  /** 失焦回调 */
  @Event onInputBlur: () => void = () => {};
  /** 点击搜索框回调（disabled 时也触发） */
  @Event onBoxClick: () => void = () => {};
  /** 内部输入值 */
  @Local private inputValue: string = "";
  /** 是否处于聚焦状态 */
  @Local private isFocused: boolean = false;
  /** TextInput 控制器 */
  private inputController: TextInputController = new TextInputController();

  aboutToAppear(): void {
    this.inputValue = this.modelValue;
    this.isFocused = this.focus;
  }

  @Monitor("modelValue")
  onModelValueChange(): void {
    if (this.inputValue !== this.modelValue) {
      this.inputValue = this.modelValue;
    }
  }

  @Monitor("focus")
  onFocusChange(): void {
    this.isFocused = this.focus;
  }

  /**
   * 获取搜索框高度
   * @returns 高度字符串
   */
  private getBoxHeight(): string {
    const height: number = getSizeHeight(this.boxSize);
    return convertDimensionsWidthUnit(height);
  }

  /**
   * 获取字体大小 key
   * @returns 字体 key
   */
  private getFontKey(): string {
    return getSizeFontKey(this.boxSize);
  }

  /**
   * 获取行高
   * @returns 行高值
   */
  private getLineHeight(): string {
    const key: string = getSizeLineHeightKey(this.boxSize);
    switch (key) {
      case "lineHeightXs":
        return this.baseStyle.lineHeightXs;
      case "lineHeightMd":
        return this.baseStyle.lineHeightMd;
      case "lineHeightLg":
        return this.baseStyle.lineHeightLg;
      default:
        return this.baseStyle.lineHeightSm;
    }
  }

  /**
   * 获取圆角
   * @returns 圆角值
   */
  private getBorderRadius(): Length {
    if (this.shape === "round") {
      return this.baseStyle.borderRadiusMax;
    }
    return this.baseStyle.borderRadius;
  }

  /**
   * 获取输入框文字颜色
   * @returns 文字颜色
   */
  private getTextColor(): ResourceColor {
    if (this.textColor !== undefined) {
      return this.textColor;
    }
    return $r("app.color.tn_text_color_primary");
  }

  /**
   * 获取占位文字颜色
   * @returns 占位文字颜色
   */
  private getPlaceholderColor(): ResourceColor {
    if (this.placeholderColor !== undefined) {
      return this.placeholderColor;
    }
    return $r("app.color.tn_text_color_placeholder");
  }

  /**
   * 获取边框颜色
   * @returns 边框颜色
   */
  private getBorderColor(): ResourceColor {
    if (this.inputBorderColor !== undefined) {
      return this.inputBorderColor;
    }
    return $r("app.color.tn_color_gray_disabled");
  }

  /**
   * 获取搜索框背景色
   * @returns 背景色
   */
  private getBgColor(): ResourceColor {
    if (this.bgColor !== undefined) {
      return this.bgColor;
    }
    return $r("app.color.tn_bg_color");
  }

  /**
   * 获取搜索按钮背景色
   * @returns 按钮背景色
   */
  private getSearchButtonBgColor(): ResourceColor {
    if (this.searchButtonBgColor !== undefined) {
      return this.searchButtonBgColor;
    }
    return getThemeColor(this.baseStyle, "primary");
  }

  /**
   * 获取搜索按钮文字颜色
   * @returns 按钮文字颜色
   */
  private getSearchButtonTextColor(): ResourceColor {
    if (this.searchButtonTextColor !== undefined) {
      return this.searchButtonTextColor;
    }
    return $r("app.color.tn_color_white");
  }

  /**
   * 是否显示清除按钮
   * @returns 是否显示
   */
  private shouldShowClear(): boolean {
    if (!this.clearable) {
      return false;
    }
    if (this.inputValue.length === 0) {
      return false;
    }
    if (this.clearTrigger === "focus") {
      return this.isFocused;
    }
    return true;
  }

  /**
   * 处理输入变化
   * @param value 新输入值
   */
  private handleInput(value: string): void {
    this.inputValue = value;
    this.onChange(value);
  }

  /**
   * 处理清除
   */
  private handleClear(): void {
    this.inputValue = "";
    this.onChange("");
    this.onClear();
  }

  /**
   * 处理搜索
   */
  private handleSearch(): void {
    if (this.disabled) {
      return;
    }
    this.onSearch(this.inputValue);
  }

  /**
   * 处理聚焦
   */
  private handleFocus(): void {
    this.isFocused = true;
    this.onInputFocus();
  }

  /**
   * 处理失焦
   */
  private handleBlur(): void {
    this.isFocused = false;
    this.onInputBlur();
  }

  build() {
    Row({ space: this.baseStyle.spaceBase }) {
      // 搜索图标
      SymbolGlyph($r("sys.symbol.magnifyingglass"))
        .fontSize(getFontSizeByKey(this.baseStyle, this.getFontKey()))
        .fontColor([$r("app.color.tn_text_color_placeholder")])

      // 输入框
      TextInput({ text: this.inputValue, placeholder: this.placeholder, controller: this.inputController })
        .layoutWeight(1)
        .height("100%")
        .backgroundColor(Color.Transparent)
        .padding(0)
        .borderRadius(0)
        .caretColor(getThemeColor(this.baseStyle, "primary"))
        .fontSize(getFontSizeByKey(this.baseStyle, this.getFontKey()))
        .fontColor(this.getTextColor())
        .placeholderColor(this.getPlaceholderColor())
        .placeholderFont({ size: getFontSizeByKey(this.baseStyle, this.getFontKey()) })
        .textAlign(this.textAlign)
        .enterKeyType(EnterKeyType.Search)
        .defaultFocus(this.focus)
        .enabled(!this.disabled)
        .onChange((value: string) => {
          this.handleInput(value);
        })
        .onFocus(() => {
          this.handleFocus();
        })
        .onBlur(() => {
          this.handleBlur();
        })
        .onSubmit(() => {
          this.handleSearch();
        })

      // 清除按钮
      if (this.shouldShowClear()) {
        SymbolGlyph($r("sys.symbol.xmark_circle_fill"))
          .fontSize(getFontSizeByKey(this.baseStyle, this.getFontKey()))
          .fontColor([$r("app.color.tn_text_color_secondary")])
          .stateStyles({
            pressed: {
              .opacity(0.5)
            },
            normal: {
              .opacity(1)
            }
          })
          .onClick(() => {
            this.handleClear();
          })
      }

      // 搜索按钮（内部右侧）
      if (this.searchButton) {
        this.SearchButton();
      }
    }
    .width("100%")
    .height(this.getBoxHeight())
    .padding({ left: this.baseStyle.spaceSm, right: this.searchButton ? 0 : this.baseStyle.spaceSm })
    .backgroundColor(this.getBgColor())
    .borderRadius(this.getBorderRadius())
    .border(this.showBorder ? { width: 1, color: this.getBorderColor() } : undefined)
    .clip(true)
    .onClick(() => {
      this.onBoxClick();
    })
    .opacity(this.disabled ? 0.6 : 1)
    .animation({ duration: this.baseStyle.animationDuration })
  }

  @Builder
  private SearchButton(): void {
    Text(this.searchButtonText)
      .fontSize(getFontSizeByKey(this.baseStyle, this.getFontKey()))
      .lineHeight(this.getLineHeight())
      .fontColor(this.getSearchButtonTextColor())
      .textAlign(TextAlign.Center)
      .height("100%")
      .padding({ left: this.baseStyle.spaceMd, right: this.baseStyle.spaceMd })
      .backgroundColor(this.getSearchButtonBgColor())
      .stateStyles({
        pressed: {
          .opacity(0.7)
        },
        normal: {
          .opacity(1)
        }
      })
      .onClick(() => {
        this.handleSearch();
      })
  }

}
