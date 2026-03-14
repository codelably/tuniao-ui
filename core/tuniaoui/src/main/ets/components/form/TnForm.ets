/**
 * @file TnForm 表单容器组件
 * @description 表单容器，管理子 FormItem 的注册、验证、取值、赋值等
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import {
  TnFormRules,
  TnFormRuleItem,
  TnLabelPosition,
  TnRequireAsteriskPosition,
  TnFieldItem,
  TnFieldValueType,
  TnFieldValidateInfo,
  TnFormValidateResult,
  TnFieldValidateResult,
  TnFormSendFieldCallResult,
  TnFormController,
  TN_FORM_EVENT,
  getTnFormEventName
} from "./TnFormTypes";
import tnEmitter from "../../utils/EventEmitter";

/**
 * TnForm 表单容器
 *
 * @example
 * TnForm({
 *   formId: "loginForm",
 *   rules: { username: [{ required: true, message: "请输入用户名" }] },
 *   controller: formController,
 *   defaultBuilder: () => {
 *     TnFormItem({ formId: "loginForm", prop: "username", label: "用户名" }) { ... }
 *   }
 * })
 */
@ComponentV2
export struct TnForm {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  /** 表单唯一标识（必填） */
  @Param formId: string = "";
  /** 验证规则集 */
  @Param rules: TnFormRules = {};
  /** 标签宽度(vp) */
  @Param labelWidth: number = 80;
  /** 标签位置 */
  @Param labelPosition: TnLabelPosition = "left";
  /** 标签后冒号 */
  @Param colon: boolean = false;
  /** 必填星号位置 */
  @Param requireAsteriskPosition: TnRequireAsteriskPosition = "left";
  /** 显示验证错误消息 */
  @Param showMessage: boolean = true;
  /** 禁用所有字段 */
  @Param disabled: boolean = false;
  /** 字段间距(vp) */
  @Param space: number = 0;
  /** 表单控制器 */
  @Param controller: TnFormController = new TnFormController();

  /** 内容插槽 */
  @BuilderParam defaultBuilder: CustomBuilder;

  /** 已注册的字段集合 */
  @Local private fieldsMap: Map<string, TnFieldItem> = new Map();

  aboutToAppear(): void {
    this.setupEventListeners();
    this.bindController();
  }

  aboutToDisappear(): void {
    this.cleanupEventListeners();
  }

  /**
   * 注册 EventBus 事件监听
   */
  private setupEventListeners(): void {
    if (this.formId.length === 0) {
      return;
    }

    // 监听 FormItem 注册
    tnEmitter.on(
      getTnFormEventName(TN_FORM_EVENT.SEND_FIELD, this.formId),
      this.formId,
      (fieldItem: TnFieldItem, callback: (result: TnFormSendFieldCallResult) => void): void => {
        this.handleFieldRegister(fieldItem, callback);
      }
    );

    // 监听 FormItem 注销
    tnEmitter.on(
      getTnFormEventName(TN_FORM_EVENT.DELETE_FIELD, this.formId),
      `${this.formId}_delete`,
      (uniId: string): void => {
        this.handleFieldDelete(uniId);
      }
    );
  }

  /**
   * 清理 EventBus 事件监听
   */
  private cleanupEventListeners(): void {
    if (this.formId.length === 0) {
      return;
    }
    tnEmitter.off(getTnFormEventName(TN_FORM_EVENT.SEND_FIELD, this.formId), this.formId);
    tnEmitter.off(getTnFormEventName(TN_FORM_EVENT.DELETE_FIELD, this.formId), `${this.formId}_delete`);
  }

  /**
   * 处理 FormItem 注册
   * @param fieldItem 字段注册信息
   * @param callback 回调，下发 Form 配置给 FormItem
   */
  private handleFieldRegister(
    fieldItem: TnFieldItem,
    callback: (result: TnFormSendFieldCallResult) => void
  ): void {
    // 存储字段
    this.fieldsMap.set(fieldItem.uniId, fieldItem);

    // 查找对应的验证规则
    let fieldRules: TnFormRuleItem[] = [];
    if (fieldItem.prop.length > 0 && this.rules[fieldItem.prop] !== undefined) {
      fieldRules = this.rules[fieldItem.prop];
    }

    // 下发配置给 FormItem
    const config: TnFormSendFieldCallResult = {
      rules: fieldRules,
      labelWidth: this.labelWidth,
      labelPosition: this.labelPosition,
      colon: this.colon,
      requireAsteriskPosition: this.requireAsteriskPosition,
      showMessage: this.showMessage,
      disabled: this.disabled
    };
    callback(config);
  }

  /**
   * 处理 FormItem 注销
   * @param uniId 字段唯一标识
   */
  private handleFieldDelete(uniId: string): void {
    this.fieldsMap.delete(uniId);
  }

  /**
   * 绑定控制器方法
   */
  private bindController(): void {
    this.controller.validate = (
      callBack?: (valid: boolean, fields: TnFieldValidateInfo[]) => void
    ): Promise<TnFormValidateResult> => {
      return this.validateAll(callBack);
    };

    this.controller.validateField = (
      name: string,
      callBack?: (valid: boolean, field?: TnFieldValidateInfo) => void
    ): Promise<TnFieldValidateResult> => {
      return this.validateSingleField(name, callBack);
    };

    this.controller.resetValidation = (name?: string | string[]): void => {
      this.resetValidation(name);
    };

    this.controller.getFormValues = (): Record<string, TnFieldValueType> => {
      return this.getFormValues();
    };

    this.controller.setFormValues = (values: Record<string, TnFieldValueType>): void => {
      this.setFormValues(values);
    };
  }

  /**
   * 验证整个表单
   * @param callBack 验证完成回调
   * @returns 验证结果
   */
  private validateAll(
    callBack?: (valid: boolean, fields: TnFieldValidateInfo[]) => void
  ): Promise<TnFormValidateResult> {
    const promises: Promise<TnFieldValidateInfo>[] = [];
    this.fieldsMap.forEach((fieldItem: TnFieldItem) => {
      if (fieldItem.prop.length > 0) {
        promises.push(fieldItem.validate());
      }
    });

    return new Promise<TnFormValidateResult>((resolve: (value: TnFormValidateResult) => void) => {
      Promise.all(promises).then((results: TnFieldValidateInfo[]) => {
        const failedFields: TnFieldValidateInfo[] = results.filter(
          (info: TnFieldValidateInfo): boolean => info.message.length > 0
        );
        const valid: boolean = failedFields.length === 0;
        const formResult: TnFormValidateResult = {
          valid: valid,
          fields: failedFields
        };
        if (callBack) {
          callBack(valid, failedFields);
        }
        resolve(formResult);
      });
    });
  }

  /**
   * 验证单个字段
   * @param name 字段名
   * @param callBack 验证完成回调
   * @returns 验证结果
   */
  private validateSingleField(
    name: string,
    callBack?: (valid: boolean, field?: TnFieldValidateInfo) => void
  ): Promise<TnFieldValidateResult> {
    let targetField: TnFieldItem | undefined = undefined;
    this.fieldsMap.forEach((fieldItem: TnFieldItem) => {
      if (fieldItem.prop === name) {
        targetField = fieldItem;
      }
    });

    if (targetField === undefined) {
      const emptyResult: TnFieldValidateResult = {
        valid: true,
        field: { label: "", name: name, message: "" }
      };
      if (callBack) {
        callBack(true, undefined);
      }
      return Promise.resolve(emptyResult);
    }

    const field: TnFieldItem = targetField as TnFieldItem;
    return new Promise<TnFieldValidateResult>((resolve: (value: TnFieldValidateResult) => void) => {
      field.validate().then((info: TnFieldValidateInfo) => {
        const valid: boolean = info.message.length === 0;
        const result: TnFieldValidateResult = {
          valid: valid,
          field: info
        };
        if (callBack) {
          callBack(valid, valid ? undefined : info);
        }
        resolve(result);
      });
    });
  }

  /**
   * 重置验证结果
   * @param name 字段名或字段名数组（不传则重置所有）
   */
  private resetValidation(name?: string | string[]): void {
    if (name === undefined) {
      // 重置所有
      this.fieldsMap.forEach((fieldItem: TnFieldItem) => {
        fieldItem.resetValidation();
      });
    } else if (typeof name === "string") {
      // 重置指定字段
      this.fieldsMap.forEach((fieldItem: TnFieldItem) => {
        if (fieldItem.prop === name) {
          fieldItem.resetValidation();
        }
      });
    } else if (Array.isArray(name)) {
      // 重置多个字段
      const names: string[] = name as string[];
      this.fieldsMap.forEach((fieldItem: TnFieldItem) => {
        if (names.indexOf(fieldItem.prop) >= 0) {
          fieldItem.resetValidation();
        }
      });
    }
  }

  /**
   * 获取表单所有值
   * @returns 字段名到值的映射
   */
  private getFormValues(): Record<string, TnFieldValueType> {
    const values: Record<string, TnFieldValueType> = {};
    this.fieldsMap.forEach((fieldItem: TnFieldItem) => {
      if (fieldItem.prop.length > 0) {
        values[fieldItem.prop] = fieldItem.getValue();
      }
    });
    return values;
  }

  /**
   * 设置表单值
   * @param values 字段名到值的映射
   */
  private setFormValues(values: Record<string, TnFieldValueType>): void {
    this.fieldsMap.forEach((fieldItem: TnFieldItem) => {
      if (fieldItem.prop.length > 0 && values[fieldItem.prop] !== undefined) {
        fieldItem.setValue(values[fieldItem.prop]);
      }
    });
  }

  build() {
    Column({ space: this.space }) {
      if (this.defaultBuilder) {
        this.defaultBuilder();
      }
    }
    .width("100%");
  }
}
