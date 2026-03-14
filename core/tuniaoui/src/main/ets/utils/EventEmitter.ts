/**
 * @file 事件总线（发布-订阅模式）
 * @description 提供组件间通信能力，用于 Form/FormItem/Field 等组件的数据传递
 * @author JunBin.Yang
 */

/**
 * 事件监听器项
 */
interface EventListenerItem {
  id: string;
  listener: Function;
}

/**
 * 事件总线类
 * 基于发布-订阅模式实现组件间通信
 */
class TnEventEmitter {
  /**
   * 事件存储映射，key 为事件名称，value 为监听器列表
   */
  private events: Record<string, EventListenerItem[]> = {};

  /**
   * 订阅事件
   * @param eventName 事件名称
   * @param id 监听器唯一标识（用于精确注销）
   * @param listener 事件回调函数
   */
  on(eventName: string, id: string, listener: Function): void {
    if (!this.events[eventName]) {
      this.events[eventName] = [];
    }
    this.events[eventName].push({ id, listener });
  }

  /**
   * 取消订阅事件
   * @param eventName 事件名称
   * @param id 监听器唯一标识
   */
  off(eventName: string, id: string): void {
    if (!this.events[eventName]) {
      return;
    }
    this.events[eventName] = this.events[eventName].filter(
      (item: EventListenerItem) => item.id !== id
    );
  }

  /**
   * 发布事件
   * @param eventName 事件名称
   * @param args 传递给监听器的参数
   */
  emit(eventName: string, ...args: Object[]): void {
    if (!this.events[eventName]) {
      return;
    }
    this.events[eventName].forEach((item: EventListenerItem) => {
      item.listener.apply(undefined, args);
    });
  }
}

/**
 * 全局事件总线单例
 */
const tnEmitter = new TnEventEmitter();

export default tnEmitter;
