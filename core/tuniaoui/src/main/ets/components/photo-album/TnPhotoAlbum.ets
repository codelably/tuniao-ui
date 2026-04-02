/**
 * @file TnPhotoAlbum 相册组件
 * @description 用于展示图片列表，支持多列布局、最大数量限制、图片预览等功能
 * @author JunBin.Yang
 */

import { AppStorageV2, LengthMetrics } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { SPACE } from "../../theme-chalk/space";
import { convertDimensionsWidthUnit } from "../../utils/Utils";
import TnImagePreview from "../image-preview/TnImagePreview";
import { TnImagePreviewOption } from "../image-preview/TnImagePreviewTypes";
import { TnPhotoAlbumImgMode } from "./TnPhotoAlbumTypes";

/** 默认图片间距(vp) */
const DEFAULT_GAP: number = SPACE.XSM;
/** 默认最大显示数量 */
const DEFAULT_MAX: number = 9;
/** 默认列数 */
const DEFAULT_COLUMN: number = 3;

/**
 * 将 TnPhotoAlbumImgMode 转换为 ImageFit
 * @param mode 图片显示模式
 * @returns ImageFit 枚举值
 */
function resolveImageFit(mode: TnPhotoAlbumImgMode): ImageFit {
  switch (mode) {
    case "contain":
      return ImageFit.Contain;
    case "fill":
      return ImageFit.Fill;
    case "auto":
      return ImageFit.Auto;
    default:
      return ImageFit.Cover;
  }
}

/**
 * TnPhotoAlbum 相册组件
 *
 * @example
 * // 基础用法
 * TnPhotoAlbum({ data: ["url1", "url2", "url3"] })
 *
 * // 4列显示
 * TnPhotoAlbum({ data: urls, column: 4 })
 *
 * // 限制最大显示数量
 * TnPhotoAlbum({ data: urls, max: 6 })
 *
 * // 禁用预览
 * TnPhotoAlbum({ data: urls, preview: false })
 */
@ComponentV2
export struct TnPhotoAlbum {
  /**
   * 全局基础样式（响应式绑定，主题切换时自动更新）
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /**
   * 图片地址列表
   */
  @Param data: string[] = [];
  /**
   * 最大允许显示图片的数量
   */
  @Param max: number = DEFAULT_MAX;
  /**
   * 一行显示的图片数量
   */
  @Param column: number = DEFAULT_COLUMN;
  /**
   * 图片显示模式
   */
  @Param imgMode: TnPhotoAlbumImgMode = "cover";
  /**
   * 点击图片是否进行预览
   */
  @Param preview: boolean = true;
  /**
   * 图片间距(vp)
   */
  @Param gap: number = DEFAULT_GAP;
  /**
   * 图片圆角
   */
  @Param imgBorderRadius: string | number | undefined = undefined;
  /**
   * 图片点击回调
   */
  @Event onImageClick: (index: number) => void = (_index: number) => {};

  /**
   * 获取实际显示的图片数据（根据 max 限制）
   * @returns 截取后的图片地址数组
   */
  private getDisplayImages(): string[] {
    const maxLength: number = Math.min(this.data.length, this.max);
    return this.data.slice(0, maxLength);
  }

  /**
   * 获取解析后的图片圆角
   * @returns 圆角值
   */
  private getResolvedBorderRadius(): string {
    if (this.imgBorderRadius !== undefined) {
      if (typeof this.imgBorderRadius === "number") {
        return convertDimensionsWidthUnit(this.imgBorderRadius);
      }
      return this.imgBorderRadius;
    }
    return this.baseStyle.borderRadius;
  }

  /**
   * 处理图片点击事件
   * @param index 被点击图片的索引
   */
  private handleImageClick(index: number): void {
    this.onImageClick(index);
    if (this.preview) {
      const displayImages: string[] = this.getDisplayImages();
      const option: TnImagePreviewOption = new TnImagePreviewOption();
      option.startIndex = index;
      TnImagePreview.show(displayImages, option);
    }
  }

  build() {
    Flex({
      wrap: FlexWrap.Wrap,
      space: {
        main: LengthMetrics.vp(this.gap),
        cross: LengthMetrics.vp(this.gap)
      }
    }) {
      ForEach(this.getDisplayImages(), (url: string, index: number) => {
        this.ImageItem(url, index);
      }, (url: string, index: number) => `${index}_${url}`);
    }
    .width("100%");
  }

  /**
   * 单张图片项构建器
   * @param url 图片地址
   * @param index 图片索引
   */
  @Builder
  private ImageItem(url: string, index: number): void {
    Image(url)
      .width(this.getItemSize())
      .aspectRatio(1)
      .objectFit(resolveImageFit(this.imgMode))
      .borderRadius(this.getResolvedBorderRadius())
      .onClick(() => {
        this.handleImageClick(index);
      })
      .stateStyles({
        normal: {
          .opacity(1.0)
        },
        pressed: {
          .opacity(0.7)
        }
      })
      .animation({ duration: this.baseStyle.animationDuration });
  }

  /**
   * 计算单个图片项的尺寸
   * 公式: (100% - (column - 1) * gap) / column
   * @returns 图片项宽度的计算表达式
   */
  private getItemSize(): string {
    const col: number = Math.max(1, this.column);
    const totalGap: number = (col - 1) * this.gap;
    return `calc((100% - ${totalGap}vp) / ${col})`;
  }
}
