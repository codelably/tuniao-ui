/**
 * @file TnFormItem 表单项容器组件
 * @description 包裹表单控件，提供标签、验证消息显示、必填星号等能力
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnUIBaseStyleType, TnUIBaseStyle } from "../../theme-chalk/index.type";
import { TnAppStorageKey } from "../../common/storage_key";
import { getThemeColor, getFontSizeByKey } from "../../common/theme_helpers";
import {
  TnFormRuleItem,
  TnLabelPosition,
  TnRequireAsteriskPosition,
  TnFieldItem,
  TnFieldValidateInfo,
  TnFieldValueType,
  TnFormSendFieldCallResult,
  TN_FORM_EVENT,
  getTnFormEventName
} from "./TnFormTypes";
import tnEmitter from "../../utils/EventEmitter";
import { validateRules } from "../../utils/FormValidation";
import { convertDimensionsWidthUnit } from "../../utils/Utils";

/**
 * TnFormItem 表单项容器
 * @description 包裹表单控件，通过 EventBus 与 TnForm 通信，实现标签显示、验证错误消息等功能
 */
@ComponentV2
export struct TnFormItem {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  /**
   * 关联的 Form ID
   */
  @Param formId: string = "";

  /**
   * 字段名称（用于验证规则匹配）
   */
  @Param prop: string = "";

  /**
   * 标签文字
   */
  @Param label: ResourceStr = "";

  /**
   * 标签宽度(vp)
   */
  @Param labelWidth: number = 0;

  /**
   * 标签位置
   */
  @Param labelPosition: TnLabelPosition | undefined = undefined;

  /**
   * 是否必填（undefined 时从 rules 推断）
   */
  @Param required: boolean | undefined = undefined;

  /**
   * 字段级验证规则（优先于 Form 级）
   */
  @Param rules: TnFormRuleItem[] = [];

  /**
   * 是否显示错误消息
   */
  @Param showMessage: boolean | undefined = undefined;

  /**
   * 字段当前值（由外部通过 @Param 传入，用于验证）
   */
  @Param value: TnFieldValueType = "";

  /**
   * 值变化回调
   */
  @Event onValueChange: (value: TnFieldValueType) => void = (_value: TnFieldValueType): void => {};

  /**
   * 内容插槽
   */
  @BuilderParam defaultBuilder: CustomBuilder;

  /**
   * 唯一标识
   */
  @Local private uniId: string = "";

  /**
   * 验证错误消息
   */
  @Local private errorMessage: string = "";

  /**
   * Form 下发的标签宽度
   */
  @Local private formLabelWidth: number = 80;

  /**
   * Form 下发的标签位置
   */
  @Local private formLabelPosition: TnLabelPosition = "left";

  /**
   * Form 下发的冒号
   */
  @Local private formColon: boolean = false;

  /**
   * Form 下发的星号位置
   */
  @Local private formAsteriskPosition: TnRequireAsteriskPosition = "left";

  /**
   * Form 下发的显示消息
   */
  @Local private formShowMessage: boolean = true;

  /**
   * Form 下发的禁用
   */
  @Local private formDisabled: boolean = false;

  /**
   * Form 下发的验证规则
   */
  @Local private formRules: TnFormRuleItem[] = [];

  aboutToAppear(): void {
    this.uniId = `tn_form_item_${Date.now()}_${Math.floor(Math.random() * 10000)}`;
    if (this.formId.length > 0) {
      this.registerToForm();
    }
  }

  aboutToDisappear(): void {
    if (this.formId.length > 0) {
      tnEmitter.emit(
        getTnFormEventName(TN_FORM_EVENT.DELETE_FIELD, this.formId),
        this.uniId
      );
      tnEmitter.off(
        getTnFormEventName(TN_FORM_EVENT.VALIDATE_FIELD, this.formId),
        this.uniId
      );
    }
  }

  /**
   * 向 Form 注册自身
   */
  private registerToForm(): void {
    const fieldItem: TnFieldItem = {
      uniId: this.uniId,
      prop: this.prop,
      validate: (): Promise<TnFieldValidateInfo> => this.doValidate(),
      resetValidation: (): void => this.resetValidation(),
      getValue: (): TnFieldValueType => this.value,
      setValue: (value: TnFieldValueType): void => {
        this.onValueChange(value);
      }
    };
    const callback = (result: TnFormSendFieldCallResult): void => {
      if (this.rules.length === 0) {
        this.formRules = result.rules || [];
      }
      if (this.labelWidth === 0) {
        this.formLabelWidth = result.labelWidth;
      }
      if (this.labelPosition === undefined) {
        this.formLabelPosition = result.labelPosition;
      }
      this.formColon = result.colon;
      this.formAsteriskPosition = result.requireAsteriskPosition;
      if (this.showMessage === undefined) {
        this.formShowMessage = result.showMessage;
      }
      this.formDisabled = result.disabled;
    };
    tnEmitter.emit(
      getTnFormEventName(TN_FORM_EVENT.SEND_FIELD, this.formId),
      fieldItem,
      callback
    );
  }

  /**
   * 执行验证
   * @returns 验证失败信息
   */
  private doValidate(): Promise<TnFieldValidateInfo> {
    const activeRules: TnFormRuleItem[] = this.rules.length > 0 ? this.rules : this.formRules;
    const result: TnFieldValidateInfo = {
      label: typeof this.label === "string" ? this.label : this.prop,
      name: this.prop,
      message: ""
    };
    return new Promise<TnFieldValidateInfo>((resolve: (value: TnFieldValidateInfo) => void) => {
      validateRules(this.value, activeRules, undefined).then((errorMsg: string) => {
        if (typeof errorMsg === "string" && errorMsg.length > 0) {
          this.errorMessage = errorMsg;
          result.message = errorMsg;
        } else {
          this.errorMessage = "";
        }
        resolve(result);
      });
    });
  }

  /**
   * 按触发方式验证
   * @param trigger 触发方式
   */
  public validateByTrigger(trigger: string): void {
    const activeRules: TnFormRuleItem[] = this.rules.length > 0 ? this.rules : this.formRules;
    validateRules(this.value, activeRules, trigger).then((errorMsg: string) => {
      if (typeof errorMsg === "string" && errorMsg.length > 0) {
        this.errorMessage = errorMsg;
      } else {
        this.errorMessage = "";
      }
    });
  }

  /**
   * 重置验证状态
   */
  private resetValidation(): void {
    this.errorMessage = "";
  }

  /**
   * 获取实际标签宽度
   * @returns 标签宽度(vp)
   */
  private getResolvedLabelWidth(): string {
    const width: number = this.labelWidth > 0 ? this.labelWidth : this.formLabelWidth;
    return convertDimensionsWidthUnit(width);
  }

  /**
   * 获取实际标签位置
   * @returns 标签位置
   */
  private getResolvedLabelPosition(): TnLabelPosition {
    return this.labelPosition !== undefined ? this.labelPosition : this.formLabelPosition;
  }

  /**
   * 获取实际是否显示错误消息
   * @returns 是否显示
   */
  private getResolvedShowMessage(): boolean {
    return this.showMessage !== undefined ? this.showMessage : this.formShowMessage;
  }

  /**
   * 判断是否必填
   * @returns 是否必填
   */
  private isRequired(): boolean {
    if (this.required !== undefined) {
      return this.required;
    }
    const activeRules: TnFormRuleItem[] = this.rules.length > 0 ? this.rules : this.formRules;
    return activeRules.some((rule: TnFormRuleItem): boolean => rule.required === true);
  }

  /**
   * 获取危险色（用于星号和错误消息）
   * @returns 危险色值
   */
  private getDangerColor(): ResourceColor {
    return getThemeColor(this.baseStyle, "danger");
  }

  /**
   * 获取主文本色
   * @returns 主文本色值
   */
  private getTextPrimaryColor(): ResourceColor {
    return $r("app.color.tn_text_color_primary");
  }

  build() {
    if (this.getResolvedLabelPosition() === "top") {
      this.TopLayoutBuilder();
    } else {
      this.LeftLayoutBuilder();
    }
  }

  /**
   * 标签在左侧的布局
   */
  @Builder
  private LeftLayoutBuilder(): void {
    Column() {
      Row() {
        // 标签区域
        if (this.label !== "") {
          Row() {
            if (this.isRequired() && this.formAsteriskPosition === "left") {
              Text("*")
                .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
                .fontColor(this.getDangerColor())
                .lineHeight(this.baseStyle.lineHeightSm)
                .margin({ right: this.baseStyle.spaceMini });
            }
            Text(this.label)
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
              .fontColor(this.getTextPrimaryColor())
              .lineHeight(this.baseStyle.lineHeightSm);
            if (this.formColon) {
              Text(":")
                .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
                .fontColor(this.getTextPrimaryColor())
                .lineHeight(this.baseStyle.lineHeightSm);
            }
            if (this.isRequired() && this.formAsteriskPosition === "right") {
              Text("*")
                .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
                .fontColor(this.getDangerColor())
                .lineHeight(this.baseStyle.lineHeightSm)
                .margin({ left: this.baseStyle.spaceMini });
            }
          }
          .width(this.getResolvedLabelWidth())
          .alignItems(VerticalAlign.Center);
        }
        // 内容区域
        Column() {
          if (this.defaultBuilder) {
            this.defaultBuilder();
          }
        }
        .layoutWeight(1);
      }
      .width("100%")
      .alignItems(VerticalAlign.Center);

      // 错误消息
      if (this.getResolvedShowMessage() && this.errorMessage.length > 0) {
        Text(this.errorMessage)
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
          .fontColor(this.getDangerColor())
          .lineHeight(this.baseStyle.lineHeightXs)
          .margin({
            top: this.baseStyle.spaceBase,
            left: this.label !== "" ? this.getResolvedLabelWidth() : 0
          });
      }
    }
    .width("100%")
    .alignItems(HorizontalAlign.Start);
  }

  /**
   * 标签在顶部的布局
   */
  @Builder
  private TopLayoutBuilder(): void {
    Column() {
      // 标签区域
      if (this.label !== "") {
        Row() {
          if (this.isRequired() && this.formAsteriskPosition === "left") {
            Text("*")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
              .fontColor(this.getDangerColor())
              .lineHeight(this.baseStyle.lineHeightSm)
              .margin({ right: convertDimensionsWidthUnit(2) });
          }
          Text(this.label)
            .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
            .fontColor(this.getTextPrimaryColor())
            .lineHeight(this.baseStyle.lineHeightSm);
          if (this.formColon) {
            Text(":")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
              .fontColor(this.getTextPrimaryColor())
              .lineHeight(this.baseStyle.lineHeightSm);
          }
          if (this.isRequired() && this.formAsteriskPosition === "right") {
            Text("*")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
              .fontColor(this.getDangerColor())
              .lineHeight(this.baseStyle.lineHeightSm)
              .margin({ left: convertDimensionsWidthUnit(2) });
          }
        }
        .margin({ bottom: this.baseStyle.spaceXsm })
        .alignItems(VerticalAlign.Center);
      }

      // 内容区域
      if (this.defaultBuilder) {
        this.defaultBuilder();
      }

      // 错误消息
      if (this.getResolvedShowMessage() && this.errorMessage.length > 0) {
        Text(this.errorMessage)
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
          .fontColor(this.getDangerColor())
          .lineHeight(this.baseStyle.lineHeightXs)
          .margin({ top: this.baseStyle.spaceBase });
      }
    }
    .width("100%")
    .alignItems(HorizontalAlign.Start);
  }
}
