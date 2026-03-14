/**
 * @file TnForm 表单展示页面视图
 * @description 参考 IBest-UI 表单示例，展示基础用法、自定义校验规则、自定义表单项类型、动态表单验证四个场景
 * @author JunBin.Yang
 */
import { AppNavDestination } from "@core/components";
import {
  ColumnBase,
  MediumPaddingVerticalScroll,
  P100,
  SpaceVerticalLarge,
  SpaceVerticalMedium
} from "@core/designsystem";
import { getWindowSafeAreaState, WindowSafeAreaState } from "@core/layoutstate";
import { LengthMetrics } from "@kit.ArkUI";
import {
  TnForm,
  TnFormItem,
  TnInput,
  TnRadio,
  TnRadioGroup,
  TnSwitch,
  TnCheckbox,
  TnCheckboxGroup,
  TnNumberBox,
  TnRate,
  TnButton,
  TnList,
  TnListItem,
  TnFormController,
  TnFormRules,
  TnRadioValueType,
  TnSwitchValueType,
  TnCheckboxValueType,
  SPACE
} from "@tuniao/tn-ui";
import TnFormViewModel, { SubjectItem } from "../viewmodel/TnFormViewModel";

/**
 * TnForm 表单展示页面
 */
@ComponentV2
export struct TnFormPage {
  /**
   * 表单展示页面 ViewModel
   */
  @Local
  private vm: TnFormViewModel = new TnFormViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  /**
   * 构建表单展示页面
   */
  build() {
    AppNavDestination({
      title: "表单",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.PageContent();
    }
  }

  /**
   * 页面内容视图
   */
  @Builder
  private PageContent() {
    MediumPaddingVerticalScroll() {
      Column() {
        // 验证结果展示
        if (this.vm.validateResultMsg.length > 0) {
          this.ValidateResultBar();
          SpaceVerticalMedium();
        }

        // 1. 基础用法
        this.BasicFormSection();
        SpaceVerticalLarge();

        // 2. 自定义校验规则
        this.CustomRuleFormSection();
        SpaceVerticalLarge();

        // 3. 自定义表单项类型
        this.CustomTypeFormSection();
        SpaceVerticalLarge();

        // 4. 动态表单验证
        this.DynamicFormSection();
      }
      .width(P100);
    };
  }

  /**
   * 验证结果展示条
   */
  @Builder
  private ValidateResultBar(): void {
    Row() {
      Text(this.vm.validateResultMsg)
        .fontSize($r("app.float.body_medium"))
        .fontColor($r("app.color.tn_color_white"))
        .maxLines(3)
        .textOverflow({ overflow: TextOverflow.Ellipsis });
    }
    .width(P100)
    .padding({
      top: SPACE.XSM,
      bottom: SPACE.XSM,
      left: SPACE.NORMAL,
      right: SPACE.NORMAL
    })
    .backgroundColor($r("app.color.tn_color_primary"))
    .borderRadius($r("app.float.radius_medium"));
  }

  // ==================== 场景一：基础用法 ====================

  /**
   * 基础用法表单区域
   * @description 演示表单基本验证流程，包含验证、设置值、提交操作
   */
  @Builder
  private BasicFormSection(): void {
    TnList({ title: "基础用法", description: "支持验证单个字段、设置表单值、提交验证", card: true }) {
      TnForm({
        formId: this.vm.basicFormId,
        rules: this.vm.basicRules,
        controller: this.vm.basicController
      }) {
        TnListItem({ bottomBorder: true }) {
          TnFormItem({
            formId: this.vm.basicFormId,
            prop: "name",
            label: "姓名",
            value: this.vm.basicForm.name,
            rules: [
              { required: true, message: "请输入姓名" },
              { min: 2, max: 10, message: "姓名长度在2-10个字符之间" }
            ]
          }) {
            TnInput({
              modelValue: this.vm.basicForm.name,
              placeholder: "请输入姓名",
              onInput: (value: string): void => {
                this.vm.setBasicName(value);
              }
            });
          };
        }

        TnListItem() {
          TnFormItem({
            formId: this.vm.basicFormId,
            prop: "phone",
            label: "手机号",
            value: this.vm.basicForm.phone,
            rules: [
              { required: true, message: "请输入手机号" }
            ]
          }) {
            TnInput({
              modelValue: this.vm.basicForm.phone,
              type: "number",
              placeholder: "请输入手机号",
              onInput: (value: string): void => {
                this.vm.setBasicPhone(value);
              }
            });
          };
        }
      };

      SpaceVerticalMedium();

      // 操作按钮
      Column({ space: SPACE.XSM }) {
        Row({ space: SPACE.XSM }) {
          TnButton({
            content: "设置值",
            type: "primary",
            btnSize: "sm",
            onBtnClick: (): void => {
              this.vm.setBasicFormValues();
            }
          });
          TnButton({
            content: "验证姓名",
            type: "primary",
            btnSize: "sm",
            onBtnClick: (): void => {
              this.vm.validateBasicName();
            }
          });
          TnButton({
            content: "提交",
            type: "primary",
            btnSize: "sm",
            onBtnClick: (): void => {
              this.vm.submitBasicForm();
            }
          });
        }
        .width(P100)
        .justifyContent(FlexAlign.SpaceEvenly);
      }
      .width(P100)
      .padding({ left: SPACE.NORMAL, right: SPACE.NORMAL, bottom: SPACE.SM });
    }
  }

  // ==================== 场景二：自定义校验规则 ====================

  /**
   * 自定义校验规则表单区域
   * @description 演示正则校验、函数校验、函数返回消息、异步校验
   */
  @Builder
  private CustomRuleFormSection(): void {
    TnList({ title: "自定义校验规则", description: "支持正则、函数、异步等多种校验方式", card: true }) {
      TnForm({
        formId: this.vm.customRuleFormId,
        rules: this.vm.customRuleRules,
        controller: this.vm.customRuleController
      }) {
        TnListItem({ bottomBorder: true }) {
          TnFormItem({
            formId: this.vm.customRuleFormId,
            prop: "patternValue",
            label: "正则校验",
            value: this.vm.customRuleForm.patternValue
          }) {
            TnInput({
              modelValue: this.vm.customRuleForm.patternValue,
              placeholder: "请输入6位数字",
              onInput: (value: string): void => {
                this.vm.setPatternValue(value);
              }
            });
          };
        }

        TnListItem({ bottomBorder: true }) {
          TnFormItem({
            formId: this.vm.customRuleFormId,
            prop: "funcValue",
            label: "函数校验",
            value: this.vm.customRuleForm.funcValue
          }) {
            TnInput({
              modelValue: this.vm.customRuleForm.funcValue,
              placeholder: "返回 true/false",
              onInput: (value: string): void => {
                this.vm.setFuncValue(value);
              }
            });
          };
        }

        TnListItem({ bottomBorder: true }) {
          TnFormItem({
            formId: this.vm.customRuleFormId,
            prop: "funcMsgValue",
            label: "返回消息",
            value: this.vm.customRuleForm.funcMsgValue
          }) {
            TnInput({
              modelValue: this.vm.customRuleForm.funcMsgValue,
              placeholder: "返回验证信息",
              onInput: (value: string): void => {
                this.vm.setFuncMsgValue(value);
              }
            });
          };
        }

        TnListItem() {
          TnFormItem({
            formId: this.vm.customRuleFormId,
            prop: "asyncValue",
            label: "异步校验",
            value: this.vm.customRuleForm.asyncValue
          }) {
            TnInput({
              modelValue: this.vm.customRuleForm.asyncValue,
              placeholder: "异步校验(输入1234通过)",
              onInput: (value: string): void => {
                this.vm.setAsyncValue(value);
              }
            });
          };
        }
      };

      SpaceVerticalMedium();

      Row() {
        TnButton({
          content: "提交",
          type: "primary",
          btnSize: "sm",
          onBtnClick: (): void => {
            this.vm.submitCustomRuleForm();
          }
        });
      }
      .width(P100)
      .justifyContent(FlexAlign.Center)
      .padding({ bottom: SPACE.SM });
    }
  }

  // ==================== 场景三：自定义表单项类型 ====================

  /**
   * 自定义表单项类型区域
   * @description 演示开关、复选框、复选框组、单选框、步进器、评分等控件
   */
  @Builder
  private CustomTypeFormSection(): void {
    TnList({ title: "自定义表单项类型", description: "支持开关、复选框、单选框、步进器、评分等控件", card: true }) {
      TnForm({
        formId: this.vm.customTypeFormId,
        rules: this.vm.customTypeRules,
        controller: this.vm.customTypeController
      }) {
        // 开关
        TnListItem({ bottomBorder: true }) {
          TnFormItem({
            formId: this.vm.customTypeFormId,
            prop: "switchValue",
            label: "开关",
            value: this.vm.customTypeForm.switchValue
          }) {
            Row() {
              TnSwitch({
                modelValue: this.vm.customTypeForm.switchValue,
                onChange: (value: TnSwitchValueType): void => {
                  this.vm.customTypeForm.switchValue = value as boolean;
                }
              });
            }
            .width(P100)
            .justifyContent(FlexAlign.End);
          };
        }

        // 复选框
        TnListItem({ bottomBorder: true }) {
          TnFormItem({
            formId: this.vm.customTypeFormId,
            prop: "checkboxValue",
            label: "复选框",
            value: this.vm.customTypeForm.checkboxValue
          }) {
            Row() {
              TnCheckbox({
                label: "agree",
                onChange: (value: TnCheckboxValueType): void => {
                  this.vm.customTypeForm.checkboxValue = value as boolean;
                }
              });
            }
            .width(P100)
            .justifyContent(FlexAlign.End);
          };
        }

        // 复选框组
        TnListItem({ bottomBorder: true }) {
          TnFormItem({
            formId: this.vm.customTypeFormId,
            prop: "checkboxGroupValue",
            label: "复选框组",
            value: this.vm.customTypeForm.checkboxGroupValue
          }) {
            TnCheckboxGroup({
              group: "formCheckboxGroup",
              modelValue: this.vm.customTypeForm.checkboxGroupValue,
              onChange: (value: Array<string | number>): void => {
                this.vm.customTypeForm.checkboxGroupValue = value as Array<string>;
              }
            }) {
              Flex({
                wrap: FlexWrap.Wrap,
                space: { main: LengthMetrics.vp(SPACE.SM), cross: LengthMetrics.vp(SPACE.XS) },
                justifyContent: FlexAlign.End
              }) {
                TnCheckbox({ group: "formCheckboxGroup", label: "1" }) {
                  Text("选项一")
                    .fontSize($r("app.float.body_medium"));
                };
                TnCheckbox({ group: "formCheckboxGroup", label: "2" }) {
                  Text("选项二")
                    .fontSize($r("app.float.body_medium"));
                };
                TnCheckbox({ group: "formCheckboxGroup", label: "3" }) {
                  Text("选项三")
                    .fontSize($r("app.float.body_medium"));
                };
              }
              .width(P100);
            };
          };
        }

        // 单选框
        TnListItem({ bottomBorder: true }) {
          TnFormItem({
            formId: this.vm.customTypeFormId,
            prop: "radioValue",
            label: "单选框",
            value: this.vm.customTypeForm.radioValue
          }) {
            TnRadioGroup({
              group: "formGenderRadio",
              modelValue: this.vm.customTypeForm.radioValue,
              onChange: (value: TnRadioValueType): void => {
                this.vm.customTypeForm.radioValue = value as string;
              }
            }) {
              Flex({
                wrap: FlexWrap.Wrap,
                space: { main: LengthMetrics.vp(SPACE.SM), cross: LengthMetrics.vp(SPACE.XS) },
                justifyContent: FlexAlign.End
              }) {
                TnRadio({ group: "formGenderRadio", label: "male" }) {
                  Text("男")
                    .fontSize($r("app.float.body_medium"));
                };
                TnRadio({ group: "formGenderRadio", label: "female" }) {
                  Text("女")
                    .fontSize($r("app.float.body_medium"));
                };
              }
              .width(P100);
            };
          };
        }

        // 步进器
        TnListItem({ bottomBorder: true }) {
          TnFormItem({
            formId: this.vm.customTypeFormId,
            prop: "stepperValue",
            label: "步进器",
            value: this.vm.customTypeForm.stepperValue
          }) {
            Row() {
              TnNumberBox({
                modelValue: this.vm.customTypeForm.stepperValue,
                min: 1,
                max: 99,
                onChange: (value: number): void => {
                  this.vm.customTypeForm.stepperValue = value;
                }
              });
            }
            .width(P100)
            .justifyContent(FlexAlign.End);
          };
        }

        // 评分
        TnListItem() {
          TnFormItem({
            formId: this.vm.customTypeFormId,
            prop: "rateValue",
            label: "评分",
            value: this.vm.customTypeForm.rateValue
          }) {
            Row() {
              TnRate({
                modelValue: this.vm.customTypeForm.rateValue,
                onChange: (value: number): void => {
                  this.vm.customTypeForm.rateValue = value;
                }
              });
            }
            .width(P100)
            .justifyContent(FlexAlign.End);
          };
        }
      };

      SpaceVerticalMedium();

      Row() {
        TnButton({
          content: "提交",
          type: "primary",
          btnSize: "sm",
          onBtnClick: (): void => {
            this.vm.submitCustomTypeForm();
          }
        });
      }
      .width(P100)
      .justifyContent(FlexAlign.Center)
      .padding({ bottom: SPACE.SM });
    }
  }

  // ==================== 场景四：动态表单验证 ====================

  /**
   * 动态表单验证区域
   * @description 演示条件显示字段和动态添加/删除表单项
   */
  @Builder
  private DynamicFormSection(): void {
    TnList({ title: "动态表单验证", description: "支持条件显示字段和动态添加/删除表单项", card: true }) {
      TnForm({
        formId: this.vm.dynamicFormId,
        rules: this.vm.dynamicRules,
        controller: this.vm.dynamicController
      }) {
        // 性别选择
        TnListItem({ bottomBorder: this.vm.dynamicForm.gender.length > 0 }) {
          TnFormItem({
            formId: this.vm.dynamicFormId,
            prop: "gender",
            label: "性别",
            value: this.vm.dynamicForm.gender
          }) {
            TnRadioGroup({
              group: "dynamicGenderRadio",
              modelValue: this.vm.dynamicForm.gender,
              onChange: (value: TnRadioValueType): void => {
                this.vm.setGender(value as string);
              }
            }) {
              Flex({
                wrap: FlexWrap.Wrap,
                space: { main: LengthMetrics.vp(SPACE.SM), cross: LengthMetrics.vp(SPACE.XS) }
              }) {
                TnRadio({ group: "dynamicGenderRadio", label: "male" }) {
                  Text("男")
                    .fontSize($r("app.float.body_medium"));
                };
                TnRadio({ group: "dynamicGenderRadio", label: "female" }) {
                  Text("女")
                    .fontSize($r("app.float.body_medium"));
                };
              }
              .width(P100);
            };
          };
        }

        // 条件显示：男生信息
        if (this.vm.dynamicForm.gender === "male") {
          TnListItem({ bottomBorder: true }) {
            TnFormItem({
              formId: this.vm.dynamicFormId,
              prop: "maleInfo",
              label: "男生信息",
              value: this.vm.dynamicForm.maleInfo
            }) {
              TnInput({
                modelValue: this.vm.dynamicForm.maleInfo,
                placeholder: "请输入男生信息",
                onInput: (value: string): void => {
                  this.vm.setMaleInfo(value);
                }
              });
            };
          }
        }

        // 条件显示：女生信息
        if (this.vm.dynamicForm.gender === "female") {
          TnListItem({ bottomBorder: true }) {
            TnFormItem({
              formId: this.vm.dynamicFormId,
              prop: "femaleInfo",
              label: "女生信息",
              value: this.vm.dynamicForm.femaleInfo
            }) {
              TnInput({
                modelValue: this.vm.dynamicForm.femaleInfo,
                placeholder: "请输入女生信息",
                onInput: (value: string): void => {
                  this.vm.setFemaleInfo(value);
                }
              });
            };
          }
        }

        // 动态学科列表
        ForEach(this.vm.dynamicForm.subjects, (item: SubjectItem, index: number) => {
          this.SubjectItemBuilder(item, index);
        });
      };

      SpaceVerticalMedium();

      // 操作按钮
      Column({ space: SPACE.XSM }) {
        Row({ space: SPACE.XSM }) {
          TnButton({
            content: "添加学科",
            type: "primary",
            btnSize: "sm",
            onBtnClick: (): void => {
              this.vm.addSubject();
            }
          });
          TnButton({
            content: "提交",
            type: "primary",
            btnSize: "sm",
            onBtnClick: (): void => {
              this.vm.submitDynamicForm();
            }
          });
        }
        .width(P100)
        .justifyContent(FlexAlign.SpaceEvenly);
      }
      .width(P100)
      .padding({ left: SPACE.NORMAL, right: SPACE.NORMAL, bottom: SPACE.SM });
    }
  }

  /**
   * 学科项构建器
   * @param item 学科数据
   * @param index 索引
   */
  @Builder
  private SubjectItemBuilder(item: SubjectItem, index: number): void {
    Column() {
      // 学科标题栏
      Row() {
        Text(`学科 ${index + 1}`)
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_primary"))
          .fontWeight(FontWeight.Medium);
        TnButton({
          content: "删除",
          type: "danger",
          btnSize: "sm",
          onBtnClick: (): void => {
            this.vm.deleteSubject(index);
          }
        });
      }
      .width(P100)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({
        top: SPACE.XSM,
        left: SPACE.NORMAL,
        right: SPACE.NORMAL
      });

      // 学科名称
      TnListItem({ bottomBorder: true }) {
        TnFormItem({
          formId: this.vm.dynamicFormId,
          prop: `subjectName`,
          label: "学科名称",
          value: item.name,
          rules: [{ required: true, message: "请输入学科名称" }]
        }) {
          TnInput({
            modelValue: item.name,
            placeholder: "请输入学科名称",
            onInput: (value: string): void => {
              this.vm.setSubjectName(index, value);
            }
          });
        };
      }

      // 学科分数
      TnListItem({ bottomBorder: true }) {
        TnFormItem({
          formId: this.vm.dynamicFormId,
          prop: `subjectScore`,
          label: "分数",
          value: item.score,
          rules: [{ required: true, message: "请输入分数" }]
        }) {
          TnInput({
            modelValue: item.score,
            type: "number",
            placeholder: "请输入分数",
            onInput: (value: string): void => {
              this.vm.setSubjectScore(index, value);
            }
          });
        };
      }
    }
    .width(P100);
  }
}
