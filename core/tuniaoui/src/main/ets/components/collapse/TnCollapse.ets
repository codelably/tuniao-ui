/**
 * @file TnCollapse 折叠面板容器组件
 * @description 管理多个 TnCollapseItem 的展开/收起状态，支持手风琴和多选模式
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import tnEmitter from "../../utils/EventEmitter";
import { TN_COLLAPSE_EVENT, getTnCollapseEventName } from "./TnCollapseTypes";

/**
 * TnCollapse 折叠面板容器组件
 *
 * @example
 * // 手风琴模式（默认，同时只展开一个）
 * TnCollapse({ groupId: "demo1", value: 0 }) {
 *   TnCollapseItem({ groupId: "demo1", name: 0, title: "面板一" }) { Text("内容一") }
 *   TnCollapseItem({ groupId: "demo1", name: 1, title: "面板二" }) { Text("内容二") }
 * }
 *
 * @example
 * // 多选模式
 * TnCollapse({ groupId: "demo2", value: [0, 1], accordion: false }) {
 *   TnCollapseItem({ groupId: "demo2", name: 0, title: "面板一" }) { Text("内容一") }
 *   TnCollapseItem({ groupId: "demo2", name: 1, title: "面板二" }) { Text("内容二") }
 * }
 */
@ComponentV2
export struct TnCollapse {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /**
   * 分组标识（须与子组件 TnCollapseItem 的 groupId 保持一致）
   */
  @Require @Param groupId: string = "";
  /**
   * 当前展开面板的标识
   * - 手风琴模式：number（单个面板标识，-1 表示全部关闭）
   * - 多选模式：number[]（多个面板标识）
   */
  @Param value: number | number[] = -1;
  /**
   * 是否开启手风琴模式（同时只展开一个面板）
   */
  @Param accordion: boolean = true;
  /**
   * 是否显示折叠箭头图标
   */
  @Param showArrow: boolean = true;
  /**
   * 折叠箭头颜色
   */
  @Param arrowColor: ResourceColor = "";
  /**
   * 是否显示面板之间的分割线
   */
  @Param hasBorder: boolean = true;
  /**
   * 展开状态变化回调
   * @param value 当前展开的面板标识
   */
  @Event onChange: (value: number | number[]) => void = () => {};
  /**
   * 双向绑定回调（用于 $value）
   * @param value 当前展开的面板标识
   */
  @Event $value: (value: number | number[]) => void = () => {};
  /**
   * 默认内容插槽（放置 TnCollapseItem）
   */
  @BuilderParam defaultBuilder: CustomBuilder;

  aboutToAppear(): void {
    // 监听子组件切换事件
    tnEmitter.on(
      getTnCollapseEventName(TN_COLLAPSE_EVENT.ITEM_TOGGLE, this.groupId),
      this.groupId,
      (name: number) => {
        this.handleItemToggle(name);
      }
    );
  }

  aboutToDisappear(): void {
    tnEmitter.off(
      getTnCollapseEventName(TN_COLLAPSE_EVENT.ITEM_TOGGLE, this.groupId),
      this.groupId
    );
  }

  /**
   * 监听 value 变化，广播给子组件
   */
  @Monitor("value")
  onValueChange(): void {
    this.broadcastState();
  }

  /**
   * 广播当前展开状态给所有子组件
   */
  private broadcastState(): void {
    tnEmitter.emit(
      getTnCollapseEventName(TN_COLLAPSE_EVENT.INIT_ITEM, this.groupId),
      this.value,
      this.accordion,
      this.showArrow,
      this.arrowColor,
      this.hasBorder
    );
  }

  /**
   * 处理子组件切换展开状态
   * @param name 被点击面板的标识
   */
  private handleItemToggle(name: number): void {
    if (this.accordion) {
      // 手风琴模式：如果点击的是已展开的面板，则关闭；否则展开该面板
      const newValue: number = (this.value === name) ? -1 : name;
      this.$value(newValue);
      this.onChange(newValue);
    } else {
      // 多选模式：切换面板在数组中的存在状态
      const currentArr: number[] = Array.isArray(this.value) ? this.value : [];
      const index: number = currentArr.indexOf(name);
      let newArr: number[];
      if (index >= 0) {
        newArr = currentArr.filter((item: number) => item !== name);
      } else {
        newArr = [...currentArr, name];
      }
      this.$value(newArr);
      this.onChange(newArr);
    }
  }

  build() {
    Column() {
      if (this.defaultBuilder) {
        this.defaultBuilder();
      }
    }
    .width("100%")
    .backgroundColor($r("app.color.tn_bg_color"))
    .borderRadius(this.baseStyle.borderRadius)
    .onAppear(() => {
      // 组件构建完成后广播初始状态
      setTimeout(() => {
        this.broadcastState();
      }, 0);
    })
  }
}
