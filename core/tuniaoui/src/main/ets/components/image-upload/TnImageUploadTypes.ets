/**
 * @file TnImageUpload 图片上传组件类型定义
 * @author JunBin.Yang
 */

/**
 * 上传文件状态
 */
export type TnUploadFileStatus = "ready" | "uploading" | "success" | "error";

/**
 * 上传文件项（响应式模型）
 * 属性通过 @Trace 实现细粒度 UI 更新，避免 ForEach 整体重建
 */
@ObservedV2
export class TnUploadFile {
  /** 文件路径/URL */
  @Trace url: string = "";
  /** 上传状态 */
  @Trace status: TnUploadFileStatus = "ready";
  /** 上传进度(0-100) */
  @Trace progress: number = 0;
  /** 消息（错误提示等） */
  @Trace message: string = "";

  constructor(url: string, status?: TnUploadFileStatus, progress?: number, message?: string) {
    this.url = url;
    this.status = status !== undefined ? status : "ready";
    this.progress = progress !== undefined ? progress : 0;
    this.message = message !== undefined ? message : "";
  }
}

/**
 * TnImageUpload 组件属性接口
 */
export interface TnImageUploadProps {
  /** 已上传文件列表 */
  fileList?: TnUploadFile[];
  /** 最大上传数量，默认 9 */
  maxCount?: number;
  /** 多选 */
  multiple?: boolean;
  /** 禁用 */
  disabled?: boolean;
  /** 显示删除按钮 */
  deletable?: boolean;
  /** 点击预览大图 */
  previewImage?: boolean;
  /** 每行列数，默认 3 */
  columns?: number;
  /** 上传按钮图标 */
  uploadIcon?: string;
  /** 上传按钮文字 */
  uploadText?: string;
  /** 选择文件回调 */
  onChoose?: (files: TnUploadFile[]) => void;
  /** 删除文件回调 */
  onDelete?: (file: TnUploadFile, index: number) => void;
  /** 预览文件回调 */
  onPreview?: (file: TnUploadFile, index: number) => void;
  /** 超出大小回调 */
  onOversize?: (files: TnUploadFile[]) => void;
}
