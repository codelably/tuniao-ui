/**
 * @file TnInput 输入框组件
 * @description 支持多种输入类型、清除按钮、密码可见切换、字数统计、下划线/边框风格、
 *              预设尺寸（sm/lg）、前后插槽（prefix/suffix）等
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { getThemeColor, getFontSizeByKey } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { TnIcon } from "../icon/TnIcon";
import { TnInputType, TnInputTextAlign, TnInputSize, TnInputSizeConfig } from "./TnInputTypes";
import { getSizeByUnit, convertDimensionsWidthUnit } from "../../utils/Utils";

/** 默认 textarea 最小高度(vp) */
const DEFAULT_TEXTAREA_HEIGHT: number = 80;

/** 各尺寸配置映射 */
const SIZE_CONFIG_MAP: Record<string, TnInputSizeConfig> = {
  "sm": { height: 24, fontSizeKey: "fontSizeXs", padding: 4 },
  "": { height: 32, fontSizeKey: "fontSize", padding: 8 },
  "lg": { height: 40, fontSizeKey: "fontSizeLg", padding: 10 },
};

/**
 * TnInput 输入框组件
 *
 * @example
 * // 基础用法
 * TnInput({ modelValue: "hello", onChange: (val) => {} })
 *
 * // 密码输入
 * TnInput({ modelValue: "", type: "password", placeholder: "请输入密码" })
 *
 * // 文本域
 * TnInput({ modelValue: "", type: "textarea", placeholder: "请输入内容" })
 *
 * // 预设尺寸
 * TnInput({ modelValue: "", size: "sm", placeholder: "小尺寸" })
 * TnInput({ modelValue: "", size: "lg", placeholder: "大尺寸" })
 */
@ComponentV2
export struct TnInput {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  /** 绑定值 */
  @Param modelValue: string = "";
  /** 输入类型 */
  @Param type: TnInputType = "text";
  /** 预设尺寸 */
  @Param inputSize: TnInputSize = "";
  /** 占位文本 */
  @Param placeholder: string = "";
  /** 占位文本颜色 */
  @Param placeholderColor: ResourceColor = $r("app.color.tn_text_color_placeholder");
  /** 禁用 */
  @Param disabled: boolean = false;
  /** 只读 */
  @Param readonly: boolean = false;
  /** 显示清除按钮 */
  @Param clearable: boolean = false;
  /** 密码可见切换 */
  @Param showPassword: boolean = true;
  /** 最大输入长度 */
  @Param maxlength: number = -1;
  /** 显示字数统计 */
  @Param showWordLimit: boolean = false;
  /** textarea 自适应高度 */
  @Param autoHeight: boolean = true;
  /** 显示边框 */
  @Param showBorder: boolean = true;
  /** 边框颜色 */
  @Param inputBorderColor: ResourceColor = $r("app.color.tn_color_gray_disabled");
  /** 下划线风格 */
  @Param underline: boolean = false;
  /** 文本对齐 */
  @Param textAlign: TnInputTextAlign = "left";
  /** 自动去首尾空格 */
  @Param trim: boolean = true;
  /** 输入框高度(vp)，优先级高于 size */
  @Param inputHeight: number = 0;
  /** 右侧图标 */
  @Param rightIcon: string = "";

  /** 前置插槽 */
  @BuilderParam prefixBuilder: CustomBuilder;
  /** 后置插槽 */
  @BuilderParam suffixBuilder: CustomBuilder;

  /** 输入回调 */
  @Event onInput: (value: string) => void = (_value: string): void => {};
  /** 变化回调 */
  @Event onChange: (value: string) => void = (_value: string): void => {};
  /** 获取焦点回调 */
  @Event onInputFocus: () => void = (): void => {};
  /** 失去焦点回调 */
  @Event onInputBlur: () => void = (): void => {};
  /** 清除回调 */
  @Event onClear: () => void = (): void => {};
  /** 确认回调 */
  @Event onConfirm: (value: string) => void = (_value: string): void => {};
  /** 点击回调 */
  @Event onInputClick: () => void = (): void => {};

  /** 是否聚焦 */
  @Local private isFocused: boolean = false;
  /** 密码是否可见 */
  @Local private passwordVisible: boolean = false;

  /**
   * 获取当前尺寸配置
   * @returns 尺寸配置项
   */
  private getSizeConfig(): TnInputSizeConfig {
    const key: string = this.inputSize || "";
    const config: TnInputSizeConfig | undefined = SIZE_CONFIG_MAP[key];
    if (config !== undefined) {
      return config;
    }
    return SIZE_CONFIG_MAP[""];
  }

  /**
   * 获取实际高度（带单位）
   * @returns 格式化后的高度
   */
  private getResolvedHeight(): string {
    if (this.inputHeight > 0) {
      return getSizeByUnit(this.inputHeight);
    }
    if (this.type === "textarea") {
      return convertDimensionsWidthUnit(DEFAULT_TEXTAREA_HEIGHT);
    }
    return convertDimensionsWidthUnit(this.getSizeConfig().height);
  }

  /**
   * 获取当前字体大小
   * @returns 字体大小值
   */
  private getResolvedFontSize(): string {
    return getFontSizeByKey(this.baseStyle, this.getSizeConfig().fontSizeKey);
  }

  /**
   * 获取当前内边距
   * @returns 内边距值(vp)
   */
  private getResolvedPadding(): number {
    return this.getSizeConfig().padding;
  }

  /**
   * 获取文本对齐方式
   * @returns TextAlign 枚举值
   */
  private getTextAlign(): TextAlign {
    switch (this.textAlign) {
      case "center":
        return TextAlign.Center;
      case "right":
        return TextAlign.End;
      default:
        return TextAlign.Start;
    }
  }

  /**
   * 处理输入值变化
   * @param value 新值
   */
  private handleValueChange(value: string): void {
    const processedValue: string = this.trim ? value.trim() : value;
    this.onInput(processedValue);
    this.onChange(processedValue);
  }

  /**
   * 是否显示清除按钮
   * @returns 是否显示
   */
  private shouldShowClear(): boolean {
    return this.clearable && this.modelValue.length > 0 && !this.disabled && !this.readonly;
  }

  /**
   * 处理清除
   */
  private handleClear(): void {
    this.onChange("");
    this.onClear();
  }

  /**
   * 获取边框配置（统一使用 .border() 避免属性覆盖）
   * @returns 边框配置对象
   */
  private getBorderConfig(): BorderOptions {
    if (this.underline) {
      return {
        width: { bottom: 1 },
        color: { bottom: this.isFocused ? getThemeColor(this.baseStyle, "primary") : this.inputBorderColor }
      };
    }
    if (!this.showBorder) {
      return { width: 0 };
    }
    return {
      width: 1,
      color: this.isFocused ? getThemeColor(this.baseStyle, "primary") : this.inputBorderColor
    };
  }

  build() {
    Column() {
      if (this.type === "textarea") {
        this.TextareaBuilder();
      } else {
        this.TextInputBuilder();
      }
      // 字数统计
      if (this.showWordLimit && this.maxlength > 0) {
        Row() {
          Blank();
          Text(`${this.modelValue.length}/${this.maxlength}`)
            .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
            .fontColor($r("app.color.tn_text_color_secondary"))
            .lineHeight(this.baseStyle.lineHeightXs);
        }
        .width("100%")
        .margin({ top: this.baseStyle.spaceBase });
      }
    }
    .width("100%")
    .onClick(() => {
      this.onInputClick();
    });
  }

  /**
   * TextInput 输入框构建器
   */
  @Builder
  private TextInputBuilder(): void {
    Row() {
      // 前置插槽
      if (this.prefixBuilder) {
        this.prefixBuilder();
      }

      TextInput({ text: this.modelValue, placeholder: this.placeholder })
        .layoutWeight(1)
        .height(this.getResolvedHeight())
        .fontSize(this.getResolvedFontSize())
        .fontColor($r("app.color.tn_text_color_primary"))
        .placeholderColor(this.placeholderColor)
        .placeholderFont({ size: this.getResolvedFontSize() })
        .textAlign(this.getTextAlign())
        .type(this.getInputType())
        .showPasswordIcon(false)
        .maxLength(this.maxlength > 0 ? this.maxlength : undefined)
        .enabled(!this.disabled && !this.readonly)
        .backgroundColor(Color.Transparent)
        .borderRadius(0)
        .padding(0)
        .onChange((value: string) => {
          this.handleValueChange(value);
        })
        .onFocus(() => {
          this.isFocused = true;
          this.onInputFocus();
        })
        .onBlur(() => {
          this.isFocused = false;
          this.onInputBlur();
        })
        .onSubmit(() => {
          this.onConfirm(this.modelValue);
        });

      // 清除按钮
      if (this.shouldShowClear()) {
        TnIcon({ name: "close-circle", iconSize: 16, color: $r("app.color.tn_color_gray"), onIconClick: () => {
          this.handleClear();
        } })
          .margin({ left: this.baseStyle.spaceBase });
      }

      // 密码可见切换
      if (this.type === "password" && this.showPassword) {
        TnIcon({
          name: this.passwordVisible ? "eye-fill" : "eye-hide",
          iconSize: 18,
          color: $r("app.color.tn_color_gray"),
          onIconClick: () => {
            this.passwordVisible = !this.passwordVisible;
          }
        })
          .margin({ left: this.baseStyle.spaceBase });
      }

      // 右侧图标
      if (this.rightIcon.length > 0) {
        TnIcon({ name: this.rightIcon, iconSize: 18, color: $r("app.color.tn_color_gray") })
          .enabled(false)
          .margin({ left: this.baseStyle.spaceBase });
      }

      // 后置插槽
      if (this.suffixBuilder) {
        this.suffixBuilder();
      }
    }
    .width("100%")
    .padding({ left: this.getResolvedPadding(), right: this.getResolvedPadding() })
    .alignItems(VerticalAlign.Center)
    .borderRadius(this.underline ? 0 : this.baseStyle.borderRadius)
    .border(this.getBorderConfig())
    .animation({ duration: this.baseStyle.animationDuration })
    .opacity(this.disabled ? 0.5 : 1.0);
  }

  /**
   * TextArea 文本域构建器
   */
  @Builder
  private TextareaBuilder(): void {
    Column() {
      TextArea({ text: this.modelValue, placeholder: this.placeholder })
        .width("100%")
        .height(this.getResolvedHeight())
        .fontSize(this.getResolvedFontSize())
        .fontColor($r("app.color.tn_text_color_primary"))
        .placeholderColor(this.placeholderColor)
        .placeholderFont({ size: this.getResolvedFontSize() })
        .maxLength(this.maxlength > 0 ? this.maxlength : undefined)
        .enabled(!this.disabled && !this.readonly)
        .backgroundColor(Color.Transparent)
        .borderRadius(0)
        .padding(0)
        .onChange((value: string) => {
          this.handleValueChange(value);
        })
        .onFocus(() => {
          this.isFocused = true;
          this.onInputFocus();
        })
        .onBlur(() => {
          this.isFocused = false;
          this.onInputBlur();
        });
    }
    .width("100%")
    .padding(this.getResolvedPadding())
    .borderRadius(this.baseStyle.borderRadius)
    .border(this.getBorderConfig())
    .animation({ duration: this.baseStyle.animationDuration })
    .opacity(this.disabled ? 0.5 : 1.0);
  }

  /**
   * 获取系统 InputType
   * @returns InputType 枚举值
   */
  private getInputType(): InputType {
    if (this.type === "password") {
      return this.passwordVisible ? InputType.Normal : InputType.Password;
    }
    switch (this.type) {
      case "number":
        return InputType.Number;
      case "digit":
        return InputType.Number;
      default:
        return InputType.Normal;
    }
  }
}
