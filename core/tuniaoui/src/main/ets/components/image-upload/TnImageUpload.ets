/**
 * @file TnImageUpload 图片上传组件
 * @description 支持图片选择、预览、删除、上传进度展示，基于系统 PhotoViewPicker
 * @author JunBin.Yang
 */

import { AppStorageV2, LengthMetrics } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { getFontSizeByKey } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { SPACE } from "../../theme-chalk/space";
import { TnIcon } from "../icon/TnIcon";
import { TnLoading } from "../loading/TnLoading";
import TnImagePreview from "../image-preview/TnImagePreview";
import { TnImagePreviewOption } from "../image-preview/TnImagePreviewTypes";
import { TnUploadFile } from "./TnImageUploadTypes";
import { photoAccessHelper } from "@kit.MediaLibraryKit";
import { getSizeByUnit, convertDimensionsWidthUnit } from "../../utils/Utils";
import { getHexColorByResoure, mixWithBlack } from "../../utils/ColorUtils";

/** 默认图片尺寸(vp) */
const DEFAULT_IMAGE_SIZE: number = 80;

/**
 * TnImageUpload 图片上传组件
 *
 * @example
 * TnImageUpload({
 *   fileList: [],
 *   onChoose: (files) => {},
 *   onDelete: (file, index) => {}
 * })
 */
@ComponentV2
export struct TnImageUpload {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  /** 已上传文件列表 */
  @Param fileList: TnUploadFile[] = [];
  /** 最大上传数量 */
  @Param maxCount: number = 9;
  /** 多选 */
  @Param multiple: boolean = false;
  /** 禁用 */
  @Param disabled: boolean = false;
  /** 显示删除按钮 */
  @Param deletable: boolean = true;
  /** 点击预览大图 */
  @Param previewImage: boolean = true;
  /** 每行列数 */
  @Param columns: number = 3;
  /** 上传按钮图标 */
  @Param uploadIcon: string = "add-circle";
  /** 上传按钮文字 */
  @Param uploadText: string = "";

  /** 选择文件回调 */
  @Event onChoose: (files: TnUploadFile[]) => void = (_files: TnUploadFile[]): void => {};
  /** 删除文件回调 */
  @Event onDelete: (file: TnUploadFile, index: number) => void =
    (_file: TnUploadFile, _index: number): void => {};
  /** 预览文件回调 */
  @Event onPreview: (file: TnUploadFile, index: number) => void =
    (_file: TnUploadFile, _index: number): void => {};
  /** 超出大小回调 */
  @Event onOversize: (files: TnUploadFile[]) => void = (_files: TnUploadFile[]): void => {};

  /**
   * 获取图片尺寸（带单位）
   * @returns 格式化后的图片尺寸
   */
  private getImageSize(): string {
    return convertDimensionsWidthUnit(DEFAULT_IMAGE_SIZE);
  }

  /**
   * 是否显示上传按钮
   * @returns 是否显示
   */
  private shouldShowUploadBtn(): boolean {
    return !this.disabled && this.fileList.length < this.maxCount;
  }

  /**
   * 显示图片预览
   * @param index 当前点击的图片索引
   */
  private showPreview(index: number): void {
    const urls: ResourceStr[] = this.fileList.map((f: TnUploadFile): ResourceStr => f.url);
    const option: TnImagePreviewOption = new TnImagePreviewOption();
    option.startIndex = index;
    TnImagePreview.show(urls, option);
  }

  /**
   * 选择图片
   */
  private async chooseImage(): Promise<void> {
    if (this.disabled) {
      return;
    }
    try {
      const remainCount: number = this.maxCount - this.fileList.length;
      const options: photoAccessHelper.PhotoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
      options.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE;
      options.maxSelectNumber = this.multiple ? remainCount : 1;
      const picker: photoAccessHelper.PhotoViewPicker = new photoAccessHelper.PhotoViewPicker();
      const result: photoAccessHelper.PhotoSelectResult = await picker.select(options);
      if (result.photoUris.length > 0) {
        const newFiles: TnUploadFile[] = result.photoUris.map((uri: string): TnUploadFile => {
          return new TnUploadFile(uri);
        });
        this.onChoose(newFiles);
      }
    } catch (error) {
      // 用户取消选择或其他错误
    }
  }

  build() {
    Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(SPACE.XSM), cross: LengthMetrics.vp(SPACE.XSM) } }) {
      // 已上传图片列表
      ForEach(
        this.fileList,
        (file: TnUploadFile, index: number) => {
          this.ImageItemBuilder(file, index);
        },
        (file: TnUploadFile, index: number): string => `upload_${index}_${file.url}`
      );

      // 上传按钮
      if (this.shouldShowUploadBtn()) {
        this.UploadBtnBuilder();
      }
    }
    .width("100%");
  }

  /**
   * 图片项构建器
   * @param file 文件信息
   * @param index 索引
   */
  @Builder
  private ImageItemBuilder(file: TnUploadFile, index: number): void {
    Stack({ alignContent: Alignment.TopEnd }) {
      // 图片
      Image(file.url)
        .width(this.getImageSize())
        .height(this.getImageSize())
        .borderRadius(this.baseStyle.borderRadius)
        .objectFit(ImageFit.Cover)
        .onClick(() => {
          if (this.previewImage) {
            this.onPreview(file, index);
            this.showPreview(index);
          }
        });

      // 上传进度（uploading 状态）
      if (file.status === "uploading") {
        Column({ space: this.baseStyle.spaceBase }) {
          TnLoading({
            customSize: 18,
            color: $r("app.color.tn_color_white"),
            mode: "circle"
          });
          Text(`${file.progress}%`)
            .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
            .fontColor($r("app.color.tn_color_white"))
            .lineHeight(this.baseStyle.lineHeightXs);
        }
        .width(this.getImageSize())
        .height(this.getImageSize())
        .borderRadius(this.baseStyle.borderRadius)
        .backgroundColor($r("app.color.tn_overlay_bg"))
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center);
      }

      // 错误提示
      if (file.status === "error") {
        Column() {
          TnIcon({ name: "close-circle-fill", iconSize: 20, color: $r("app.color.tn_color_white") }).enabled(false);
          if (file.message.length > 0) {
            Text(file.message)
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
              .fontColor($r("app.color.tn_color_white"))
              .lineHeight(this.baseStyle.lineHeightXs)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis });
          }
        }
        .width(this.getImageSize())
        .height(this.getImageSize())
        .borderRadius(this.baseStyle.borderRadius)
        .backgroundColor($r("app.color.tn_overlay_error_bg"))
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center);
      }

      // 删除按钮
      if (this.deletable && !this.disabled) {
        Row() {
          TnIcon({ name: "close", iconSize: 12, color: $r("app.color.tn_color_white") }).enabled(false);
        }
        .width(convertDimensionsWidthUnit(18))
        .height(convertDimensionsWidthUnit(18))
        .borderRadius(this.baseStyle.borderRadiusMax)
        .backgroundColor($r("app.color.tn_overlay_bg"))
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .margin({ top: convertDimensionsWidthUnit(-4), right: convertDimensionsWidthUnit(-4) })
        .stateStyles({
          normal: {
            .opacity(1.0)
          },
          pressed: {
            .opacity(0.7)
          }
        })
        .onClick(() => {
          this.onDelete(file, index);
        });
      }
    }
    .width(this.getImageSize())
    .height(this.getImageSize());
  }

  /**
   * 上传按钮构建器
   */
  @Builder
  private UploadBtnBuilder(): void {
    Column({ space: this.baseStyle.spaceBase }) {
      TnIcon({
        name: this.uploadIcon,
        iconSize: 28,
        color: $r("app.color.tn_color_gray")
      }).enabled(false);
      if (this.uploadText.length > 0) {
        Text(this.uploadText)
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
          .fontColor($r("app.color.tn_text_color_secondary"))
          .lineHeight(this.baseStyle.lineHeightXs);
      }
    }
    .width(this.getImageSize())
    .height(this.getImageSize())
    .borderRadius(this.baseStyle.borderRadius)
    .borderWidth(1)
    .borderStyle(BorderStyle.Dashed)
    .borderColor($r("app.color.tn_color_gray_disabled"))
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .stateStyles({
      normal: {
        .backgroundColor($r("app.color.tn_bg_color"))
      },
      pressed: {
        .backgroundColor(mixWithBlack(getHexColorByResoure($r("app.color.tn_bg_color"))))
      }
    })
    .animation({ duration: this.baseStyle.animationDuration })
    .onClick(() => {
      this.chooseImage();
    });
  }
}
