/**
 * @file TnTag 标签组件
 * @description 支持多种颜色类型、尺寸、形状、边框、朴素模式、可关闭等
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { getFontSizeByKey, getThemeColor, getThemeColorLight } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { ContextUtil } from "../../utils/ContextUtil";
import { getSizeByUnit, convertDimensionsWidthUnit } from "../../utils/Utils";
import { TnIcon } from "../icon/TnIcon";
import { TnTagColorType, TnTagShapeType, TnTagSizeConfig, TnTagSizeType } from "./TnTagTypes";

/** 关闭图标尺寸(vp) */
const CLOSE_ICON_SIZE: number = 12;

/**
 * 根据尺寸类型获取标签尺寸配置
 * @param size 尺寸类型
 * @returns 尺寸配置
 */
function getTagSizeConfig(size: TnTagSizeType | undefined): TnTagSizeConfig {
  switch (size) {
    case "sm":
      return { height: 18, paddingHorizontal: 5, fontSizeKey: "fontSizeXs" };
    case "lg":
      return { height: 28, paddingHorizontal: 10, fontSizeKey: "fontSizeSm" };
    case "xl":
      return { height: 34, paddingHorizontal: 12, fontSizeKey: "fontSize" };
    default:
      return { height: 22, paddingHorizontal: 8, fontSizeKey: "fontSizeXs" };
  }
}

/**
 * TnTag 标签组件
 *
 * @example
 * // 基础标签
 * TnTag({ text: "标签" })
 *
 * // 带主题类型
 * TnTag({ text: "成功", type: "success" })
 *
 * // 朴素标签
 * TnTag({ text: "朴素", type: "primary", plain: true })
 *
 * // 圆形标签
 * TnTag({ text: "圆形", type: "warning", shape: "circle" })
 *
 * // 可关闭标签
 * TnTag({ text: "可关闭", type: "danger", closeable: true })
 */
@ComponentV2
export struct TnTag {
  /**
   * 全局基础样式（响应式绑定，主题切换时自动更新）
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /**
   * 标签颜色类型
   */
  @Param type: TnTagColorType = "primary";
  /**
   * 标签尺寸
   */
  @Param tagSize: TnTagSizeType | undefined = undefined;
  /**
   * 标签形状
   */
  @Param shape: TnTagShapeType | undefined = undefined;
  /**
   * 标签文本
   */
  @Param text: ResourceStr = "";
  /**
   * 自定义背景色
   */
  @Param bgColor: ResourceColor | undefined = undefined;
  /**
   * 自定义文字色
   */
  @Param textColor: ResourceColor | undefined = undefined;
  /**
   * 是否显示边框
   */
  @Param showBorder: boolean = false;
  /**
   * 自定义边框色
   */
  @Param tagBorderColor: ResourceColor | undefined = undefined;
  /**
   * 边框是否加粗
   */
  @Param borderBold: boolean = false;
  /**
   * 是否加粗字体
   */
  @Param bold: boolean = false;
  /**
   * 自定义字体大小
   */
  @Param fontSize: number | string | undefined = undefined;
  /**
   * 自定义宽度
   */
  @Param tagWidth: number | string | undefined = undefined;
  /**
   * 自定义高度
   */
  @Param tagHeight: number | string | undefined = undefined;
  /**
   * 朴素模式（透明背景 + 主题色边框和文字）
   */
  @Param plain: boolean = false;
  /**
   * 是否可关闭
   */
  @Param closeable: boolean = false;
  /**
   * 标签点击回调
   */
  @Event onTagClick: () => void = () => {
  };
  /**
   * 关闭回调
   */
  @Event onClose: () => void = () => {
  };
  /**
   * 自定义内容插槽
   */
  @BuilderParam defaultBuilder: CustomBuilder;
  /**
   * 是否可见（内部状态，用于关闭动画）
   */
  @Local private visible: boolean = true;

  /**
   * 获取当前标签的尺寸配置
   * @returns 尺寸配置
   */
  private getSizeConfig(): TnTagSizeConfig {
    return getTagSizeConfig(this.tagSize);
  }

  /**
   * 获取解析后的标签高度
   * @returns 高度字符串
   */
  private getResolvedHeight(): string {
    if (this.tagHeight !== undefined) {
      if (typeof this.tagHeight === "number") {
        return getSizeByUnit(this.tagHeight);
      }
      return this.tagHeight;
    }
    return convertDimensionsWidthUnit(this.getSizeConfig().height);
  }

  /**
   * 获取解析后的标签宽度
   * @returns 宽度字符串或 undefined（自适应）
   */
  private getResolvedWidth(): string | undefined {
    if (this.tagWidth !== undefined) {
      if (typeof this.tagWidth === "number") {
        return getSizeByUnit(this.tagWidth);
      }
      return this.tagWidth;
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
    const config: TnTagSizeConfig = this.getSizeConfig();
    return getFontSizeByKey(this.baseStyle, config.fontSizeKey);
  }

  /**
   * 获取解析后的背景色
   * @returns 背景颜色
   */
  private getResolvedBgColor(): ResourceColor {
    if (this.plain) {
      return Color.Transparent;
    }
    if (this.bgColor !== undefined) {
      return this.bgColor;
    }
    return getThemeColorLight(this.baseStyle, this.type);
  }

  /**
   * 获取解析后的文字色
   * @returns 文字颜色
   */
  private getResolvedTextColor(): ResourceColor {
    if (this.textColor !== undefined) {
      return this.textColor;
    }
    return getThemeColor(this.baseStyle, this.type);
  }

  /**
   * 获取解析后的边框色
   * @returns 边框颜色
   */
  private getResolvedBorderColor(): ResourceColor {
    if (this.tagBorderColor !== undefined) {
      return this.tagBorderColor;
    }
    if (this.plain) {
      return getThemeColor(this.baseStyle, this.type);
    }
    if (this.showBorder) {
      return getThemeColor(this.baseStyle, this.type);
    }
    return Color.Transparent;
  }

  /**
   * 判断是否需要显示边框
   * @returns 是否需要边框
   */
  private hasBorder(): boolean {
    return this.showBorder || this.plain || this.tagBorderColor !== undefined;
  }

  /**
   * 获取边框宽度
   * @returns 边框宽度
   */
  private getResolvedBorderWidth(): number {
    if (!this.hasBorder()) {
      return 0;
    }
    return this.borderBold ? 2 : 1;
  }

  /**
   * 获取解析后的圆角
   * @returns 圆角值
   */
  private getResolvedBorderRadius(): BorderRadiuses | string {
    const config: TnTagSizeConfig = this.getSizeConfig();
    const maxRadius: string = this.baseStyle.borderRadiusMax;
    const defaultRadius: string = this.baseStyle.borderRadiusSm;

    switch (this.shape) {
      case "circle":
        return maxRadius;
      case "round":
        return defaultRadius;
      case "circleLeft": {
        const halfHeight: number = config.height / 2;
        return {
          topLeft: convertDimensionsWidthUnit(halfHeight),
          topRight: 0,
          bottomLeft: convertDimensionsWidthUnit(halfHeight),
          bottomRight: 0
        } as BorderRadiuses;
      }
      case "circleRight": {
        const halfHeight: number = config.height / 2;
        return {
          topLeft: 0,
          topRight: convertDimensionsWidthUnit(halfHeight),
          bottomLeft: 0,
          bottomRight: convertDimensionsWidthUnit(halfHeight)
        } as BorderRadiuses;
      }
      default:
        return defaultRadius;
    }
  }

  /**
   * 获取水平内边距
   * @returns 水平内边距字符串
   */
  private getResolvedPaddingHorizontal(): string {
    return  convertDimensionsWidthUnit(this.getSizeConfig().paddingHorizontal);
  }

  /**
   * 处理标签点击事件
   */
  private handleClick(): void {
    this.onTagClick();
  }

  /**
   * 处理关闭事件
   */
  private handleClose(): void {
    this.visible = false;
    this.onClose();
  }

  build() {
    if (this.visible) {
      Row({ space: this.baseStyle.spaceBase }) {
        if (this.defaultBuilder) {
          this.defaultBuilder();
        } else {
          this.TagContentBuilder();
        }
        if (this.closeable) {
          TnIcon({
            name: "close",
            color: this.getResolvedTextColor(),
            iconSize: CLOSE_ICON_SIZE,
            onIconClick: (): void => {
              ContextUtil.getUICtx().animateTo({ duration: this.baseStyle.animationDuration }, () => this.handleClose());
            }
          });
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
      .borderWidth(this.getResolvedBorderWidth())
      .borderColor(this.getResolvedBorderColor())
      .borderRadius(this.getResolvedBorderRadius())
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .onClick(() => {
        this.handleClick();
      })
      .stateStyles({
        normal: {
          .opacity(1.0)
        },
        pressed: {
          .opacity(0.7)
        }
      })
      .animation({ duration: this.baseStyle.animationDuration })
      .transition(TransitionEffect.OPACITY);
    }
  }

  /**
   * 标签内容构建器（文本）
   */
  @Builder
  private TagContentBuilder(): void {
    Text(this.text)
      .fontSize(this.getResolvedFontSize())
      .fontColor(this.getResolvedTextColor())
      .fontWeight(this.bold ? FontWeight.Bold : FontWeight.Normal)
      .lineHeight(this.baseStyle.lineHeightXs)
      .maxLines(1)
      .textOverflow({ overflow: TextOverflow.Ellipsis });
  }
}
