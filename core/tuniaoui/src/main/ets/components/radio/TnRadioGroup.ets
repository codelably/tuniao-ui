/**
 * @file TnRadioGroup 单选框组组件
 * @description 管理一组 TnRadio 子组件的选中状态，通过 EventBus 实现父子通信
 * @author JunBin.Yang
 */

import tnEmitter from "../../utils/EventEmitter";
import { AppStorageV2, LengthMetrics } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { SPACE } from "../../theme-chalk/space";
import {
  TnRadioValueType,
  TN_RADIO_GROUP_EVENT,
  getTnRadioGroupEventName,
  TnRadioGroupConfig
} from "./TnRadioTypes";

/**
 * TnRadioGroup 单选框组
 *
 * @example
 * TnRadioGroup({ group: "gender", modelValue: "male", onChange: (val) => { ... } }) {
 *   TnRadio({ group: "gender", label: "male" }) { Text("男") }
 *   TnRadio({ group: "gender", label: "female" }) { Text("女") }
 * }
 */
@ComponentV2
export struct TnRadioGroup {
  /** 全局基础样式 */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /** 分组标识，子项 TnRadio 需传入相同的 group 值 */
  @Param group: string = "";
  /** 当前选中值 */
  @Param modelValue: TnRadioValueType = "";
  /** 禁用所有子项 */
  @Param disabled: boolean = false;
  /** 是否换行排列 */
  @Param wrap: boolean = false;
  /** 激活颜色 */
  @Param activeColor: string = "";
  /** 尺寸(vp) */
  @Param groupSize: number = 0;

  /** 值变化回调 */
  @Event onChange: (value: TnRadioValueType) => void = (_value: TnRadioValueType): void => {};

  /** 内容插槽 */
  @BuilderParam defaultBuilder: CustomBuilder;

  /** 组件唯一 ID（用于事件注销） */
  @Local private uniId: string = "";

  aboutToAppear(): void {
    this.uniId = `tn_radio_group_${Date.now()}_${Math.floor(Math.random() * 10000)}`;
    // 监听子项点击
    tnEmitter.on(
      getTnRadioGroupEventName(TN_RADIO_GROUP_EVENT.ITEM_CLICK, this.group),
      this.uniId,
      (value: TnRadioValueType): void => {
        this.onChange(value);
        // 广播新值给所有子项
        this.broadcastConfig();
      }
    );
    // 延迟广播初始配置给子项
    setTimeout(() => {
      this.broadcastConfig();
    }, 50);
  }

  aboutToDisappear(): void {
    tnEmitter.off(
      getTnRadioGroupEventName(TN_RADIO_GROUP_EVENT.ITEM_CLICK, this.group),
      this.uniId
    );
  }

  /**
   * 监听外部 modelValue / disabled 变化，重新广播配置
   */
  @Monitor("modelValue", "disabled")
  onPropsChange(): void {
    this.broadcastConfig();
  }

  /**
   * 广播组配置给所有子项
   */
  private broadcastConfig(): void {
    const config: TnRadioGroupConfig = {
      selectedValue: this.modelValue,
      disabled: this.disabled,
      activeColor: this.activeColor,
      size: this.groupSize
    };
    tnEmitter.emit(
      getTnRadioGroupEventName(TN_RADIO_GROUP_EVENT.CONFIG, this.group),
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
