/**
 * @file TnSubsection 分段器展示页面视图
 * @author JunBin.Yang
 */

import { AppNavDestination } from "@core/components";
import { P100, SpaceVerticalLarge, SpaceVerticalMedium } from "@core/designsystem";
import { getWindowSafeAreaState, WindowSafeAreaState } from "@core/layoutstate";
import { TnSubsection, getThemeColor, TnUIBaseStyle, TnUIBaseStyleType, getFontSizeByKey } from "@tuniao/tn-ui";
import { TnAppStorageKey } from "@tuniao/tn-ui/src/main/ets/common/storage_key";
import { AppStorageV2 } from "@kit.ArkUI";
import TnSubsectionViewModel from "../viewmodel/TnSubsectionViewModel";

/**
 * TnSubsection 分段器展示页面
 */
@ComponentV2
export struct TnSubsectionPage {
  @Local private vm: TnSubsectionViewModel = new TnSubsectionViewModel();
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();
  @Local private baseStyle: TnUIBaseStyleType =
    AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  build() {
    AppNavDestination({
      title: "分段器",
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

  @Builder
  private PageContent(): void {
    Scroll() {
      Column() {
        // 1. 基础用法（default 模式）
        this.SectionTitle("基础用法");
        this.SectionDesc("默认模式，带主题色边框和滑块");
        SpaceVerticalMedium();
        TnSubsection({
          modelValue: this.vm.basicIndex,
          items: this.vm.basicItems,
          onChange: (index: number) => {
            this.vm.basicIndex = index;
          }
        })
        SpaceVerticalMedium();
        Text(`当前选中: ${this.vm.basicItems[this.vm.basicIndex]}`)
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
          .fontColor($r("app.color.tn_text_color_secondary"))
        SpaceVerticalLarge();

        // 2. 两个选项
        this.SectionTitle("两个选项");
        this.SectionDesc("仅两个选项的分段器");
        SpaceVerticalMedium();
        TnSubsection({
          modelValue: this.vm.twoItemIndex,
          items: this.vm.twoItems,
          onChange: (index: number) => {
            this.vm.twoItemIndex = index;
          }
        })
        SpaceVerticalMedium();
        Text(`当前选中: ${this.vm.twoItems[this.vm.twoItemIndex]}`)
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
          .fontColor($r("app.color.tn_text_color_secondary"))
        SpaceVerticalLarge();

        // 3. 多个选项
        this.SectionTitle("多个选项");
        this.SectionDesc("支持多个选项的分段器");
        SpaceVerticalMedium();
        TnSubsection({
          modelValue: this.vm.multiIndex,
          items: this.vm.multiItems,
          onChange: (index: number) => {
            this.vm.multiIndex = index;
          }
        })
        SpaceVerticalMedium();
        Text(`当前选中: ${this.vm.multiItems[this.vm.multiIndex]}`)
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
          .fontColor($r("app.color.tn_text_color_secondary"))
        SpaceVerticalLarge();

        // 4. button 模式
        this.SectionTitle("按钮模式");
        this.SectionDesc("button 模式，灰色背景 + 白色滑块");
        SpaceVerticalMedium();
        TnSubsection({
          modelValue: this.vm.buttonModeIndex,
          items: this.vm.buttonModeItems,
          mode: "button",
          onChange: (index: number) => {
            this.vm.buttonModeIndex = index;
          }
        })
        SpaceVerticalMedium();
        Text(`当前选中: ${this.vm.buttonModeItems[this.vm.buttonModeIndex]}`)
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
          .fontColor($r("app.color.tn_text_color_secondary"))
        SpaceVerticalLarge();

        // 5. 自定义颜色（default 模式）
        this.SectionTitle("自定义颜色");
        this.SectionDesc("default 模式下自定义激活颜色");
        SpaceVerticalMedium();
        TnSubsection({
          modelValue: this.vm.colorIndex,
          items: this.vm.colorItems,
          activeColor: getThemeColor(this.baseStyle, "danger"),
          onChange: (index: number) => {
            this.vm.colorIndex = index;
          }
        })
        SpaceVerticalLarge();

        // 6. 自定义颜色（button 模式）
        this.SectionTitle("自定义颜色 - 按钮模式");
        this.SectionDesc("button 模式下自定义激活文字颜色");
        SpaceVerticalMedium();
        TnSubsection({
          modelValue: this.vm.colorButtonIndex,
          items: this.vm.colorButtonItems,
          mode: "button",
          activeColor: getThemeColor(this.baseStyle, "success"),
          onChange: (index: number) => {
            this.vm.colorButtonIndex = index;
          }
        })
        SpaceVerticalLarge();

        // 7. 禁用状态
        this.SectionTitle("禁用状态");
        this.SectionDesc("禁用后无法切换选项");
        SpaceVerticalMedium();
        TnSubsection({
          modelValue: this.vm.disabledIndex,
          items: this.vm.disabledItems,
          disabled: true,
          onChange: (index: number) => {
            this.vm.disabledIndex = index;
          }
        })
        SpaceVerticalMedium();
        Text(`固定在: ${this.vm.disabledItems[this.vm.disabledIndex]}（禁用状态）`)
          .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
          .fontColor($r("app.color.tn_text_color_placeholder"))
      }
      .width(P100)
      .padding({
        left: this.baseStyle.space,
        right: this.baseStyle.space,
        top: this.baseStyle.spaceLg,
        bottom: this.baseStyle.spaceLg
      })
    }
    .width(P100)
    .layoutWeight(1)
  }

  @Builder
  private SectionTitle(title: string): void {
    Text(title)
      .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeLg"))
      .fontColor($r("app.color.tn_text_color_primary"))
      .fontWeight(FontWeight.Bold)
      .width(P100);
  }

  @Builder
  private SectionDesc(desc: string): void {
    Text(desc)
      .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
      .fontColor($r("app.color.tn_text_color_secondary"))
      .width(P100)
      .margin({ top: this.baseStyle.spaceBase });
  }
}