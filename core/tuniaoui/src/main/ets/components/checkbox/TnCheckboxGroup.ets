/**
 * @file TnCheckboxGroup 复选框组组件
 * @description 管理一组 TnCheckbox 子组件的选中状态，通过 EventBus 实现父子通信
 * @author JunBin.Yang
 */

import tnEmitter from "../../utils/EventEmitter";
import { AppStorageV2, LengthMetrics } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { SPACE } from "../../theme-chalk/space";
import {
  TnCheckboxValueType,
  TN_CHECKBOX_GROUP_EVENT,
  getTnCheckboxGroupEventName,
  TnCheckboxGroupConfig
} from "./TnCheckboxTypes";

/**
 * TnCheckboxGroup 复选框组
 *
 * @example
 * TnCheckboxGroup({ group: "fruits", modelValue: ["a"], onChange: (val) => { ... } }) {
 *   TnCheckbox({ group: "fruits", label: "a" }) { Text("选项A") }
 *   TnCheckbox({ group: "fruits", label: "b" }) { Text("选项B") }
 * }
 */
@ComponentV2
export struct TnCheckboxGroup {
  /** 全局基础样式 */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /** 分组标识，子项 TnCheckbox 需传入相同的 group 值 */
  @Param group: string = "";
  /** 选中值数组 */
  @Param modelValue: Array<string | number> = [];
  /** 禁用所有子项 */
  @Param disabled: boolean = false;
  /** 是否换行排列 */
  @Param wrap: boolean = false;
  /** 激活颜色 */
  @Param activeColor: string = "";
  /** 尺寸(vp) */
  @Param groupSize: number = 0;
  /** 最少选择数 */
  @Param min: number = 0;
  /** 最多选择数 */
  @Param max: number = Infinity;

  /** 值变化回调 */
  @Event onChange: (value: Array<string | number>) => void = (_value: Array<string | number>): void => {};

  /** 内容插槽 */
  @BuilderParam defaultBuilder: CustomBuilder;

  /** 组件唯一 ID（用于事件注销） */
  @Local private uniId: string = "";
  /** 实际使用的分组标识 */
  @Local private resolvedGroup: string = "";

  aboutToAppear(): void {
    this.uniId = `tn_checkbox_group_${Date.now()}_${Math.floor(Math.random() * 10000)}`;
    this.resolvedGroup = this.group.length > 0 ? this.group : this.uniId;
    // 监听子项点击
    tnEmitter.on(
      getTnCheckboxGroupEventName(TN_CHECKBOX_GROUP_EVENT.ITEM_CLICK, this.resolvedGroup),
      this.uniId,
      (label: TnCheckboxValueType): void => {
        this.handleItemClick(label);
      }
    );
    // 延迟广播初始配置给子项
    setTimeout(() => {
      this.broadcastConfig();
    }, 50);
  }

  aboutToDisappear(): void {
    tnEmitter.off(
      getTnCheckboxGroupEventName(TN_CHECKBOX_GROUP_EVENT.ITEM_CLICK, this.resolvedGroup),
      this.uniId
    );
  }

  /**
   * 监听外部 modelValue / disabled 变化，重新广播配置
   */
  @Monitor("modelValue", "disabled", "activeColor", "groupSize", "min", "max")
  onPropsChange(): void {
    this.broadcastConfig();
  }

  /**
   * 处理子项点击
   * @param label 子项值
   */
  private handleItemClick(label: TnCheckboxValueType): void {
    const labelValue: string | number = typeof label === "boolean"
      ? (label ? 1 : 0)
      : label as (string | number);
    const index: number = this.modelValue.indexOf(labelValue);
    let newValues: Array<string | number>;
    if (index > -1) {
      // 取消选中：检查最小数量限制
      if (this.modelValue.length <= this.min) {
        return;
      }
      newValues = this.modelValue.filter((_item: string | number, i: number): boolean => i !== index);
    } else {
      // 选中：检查最大数量限制
      if (this.modelValue.length >= this.max) {
        return;
      }
      newValues = [...this.modelValue, labelValue];
    }
    this.onChange(newValues);
    this.broadcastValues(newValues);
  }

  /**
   * 广播选中值给所有子项
   * @param values 新选中值数组
   */
  private broadcastValues(values: Array<string | number>): void {
    tnEmitter.emit(
      getTnCheckboxGroupEventName(TN_CHECKBOX_GROUP_EVENT.VALUE_CHANGE, this.resolvedGroup),
      values
    );
  }

  /**
   * 广播组配置给所有子项
   */
  private broadcastConfig(): void {
    const config: TnCheckboxGroupConfig = {
      selectedValues: this.modelValue,
      disabled: this.disabled,
      activeColor: this.activeColor,
      size: this.groupSize,
      min: this.min,
      max: this.max
    };
    tnEmitter.emit(
      getTnCheckboxGroupEventName(TN_CHECKBOX_GROUP_EVENT.CONFIG, this.resolvedGroup),
      config
    );
  }

  build() {
    if (this.wrap) {
      Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(SPACE.MD), cross: LengthMetrics.vp(SPACE.MD) } }) {
        if (this.defaultBuilder) {
          this.defaultBuilder();
        }
      }
      .width("100%");
    } else {
      Row({ space: this.baseStyle.spaceMd }) {
        if (this.defaultBuilder) {
          this.defaultBuilder();
        }
      }
      .alignItems(VerticalAlign.Center);
    }
  }
}
