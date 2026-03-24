/**
 * @file TnCollapseItem 折叠面板子项组件
 * @description 可展开/收起的单个面板项，配合 TnCollapse 使用
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { getFontSizeByKey } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { TnIcon } from "../icon/TnIcon";
import { getHexColorByResoure, mixWithBlack } from "../../utils/ColorUtils";
import { convertDimensionsWidthUnit } from "../../utils/Utils";
import tnEmitter from "../../utils/EventEmitter";
import { TN_COLLAPSE_EVENT, getTnCollapseEventName } from "./TnCollapseTypes";

/** 组件实例唯一 ID 计数器 */
let itemIdCounter = 0;

/** 标题区域最小高度 */
const TITLE_MIN_HEIGHT = 48;

/** 分割线粗细 */
const DIVIDER_STROKE_WIDTH = 0.5;

/** 禁用态透明度 */
const DISABLED_OPACITY = 0.4;

/** 首次渲染动画延迟，避免初始化时的展开闪烁 */
const INITIAL_ANIMATION_DELAY = 220;

/**
 * TnCollapseItem 折叠面板子项组件
 *
 * @example
 * TnCollapseItem({ groupId: "g1", name: 0, title: "面板标题" }) {
 *   Text("面板内容")
 * }
 */
@ComponentV2
export struct TnCollapseItem {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /**
   * 分组标识（须与父组件 TnCollapse 的 groupId 一致）
   */
  @Require @Param groupId: string = "";
  /**
   * 面板唯一标识
   */
  @Require @Param name: number = 0;
  /**
   * 面板标题文字
   */
  @Param title: ResourceStr = "";
  /**
   * 是否禁用（禁用后不可展开/收起）
   */
  @Param disabled: boolean = false;
  /**
   * 标题左侧图标名称
   */
  @Param icon: string = "";
  /**
   * 标题左侧图标颜色
   */
  @Param iconColor: ResourceColor = "";
  /**
   * 面板内容构建器
   */
  @BuilderParam defaultBuilder: CustomBuilder;
  /**
   * 是否展开
   */
  @Local private isExpand: boolean = false;
  /**
   * 是否显示箭头
   */
  @Local private showArrow: boolean = true;
  /**
   * 箭头颜色
   */
  @Local private arrowColor: ResourceColor = "";
  /**
   * 是否显示分割线
   */
  @Local private hasBorder: boolean = true;
  /**
   * 动画是否就绪（首次渲染跳过动画）
   */
  @Local private isReady: boolean = false;
  /**
   * 组件实例唯一 ID
   */
  @Local private uniId: string = "";

  aboutToAppear(): void {
    itemIdCounter++;
    this.uniId = `tn_collapse_item_${itemIdCounter}`;

    // 监听父组件广播的展开状态
    tnEmitter.on(
      getTnCollapseEventName(TN_COLLAPSE_EVENT.INIT_ITEM, this.groupId),
      this.uniId,
      (value: number | number[], accordion: boolean, showArrow: boolean, arrowColor: ResourceColor, hasBorder: boolean) => {
        this.showArrow = showArrow;
        this.arrowColor = arrowColor;
        this.hasBorder = hasBorder;
        this.updateExpandState(value, accordion);
      }
    );

    // 延迟启用动画，避免首次渲染时的闪烁
    setTimeout(() => {
      this.isReady = true;
    }, INITIAL_ANIMATION_DELAY);
  }

  aboutToDisappear(): void {
    tnEmitter.off(
      getTnCollapseEventName(TN_COLLAPSE_EVENT.INIT_ITEM, this.groupId),
      this.uniId
    );
  }

  /**
   * 根据父组件传来的 value 更新展开状态
   * @param value 当前展开面板标识
   * @param accordion 是否手风琴模式
   */
  private updateExpandState(value: number | number[], accordion: boolean): void {
    if (accordion) {
      this.isExpand = (value === this.name);
    } else {
      const arr: number[] = Array.isArray(value) ? value : [];
      this.isExpand = arr.indexOf(this.name) >= 0;
    }
  }

  /**
   * 处理标题区域点击
   */
  private handleTitleClick(): void {
    if (this.disabled) {
      return;
    }
    tnEmitter.emit(
      getTnCollapseEventName(TN_COLLAPSE_EVENT.ITEM_TOGGLE, this.groupId),
      this.name
    );
  }

  /**
   * 获取箭头颜色
   * @returns 箭头颜色值
   */
  private getArrowColor(): ResourceColor {
    if (this.arrowColor && this.arrowColor !== "") {
      return this.arrowColor;
    }
    return $r("app.color.tn_text_color_secondary");
  }

  /**
   * 获取动画时长
   * @returns 动画毫秒数
   */
  private getAnimationDuration(): number {
    return this.isReady ? this.baseStyle.animationDuration : 0;
  }

  build() {
    Column() {
      // 标题区域
      Row() {
        // 标题内容
        Row({ space: this.baseStyle.spaceXsm }) {
          if (this.icon.length > 0) {
            TnIcon({
              name: this.icon,
              iconSize: getFontSizeByKey(this.baseStyle, "fontSizeXl"),
              color: this.iconColor !== "" ? this.iconColor : $r("app.color.tn_text_color_primary")
            }).enabled(false)
          }
          Text(this.title)
            .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
            .fontColor($r("app.color.tn_text_color_primary"))
            .lineHeight(this.baseStyle.lineHeightSm)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis });
        }
        .layoutWeight(1)

        // 箭头图标
        if (this.showArrow) {
          TnIcon({
            name: "down",
            iconSize: getFontSizeByKey(this.baseStyle, "fontSizeLg"),
            color: this.getArrowColor()
          }).enabled(false)
            .rotate({ z: 1, angle: this.isExpand ? -180 : 0 })
            .animation({ duration: this.getAnimationDuration() })
        }
      }
      .width("100%")
      .constraintSize({ minHeight: convertDimensionsWidthUnit(TITLE_MIN_HEIGHT) })
      .padding({
        left: this.baseStyle.space,
        right: this.baseStyle.space,
        top: this.baseStyle.spaceMd,
        bottom: this.baseStyle.spaceMd
      })
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .enabled(!this.disabled)
      .opacity(this.disabled ? DISABLED_OPACITY : 1)
      .onClick(() => {
        this.handleTitleClick();
      })
      .stateStyles({
        normal: {
          .backgroundColor($r("app.color.tn_bg_color"))
        },
        pressed: {
          .backgroundColor(mixWithBlack(getHexColorByResoure($r("app.color.tn_bg_color"))))
        }
      })

      // 分割线
      if (this.hasBorder) {
        Divider()
          .width("100%")
          .strokeWidth(DIVIDER_STROKE_WIDTH)
          .color($r("app.color.tn_color_gray_disabled"))
          .padding({ left: this.baseStyle.space, right: this.baseStyle.space })
      }

      // 内容区域
      if (this.defaultBuilder) {
        Column() {
          this.defaultBuilder();
        }
        .width("100%")
        .padding({
          left: this.baseStyle.space,
          right: this.baseStyle.space,
          top: this.baseStyle.spaceMd,
          bottom: this.baseStyle.spaceMd
        })
        .visibility(this.isExpand ? Visibility.Visible : Visibility.None)
        .animation({ duration: this.getAnimationDuration() })
      }
    }
    .width("100%")
  }
}
