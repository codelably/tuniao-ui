/**
 * @file TnSwiper 轮播图组件
 * @description 支持多种切换动画效果（滑动、淡入淡出、缩放、卡片、翻转）的轮播图组件，
 *              提供圆点、线条、数字三种指示器样式。
 *              指示器由 fraction（onContentDidScroll 逐帧回调）连续驱动，与滑动完全同步；
 *              项目视觉效果（opacity/scale/rotate）由 innerIndex 离散驱动 + animation 补间，
 *              确保切换过程中有平滑的过渡动画。
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { getFontSizeByKey, getThemeColor, getTnShadow } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { SPACE } from "../../theme-chalk/space";
import { convertDimensionsWidthUnit, getSizeByUnit } from "../../utils/Utils";
import {
  TnSwiperEffect,
  TnSwiperIndicatorPosition,
  TnSwiperIndicatorType
} from "./TnSwiperTypes";

/** 默认轮播高度(vp) */
const DEFAULT_HEIGHT: number = 180;
/** 默认自动播放间隔(ms) */
const DEFAULT_INTERVAL: number = 5000;
/** 默认切换动画时长(ms) */
const DEFAULT_DURATION: number = 500;
/** 指示器圆点默认尺寸(vp)，对应 SPACE.XSM */
const DOT_SIZE: number = SPACE.XSM;
/** 指示器圆点选中时宽度(vp)，对应 SPACE.LG */
const DOT_ACTIVE_WIDTH: number = SPACE.LG;
/** 线条指示器总宽度(vp) */
const LINE_WIDTH: number = 60;
/** 线条指示器高度(vp)，对应 SPACE.BASE */
const LINE_HEIGHT: number = SPACE.BASE;
/** 卡片模式默认缩放比例 */
const CARD_SCALE_RATIO: number = 0.85;
/** 卡片模式默认露出边距(vp) */
const CARD_PEEK_MARGIN: number = 40;

/**
 * 线性插值
 * @param start 起始值
 * @param end 结束值
 * @param fraction 插值进度 (0~1)
 * @returns 插值后的值
 */
function lerp(start: number, end: number, fraction: number): number {
  return start + (end - start) * fraction;
}

/**
 * 将 TnSwiperIndicatorPosition 映射到 Stack 的 Alignment
 * @param position 指示器位置
 * @returns Alignment 枚举
 */
function resolveIndicatorAlignment(position: TnSwiperIndicatorPosition): Alignment {
  switch (position) {
    case "left-top":
      return Alignment.TopStart;
    case "center-top":
      return Alignment.Top;
    case "right-top":
      return Alignment.TopEnd;
    case "left-bottom":
      return Alignment.BottomStart;
    case "right-bottom":
      return Alignment.BottomEnd;
    default:
      return Alignment.Bottom;
  }
}

/**
 * TnSwiper 轮播图组件
 *
 * @example
 * // 基础用法
 * TnSwiper({ data: ["url1", "url2", "url3"] })
 *
 * // 自动播放 + 循环
 * TnSwiper({ data: urls, autoplay: true, loop: true })
 *
 * // 卡片效果
 * TnSwiper({ data: urls, effect: "card" })
 *
 * // 自定义指示器
 * TnSwiper({ data: urls, indicatorType: "number", indicatorPosition: "right-bottom" })
 */
@ComponentV2
export struct TnSwiper {
  /**
   * 全局基础样式（响应式绑定，主题切换时自动更新）
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /**
   * 当前选中的轮播项索引
   */
  @Param currentIndex: number = 0;
  /**
   * 轮播图数据（图片 URL 列表）
   */
  @Param data: string[] = [];
  /**
   * 轮播图宽度
   */
  @Param swiperWidth: string | number = "100%";
  /**
   * 轮播图高度
   */
  @Param swiperHeight: string | number = DEFAULT_HEIGHT;
  /**
   * 是否自动播放
   */
  @Param autoplay: boolean = false;
  /**
   * 自动播放间隔时间（毫秒）
   */
  @Param interval: number = DEFAULT_INTERVAL;
  /**
   * 切换动画时长（毫秒）
   */
  @Param duration: number = DEFAULT_DURATION;
  /**
   * 是否循环播放
   */
  @Param loop: boolean = false;
  /**
   * 前一项露出的间距(vp)
   */
  @Param previousMargin: number = 0;
  /**
   * 后一项露出的间距(vp)
   */
  @Param nextMargin: number = 0;
  /**
   * 项目之间的间距(vp)，当 previousMargin/nextMargin > 0 或卡片模式时默认使用 SPACE.SM
   */
  @Param itemSpace: number | undefined = undefined;
  /**
   * 是否显示指示器
   */
  @Param showIndicator: boolean = true;
  /**
   * 指示器位置
   */
  @Param indicatorPosition: TnSwiperIndicatorPosition = "center-bottom";
  /**
   * 指示器类型
   */
  @Param indicatorType: TnSwiperIndicatorType = "dot";
  /**
   * 指示器默认颜色
   */
  @Param indicatorBgColor: ResourceColor | undefined = undefined;
  /**
   * 指示器选中颜色
   */
  @Param indicatorActiveBgColor: ResourceColor | undefined = undefined;
  /**
   * 数字指示器文字颜色
   */
  @Param indicatorTextColor: ResourceColor | undefined = undefined;
  /**
   * 切换动画效果
   */
  @Param effect: TnSwiperEffect = "slide";
  /**
   * 图片显示模式
   */
  @Param imgMode: ImageFit = ImageFit.Cover;
  /**
   * 图片圆角
   */
  @Param imgBorderRadius: number | undefined = undefined;
  /**
   * 切换回调
   */
  @Event onChange: (index: number) => void = (_index: number) => {};
  /**
   * 点击回调
   */
  @Event onItemClick: (index: number) => void = (_index: number) => {};

  /**
   * 指示器 fraction（连续小数，如 0.0, 0.5, 1.0, 1.7 等）
   * 驱动指示器和项目效果的实时插值，与 Swiper 页面滑动完全同步
   */
  @Local private fraction: number = 0;
  /** 最终确认的当前索引（由 onChange 确认） */
  @Local private innerIndex: number = 0;
  /** Swiper 控制器 */
  private swiperController: SwiperController = new SwiperController();

  aboutToAppear(): void {
    this.innerIndex = this.currentIndex;
    this.fraction = this.currentIndex;
  }

  @Monitor("currentIndex")
  onCurrentIndexChange(): void {
    if (this.currentIndex !== this.innerIndex) {
      this.innerIndex = this.currentIndex;
      this.fraction = this.currentIndex;
    }
  }

  // ==================== 尺寸解析 ====================

  /**
   * 获取解析后的宽度
   * @returns 带单位的宽度值
   */
  private getResolvedWidth(): string | number {
    if (typeof this.swiperWidth === "number") {
      return getSizeByUnit(this.swiperWidth);
    }
    return this.swiperWidth;
  }

  /**
   * 获取解析后的高度
   * @returns 带单位的高度值
   */
  private getResolvedHeight(): string | number {
    if (typeof this.swiperHeight === "number") {
      return getSizeByUnit(this.swiperHeight);
    }
    return this.swiperHeight;
  }

  /**
   * 获取解析后的图片圆角
   * @returns 圆角值字符串
   */
  private getResolvedImgRadius(): string {
    if (this.imgBorderRadius !== undefined) {
      return convertDimensionsWidthUnit(this.imgBorderRadius);
    }
    return this.baseStyle.borderRadiusLg;
  }

  // ==================== 颜色解析 ====================

  /**
   * 获取指示器默认颜色
   * @returns 指示器默认背景色
   */
  private getIndicatorDefaultColor(): ResourceColor {
    if (this.indicatorBgColor !== undefined) {
      return this.indicatorBgColor;
    }
    return $r("app.color.tn_overlay_bg");
  }

  /**
   * 获取指示器选中颜色
   * @returns 指示器选中态背景色
   */
  private getIndicatorActiveColor(): ResourceColor {
    if (this.indicatorActiveBgColor !== undefined) {
      return this.indicatorActiveBgColor;
    }
    return getThemeColor(this.baseStyle, "primary");
  }

  /**
   * 获取数字指示器文字颜色
   * @returns 数字文字颜色
   */
  private getNumberTextColor(): ResourceColor {
    if (this.indicatorTextColor !== undefined) {
      return this.indicatorTextColor;
    }
    return $r("app.color.tn_color_white");
  }

  // ==================== 边距与间距 ====================

  /**
   * 获取前一项露出间距（卡片模式自动使用默认值）
   * @returns 前一项露出间距(vp)
   */
  private getResolvedPrevMargin(): number {
    if (this.effect === "card") {
      return this.previousMargin > 0 ? this.previousMargin : CARD_PEEK_MARGIN;
    }
    return this.previousMargin;
  }

  /**
   * 获取后一项露出间距（卡片模式自动使用默认值）
   * @returns 后一项露出间距(vp)
   */
  private getResolvedNextMargin(): number {
    if (this.effect === "card") {
      return this.nextMargin > 0 ? this.nextMargin : CARD_PEEK_MARGIN;
    }
    return this.nextMargin;
  }

  /**
   * 获取项目之间的间距
   * 当前后露出或卡片模式时，自动使用 SPACE.SM 间距
   * @returns 项间距(vp)
   */
  private getResolvedItemSpace(): number {
    if (this.itemSpace !== undefined) {
      return this.itemSpace;
    }
    const hasPeek: boolean = this.getResolvedPrevMargin() > 0 || this.getResolvedNextMargin() > 0;
    if (hasPeek || this.effect === "card") {
      return SPACE.SM;
    }
    return 0;
  }

  // ==================== 事件处理 ====================

  /**
   * 处理 Swiper 实时滚动回调（逐帧触发，手势/自动播放均触发）
   * 将 selectedIndex + position 转换为连续的 fraction 值，驱动所有视觉效果
   * @param selectedIndex 当前选中页索引
   * @param index 视口内页面索引
   * @param position 该页面相对 selectedIndex 的比例位移
   */
  private handleContentDidScroll(selectedIndex: number, index: number, position: number): void {
    // 仅处理 selectedIndex 对应页面的位移，避免重复计算
    if (index !== selectedIndex) {
      return;
    }
    // position 为页面偏移比例：向左滑出时为负值，向右滑出时为正值
    // 视口中心位置 = selectedIndex - position
    const raw: number = selectedIndex - position;
    // 近整数吸附：消除切换完成瞬间的微小越界（如 1.01 → 1），避免指示器闪烁
    const rounded: number = Math.round(raw);
    this.fraction = Math.abs(raw - rounded) < 0.01 ? rounded : raw;
    // 注意：循环模式下 fraction 可能超出 [0, length-1]（如 5 或 -1），
    // 由各指示器方法通过 wrapIndex 处理，此处不做 clamp
  }

  /**
   * 处理轮播切换完成
   * @param index 最终确认的索引
   */
  private handleChange(index: number): void {
    this.innerIndex = index;
    this.fraction = index;
    this.onChange(index);
  }

  // ==================== 项目效果计算（基于 innerIndex 离散驱动 + animation 补间） ====================

  /**
   * 根据动画效果计算不透明度
   * 当前页 opacity=1，非当前页根据效果降低
   * @param index 项索引
   * @returns 不透明度值 (0~1)
   */
  private getItemOpacity(index: number): number {
    const isCurrent: boolean = index === this.innerIndex;
    if (this.effect === "fade") {
      return isCurrent ? 1.0 : 0.3;
    }
    if (this.effect === "card") {
      return isCurrent ? 1.0 : 0.7;
    }
    return 1.0;
  }

  /**
   * 根据动画效果计算缩放比例
   * 当前页 scale=1，非当前页根据效果缩小
   * @param index 项索引
   * @returns 缩放比例
   */
  private getItemScale(index: number): number {
    const isCurrent: boolean = index === this.innerIndex;
    if (this.effect === "scale") {
      return isCurrent ? 1.0 : 0.8;
    }
    if (this.effect === "card") {
      return isCurrent ? 1.0 : CARD_SCALE_RATIO;
    }
    return 1.0;
  }

  /**
   * 根据动画效果计算旋转角度
   * 当前页 angle=0，左侧正角度，右侧负角度
   * @param index 项索引
   * @returns 旋转角度
   */
  private getItemRotation(index: number): number {
    if (this.effect === "flip") {
      if (index < this.innerIndex) {
        return 45;
      }
      if (index > this.innerIndex) {
        return -45;
      }
      return 0;
    }
    return 0;
  }

  // ==================== 指示器计算（基于 fraction 实时插值） ====================

  /**
   * 将索引 wrap 到 [0, count) 范围内，支持循环模式下的越界值
   * 例：count=5 时，wrapIndex(5)=0，wrapIndex(-1)=4
   * @param idx 原始索引（可能越界）
   * @returns wrap 后的有效索引
   */
  private wrapIndex(idx: number): number {
    const count: number = this.data.length;
    if (count <= 0) {
      return 0;
    }
    return ((idx % count) + count) % count;
  }

  /**
   * 获取 fraction 对应的当前索引（四舍五入 + wrap）
   * @returns 当前索引
   */
  private getFractionIndex(): number {
    return this.wrapIndex(Math.round(this.fraction));
  }

  /**
   * 获取 fraction 的小数部分（0~1 之间）
   * @returns 小数进度
   */
  private getFractionProgress(): number {
    const progress: number = this.fraction - Math.floor(this.fraction);
    return Math.max(0, Math.min(progress, 1));
  }

  /**
   * 计算圆点指示器中指定索引的宽度
   * 利用 fraction 在相邻两个点之间进行线性插值，循环模式下通过 wrap 处理越界
   * @param index 圆点索引
   * @returns 圆点宽度(vp)
   */
  private getDotWidth(index: number): number {
    const wrappedFloor: number = this.wrapIndex(Math.floor(this.fraction));
    const wrappedCeil: number = this.wrapIndex(Math.ceil(this.fraction));
    const progress: number = this.getFractionProgress();

    if (wrappedFloor === wrappedCeil) {
      return index === wrappedFloor ? DOT_ACTIVE_WIDTH : DOT_SIZE;
    }
    if (index === wrappedFloor) {
      return lerp(DOT_ACTIVE_WIDTH, DOT_SIZE, progress);
    }
    if (index === wrappedCeil) {
      return lerp(DOT_SIZE, DOT_ACTIVE_WIDTH, progress);
    }
    return DOT_SIZE;
  }

  /**
   * 判断指定索引的圆点是否处于活动状态（循环模式下通过 wrap 处理越界）
   * @param index 圆点索引
   * @returns 是否活动
   */
  private isDotActive(index: number): boolean {
    const wrappedFloor: number = this.wrapIndex(Math.floor(this.fraction));
    const wrappedCeil: number = this.wrapIndex(Math.ceil(this.fraction));
    return index === wrappedFloor || index === wrappedCeil;
  }

  /**
   * 计算线条指示器活动滑块的偏移量
   * 使用 wrap 后的 fraction 进行连续偏移，循环模式下正确回绕
   * @returns 偏移量(vp)
   */
  private getLineActiveOffset(): number {
    const count: number = this.data.length;
    if (count <= 0) {
      return 0;
    }
    // wrap fraction 到 [0, count) 范围
    const wrappedFraction: number = ((this.fraction % count) + count) % count;
    return (LINE_WIDTH / count) * wrappedFraction;
  }

  /**
   * 计算线条指示器活动滑块的宽度
   * @returns 滑块宽度(vp)
   */
  private getLineActiveWidth(): number {
    const count: number = this.data.length;
    if (count <= 0) {
      return 0;
    }
    return LINE_WIDTH / count;
  }

  // ==================== 构建方法 ====================

  build() {
    Stack({ alignContent: resolveIndicatorAlignment(this.indicatorPosition) }) {
      // 轮播内容
      Swiper(this.swiperController) {
        ForEach(this.data, (url: string, index: number) => {
          this.SwiperItemContent(url, index);
        }, (url: string, index: number) => `${this.effect}_${index}_${url}`);
      }
      .index(this.innerIndex)
      .autoPlay(this.autoplay)
      .interval(this.interval)
      .duration(this.duration)
      .loop(this.loop)
      .indicator(false)
      .prevMargin(convertDimensionsWidthUnit(this.getResolvedPrevMargin()))
      .nextMargin(convertDimensionsWidthUnit(this.getResolvedNextMargin()))
      .itemSpace(convertDimensionsWidthUnit(this.getResolvedItemSpace()))
      .onContentDidScroll((selectedIndex: number, index: number, position: number, _mainAxisLength: number) => {
        this.handleContentDidScroll(selectedIndex, index, position);
      })
      .onChange((index: number) => {
        this.handleChange(index);
      })
      .width("100%")
      .height("100%");

      // 指示器
      if (this.showIndicator && this.data.length > 1) {
        this.IndicatorContent();
      }
    }
    .width(this.getResolvedWidth())
    .height(this.getResolvedHeight())
    .clip(true);
  }

  /**
   * 单个轮播项内容
   * opacity/scale/rotate 由 innerIndex 离散值驱动，配合 .animation() 实现平滑补间过渡
   * @param url 图片地址
   * @param index 项索引
   */
  @Builder
  private SwiperItemContent(url: string, index: number): void {
    Stack() {
      Image(url)
        .width("100%")
        .height("100%")
        .objectFit(this.imgMode)
        .borderRadius(this.getResolvedImgRadius())
    }
    .width("100%")
    .height("100%")
    .onClick(() => {
      this.onItemClick(index);
    })
    .opacity(this.getItemOpacity(index))
    .scale({
      x: this.getItemScale(index),
      y: this.getItemScale(index)
    })
    .rotate({
      y: 1,
      angle: this.getItemRotation(index)
    })
    .animation({ duration: this.duration })
    .shadow(this.effect === "card" ? getTnShadow(this.baseStyle, "md") : undefined);
  }

  // ==================== 指示器构建 ====================

  /**
   * 指示器内容构建器
   */
  @Builder
  private IndicatorContent(): void {
    if (this.indicatorType === "dot") {
      this.DotIndicator();
    } else if (this.indicatorType === "line") {
      this.LineIndicator();
    } else {
      this.NumberIndicator();
    }
  }

  /**
   * 圆点指示器
   * 利用 fraction 对相邻两个圆点的宽度做实时插值
   */
  @Builder
  private DotIndicator(): void {
    Row({ space: this.baseStyle.spaceXs }) {
      ForEach(this.data, (_url: string, index: number) => {
        Column()
          .width(this.getDotWidth(index))
          .height(DOT_SIZE)
          .borderRadius(this.baseStyle.borderRadiusMax)
          .backgroundColor(
            this.isDotActive(index)
              ? this.getIndicatorActiveColor()
              : this.getIndicatorDefaultColor()
          );
      }, (_url: string, index: number) => `dot_${index}`);
    }
    .margin(this.baseStyle.spaceMd);
  }

  /**
   * 线条指示器
   * 活动滑块位置由 fraction 直接驱动，实现与滑动手势的实时同步
   */
  @Builder
  private LineIndicator(): void {
    Stack({ alignContent: Alignment.Start }) {
      // 背景轨道
      Column()
        .width(LINE_WIDTH)
        .height(LINE_HEIGHT)
        .borderRadius(this.baseStyle.borderRadiusMax)
        .backgroundColor(this.getIndicatorDefaultColor());
      // 活动滑块
      Column()
        .width(this.getLineActiveWidth())
        .height(LINE_HEIGHT)
        .borderRadius(this.baseStyle.borderRadiusMax)
        .backgroundColor(this.getIndicatorActiveColor())
        .translate({ x: this.getLineActiveOffset() });
    }
    .width(LINE_WIDTH)
    .height(LINE_HEIGHT)
    .margin(this.baseStyle.spaceMd);
  }

  /**
   * 数字指示器
   */
  @Builder
  private NumberIndicator(): void {
    Row() {
      Text(`${this.getFractionIndex() + 1}`)
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
        .fontColor(this.getNumberTextColor())
        .lineHeight(this.baseStyle.lineHeightXs);
      Text(" / ")
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
        .fontColor(this.getNumberTextColor())
        .lineHeight(this.baseStyle.lineHeightXs);
      Text(`${this.data.length}`)
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
        .fontColor(this.getNumberTextColor())
        .lineHeight(this.baseStyle.lineHeightXs);
    }
    .padding({
      left: this.baseStyle.spaceMd,
      right: this.baseStyle.spaceMd,
      top: this.baseStyle.spaceBase,
      bottom: this.baseStyle.spaceBase
    })
    .borderRadius(this.baseStyle.borderRadiusMax)
    .backgroundColor(this.getIndicatorDefaultColor())
    .margin(this.baseStyle.spaceMd);
  }
}
