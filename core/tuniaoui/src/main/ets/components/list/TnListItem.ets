/**
 * @file TnListItem 列表项组件
 * @description 用于展示列表数据的单个列表项，支持文本内容、右侧图标、底部边框、圆角、点击反馈等
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { getFontSizeByKey } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { getSizeByUnit } from "../../utils/Utils";
import { getHexColorByResoure, mixWithBlack } from "../../utils/ColorUtils";
import { TnIcon } from "../icon/TnIcon";

/**
 * TnListItem 列表项组件
 *
 * @example
 * // 基础用法
 * TnListItem({ title: "联系客服" })
 *
 * // 带右侧图标
 * TnListItem({ title: "设置", rightIcon: "right" })
 *
 * // 带底部边框
 * TnListItem({ title: "订单", bottomBorder: true })
 */
@ComponentV2
export struct TnListItem {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /**
   * 列表项文本内容
   */
  @Param title: ResourceStr = "";
  /**
   * 列表项描述（显示在标题下方，次要色小字）
   */
  @Param description: ResourceStr = "";
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
   * 右侧图标名称（不填则不显示）
   */
  @Param rightIcon: string = "";
  /**
   * 右侧图标颜色
   */
  @Param rightIconColor: ResourceColor | undefined = undefined;
  /**
   * 右侧图标大小
   */
  @Param rightIconSize: number | string | undefined = undefined;
  /**
   * 是否显示圆角
   */
  @Param radius: boolean = false;
  /**
   * 是否显示底部边框
   */
  @Param bottomBorder: boolean = false;
  /**
   * 底部边框是否缩进
   */
  @Param bottomBorderIndent: boolean = false;
  /**
   * 底部边框颜色
   */
  @Param dividerColor: ResourceColor | undefined = undefined;
  /**
   * 是否可点击（开启点击反馈）
   */
  @Param clickable: boolean = false;
  /**
   * 是否禁用
   */
  @Param disabled: boolean = false;
  /**
   * 自定义内边距
   */
  @Param listPadding: Padding | Length | undefined = undefined;
  /**
   * 点击事件回调
   */
  @Event onItemClick: () => void = () => {
  };
  /**
   * 自定义内容插槽（优先级高于 title）
   */
  @BuilderParam defaultBuilder: CustomBuilder;

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
    return getFontSizeByKey(this.baseStyle, "fontSize");
  }

  /**
   * 获取解析后的背景色
   * @returns 背景颜色
   */
  private getResolvedBgColor(): ResourceColor {
    if (this.bgColor !== undefined) {
      return this.bgColor;
    }
    return $r("app.color.tn_bg_color");
  }

  /**
   * 获取解析后的文字色
   * @returns 文字颜色
   */
  private getResolvedTextColor(): ResourceColor {
    if (this.textColor !== undefined) {
      return this.textColor;
    }
    return $r("app.color.tn_text_color_primary");
  }

  /**
   * 获取解析后的右侧图标颜色
   * @returns 图标颜色
   */
  private getResolvedRightIconColor(): ResourceColor {
    if (this.rightIconColor !== undefined) {
      return this.rightIconColor;
    }
    return $r("app.color.tn_text_color_secondary");
  }

  /**
   * 获取解析后的右侧图标大小
   * @returns 图标大小
   */
  private getResolvedRightIconSize(): number | string {
    if (this.rightIconSize !== undefined) {
      return this.rightIconSize;
    }
    return 16;
  }

  /**
   * 获取解析后的边框颜色
   * @returns 边框颜色
   */
  private getResolvedBorderColor(): ResourceColor {
    if (this.dividerColor !== undefined) {
      return this.dividerColor;
    }
    return $r("app.color.tn_list_border_color");
  }

  /**
   * 获取解析后的内边距
   * @returns 内边距
   */
  private getResolvedPadding(): Padding | Length {
    if (this.listPadding !== undefined) {
      return this.listPadding;
    }
    return {
      top: this.baseStyle.spaceSm,
      bottom: this.baseStyle.spaceSm,
      left: this.baseStyle.space,
      right: this.baseStyle.space
    };
  }

  /**
   * 获取解析后的圆角
   * @returns 圆角值
   */
  private getResolvedBorderRadius(): string {
    if (this.radius) {
      return this.baseStyle.borderRadiusLg;
    }
    return "0";
  }

  /**
   * 是否具有点击行为
   * @returns 是否可点击
   */
  private hasClickBehavior(): boolean {
    return this.clickable || this.rightIcon.length > 0;
  }

  build() {
    Column() {
      Row() {
        // 内容区域
        Row() {
          if (this.defaultBuilder) {
            this.defaultBuilder();
          } else {
            Column() {
              Text(this.title)
                .fontSize(this.getResolvedFontSize())
                .fontColor(this.getResolvedTextColor())
                .lineHeight(this.baseStyle.lineHeightSm)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .width("100%");

              if (this.description) {
                Text(this.description)
                  .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
                  .fontColor($r("app.color.tn_text_color_secondary"))
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .margin({ top: this.baseStyle.spaceBase })
                  .lineHeight(this.baseStyle.lineHeightXs)
                  .width("100%");
              }
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start);
          }
        }
        .layoutWeight(1);

        // 右侧图标
        if (this.rightIcon.length > 0) {
          Row() {
            TnIcon({
              name: this.rightIcon,
              iconSize: this.getResolvedRightIconSize(),
              color: this.getResolvedRightIconColor()
            }).enabled(false);
          }
          .margin({ left: this.baseStyle.spaceXsm });
        }
      }
      .width("100%")
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding(this.getResolvedPadding());

      // 底部边框
      if (this.bottomBorder) {
        Divider()
          .width(this.bottomBorderIndent ? "95%" : "100%")
          .height(1)
          .color(this.getResolvedBorderColor());
      }
    }
    .width("100%")
    .backgroundColor(this.getResolvedBgColor())
    .borderRadius(this.getResolvedBorderRadius())
    .clip(this.radius)
    .stateStyles({
      normal: {
        .backgroundColor(this.getResolvedBgColor())
      },
      pressed: {
        .backgroundColor(this.hasClickBehavior() && !this.disabled
          ? mixWithBlack(getHexColorByResoure(this.getResolvedBgColor()))
          : this.getResolvedBgColor())
      }
    })
    .animation({ duration: this.baseStyle.animationDuration })
    .enabled(!this.disabled)
    .opacity(this.disabled ? 0.5 : 1)
    .onClick(() => {
      this.onItemClick();
    });
  }
}
