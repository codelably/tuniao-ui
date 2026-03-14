/**
 * @file TnImageUpload 图片上传展示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";
import { TnUploadFile, TnUploadFileStatus } from "@tuniao/tn-ui";

/** 模拟上传间隔（毫秒） */
const UPLOAD_INTERVAL: number = 200;

/** 模拟上传每次递增的进度值 */
const UPLOAD_STEP: number = 10;

/** 模拟上传失败的概率阈值 */
const FAIL_THRESHOLD: number = 0.5;

/**
 * TnImageUpload 图片上传展示页面 ViewModel
 */
@ObservedV2
export default class TnImageUploadViewModel extends BaseViewModel {
  /**
   * 已上传的文件列表
   */
  @Trace fileList: TnUploadFile[] = [];

  /**
   * 模拟上传的文件列表
   */
  @Trace uploadDemoFileList: TnUploadFile[] = [];

  /**
   * 批量添加文件到列表
   * @param files 待添加的文件数组
   */
  addFiles(files: TnUploadFile[]): void {
    this.fileList = [...this.fileList, ...files];
  }

  /**
   * 根据索引删除文件列表中的指定文件
   * @param index 待删除文件的索引
   */
  deleteFile(index: number): void {
    this.fileList = this.fileList.filter((_item: TnUploadFile, i: number) => i !== index);
  }

  /**
   * 添加文件并模拟上传过程
   * @param files 待添加的文件数组
   */
  addFilesWithUpload(files: TnUploadFile[]): void {
    const uploadingFiles: TnUploadFile[] = files.map((f: TnUploadFile): TnUploadFile => {
      return new TnUploadFile(f.url, "uploading");
    });
    this.uploadDemoFileList = [...this.uploadDemoFileList, ...uploadingFiles];
    for (let i: number = 0; i < uploadingFiles.length; i++) {
      this.simulateUpload(uploadingFiles[i]);
    }
  }

  /**
   * 删除模拟上传列表中的指定文件
   * @param index 待删除文件的索引
   */
  deleteUploadDemoFile(index: number): void {
    this.uploadDemoFileList = this.uploadDemoFileList.filter((_item: TnUploadFile, i: number) => i !== index);
  }

  /**
   * 模拟单个文件的上传过程
   * 直接修改 TnUploadFile 的 @Trace 属性，仅触发进度文字的局部刷新
   * @param file 文件对象引用
   */
  private simulateUpload(file: TnUploadFile): void {
    const timerId: number = setInterval(() => {
      if (file.status !== "uploading") {
        clearInterval(timerId);
        return;
      }
      const newProgress: number = file.progress + UPLOAD_STEP;
      if (newProgress >= 100) {
        clearInterval(timerId);
        const isFail: boolean = Math.random() < FAIL_THRESHOLD;
        file.progress = 100;
        file.status = isFail ? "error" : "success";
        file.message = isFail ? "上传失败" : "";
      } else {
        file.progress = newProgress;
      }
    }, UPLOAD_INTERVAL);
  }
}
