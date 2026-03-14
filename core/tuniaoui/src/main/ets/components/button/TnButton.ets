/**
 * @file TnButton 按钮组件
 * @description 支持多种颜色类型、尺寸、形状、朴素/文本模式、加载/禁用状态、图标、阴影等
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { getFontSizeByKey, getThemeColor, getThemeColorLight, getTnShadow } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { getSizeByUnit, convertDimensionsWidthUnit } from "../../utils/Utils";
import { TnIcon } from "../icon/TnIcon";
import { TnButtonColorType, TnButtonShapeType, TnButtonSizeConfig, TnButtonSizeType } from "./TnButtonTypes";

/** 防抖间隔（毫秒） */
const DEBOUNCE_INTERVAL: number = 250;

/**
 * 根据尺寸类型获取按钮尺寸配置
 * @param size 尺寸类型
 * @returns 尺寸配置
 */
function getButtonSizeConfig(size: TnButtonSizeType | undefined): TnButtonSizeConfig {
  switch (size) {
    case "sm":
      return { height: 26, paddingHorizontal: 10, fontSizeKey: "fontSizeSm" };
    case "lg":
      return { height: 40, paddingHorizontal: 18, fontSizeKey: "fontSizeLg" };
    case "xl":
      return { height: 48, paddingHorizontal: 24, fontSizeKey: "fontSizeXl" };
    default:
      return { height: 32, paddingHorizontal: 15, fontSizeKey: "fontSize" };
  }
}

/**
 * TnButton 按钮组件
 *
 * @example
 * // 基础按钮
 * TnButton({ content: "按钮" })
 *
 * // 带主题类型
 * TnButton({ content: "成功", type: "success" })
 *
 * // 朴素按钮
 * TnButton({ content: "朴素", type: "primary", plain: true })
 *
 * // 文本按钮
 * TnButton({ content: "文本", type: "primary", textMode: true })
 *
 * // 图标按钮
 * TnButton({ content: "搜索", icon: "search", type: "primary" })
 */
@ComponentV2
export struct TnButton {
  /**
   * 全局基础样式（响应式绑定，主题切换时自动更新）
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /**
   * 按钮颜色类型
   */
  @Param type: TnButtonColorType = "primary";
  /**
   * 按钮尺寸
   */
  @Param btnSize: TnButtonSizeType | undefined = undefined;
  /**
   * 按钮形状
   */
  @Param shape: TnButtonShapeType | undefined = undefined;
  /**
   * 文本按钮模式（透明背景）
   */
  @Param textMode: boolean = false;
  /**
   * 朴素按钮（边框 + 浅背景）
   */
  @Param plain: boolean = false;
  /**
   * 禁用状态
   */
  @Param disabled: boolean = false;
  /**
   * 加载状态
   */
  @Param loading: boolean = false;
  /**
   * 加粗字体
   */
  @Param bold: boolean = false;
  /**
   * 自定义字体大小
   */
  @Param fontSize: number | string | undefined = undefined;
  /**
   * 自定义背景色
   */
  @Param bgColor: ResourceColor | undefined = undefined;
  /**
   * 自定义文字色
   */
  @Param textColor: ResourceColor | undefined = undefined;
  /**
   * 自定义边框色
   */
  @Param btnBorderColor: ResourceColor | undefined = undefined;
  /**
   * 显示阴影
   */
  @Param showShadow: boolean = false;
  /**
   * 阴影颜色
   */
  @Param shadowColor: ResourceColor | undefined = undefined;
  /**
   * 图标名称（使用 TnIcon）
   */
  @Param icon: string = "";
  /**
   * 自定义宽度
   */
  @Param btnWidth: number | string | undefined = undefined;
  /**
   * 自定义高度
   */
  @Param btnHeight: number | string | undefined = undefined;
  /**
   * 点击防抖（250ms）
   */
  @Param debounce: boolean = false;
  /**
   * 按钮文本
   */
  @Param content: ResourceStr = "";
  /**
   * 点击回调
   */
  @Event onBtnClick: () => void = () => {
  };
  /**
   * 自定义内容插槽
   */
  @BuilderParam defaultBuilder: CustomBuilder;
  /**
   * 上次点击时间戳（防抖用）
   */
  @Local private lastClickTime: number = 0;

  /**
   * 获取当前按钮的尺寸配置
   * @returns 尺寸配置
   */
  private getSizeConfig(): TnButtonSizeConfig {
    return getButtonSizeConfig(this.btnSize);
  }

  /**
   * 获取解析后的按钮高度
   * @returns 高度字符串
   */
  private getResolvedHeight(): string {
    if (this.btnHeight !== undefined) {
      if (typeof this.btnHeight === "number") {
        return getSizeByUnit(this.btnHeight);
      }
      return this.btnHeight;
    }
    return convertDimensionsWidthUnit(this.getSizeConfig().height);
  }

  /**
   * 获取解析后的按钮宽度
   * @returns 宽度字符串或 undefined（自适应）
   */
  private getResolvedWidth(): string | undefined {
    if (this.btnWidth !== undefined) {
      if (typeof this.btnWidth === "number") {
        return getSizeByUnit(this.btnWidth);
      }
      return this.btnWidth;
    }
    if (this.shape === "circle") {
      return this.getResolvedHeight();
    }
    return undefined;
  }

  /**
   * 获取解析后的字体大小
   * @returns 字体大小字符串
   */
  private getResolvedFontSize(): string {
    if (this.fontSize !== undefined) {
      if (typeof this.fontSize === "number") {
        return getSizeByUnit(this.fontSize, true);
      }
      return this.fontSize;
    }
    const config: TnButtonSizeConfig = this.getSizeConfig();
    return getFontSizeByKey(this.baseStyle, config.fontSizeKey);
  }

  /**
   * 获取解析后的背景色
   * @returns 背景颜色
   */
  private getResolvedBgColor(): ResourceColor {
    if (this.textMode) {
      return Color.Transparent;
    }
    if (this.plain) {
      if (this.bgColor !== undefined) {
        return this.bgColor;
      }
      return getThemeColorLight(this.baseStyle, this.type);
    }
    if (this.bgColor !== undefined) {
      return this.bgColor;
    }
    return getThemeColor(this.baseStyle, this.type);
  }

  /**
   * 获取解析后的文字色
   * @returns 文字颜色
   */
  private getResolvedTextColor(): ResourceColor {
    if (this.textColor !== undefined) {
      return this.textColor;
    }
    if (this.textMode || this.plain) {
      return getThemeColor(this.baseStyle, this.type);
    }
    return $r("app.color.tn_color_white");
  }

  /**
   * 获取解析后的边框色
   * @returns 边框颜色
   */
  private getResolvedBorderColor(): ResourceColor {
    if (this.btnBorderColor !== undefined) {
      return this.btnBorderColor;
    }
    if (this.plain) {
      return getThemeColor(this.baseStyle, this.type);
    }
    return Color.Transparent;
  }

  /**
   * 获取解析后的圆角
   * @returns 圆角值
   */
  private getResolvedBorderRadius(): string {
    if (this.shape === "round") {
      return this.baseStyle.borderRadiusMax;
    }
    if (this.shape === "circle") {
      return convertDimensionsWidthUnit(this.getSizeConfig().height / 2);
    }
    return this.baseStyle.borderRadius;
  }

  /**
   * 获取按钮透明度
   * @returns 透明度值
   */
  private getResolvedOpacity(): number {
    if (this.disabled) {
      if (this.plain || this.textMode) {
        return 0.5;
      }
      return 0.6;
    }
    return 1;
  }

  /**
   * 获取水平内边距
   * @returns 水平内边距字符串
   */
  private getResolvedPaddingHorizontal(): string {
    if (this.shape === "circle") {
      return "0vp";
    }
    return convertDimensionsWidthUnit(this.getSizeConfig().paddingHorizontal);
  }

  /**
   * 处理按钮点击事件（含防抖逻辑）
   */
  private handleClick(): void {
    if (this.disabled || this.loading) {
      return;
    }
    if (this.debounce) {
      const now: number = Date.now();
      if (now - this.lastClickTime < DEBOUNCE_INTERVAL) {
        return;
      }
      this.lastClickTime = now;
    }
    this.onBtnClick();
  }

  build() {
    Button({ type: ButtonType.Normal }) {
      if (this.defaultBuilder) {
        this.defaultBuilder();
      } else {
        this.ButtonContentBuilder();
      }
    }
    .width(this.getResolvedWidth())
    .height(this.getResolvedHeight())
    .padding({
      left: this.getResolvedPaddingHorizontal(),
      right: this.getResolvedPaddingHorizontal(),
      top: 0,
      bottom: 0
    })
    .backgroundColor(this.getResolvedBgColor())
    .fontColor(this.getResolvedTextColor())
    .borderWidth(this.plain ? 1 : 0)
    .borderColor(this.getResolvedBorderColor())
    .borderRadius(this.getResolvedBorderRadius())
    .opacity(this.getResolvedOpacity())
    .enabled(!this.disabled)
    .hitTestBehavior(this.loading ? HitTestMode.None : HitTestMode.Default)
    .stateEffect(!this.disabled && !this.loading)
    .shadow(this.showShadow
      ? {
          radius: this.baseStyle.shadowMd.radius,
          color: this.shadowColor !== undefined ? this.shadowColor : getThemeColor(this.baseStyle, this.type),
          offsetX: this.baseStyle.shadowMd.offsetX,
          offsetY: this.baseStyle.shadowMd.offsetY
        }
      : { radius: 0, color: Color.Transparent, offsetX: 0, offsetY: 0 })
    .opacity(this.getResolvedOpacity())
    .animation({ duration: this.baseStyle.animationDuration })
    .onClick(() => {
      this.handleClick();
    });
  }

  /**
   * 按钮内容构建器（图标 + 文本）
   */
  @Builder
  private ButtonContentBuilder(): void {
    Row({ space: this.baseStyle.spaceBase }) {
      if (this.loading) {
        LoadingProgress()
          .width(this.getResolvedFontSize())
          .height(this.getResolvedFontSize())
          .color(this.getResolvedTextColor());
      } else if (this.icon.length > 0) {
        TnIcon({
          name: this.icon,
          color: this.getResolvedTextColor(),
          iconSize: this.getResolvedFontSize()
        }).enabled(false);
      }
      if (this.content !== "") {
        Text(this.content)
          .fontSize(this.getResolvedFontSize())
          .fontColor(this.getResolvedTextColor())
          .fontWeight(this.bold ? FontWeight.Bold : FontWeight.Normal)
          .lineHeight(this.baseStyle.lineHeightSm);
      }
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center);
  }
}
