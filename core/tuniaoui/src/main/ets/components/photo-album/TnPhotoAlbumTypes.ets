/**
 * @file TnPhotoAlbum 相册组件类型定义
 * @author JunBin.Yang
 */

/**
 * 图片显示模式
 * - cover: 保持比例裁剪填充（默认）
 * - contain: 保持比例完整显示
 * - fill: 拉伸填充
 * - auto: 自适应
 */
export type TnPhotoAlbumImgMode = "cover" | "contain" | "fill" | "auto";

/**
 * TnPhotoAlbum 组件属性接口
 */
export interface TnPhotoAlbumProps {
  /** 图片地址列表 */
  data?: string[];
  /** 最大允许显示图片的数量，默认 9 */
  max?: number;
  /** 一行显示的图片数量，默认 3 */
  column?: number;
  /** 图片显示模式，默认 "cover" */
  imgMode?: TnPhotoAlbumImgMode;
  /** 点击图片是否进行预览，默认 true */
  preview?: boolean;
  /** 图片间距（vp），默认使用 baseStyle.spaceXsm (8) */
  gap?: number;
  /** 图片圆角，默认使用 baseStyle.borderRadius */
  imgBorderRadius?: string | number;
  /** 图片点击回调 */
  onImageClick?: (index: number) => void;
}
