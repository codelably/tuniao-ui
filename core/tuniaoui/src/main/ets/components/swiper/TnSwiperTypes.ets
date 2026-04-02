/**
 * @file TnSwiper 轮播图组件类型定义
 * @author JunBin.Yang
 */

/**
 * 指示器类型
 * - dot: 圆点指示器（默认）
 * - line: 线条指示器
 * - number: 数字指示器
 */
export type TnSwiperIndicatorType = "dot" | "line" | "number";

/**
 * 指示器位置
 * - left-top: 左上角
 * - center-top: 顶部居中
 * - right-top: 右上角
 * - left-bottom: 左下角
 * - center-bottom: 底部居中（默认）
 * - right-bottom: 右下角
 */
export type TnSwiperIndicatorPosition =
  | "left-top"
  | "center-top"
  | "right-top"
  | "left-bottom"
  | "center-bottom"
  | "right-bottom";

/**
 * 切换动画效果
 * - slide: 标准滑动（默认）
 * - fade: 淡入淡出
 * - scale: 缩放切换
 * - card: 卡片层叠
 * - flip: 翻转切换
 */
export type TnSwiperEffect = "slide" | "fade" | "scale" | "card" | "flip";

/**
 * TnSwiper 组件属性接口
 */
export interface TnSwiperProps {
  /** 当前选中的轮播项索引，默认 0 */
  currentIndex?: number;
  /** 轮播图数据（图片 URL 列表） */
  data?: string[];
  /** 轮播图宽度，默认 "100%" */
  width?: string | number;
  /** 轮播图高度，默认 180 */
  height?: string | number;
  /** 是否自动播放，默认 false */
  autoplay?: boolean;
  /** 自动播放间隔时间（毫秒），默认 5000 */
  interval?: number;
  /** 切换动画时长（毫秒），默认 500 */
  duration?: number;
  /** 是否循环播放，默认 false */
  loop?: boolean;
  /** 前一项露出的间距，默认 0 */
  previousMargin?: number;
  /** 后一项露出的间距，默认 0 */
  nextMargin?: number;
  /** 项目之间的间距(vp)，当前后露出或卡片模式时默认 10 */
  itemSpace?: number;
  /** 是否显示指示器，默认 true */
  showIndicator?: boolean;
  /** 指示器位置，默认 "center-bottom" */
  indicatorPosition?: TnSwiperIndicatorPosition;
  /** 指示器类型，默认 "dot" */
  indicatorType?: TnSwiperIndicatorType;
  /** 指示器默认颜色 */
  indicatorBgColor?: ResourceColor;
  /** 指示器选中颜色 */
  indicatorActiveBgColor?: ResourceColor;
  /** 数字指示器文字颜色 */
  indicatorTextColor?: ResourceColor;
  /** 切换动画效果，默认 "slide" */
  effect?: TnSwiperEffect;
  /** 图片显示模式，默认 Cover */
  imgMode?: ImageFit;
  /** 图片圆角 */
  imgBorderRadius?: number;
  /** 切换回调 */
  onChange?: (index: number) => void;
  /** 点击回调 */
  onItemClick?: (index: number) => void;
}
