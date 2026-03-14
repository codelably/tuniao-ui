/**
 * @file TnInput 输入框展示页面视图
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
import { TnInput, TnIcon } from "@tuniao/tn-ui";
import TnInputViewModel from "../viewmodel/TnInputViewModel";

/**
 * TnInput 输入框展示页面
 */
@ComponentV2
export struct TnInputPage {
  /**
   * 输入框展示页面 ViewModel
   */
  @Local
  private vm: TnInputViewModel = new TnInputViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  /**
   * 构建输入框展示页面
   */
  build() {
    AppNavDestination({
      title: "输入框",
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
      ColumnBase({ widthValue: P100 }) {
        // 1. 基础用法
        this.SectionTitle("基础用法");
        SpaceVerticalMedium();
        this.BasicSection();

        SpaceVerticalLarge();

        // 2. 密码输入
        this.SectionTitle("密码输入");
        SpaceVerticalMedium();
        this.PasswordSection();

        SpaceVerticalLarge();

        // 3. 文本域
        this.SectionTitle("文本域");
        SpaceVerticalMedium();
        this.TextareaSection();

        SpaceVerticalLarge();

        // 4. 清除按钮
        this.SectionTitle("清除按钮");
        SpaceVerticalMedium();
        this.ClearableSection();

        SpaceVerticalLarge();

        // 5. 字数统计
        this.SectionTitle("字数统计");
        SpaceVerticalMedium();
        this.WordLimitSection();

        SpaceVerticalLarge();

        // 6. 禁用/只读
        this.SectionTitle("禁用/只读");
        SpaceVerticalMedium();
        this.DisabledReadonlySection();

        SpaceVerticalLarge();

        // 7. 下划线样式
        this.SectionTitle("下划线样式");
        SpaceVerticalMedium();
        this.UnderlineSection();

        SpaceVerticalLarge();

        // 8. 输入框尺寸
        this.SectionTitle("输入框尺寸");
        SpaceVerticalMedium();
        this.SizeSection();

        SpaceVerticalLarge();

        // 9. 对齐方式
        this.SectionTitle("对齐方式");
        SpaceVerticalMedium();
        this.AlignSection();

        SpaceVerticalLarge();

        // 10. 前后插槽
        this.SectionTitle("前后插槽");
        SpaceVerticalMedium();
        this.SlotSection();
      };
    };
  }

  /**
   * 区域标题
   * @param title 标题文本
   */
  @Builder
  private SectionTitle(title: string): void {
    Text(title)
      .fontSize($r("app.float.headline_medium"))
      .fontColor($r("app.color.text_primary"))
      .fontWeight(FontWeight.Bold);
  }

  /**
   * 1. 基础用法展示区
   */
  @Builder
  private BasicSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("通过 modelValue 双向绑定输入内容，placeholder 设置占位提示文字")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnInput({
          modelValue: this.vm.inputValue1,
          placeholder: "请输入内容",
          onInput: (value: string) => {
            this.vm.setInputValue1(value);
          }
        });

        SpaceVerticalMedium();

        Text(`输入内容: ${this.vm.inputValue1 || "（空）"}`)
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_secondary"));
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 2. 密码输入展示区
   */
  @Builder
  private PasswordSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 type 为 password 时，输入内容自动隐藏，适用于密码、验证码等场景")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnInput({
          modelValue: this.vm.passwordValue,
          type: "password",
          placeholder: "请输入密码",
          onInput: (value: string) => {
            this.vm.setPasswordValue(value);
          }
        });
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 3. 文本域展示区
   */
  @Builder
  private TextareaSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 type 为 textarea 时，输入框变为多行文本域，支持换行输入")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnInput({
          modelValue: this.vm.textareaValue,
          type: "textarea",
          placeholder: "请输入多行文本内容",
          onInput: (value: string) => {
            this.vm.setTextareaValue(value);
          }
        });

        SpaceVerticalMedium();

        Text(`已输入: ${this.vm.textareaValue.length} 字`)
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_secondary"));
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 4. 清除按钮展示区
   */
  @Builder
  private ClearableSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 clearable 在输入框有内容时显示清除图标，点击可一键清空内容")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnInput({
          modelValue: this.vm.inputValue2,
          clearable: true,
          placeholder: "输入内容后右侧出现清除按钮",
          onInput: (value: string) => {
            this.vm.setInputValue2(value);
          },
          onClear: () => {
            this.vm.setInputValue2("");
          }
        });
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 5. 字数统计展示区
   */
  @Builder
  private WordLimitSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("配合 showWordLimit 和 maxlength 展示字数统计，超出限制后无法继续输入")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnInput({
          modelValue: this.vm.inputValue1,
          showWordLimit: true,
          maxlength: 50,
          placeholder: "最多输入 50 个字符",
          onInput: (value: string) => {
            this.vm.setInputValue1(value);
          }
        });
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 6. 禁用/只读展示区
   */
  @Builder
  private DisabledReadonlySection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("disabled 禁用输入框（灰色样式，不可聚焦），readonly 只读输入框（可展示内容，不可编辑）")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnInput({
          modelValue: "禁用状态的内容",
          disabled: true,
          placeholder: "禁用状态"
        });

        SpaceVerticalMedium();

        TnInput({
          modelValue: "只读状态的内容",
          readonly: true,
          placeholder: "只读状态"
        });
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 7. 下划线样式展示区
   */
  @Builder
  private UnderlineSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 underline 为下划线样式，去除外边框，仅保留底部下划线，风格更简洁")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnInput({
          modelValue: this.vm.inputValue1,
          underline: true,
          placeholder: "下划线样式输入框",
          onInput: (value: string) => {
            this.vm.setInputValue1(value);
          }
        });

        SpaceVerticalMedium();

        TnInput({
          modelValue: this.vm.passwordValue,
          type: "password",
          underline: true,
          placeholder: "下划线密码输入框",
          onInput: (value: string) => {
            this.vm.setPasswordValue(value);
          }
        });
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 8. 输入框尺寸展示区
   */
  @Builder
  private SizeSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("通过 size 属性设置输入框预设尺寸，支持 sm（小）和 lg（大），默认为中等尺寸")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnInput({
          modelValue: this.vm.sizeSmValue,
          inputSize: "sm",
          placeholder: "小尺寸输入框 (sm)",
          onInput: (value: string) => {
            this.vm.setSizeSmValue(value);
          }
        });

        SpaceVerticalMedium();

        TnInput({
          modelValue: this.vm.inputValue1,
          placeholder: "默认尺寸输入框",
          onInput: (value: string) => {
            this.vm.setInputValue1(value);
          }
        });

        SpaceVerticalMedium();

        TnInput({
          modelValue: this.vm.sizeLgValue,
          inputSize: "lg",
          placeholder: "大尺寸输入框 (lg)",
          onInput: (value: string) => {
            this.vm.setSizeLgValue(value);
          }
        });
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 9. 对齐方式展示区
   */
  @Builder
  private AlignSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("通过 textAlign 属性设置输入框内容对齐方式，支持 left、center、right")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnInput({
          modelValue: this.vm.inputValue1,
          textAlign: "left",
          placeholder: "左对齐（默认）",
          onInput: (value: string) => {
            this.vm.setInputValue1(value);
          }
        });

        SpaceVerticalMedium();

        TnInput({
          modelValue: this.vm.alignCenterValue,
          textAlign: "center",
          placeholder: "居中对齐",
          onInput: (value: string) => {
            this.vm.setAlignCenterValue(value);
          }
        });

        SpaceVerticalMedium();

        TnInput({
          modelValue: this.vm.alignRightValue,
          textAlign: "right",
          placeholder: "右对齐",
          onInput: (value: string) => {
            this.vm.setAlignRightValue(value);
          }
        });
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 10. 前后插槽展示区
   */
  @Builder
  private SlotSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("通过 prefixBuilder 和 suffixBuilder 自定义输入框前后内容，如图标、文字等")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnInput({
          modelValue: this.vm.slotValue,
          placeholder: "请输入搜索内容",
          onInput: (value: string) => {
            this.vm.setSlotValue(value);
          },
          prefixBuilder: (): void => this.PrefixSearchIcon(),
          suffixBuilder: (): void => this.SuffixSearchButton()
        });
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 搜索图标前置插槽
   */
  @Builder
  private PrefixSearchIcon(): void {
    TnIcon({ name: "search", iconSize: 16, color: $r("app.color.tn_color_gray") })
      .margin({ right: 4 });
  }

  /**
   * 搜索按钮后置插槽
   */
  @Builder
  private SuffixSearchButton(): void {
    Text("搜索")
      .fontSize($r("app.float.body_medium"))
      .fontColor($r("app.color.tn_color_white"))
      .backgroundColor($r("app.color.tn_color_primary"))
      .borderRadius($r("app.float.radius_small"))
      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      .margin({ left: 4 });
  }
}
