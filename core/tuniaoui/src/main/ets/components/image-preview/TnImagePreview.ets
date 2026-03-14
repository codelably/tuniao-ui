/**
 * @file TnImagePreview 图片预览组件
 * @description 全屏图片预览，支持 Swiper 切换、双击缩放、捏合缩放、页码显示
 * @author JunBin.Yang
 */

import { AppStorageV2, ComponentContent } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { getFontSizeByKey } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { convertDimensionsWidthUnit } from "../../utils/Utils";
import { ContextUtil } from "../../utils/ContextUtil";
import { TnImagePreviewOption, TnImagePreviewParams } from "./TnImagePreviewTypes";

/** 页码距底部/顶部偏移量（vp） */
const INDEX_OFFSET: number = 52;

/**
 * 将数值限制在指定范围内
 * @param value 原始值
 * @param min 最小值
 * @param max 最大值
 * @returns 限制后的值
 */
function clampValue(value: number, min: number, max: number): number {
  if (value < min) {
    return min;
  }
  if (value > max) {
    return max;
  }
  return value;
}

/**
 * 双指中心坐标
 */
interface CenterLocation {
  x: number;
  y: number;
}

/**
 * 预览单张图片项
 */
@ComponentV2
struct TnPreviewSwiperItem {
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  @Param params: TnImagePreviewParams = new TnImagePreviewParams([]);
  @Param url: ResourceStr = "";
  @Param itemIndex: number = 0;
  @Param activeIndex: number = 0;
  @Param isDisabledSwiper: boolean[] = [false];

  /** 当前缩放比例 */
  @Local curScale: number = 1;
  /** 捏合缩放基准值 */
  @Local pinchValue: number = 1;
  /** 图片水平偏移 */
  @Local offsetX: number = 0;
  /** 图片垂直偏移 */
  @Local offsetY: number = 0;

  /** 手指按下起始 X */
  private startX: number = 0;
  /** 手指按下起始 Y */
  private startY: number = 0;
  /** 手指按下时的偏移 X */
  private curX: number = 0;
  /** 手指按下时的偏移 Y */
  private curY: number = 0;
  /** 最大水平偏移 */
  private offsetMaxX: number = 0;
  /** 最大垂直偏移 */
  private offsetMaxY: number = 0;
  /** 容器宽度 */
  private rootWidth: number = 0;
  /** 容器高度 */
  private rootHeight: number = 0;
  /** 图片原始宽度（vp） */
  private imgWidth: number = 0;
  /** 图片原始高度（vp） */
  private imgHeight: number = 0;
  /** 是否正在移动 */
  private isMoving: boolean = false;
  /** 手指是否移动过 */
  private isFingerMoved: boolean = false;
  /** 上一次捏合中心点 */
  private lastCenter: CenterLocation = { x: 0, y: 0 };

  /**
   * 初始化图片信息
   * @param width 图片像素宽度
   * @param height 图片像素高度
   */
  private initImageInfo(width: number, height: number): void {
    this.imgWidth = px2vp(width);
    this.imgHeight = px2vp(height);
    this.setScaleParams(1);
  }

  /**
   * 计算最大水平移动距离
   * @returns 最大水平偏移量
   */
  private getMaxMoveX(): number {
    if (this.imgWidth > 0) {
      return Math.max(0, (this.curScale * this.rootWidth - this.rootWidth) / 2);
    }
    return 0;
  }

  /**
   * 计算最大垂直移动距离
   * @returns 最大垂直偏移量
   */
  private getMaxMoveY(): number {
    if (this.imgHeight > 0) {
      return Math.max(0, (this.curScale * this.imgHeight - this.rootHeight) / 2);
    }
    return 0;
  }

  /**
   * 设置缩放参数
   * @param scale 目标缩放比例
   * @param center 缩放中心点
   */
  private setScaleParams(scale: number, center?: CenterLocation): void {
    scale = clampValue(scale, this.params.minScale, this.params.maxScale + 1);
    if (scale !== this.curScale) {
      const ratio: number = scale / this.curScale;
      this.curScale = scale;
      this.offsetMaxX = this.getMaxMoveX();
      this.offsetMaxY = this.getMaxMoveY();
      if (center !== undefined) {
        const moveX: number = this.offsetX - (center.x - this.rootWidth / 2) * (ratio - 1);
        const moveY: number = this.offsetY - (center.y - this.rootHeight / 2) * (ratio - 1);
        this.offsetX = clampValue(moveX, -this.offsetMaxX, this.offsetMaxX);
        this.offsetY = clampValue(moveY, -this.offsetMaxY, this.offsetMaxY);
      } else {
        this.offsetX = 0;
        this.offsetY = 0;
      }
    }
  }

  /**
   * 单击处理
   */
  private handleSingleClick(): void {
    if (this.isFingerMoved) {
      return;
    }
    if (this.params.closeOnClickImage) {
      this.params.hide();
    }
    if (this.params.onImageClick !== undefined) {
      this.params.onImageClick(this.itemIndex);
    }
  }

  /**
   * 双击处理
   * @param fingers 手指信息列表
   */
  private handleDoubleClick(fingers: FingerInfo[]): void {
    if (this.isFingerMoved) {
      return;
    }
    const targetScale: number = this.curScale === 1 ? 2 : 1;
    const center: CenterLocation = targetScale === 2
      ? { x: fingers[0].localX, y: fingers[0].localY }
      : { x: this.rootWidth / 2, y: this.rootHeight / 2 };
    this.setScaleParams(targetScale, center);
  }

  /**
   * 手指触摸事件处理
   * @param event 触摸事件
   */
  private onFingerMove(event: TouchEvent): void {
    if (event.type === TouchType.Down) {
      this.isMoving = this.curScale !== 1;
      this.startX = event.touches[0].x;
      this.startY = event.touches[0].y;
      this.curX = this.offsetX;
      this.curY = this.offsetY;
      this.isFingerMoved = false;
    } else if (event.type === TouchType.Move) {
      const dx: number = event.touches[0].x - this.startX;
      const dy: number = event.touches[0].y - this.startY;
      this.isFingerMoved = dx !== 0 || dy !== 0;
      const targetX: number = this.curX + dx;
      const isDisabled: boolean = Math.abs(targetX) <= this.offsetMaxX;
      this.isDisabledSwiper[0] = isDisabled;
      if (this.isMoving) {
        this.offsetX = clampValue(targetX, -this.offsetMaxX, this.offsetMaxX);
        this.offsetY = clampValue(this.curY + dy, -this.offsetMaxY, this.offsetMaxY);
      }
    } else if (event.type === TouchType.Up) {
      this.isMoving = false;
    }
  }

  /**
   * 监听当前激活索引变化，重置缩放
   */
  @Monitor("activeIndex")
  resetScale(): void {
    this.setScaleParams(1);
  }

  build() {
    Row() {
      Image(this.url)
        .width("100%")
        .objectFit(ImageFit.Contain)
        .scale({ x: this.curScale, y: this.curScale, z: 1 })
        .translate({ x: this.offsetX, y: this.offsetY, z: 0 })
        .draggable(false)
        .animation({ duration: this.baseStyle.animationDuration })
        .onComplete((event) => {
          if (event !== undefined) {
            this.rootWidth = px2vp(event.componentWidth);
            this.rootHeight = px2vp(event.componentHeight);
            this.initImageInfo(event.contentWidth, event.contentHeight);
          }
        })
        .gesture(
          GestureGroup(GestureMode.Exclusive,
            TapGesture({ count: 2 }).onAction((event: GestureEvent) => {
              this.handleDoubleClick(event.fingerList);
            }),
            TapGesture().onAction(() => {
              this.handleSingleClick();
            })
          )
        );
    }
    .justifyContent(FlexAlign.Center)
    .width("100%")
    .height("100%")
    .onTouch((event: TouchEvent) => {
      this.onFingerMove(event);
    })
    .gesture(
      GestureGroup(GestureMode.Exclusive,
        TapGesture({ count: 2 }).onAction((event: GestureEvent) => {
          this.handleDoubleClick(event.fingerList);
        }),
        TapGesture().onAction(() => {
          if (!this.isFingerMoved && this.params.closeOnClickOverlay) {
            this.params.hide();
          }
        }),
        LongPressGesture().onAction(() => {
          if (this.params.onImageLongPress !== undefined) {
            this.params.onImageLongPress(this.itemIndex);
          }
        }),
        PinchGesture({ fingers: 2 })
          .onActionStart(() => {
            this.pinchValue = this.curScale;
          })
          .onActionUpdate((event: GestureEvent) => {
            const scale: number = Math.round(this.pinchValue * event.scale * 10) / 10;
            const center: CenterLocation = {
              x: (event.fingerList[0].localX + event.fingerList[1].localX) / 2,
              y: (event.fingerList[0].localY + event.fingerList[1].localY) / 2
            };
            this.lastCenter = center;
            this.isMoving = false;
            this.isDisabledSwiper[0] = true;
            this.setScaleParams(scale, center);
          })
          .onActionEnd(() => {
            const maxZoom: number = this.params.maxScale;
            if (this.curScale > maxZoom) {
              this.setScaleParams(maxZoom, this.lastCenter);
            }
            this.pinchValue = Math.min(this.curScale, maxZoom);
          })
      )
    );
  }
}

/**
 * 预览主内容（Swiper + 页码）
 */
@ComponentV2
struct TnPreviewContent {
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  @Param params: TnImagePreviewParams = new TnImagePreviewParams([]);
  @Local currentIndex: number = 0;
  @Local isDisabledSwiper: boolean[] = [false];

  aboutToAppear(): void {
    this.currentIndex = this.params.startIndex;
  }

  build() {
    Stack({
      alignContent: this.params.indexPosition === "top" ? Alignment.Top : Alignment.Bottom
    }) {
      Swiper() {
        ForEach(this.params.urls, (url: ResourceStr, index: number) => {
          TnPreviewSwiperItem({
            url: url,
            itemIndex: index,
            activeIndex: this.currentIndex,
            params: this.params,
            isDisabledSwiper: this.isDisabledSwiper
          });
        }, (url: ResourceStr, index: number): string => `tn_preview_${index}`);
      }
      .width("100%")
      .height("100%")
      .index($$this.currentIndex)
      .indicator(false)
      .loop(this.params.loop)
      .duration(this.params.swipeDuration)
      .disableSwipe(this.isDisabledSwiper[0])
      .cachedCount(3);

      if (this.params.showIndex && this.params.urls.length > 1) {
        Text(`${this.currentIndex + 1} / ${this.params.urls.length}`)
          .fontColor($r("app.color.tn_color_white"))
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeLg"))
          .lineHeight(this.baseStyle.lineHeightMd)
          .offset({
            y: this.params.indexPosition === "top"
              ? convertDimensionsWidthUnit(INDEX_OFFSET)
              : `-${convertDimensionsWidthUnit(INDEX_OFFSET)}`
          });
      }
    }
    .width("100%")
    .height("100%");
  }
}

/**
 * 预览组件 Builder 函数
 * @param params 预览参数
 */
@Builder
function tnImagePreviewBuilder(params: TnImagePreviewParams): void {
  TnPreviewContent({ params: params });
}

/**
 * TnImagePreview 图片预览服务
 *
 * @example
 * import TnImagePreview from "../components/image-preview/TnImagePreview";
 *
 * // 基础用法
 * TnImagePreview.show(["image1.png", "image2.png"]);
 *
 * // 指定初始索引
 * TnImagePreview.show(urls, { startIndex: 2 });
 */
class TnImagePreviewService {
  private contentNode: ComponentContent<TnImagePreviewParams> | null = null;
  private uiContext: UIContext | null = null;

  /**
   * 显示图片预览
   * @param urls 图片地址列表
   * @param option 预览配置选项
   */
  public show(urls: ResourceStr[], option?: TnImagePreviewOption): void {
    if (this.contentNode !== null) {
      return;
    }
    this.uiContext = ContextUtil.getUICtx();
    const promptAction = this.uiContext.getPromptAction();
    const params: TnImagePreviewParams = new TnImagePreviewParams(urls, option);
    params.hide = (): void => this.hide();
    const contentNode: ComponentContent<TnImagePreviewParams> =
      new ComponentContent(this.uiContext, wrapBuilder(tnImagePreviewBuilder), params);
    this.contentNode = contentNode;
    promptAction.openCustomDialog(contentNode, {
      alignment: DialogAlignment.Center,
      isModal: true,
      maskColor: $r("app.color.tn_preview_mask_bg"),
      autoCancel: false,
      onDidDisappear: (): void => {
        contentNode.dispose();
        this.contentNode = null;
        this.uiContext = null;
      }
    });
  }

  /**
   * 关闭图片预览
   */
  public hide(): void {
    if (this.contentNode !== null && this.uiContext !== null) {
      const node: ComponentContent<TnImagePreviewParams> = this.contentNode;
      try {
        this.uiContext.getPromptAction().closeCustomDialog(node);
      } catch (error) {
        // 对话框可能已关闭
      }
    }
  }
}

const TnImagePreview: TnImagePreviewService = new TnImagePreviewService();
export default TnImagePreview;
