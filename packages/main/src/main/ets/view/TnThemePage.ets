/**
 * @file TnTheme 主题切换展示页面视图
 * @description 参考 IBest-UI 风格，每种组件仅展示 1 个 primary 实例，切换主题时整页统一变化
 * @author JunBin.Yang
 */

import { AppNavDestination } from "@core/components";
import {
  P100
} from "@core/designsystem";
import { getWindowSafeAreaState, WindowSafeAreaState } from "@core/layoutstate";
import {
  TnButton,
  TnTag,
  TnBadge,
  TnLoading,
  TnSwitch,
  TnRadio,
  TnRadioGroup,
  TnCheckbox,
  TnCheckboxGroup,
  TnRate,
  TnSlider,
  TnRadioValueType,
  TnSwitchValueType,
  SPACE
} from "@tuniao/tn-ui";
import TnThemeViewModel from "../viewmodel/TnThemeViewModel";

/**
 * TnTheme 主题切换展示页面
 */
@ComponentV2
export struct TnThemePage {
  /**
   * 主题展示页面 ViewModel
   */
  @Local
  private vm: TnThemeViewModel = new TnThemeViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();
  /**
   * 颜色输入框的值
   */
  @Local
  private colorInputValue: string = "";
  /**
   * 开关组件演示值
   */
  @Local
  private switchValue: boolean = true;
  /**
   * 单选框演示值
   */
  @Local
  private radioValue: TnRadioValueType = "1";
  /**
   * 复选框演示值
   */
  @Local
  private checkboxValues: Array<string | number> = ["a"];
  /**
   * 评分演示值
   */
  @Local
  private rateValue: number = 4;
  /**
   * 滑块演示值
   */
  @Local
  private sliderValue: number = 50;

  /**
   * 页面销毁时恢复默认主题
   */
  aboutToDisappear(): void {
    this.vm.restoreDefaultTheme();
  }

  build() {
    AppNavDestination({
      title: "主题切换",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.ThemeContent();
    }
  }

  /**
   * 主题内容视图
   */
  @Builder
  private ThemeContent() {
    List({ space: 0 }) {
      // 自定义颜色输入
      ListItem() {
        this.SectionCard("自定义颜色");
      }
      ListItem() {
        this.CustomColorInput();
      }

      // 按钮
      ListItem() {
        this.SectionCard("按钮 Button");
      }
      ListItem() {
        TnButton({ content: "按钮", type: "primary" });
      }

      // 复选框
      ListItem() {
        this.SectionCard("复选框 Checkbox");
      }
      ListItem() {
        TnCheckboxGroup({
          group: "themeDemo",
          modelValue: this.checkboxValues,
          onChange: (values: Array<string | number>) => {
            this.checkboxValues = values;
          }
        }) {
          TnCheckbox({ group: "themeDemo", label: "a" }) {
            Text("内容")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_primary"));
          };
        }
      }

      // 单选框
      ListItem() {
        this.SectionCard("单选框 Radio");
      }
      ListItem() {
        TnRadioGroup({
          group: "themeRadio",
          modelValue: this.radioValue,
          onChange: (value: TnRadioValueType) => {
            this.radioValue = value;
          }
        }) {
          Row({ space: SPACE.LG }) {
            TnRadio({ group: "themeRadio", label: "1" }) {
              Text("选项1")
                .fontSize($r("app.float.body_medium"))
                .fontColor($r("app.color.text_primary"));
            };
            TnRadio({ group: "themeRadio", label: "2" }) {
              Text("选项2")
                .fontSize($r("app.float.body_medium"))
                .fontColor($r("app.color.text_primary"));
            };
            TnRadio({ group: "themeRadio", label: "3" }) {
              Text("选项3")
                .fontSize($r("app.float.body_medium"))
                .fontColor($r("app.color.text_primary"));
            };
          }
        }
      }

      // 开关
      ListItem() {
        this.SectionCard("开关 Switch");
      }
      ListItem() {
        TnSwitch({
          modelValue: this.switchValue,
          onChange: (value: TnSwitchValueType) => {
            this.switchValue = value as boolean;
          }
        });
      }

      // 评分
      ListItem() {
        this.SectionCard("评分 Rate");
      }
      ListItem() {
        TnRate({
          modelValue: this.rateValue,
          activeColor: "primary",
          onChange: (value: number) => {
            this.rateValue = value;
          }
        });
      }

      // 滑块
      ListItem() {
        this.SectionCard("滑块 Slider");
      }
      ListItem() {
        Column() {
          TnSlider({
            modelValue: this.sliderValue,
            onChange: (value: number) => {
              this.sliderValue = value;
            }
          });
        }
        .width(P100);
      }

      // 标签
      ListItem() {
        this.SectionCard("标签 Tag");
      }
      ListItem() {
        TnTag({ text: "标签", type: "primary" });
      }

      // 徽标
      ListItem() {
        this.SectionCard("徽标 Badge");
      }
      ListItem() {
        Row() {
          TnBadge({ value: 5, type: "primary", absolute: true }) {
            Row()
              .width(40)
              .height(40)
              .borderRadius(8)
              .backgroundColor($r("app.color.bg_grey"));
          };
        }
        .padding({ top: SPACE.SM });
      }

      // 加载
      ListItem() {
        this.SectionCard("加载 Loading");
      }
      ListItem() {
        TnLoading({ type: "primary", text: "加载中..." });
      }

      // 底部占位
      ListItem()
        .height(50);
    }
    .width(P100)
    .layoutWeight(1)
    .padding({
      left: SPACE.SM,
      right: SPACE.SM,
      bottom: this.windowSafeAreaState.bottomInset
    })
    .edgeEffect(EdgeEffect.Spring)
    .scrollBar(BarState.Off);
  }

  /**
   * 区域标题
   * @param title 标题文本
   */
  @Builder
  private SectionCard(title: string): void {
    Text(title)
      .fontSize($r("app.float.body_medium"))
      .fontColor($r("app.color.text_subtitle"))
      .padding({ top: SPACE.MD, bottom: SPACE.XS })
      .textAlign(TextAlign.Start);
  }

  /**
   * 自定义颜色输入区
   */
  @Builder
  private CustomColorInput(): void {
    Row({ space: 8 }) {
      TextInput({ placeholder: "#07c160", text: this.colorInputValue })
        .layoutWeight(1)
        .height(40)
        .fontSize($r("app.float.body_medium"))
        .onChange((value: string) => {
          this.colorInputValue = value;
        })
        .onSubmit(() => {
          if (this.colorInputValue.length > 0) {
            this.vm.applyCustomColor(this.colorInputValue);
          }
        });

      TnButton({
        content: "确认",
        type: "primary",
        shape: "round",
        btnSize: "sm",
        onBtnClick: () => {
          if (this.colorInputValue.length > 0) {
            this.vm.applyCustomColor(this.colorInputValue);
          } else {
            this.vm.applyRandomColor();
            this.colorInputValue = this.vm.customColor;
          }
        }
      });

      TnButton({
        content: "随机",
        type: "warning",
        shape: "round",
        btnSize: "sm",
        onBtnClick: () => {
          this.vm.applyRandomColor();
          this.colorInputValue = this.vm.customColor;
        }
      });
    }
    .width(P100)
    .alignItems(VerticalAlign.Center);
  }
}
