/**
 * @file TnForm 表单展示页面 ViewModel
 * @description 管理表单示例中各场景的数据模型与业务逻辑
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";
import { TnFormController, TnFormRules, TnFormRuleItem } from "@tuniao/tn-ui";

/**
 * 基础表单数据模型
 */
@ObservedV2
export class BasicFormData {
  /** 姓名 */
  @Trace name: string = "";
  /** 手机号 */
  @Trace phone: string = "";
}

/**
 * 自定义校验表单数据模型
 */
@ObservedV2
export class CustomRuleFormData {
  /** 正则校验值 */
  @Trace patternValue: string = "123";
  /** 函数校验值 */
  @Trace funcValue: string = "";
  /** 函数校验（返回消息）值 */
  @Trace funcMsgValue: string = "abc";
  /** 异步校验值 */
  @Trace asyncValue: string = "";
}

/**
 * 自定义表单项类型数据模型
 */
@ObservedV2
export class CustomTypeFormData {
  /** 开关值 */
  @Trace switchValue: boolean = false;
  /** 复选框值 */
  @Trace checkboxValue: boolean = false;
  /** 复选框组值 */
  @Trace checkboxGroupValue: Array<string> = [];
  /** 单选框值 */
  @Trace radioValue: string = "";
  /** 步进器值 */
  @Trace stepperValue: number = 1;
  /** 评分值 */
  @Trace rateValue: number = 0;
}

/**
 * 动态表单学科项
 */
@ObservedV2
export class SubjectItem {
  /** 学科名称 */
  @Trace name: string = "";
  /** 学科分数 */
  @Trace score: string = "";
}

/**
 * 动态表单数据模型
 */
@ObservedV2
export class DynamicFormData {
  /** 性别 */
  @Trace gender: string = "";
  /** 男生信息 */
  @Trace maleInfo: string = "";
  /** 女生信息 */
  @Trace femaleInfo: string = "";
  /** 学科列表 */
  @Trace subjects: Array<SubjectItem> = [];
}

/**
 * TnForm 表单展示页面 ViewModel
 */
@ObservedV2
export default class TnFormViewModel extends BaseViewModel {
  // ==================== 场景一：基础用法 ====================
  /** 基础表单数据 */
  @Trace basicForm: BasicFormData = new BasicFormData();
  /** 基础表单控制器 */
  @Trace basicController: TnFormController = new TnFormController();
  /** 基础表单 ID */
  readonly basicFormId: string = "basicForm";
  /** 基础表单校验规则 */
  basicRules: TnFormRules = {
    "name": [
      { required: true, message: "请输入姓名" },
      { min: 2, max: 10, message: "姓名长度在2-10个字符之间" }
    ],
    "phone": [
      { required: true, message: "请输入手机号" }
    ]
  };

  // ==================== 场景二：自定义校验规则 ====================
  /** 自定义校验表单数据 */
  @Trace customRuleForm: CustomRuleFormData = new CustomRuleFormData();
  /** 自定义校验表单控制器 */
  @Trace customRuleController: TnFormController = new TnFormController();
  /** 自定义校验表单 ID */
  readonly customRuleFormId: string = "customRuleForm";
  /** 正则校验模式 */
  private patternReg: RegExp = /\d{6}/;
  /** 函数校验器 */
  private funcValidator: (value: string) => boolean = (val: string): boolean => /1\d{10}/.test(val);
  /** 函数校验器（返回消息） */
  private funcMsgValidator: (value: string) => string = (val: string): string => {
    if (val.length === 0) {
      return "请输入内容";
    }
    if (!/^\d+$/.test(val)) {
      return `${val} 不合法，请输入纯数字`;
    }
    return "";
  };
  /** 异步校验器 */
  private asyncValidator: (value: string) => Promise<boolean> = (val: string): Promise<boolean> => {
    return new Promise<boolean>((resolve: (value: boolean) => void): void => {
      setTimeout((): void => {
        resolve(val === "1234");
      }, 1000);
    });
  };
  /** 自定义校验规则 */
  customRuleRules: TnFormRules = {
    "patternValue": [
      { pattern: this.patternReg, message: "请输入6位数字" } as TnFormRuleItem
    ],
    "funcValue": [
      { validator: this.funcValidator, message: "请输入正确的手机号" } as TnFormRuleItem
    ],
    "funcMsgValue": [
      { validator: this.funcMsgValidator } as TnFormRuleItem
    ],
    "asyncValue": [
      { validator: this.asyncValidator, message: "请输入正确内容(1234)" } as TnFormRuleItem
    ]
  };

  // ==================== 场景三：自定义表单项类型 ====================
  /** 自定义类型表单数据 */
  @Trace customTypeForm: CustomTypeFormData = new CustomTypeFormData();
  /** 自定义类型表单控制器 */
  @Trace customTypeController: TnFormController = new TnFormController();
  /** 自定义类型表单 ID */
  readonly customTypeFormId: string = "customTypeForm";
  /** 自定义类型校验规则 */
  customTypeRules: TnFormRules = {
    "checkboxGroupValue": [
      { required: true, message: "请至少选择一项" }
    ],
    "radioValue": [
      { required: true, message: "请选择" }
    ],
    "rateValue": [
      { required: true, message: "请评分" }
    ]
  };

  // ==================== 场景四：动态表单验证 ====================
  /** 动态表单数据 */
  @Trace dynamicForm: DynamicFormData = new DynamicFormData();
  /** 动态表单控制器 */
  @Trace dynamicController: TnFormController = new TnFormController();
  /** 动态表单 ID */
  readonly dynamicFormId: string = "dynamicForm";
  /** 动态表单校验规则 */
  dynamicRules: TnFormRules = {
    "gender": [
      { required: true, message: "请选择性别" }
    ],
    "maleInfo": [
      { required: true, message: "请输入男生信息" }
    ],
    "femaleInfo": [
      { required: true, message: "请输入女生信息" }
    ],
    "subjectName": [
      { required: true, message: "请输入学科名称" }
    ],
    "subjectScore": [
      { required: true, message: "请输入分数" }
    ]
  };

  // ==================== 验证结果展示 ====================
  /** 验证结果消息 */
  @Trace validateResultMsg: string = "";

  // ==================== 基础表单操作 ====================

  /**
   * 设置基础表单姓名
   * @param value 姓名值
   */
  setBasicName(value: string): void {
    this.basicForm.name = value;
  }

  /**
   * 设置基础表单手机号
   * @param value 手机号值
   */
  setBasicPhone(value: string): void {
    this.basicForm.phone = value;
  }

  /**
   * 提交基础表单
   */
  submitBasicForm(): void {
    this.basicController.validate().then((res): void => {
      if (res.valid) {
        this.validateResultMsg = "验证通过";
      } else {
        const labels: Array<string> = res.fields.map((item): string => item.label);
        this.validateResultMsg = `${labels.join(",")} 验证失败`;
      }
    });
  }

  /**
   * 验证基础表单姓名字段
   */
  validateBasicName(): void {
    this.basicController.validateField("name").then((res): void => {
      if (res.valid) {
        this.validateResultMsg = "姓名验证通过";
      } else {
        this.validateResultMsg = `${res.field.label} 验证失败: ${res.field.message}`;
      }
    });
  }

  /**
   * 设置基础表单值
   */
  setBasicFormValues(): void {
    this.basicController.setFormValues({
      "name": "张三",
      "phone": "13800138000"
    });
    this.basicForm.name = "张三";
    this.basicForm.phone = "13800138000";
  }

  // ==================== 自定义校验表单操作 ====================

  /**
   * 设置正则校验值
   * @param value 输入值
   */
  setPatternValue(value: string): void {
    this.customRuleForm.patternValue = value;
  }

  /**
   * 设置函数校验值
   * @param value 输入值
   */
  setFuncValue(value: string): void {
    this.customRuleForm.funcValue = value;
  }

  /**
   * 设置函数消息校验值
   * @param value 输入值
   */
  setFuncMsgValue(value: string): void {
    this.customRuleForm.funcMsgValue = value;
  }

  /**
   * 设置异步校验值
   * @param value 输入值
   */
  setAsyncValue(value: string): void {
    this.customRuleForm.asyncValue = value;
  }

  /**
   * 提交自定义校验表单
   */
  submitCustomRuleForm(): void {
    this.customRuleController.validate().then((res): void => {
      if (res.valid) {
        this.validateResultMsg = "自定义校验全部通过";
      } else {
        const labels: Array<string> = res.fields.map((item): string => item.message);
        this.validateResultMsg = labels.join("; ");
      }
    });
  }

  // ==================== 自定义类型表单操作 ====================

  /**
   * 提交自定义类型表单
   */
  submitCustomTypeForm(): void {
    this.customTypeController.validate().then((res): void => {
      if (res.valid) {
        const values: string = JSON.stringify(this.customTypeController.getFormValues());
        this.validateResultMsg = `表单值: ${values}`;
      } else {
        const labels: Array<string> = res.fields.map((item): string => item.message);
        this.validateResultMsg = labels.join("; ");
      }
    });
  }

  // ==================== 动态表单操作 ====================

  /**
   * 设置性别
   * @param value 性别值
   */
  setGender(value: string): void {
    this.dynamicForm.gender = value;
  }

  /**
   * 设置男生信息
   * @param value 信息值
   */
  setMaleInfo(value: string): void {
    this.dynamicForm.maleInfo = value;
  }

  /**
   * 设置女生信息
   * @param value 信息值
   */
  setFemaleInfo(value: string): void {
    this.dynamicForm.femaleInfo = value;
  }

  /**
   * 添加学科
   */
  addSubject(): void {
    this.dynamicForm.subjects.push(new SubjectItem());
  }

  /**
   * 删除学科
   * @param index 索引
   */
  deleteSubject(index: number): void {
    this.dynamicForm.subjects.splice(index, 1);
  }

  /**
   * 设置学科名称
   * @param index 索引
   * @param value 名称
   */
  setSubjectName(index: number, value: string): void {
    this.dynamicForm.subjects[index].name = value;
  }

  /**
   * 设置学科分数
   * @param index 索引
   * @param value 分数
   */
  setSubjectScore(index: number, value: string): void {
    this.dynamicForm.subjects[index].score = value;
  }

  /**
   * 提交动态表单
   */
  submitDynamicForm(): void {
    this.dynamicController.validate().then((res): void => {
      if (res.valid) {
        this.validateResultMsg = "动态表单验证全部通过";
      } else {
        const labels: Array<string> = res.fields.map((item): string => item.message);
        this.validateResultMsg = labels.join("; ");
      }
    });
  }
}
