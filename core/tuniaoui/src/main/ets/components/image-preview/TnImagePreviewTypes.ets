/**
 * @file TnImagePreview 图片预览组件类型定义
 * @author JunBin.Yang
 */

/**
 * 图片预览配置选项
 */
export class TnImagePreviewOption {
  /**
   * 指定初始显示的图片索引
   */
  startIndex: number = 0;
  /**
   * 动画时长（毫秒）
   */
  swipeDuration: number = 200;
  /**
   * 是否显示页码
   */
  showIndex: boolean = true;
  /**
   * 页码位置
   */
  indexPosition: "top" | "bottom" = "bottom";
  /**
   * 是否循环
   */
  loop: boolean = true;
  /**
   * 是否在点击图片后关闭预览
   */
  closeOnClickImage: boolean = true;
  /**
   * 是否在点击遮罩后关闭预览
   */
  closeOnClickOverlay: boolean = true;
  /**
   * 最大缩放比例
   */
  maxScale: number = 3;
  /**
   * 最小缩放比例
   */
  minScale: number = 1;
  /**
   * 图片点击事件
   */
  onImageClick: ((index: number) => void) | undefined = undefined;
  /**
   * 图片长按事件
   */
  onImageLongPress: ((index: number) => void) | undefined = undefined;
}

/**
 * 图片预览内部参数（包含图片列表和关闭方法）
 */
export class TnImagePreviewParams extends TnImagePreviewOption {
  /** 图片列表 */
  urls: ResourceStr[] = [];
  /** 关闭预览的方法 */
  hide: () => void = (): void => {};

  constructor(urls: ResourceStr[], option?: TnImagePreviewOption) {
    super();
    this.urls = urls;
    if (option !== undefined) {
      this.startIndex = option.startIndex;
      this.swipeDuration = option.swipeDuration;
      this.showIndex = option.showIndex;
      this.indexPosition = option.indexPosition;
      this.loop = option.loop;
      this.closeOnClickImage = option.closeOnClickImage;
      this.closeOnClickOverlay = option.closeOnClickOverlay;
      this.maxScale = option.maxScale;
      this.minScale = option.minScale;
      this.onImageClick = option.onImageClick;
      this.onImageLongPress = option.onImageLongPress;
    }
  }
}
