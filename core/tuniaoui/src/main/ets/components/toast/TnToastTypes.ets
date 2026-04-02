/**
 * @file TnToast 轻提示组件类型定义
 * @description 定义轻提示类型、配置选项、内部参数等类型
 * @author JunBin.Yang
 */

import { TnLoadingModeType } from "../loading/TnLoadingTypes";

/**
 * 轻提示图标类型
 * - success: 成功图标
 * - warning: 警告图标
 * - fail: 失败图标
 * - loading: 加载动画
 */
export type TnToastType = "success" | "warning" | "fail" | "loading";

/**
 * 轻提示显示位置
 * - top: 顶部显示
 * - center: 居中显示（默认）
 * - bottom: 底部显示
 */
export type TnToastPosition = "top" | "center" | "bottom";

/**
 * 文本换行模式
 * - normal: 正常换行
 * - break-all: 允许在任意字符间换行
 * - break-word: 优先在单词边界换行
 */
export type TnToastWordBreak = "normal" | "break-all" | "break-word";

/**
 * 轻提示配置选项（公开 API）
 */
export class TnToastOption {
  /**
   * 提示文本内容
   */
  message: string = "";
  /**
   * 图标类型，设置后会在文字上方展示对应图标
   */
  type: TnToastType | undefined = undefined;
  /**
   * 自动关闭时长（毫秒），0 表示不自动关闭
   */
  duration: number = 1500;
  /**
   * 显示位置
   */
  position: TnToastPosition = "center";
  /**
   * 文本换行模式
   */
  wordBreak: TnToastWordBreak = "normal";
  /**
   * 自定义图标（优先级高于 type），支持图片路径或资源
   */
  icon: ResourceStr | undefined = undefined;
  /**
   * 图标尺寸（vp）
   */
  iconSize: number = 36;
  /**
   * 是否显示背景遮罩层
   */
  isShowMask: boolean = false;
  /**
   * Y 轴偏移量（vp）
   */
  offsetY: number = 0;
  /**
   * 加载动画模式（type 为 "loading" 时生效）
   */
  loadingMode: TnLoadingModeType = "circle";
  /**
   * 加载动画颜色（type 为 "loading" 时生效），默认白色
   */
  loadingColor: ResourceColor | undefined = undefined;
  /**
   * 提示显示后的回调
   */
  onOpen: (() => void) | undefined = undefined;
  /**
   * 提示关闭后的回调
   */
  onClose: (() => void) | undefined = undefined;
}

/**
 * 加载提示快捷配置选项
 */
export class TnToastLoadingOption {
  /**
   * 提示文本内容
   */
  message: string = "";
  /**
   * 自动关闭时长（毫秒），默认 0 不自动关闭
   */
  duration: number = 0;
  /**
   * 加载动画模式
   */
  loadingMode: TnLoadingModeType = "circle";
  /**
   * 加载动画颜色，默认白色
   */
  loadingColor: ResourceColor | undefined = undefined;
}

/**
 * 轻提示内部参数（包含关闭方法和响应式消息）
 * 使用 @ObservedV2 支持动态更新 message
 */
@ObservedV2
export class TnToastParams {
  /**
   * 响应式提示文本（支持动态更新）
   */
  @Trace message: string = "";
  /**
   * 图标类型
   */
  type: TnToastType | undefined = undefined;
  /**
   * 自动关闭时长
   */
  duration: number = 1500;
  /**
   * 显示位置
   */
  position: TnToastPosition = "center";
  /**
   * 文本换行模式
   */
  wordBreak: TnToastWordBreak = "normal";
  /**
   * 自定义图标
   */
  icon: ResourceStr | undefined = undefined;
  /**
   * 图标尺寸（vp）
   */
  iconSize: number = 36;
  /**
   * 是否显示背景遮罩
   */
  isShowMask: boolean = false;
  /**
   * Y 轴偏移量
   */
  offsetY: number = 0;
  /**
   * 加载动画模式
   */
  loadingMode: TnLoadingModeType = "circle";
  /**
   * 加载动画颜色
   */
  loadingColor: ResourceColor | undefined = undefined;
  /**
   * 显示后回调
   */
  onOpen: (() => void) | undefined = undefined;
  /**
   * 关闭后回调
   */
  onClose: (() => void) | undefined = undefined;
  /**
   * 关闭方法（由 Service 注入）
   */
  hide: () => void = (): void => {};

  constructor(option?: TnToastOption) {
    if (option !== undefined) {
      this.message = option.message;
      this.type = option.type;
      this.duration = option.duration;
      this.position = option.position;
      this.wordBreak = option.wordBreak;
      this.icon = option.icon;
      this.iconSize = option.iconSize;
      this.isShowMask = option.isShowMask;
      this.offsetY = option.offsetY;
      this.loadingMode = option.loadingMode;
      this.loadingColor = option.loadingColor;
      this.onOpen = option.onOpen;
      this.onClose = option.onClose;
    }
  }
}
