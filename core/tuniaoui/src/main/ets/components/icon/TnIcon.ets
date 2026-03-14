/**
 * @file TnIcon 图标组件
 * @description 支持字体图标和图片图标，可自定义颜色、尺寸、加粗等
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { getThemeColor } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { getSizeByUnit } from "../../utils/Utils";
import { TN_ICON_DATA } from "./TnIconData";
import { TnIconColorType } from "./TnIconTypes";

/**
 * 判断图标名称是否为图片路径
 * @param name 图标名称
 * @returns 是否为图片图标
 */
function isImageIcon(name: string | Resource): boolean {
  if (typeof name !== "string") {
    return true;
  }
  if (name.length === 0) {
    return false;
  }
  return name.indexOf("/") >= 0 || name.startsWith("http");
}

/**
 * TnIcon 图标组件
 *
 * @example
 * // 字体图标
 * TnIcon({ name: "home" })
 *
 * // 带颜色的图标
 * TnIcon({ name: "home", type: "primary" })
 *
 * // 图片图标
 * TnIcon({ name: "https://example.com/icon.png", iconSize: 40 })
 *
 * // 带背景色和圆角的图标
 * TnIcon({ name: "home", color: Color.White, bgColor: "#01beff", iconPadding: 10, iconRadius: 8 })
 */
@ComponentV2
export struct TnIcon {
  /**
   * 全局基础样式（响应式绑定，主题切换时自动更新）
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /**
   * 图标名称或图片路径
   */
  @Require @Param name: string | Resource = "";
  /**
   * 自定义图标颜色
   */
  @Param color: ResourceColor | undefined = undefined;
  /**
   * 主题颜色类型
   */
  @Param type: TnIconColorType | undefined = undefined;
  /**
   * 图标尺寸
   */
  @Param iconSize: number | string | undefined = undefined;
  /**
   * 是否加粗
   */
  @Param bold: boolean = false;
  /**
   * 图标圆角
   */
  @Param iconRadius: Length = 0;
  /**
   * 图标背景色，设置后图标会包裹在带背景色的容器中
   */
  @Param bgColor: ResourceColor | undefined = undefined;
  /**
   * 图标内间距，配合 bgColor 使用，控制图标与背景边缘的距离
   */
  @Param iconPadding: number | Padding | undefined = undefined;
  /**
   * 自定义字体名称
   */
  @Param customFontName: string = "";
  /**
   * 点击回调
   */
  @Event onIconClick: (event: ClickEvent) => void = (event: ClickEvent) => {};

  /**
   * 获取解析后的图标尺寸字符串
   * @returns 尺寸字符串
   */
  private getResolvedSize(): string {
    if (this.iconSize !== undefined) {
      if (typeof this.iconSize === "number") {
        return getSizeByUnit(this.iconSize, true);
      }
      return this.iconSize;
    }
    return this.baseStyle.fontSizeLg;
  }

  /**
   * 获取解析后的图标颜色
   * @returns 图标颜色或 undefined
   */
  private getResolvedColor(): ResourceColor | undefined {
    if (this.color !== undefined) {
      return this.color;
    }
    if (this.type !== undefined) {
      return getThemeColor(this.baseStyle, this.type);
    }
    return undefined;
  }

  /**
   * 获取字体图标对应的 Unicode 字符
   * @returns Unicode 字符，未找到时返回空字符串
   */
  private getIconUnicode(): string {
    const unicode: string | undefined = TN_ICON_DATA[this.name as string];
    if (unicode !== undefined) {
      return unicode;
    }
    return "";
  }

  /**
   * 获取实际使用的字体名称
   * @returns 字体名称
   */
  private getFontName(): string {
    if (this.customFontName.length > 0) {
      return this.customFontName;
    }
    return "TnFont";
  }

  /**
   * 获取解析后的内间距
   * @returns 内间距值
   */
  private getResolvedPadding(): number | string | Padding {
    if (this.iconPadding !== undefined) {
      return this.iconPadding;
    }
    return this.baseStyle.spaceXsm;
  }

  build() {
    if (this.bgColor !== undefined) {
      Column() {
        if (isImageIcon(this.name)) {
          this.ImageIconBuilder();
        } else {
          this.FontIconBuilder();
        }
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .padding(this.getResolvedPadding())
      .backgroundColor(this.bgColor)
      .borderRadius(this.iconRadius)
      .onClick((event: ClickEvent) => {
        this.onIconClick(event);
      });
    } else {
      if (isImageIcon(this.name)) {
        this.NoBgImageIconBuilder();
      } else {
        this.NoBgFontIconBuilder();
      }
    }
  }

  /**
   * 无背景色 - 字体图标渲染（含圆角和点击）
   */
  @Builder
  private NoBgFontIconBuilder(): void {
    Text(this.getIconUnicode())
      .fontFamily(this.getFontName())
      .fontSize(this.getResolvedSize())
      .fontWeight(this.bold ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(this.getResolvedColor())
      .borderRadius(this.iconRadius)
      .onClick((event: ClickEvent) => {
        this.onIconClick(event);
      });
  }

  /**
   * 无背景色 - 图片图标渲染（含圆角和点击）
   */
  @Builder
  private NoBgImageIconBuilder(): void {
    Image(this.name)
      .width(this.getResolvedSize())
      .height(this.getResolvedSize())
      .objectFit(ImageFit.Contain)
      .borderRadius(this.iconRadius)
      .onClick((event: ClickEvent) => {
        this.onIconClick(event);
      });
  }

  /**
   * 字体图标渲染
   */
  @Builder
  private FontIconBuilder(): void {
    Text(this.getIconUnicode())
      .fontFamily(this.getFontName())
      .fontSize(this.getResolvedSize())
      .fontWeight(this.bold ? FontWeight.Bold : FontWeight.Normal)
      .fontColor(this.getResolvedColor());
  }

  /**
   * 图片图标渲染
   */
  @Builder
  private ImageIconBuilder(): void {
    Image(this.name)
      .width(this.getResolvedSize())
      .height(this.getResolvedSize())
      .objectFit(ImageFit.Contain);
  }
}
