/**
 * @file TnEmpty 空白页组件
 * @description 用于数据为空时展示空白提示，支持 14 种预设模式及自定义图标/提示
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { getFontSizeByKey } from "../../common/theme_helpers";
import { convertDimensionsWidthUnit } from "../../utils/Utils";
import { TnIcon } from "../icon/TnIcon";
import { TnEmptyMode, TnEmptySizeType, TN_EMPTY_DEFAULT_TIPS } from "./TnEmptyTypes";

/** 默认图标尺寸 */
const DEFAULT_ICON_SIZE: number = 120;
/** 小尺寸图标 */
const SM_ICON_SIZE: number = 80;
/** 大尺寸图标 */
const LG_ICON_SIZE: number = 160;
/** 超大尺寸图标 */
const XL_ICON_SIZE: number = 200;

@ComponentV2
export struct TnEmpty {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /**
   * 空白提示类型
   */
  @Param mode: TnEmptyMode = "data";
  /**
   * 内容颜色
   */
  @Param color: ResourceColor = "";
  /**
   * 内容尺寸（预设值 "sm" | "lg" | "xl" 或自定义数值 vp）
   */
  @Param emptySize: TnEmptySizeType | number | undefined = undefined;
  /**
   * 是否显示提示文字
   */
  @Param showTips: boolean = true;
  /**
   * 自定义提示文案（优先于默认提示）
   */
  @Param tips: string = "";
  /**
   * 自定义图标插槽
   */
  @BuilderParam iconBuilder: CustomBuilder;
  /**
   * 自定义提示文字插槽
   */
  @BuilderParam tipsBuilder: CustomBuilder;
  /**
   * 底部自定义内容插槽
   */
  @BuilderParam defaultBuilder: CustomBuilder;

  /**
   * 获取图标名称
   * @returns 对应模式的图标名称
   */
  private getIconName(): string {
    return `empty-${this.mode}`;
  }

  /**
   * 获取提示文案
   * @returns 自定义文案或默认文案
   */
  private getTips(): string {
    if (this.tips) {
      return this.tips;
    }
    return TN_EMPTY_DEFAULT_TIPS[this.mode] ?? "";
  }

  /**
   * 获取图标尺寸
   * @returns 图标尺寸数值
   */
  private getIconSize(): number {
    if (typeof this.emptySize === "number") {
      return this.emptySize;
    }
    switch (this.emptySize) {
      case "sm":
        return SM_ICON_SIZE;
      case "lg":
        return LG_ICON_SIZE;
      case "xl":
        return XL_ICON_SIZE;
      default:
        return DEFAULT_ICON_SIZE;
    }
  }

  /**
   * 获取提示文字字体大小
   * @returns 字体大小字符串
   */
  private getTipsFontSize(): string {
    if (typeof this.emptySize === "number") {
      return convertDimensionsWidthUnit(Math.round(this.emptySize * 0.12), true);
    }
    switch (this.emptySize) {
      case "sm":
        return getFontSizeByKey(this.baseStyle, "fontSizeXs");
      case "lg":
        return getFontSizeByKey(this.baseStyle, "fontSizeLg");
      case "xl":
        return getFontSizeByKey(this.baseStyle, "fontSizeXl");
      default:
        return getFontSizeByKey(this.baseStyle, "fontSize");
    }
  }

  /**
   * 获取提示文字行高（与字体大小匹配）
   * @returns 行高字符串
   */
  private getTipsLineHeight(): string {
    if (typeof this.emptySize === "number") {
      return convertDimensionsWidthUnit(Math.round(this.emptySize * 0.16));
    }
    switch (this.emptySize) {
      case "sm":
        return this.baseStyle.lineHeightXs;
      case "lg":
        return this.baseStyle.lineHeightMd;
      case "xl":
        return this.baseStyle.lineHeightLg;
      default:
        return this.baseStyle.lineHeightSm;
    }
  }

  /**
   * 获取内容颜色
   * @returns 颜色值
   */
  private getContentColor(): ResourceColor {
    if (this.color) {
      return this.color;
    }
    return $r("app.color.tn_color_gray_disabled");
  }

  build() {
    Column({ space: this.baseStyle.spaceSm }) {
      // 图标区域
      if (this.iconBuilder) {
        this.iconBuilder();
      } else {
        TnIcon({
          name: this.getIconName(),
          color: this.getContentColor(),
          iconSize: this.getIconSize()
        })
      }

      // 提示文字区域
      if (this.tipsBuilder) {
        this.tipsBuilder();
      } else if (this.showTips) {
        Text(this.getTips())
          .fontSize(this.getTipsFontSize())
          .fontColor(this.getContentColor())
          .lineHeight(this.getTipsLineHeight())
          .textAlign(TextAlign.Center)
          .padding({
            left: this.baseStyle.spaceXl,
            right: this.baseStyle.spaceXl
          })
      }

      // 底部自定义内容
      if (this.defaultBuilder) {
        this.defaultBuilder();
      }
    }
    .width("100%")
    .alignItems(HorizontalAlign.Center)
    .padding({
      top: this.baseStyle.spaceLg,
      bottom: this.baseStyle.spaceLg
    })
  }
}
