/**
 * @file TnList 列表容器组件
 * @description 用于将多个 TnListItem 组织为一个分组，支持标题、描述、卡片风格、边框等
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { getFontSizeByKey } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";

/**
 * TnList 列表容器组件
 *
 * @example
 * // 基础分组
 * TnList({ title: "分组标题" }) {
 *   TnListItem({ title: "列表项1", bottomBorder: true })
 *   TnListItem({ title: "列表项2" })
 * }
 *
 * // 卡片风格（类似 GroupCard）
 * TnList({ title: "标题", description: "描述文字", card: true }) {
 *   TnListItem({ title: "列表项1", rightIcon: "right", bottomBorder: true })
 *   TnListItem({ title: "列表项2", rightIcon: "right" })
 * }
 */
@ComponentV2
export struct TnList {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /**
   * 分组标题
   */
  @Param title: ResourceStr = "";
  /**
   * 分组描述（显示在标题下方）
   */
  @Param description: ResourceStr = "";
  /**
   * 是否为卡片风格（白色背景 + 圆角 + 内边距，列表项自动缩进）
   */
  @Param card: boolean = false;
  /**
   * 是否为列表项内嵌缩进风格（圆角 + 外边距）
   */
  @Param inset: boolean = false;
  /**
   * 是否显示外边框
   */
  @Param hasBorder: boolean = true;
  /**
   * 圆角大小（card / inset 模式有效）
   */
  @Param radius: Length | undefined = undefined;
  /**
   * 标题字重
   */
  @Param titleFontWeight: FontWeight = FontWeight.Normal;
  /**
   * 标题内边距
   */
  @Param titlePadding: Padding | Length | undefined = undefined;
  /**
   * 外边距（inset 模式有效）
   */
  @Param outerMargin: Padding | Length | undefined = undefined;
  /**
   * 默认内容插槽
   */
  @BuilderParam defaultBuilder: CustomBuilder;

  /**
   * 获取解析后的圆角
   * @returns 圆角值
   */
  private getResolvedRadius(): Length {
    if (this.radius !== undefined) {
      return this.radius;
    }
    if (this.card) {
      return this.baseStyle.borderRadiusXxl;
    }
    return this.baseStyle.borderRadiusLg;
  }

  /**
   * 获取解析后的标题内边距
   * @returns 标题内边距
   */
  private getResolvedTitlePadding(): Padding {
    if (this.titlePadding !== undefined) {
      if (typeof this.titlePadding === "number" || typeof this.titlePadding === "string") {
        return {
          top: this.titlePadding as Length,
          bottom: this.titlePadding as Length,
          left: this.titlePadding as Length,
          right: this.titlePadding as Length
        };
      }
      return this.titlePadding as Padding;
    }
    if (this.card) {
      return {
        top: this.baseStyle.spaceMd,
        bottom: this.baseStyle.spaceXsm,
        left: this.baseStyle.spaceMd,
        right: this.baseStyle.spaceMd
      };
    }
    return {
      top: this.baseStyle.spaceXsm,
      bottom: this.baseStyle.spaceXsm,
      left: this.baseStyle.space,
      right: this.baseStyle.space
    };
  }

  /**
   * 获取解析后的外边距
   * @returns 外边距
   */
  private getResolvedOuterMargin(): Padding | Length | number {
    if (this.inset) {
      if (this.outerMargin !== undefined) {
        return this.outerMargin;
      }
      return {
        left: this.baseStyle.spaceMd,
        right: this.baseStyle.spaceMd
      };
    }
    return 0;
  }

  /**
   * 获取边框宽度
   * @returns 边框宽度
   */
  private getBorderWidth(): number {
    if (this.card || this.inset) {
      return 0;
    }
    return this.hasBorder ? 1 : 0;
  }

  /**
   * 获取标题字体大小
   * @returns 字体大小键名
   */
  private getTitleFontSizeKey(): string {
    if (this.card) {
      return "fontSizeLg";
    }
    return "fontSizeSm";
  }

  /**
   * 获取标题颜色
   * @returns 标题颜色
   */
  private getTitleColor(): ResourceColor {
    if (this.card) {
      return $r("app.color.tn_text_color_primary");
    }
    return $r("app.color.tn_text_color_secondary");
  }

  /**
   * 获取标题字重
   * @returns 字重值
   */
  private getResolvedTitleFontWeight(): FontWeight {
    if (this.card && this.titleFontWeight === FontWeight.Normal) {
      return FontWeight.Bold;
    }
    return this.titleFontWeight;
  }

  build() {
    Column() {
      // 标题区域
      if (this.title || this.description) {
        Column() {
          if (this.title) {
            Text(this.title)
              .textAlign(TextAlign.Start)
              .width("100%")
              .fontSize(getFontSizeByKey(this.baseStyle, this.getTitleFontSizeKey()))
              .fontColor(this.getTitleColor())
              .fontWeight(this.getResolvedTitleFontWeight())
              .lineHeight(this.card ? this.baseStyle.lineHeightMd : this.baseStyle.lineHeightXsm);
          }

          if (this.description) {
            Text(this.description)
              .textAlign(TextAlign.Start)
              .width("100%")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
              .fontColor($r("app.color.tn_text_color_secondary"))
              .margin({ top: this.baseStyle.spaceBase })
              .lineHeight(this.baseStyle.lineHeightXs);
          }
        }
        .width("100%")
        .padding(this.getResolvedTitlePadding())
        .alignItems(HorizontalAlign.Start);
      }

      // 内容区域
      if (this.defaultBuilder) {
        Column() {
          this.defaultBuilder();
        }
        .width("100%")
        .alignItems(HorizontalAlign.Start)
        .borderRadius(this.inset ? this.getResolvedRadius() : 0)
        .clip(this.inset);
      }
    }
    .width("100%")
    .backgroundColor(this.card ? $r("app.color.tn_bg_color") : Color.Transparent)
    .borderRadius(this.card ? this.getResolvedRadius() : 0)
    .clip(this.card)
    .padding(this.card ? { bottom: this.baseStyle.spaceXsm } : 0)
    .border({
      width: {
        bottom: this.getBorderWidth(),
        top: this.title ? 0 : this.getBorderWidth()
      },
      color: $r("app.color.tn_list_border_color")
    })
    .margin(this.getResolvedOuterMargin());
  }
}
