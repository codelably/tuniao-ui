/**
 * @file TnNotify 消息通知组件类型定义
 * @description 定义通知类型、配置选项、内部参数等类型
 * @author JunBin.Yang
 */

/**
 * 通知类型
 * - primary: 主题色通知
 * - success: 成功通知
 * - warning: 警告通知
 * - danger: 危险/错误通知
 */
export type TnNotifyType = "primary" | "success" | "warning" | "danger";

/**
 * 通知显示位置
 * - top: 顶部显示
 * - bottom: 底部显示
 */
export type TnNotifyPosition = "top" | "bottom";

/**
 * 通知配置选项
 */
export class TnNotifyOption {
  /**
   * 通知显示的文本内容
   */
  message: string = "";
  /**
   * 通知类型，对应不同的背景颜色
   */
  type: TnNotifyType = "danger";
  /**
   * 自动关闭时长（毫秒），0 表示不自动关闭
   */
  duration: number = 3000;
  /**
   * 文字颜色，默认白色
   */
  color: ResourceColor | undefined = undefined;
  /**
   * 自定义背景颜色，设置后会覆盖 type 对应的颜色
   */
  backgroundColor: ResourceColor | undefined = undefined;
  /**
   * 显示位置
   */
  position: TnNotifyPosition = "top";
  /**
   * 通知显示后的回调
   */
  onOpen: (() => void) | undefined = undefined;
  /**
   * 通知关闭后的回调
   */
  onClose: (() => void) | undefined = undefined;
  /**
   * 点击通知时的回调
   */
  onClick: (() => void) | undefined = undefined;
}

/**
 * 通知内部参数（包含关闭方法）
 */
export class TnNotifyParams extends TnNotifyOption {
  /** 关闭通知的方法 */
  hide: () => void = (): void => {};

  constructor(option?: TnNotifyOption) {
    super();
    if (option !== undefined) {
      this.message = option.message;
      this.type = option.type;
      this.duration = option.duration;
      this.color = option.color;
      this.backgroundColor = option.backgroundColor;
      this.position = option.position;
      this.onOpen = option.onOpen;
      this.onClose = option.onClose;
      this.onClick = option.onClick;
    }
  }
}
