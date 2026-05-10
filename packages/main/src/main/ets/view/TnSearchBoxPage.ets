/**
 * @file TnSearchBox 搜索框展示页面视图
 * @author JunBin.Yang
 */

import { AppNavDestination } from "@core/components";
import { P100, SpaceVerticalLarge, SpaceVerticalMedium } from "@core/designsystem";
import { getWindowSafeAreaState, WindowSafeAreaState } from "@core/layoutstate";
import { TnSearchBox, getThemeColor, TnUIBaseStyle, TnUIBaseStyleType, getFontSizeByKey } from "@tuniao/tn-ui";
import { TnAppStorageKey } from "@tuniao/tn-ui/src/main/ets/common/storage_key";
import { AppStorageV2 } from "@kit.ArkUI";
import TnSearchBoxViewModel from "../viewmodel/TnSearchBoxViewModel";

/**
 * TnSearchBox 搜索框展示页面
 */
@ComponentV2
export struct TnSearchBoxPage {
  @Local private vm: TnSearchBoxViewModel = new TnSearchBoxViewModel();
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();
  @Local private baseStyle: TnUIBaseStyleType =
    AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  build() {
    AppNavDestination({
      title: "搜索框",
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
        // 1. 基础用法
        this.SectionTitle("基础用法");
        this.SectionDesc("默认方形搜索框，带搜索按钮");
        SpaceVerticalMedium();
        TnSearchBox({
          modelValue: this.vm.basicValue,
          onChange: (value: string) => {
            this.vm.basicValue = value;
          },
          onSearch: (value: string) => {
            this.vm.searchResult = `搜索: ${value}`;
          }
        })
        if (this.vm.searchResult.length > 0) {
          SpaceVerticalMedium();
          Text(this.vm.searchResult)
            .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
            .fontColor($r("app.color.tn_text_color_secondary"))
        }
        SpaceVerticalLarge();

        // 2. 圆形搜索框
        this.SectionTitle("圆形搜索框");
        this.SectionDesc("shape 设置为 round，胶囊形状");
        SpaceVerticalMedium();
        TnSearchBox({
          modelValue: this.vm.roundValue,
          shape: "round",
          onChange: (value: string) => {
            this.vm.roundValue = value;
          },
          onSearch: (value: string) => {
            this.vm.searchResult = `圆形搜索: ${value}`;
          }
        })
        SpaceVerticalLarge();

        // 3. 自定义占位文本
        this.SectionTitle("自定义占位文本");
        this.SectionDesc("通过 placeholder 自定义提示文字");
        SpaceVerticalMedium();
        TnSearchBox({
          modelValue: this.vm.placeholderValue,
          placeholder: "搜索商品、店铺",
          onChange: (value: string) => {
            this.vm.placeholderValue = value;
          }
        })
        SpaceVerticalLarge();

        // 4. 禁用状态
        this.SectionTitle("禁用状态");
        this.SectionDesc("disabled 为 true 时不可交互");
        SpaceVerticalMedium();
        TnSearchBox({
          modelValue: this.vm.disabledValue,
          disabled: true
        })
        SpaceVerticalLarge();

        // 5. 无边框
        this.SectionTitle("无边框");
        this.SectionDesc("border 设置为 false 隐藏边框");
        SpaceVerticalMedium();
        TnSearchBox({
          modelValue: this.vm.noBorderValue,
          showBorder: false,
          bgColor: $r("app.color.tn_color_gray_disabled"),
          onChange: (value: string) => {
            this.vm.noBorderValue = value;
          }
        })
        SpaceVerticalLarge();

        // 6. 无搜索按钮
        this.SectionTitle("无搜索按钮");
        this.SectionDesc("searchButton 设置为 false 隐藏搜索按钮");
        SpaceVerticalMedium();
        TnSearchBox({
          modelValue: this.vm.noButtonValue,
          searchButton: false,
          onChange: (value: string) => {
            this.vm.noButtonValue = value;
          }
        })
        SpaceVerticalLarge();

        // 7. 自定义搜索按钮
        this.SectionTitle("自定义搜索按钮");
        this.SectionDesc("自定义按钮文字和颜色");
        SpaceVerticalMedium();
        TnSearchBox({
          modelValue: this.vm.customButtonValue,
          searchButtonText: "查找",
          searchButtonBgColor: getThemeColor(this.baseStyle, "success"),
          shape: "round",
          onChange: (value: string) => {
            this.vm.customButtonValue = value;
          }
        })
        SpaceVerticalLarge();

        // 8. 自定义颜色
        this.SectionTitle("自定义颜色");
        this.SectionDesc("自定义边框颜色和背景色");
        SpaceVerticalMedium();
        TnSearchBox({
          modelValue: this.vm.customColorValue,
          inputBorderColor: getThemeColor(this.baseStyle, "primary"),
          searchButtonBgColor: getThemeColor(this.baseStyle, "warning"),
          onChange: (value: string) => {
            this.vm.customColorValue = value;
          }
        })
        SpaceVerticalLarge();

        // 9. 不同尺寸
        this.SectionTitle("不同尺寸");
        this.SectionDesc("支持 sm、default、lg、xl 四种尺寸");
        SpaceVerticalMedium();
        TnSearchBox({
          modelValue: this.vm.smValue,
          boxSize: "sm",
          placeholder: "小尺寸",
          onChange: (value: string) => {
            this.vm.smValue = value;
          }
        })
        SpaceVerticalMedium();
        TnSearchBox({
          modelValue: this.vm.lgValue,
          boxSize: "lg",
          placeholder: "大尺寸",
          onChange: (value: string) => {
            this.vm.lgValue = value;
          }
        })
        SpaceVerticalMedium();
        TnSearchBox({
          modelValue: this.vm.xlValue,
          boxSize: "xl",
          placeholder: "超大尺寸",
          onChange: (value: string) => {
            this.vm.xlValue = value;
          }
        })
        SpaceVerticalLarge();

        // 10. 清除按钮始终显示
        this.SectionTitle("清除按钮始终显示");
        this.SectionDesc("clearTrigger 设置为 always，有值时始终显示清除按钮");
        SpaceVerticalMedium();
        TnSearchBox({
          modelValue: this.vm.clearAlwaysValue,
          clearTrigger: "always",
          onChange: (value: string) => {
            this.vm.clearAlwaysValue = value;
          },
          onClear: () => {
            this.vm.clearAlwaysValue = "";
          }
        })
        SpaceVerticalLarge();

        // 11. 文字居中
        this.SectionTitle("文字居中");
        this.SectionDesc("textAlign 设置为 Center");
        SpaceVerticalMedium();
        TnSearchBox({
          modelValue: this.vm.centerValue,
          textAlign: TextAlign.Center,
          searchButton: false,
          shape: "round",
          onChange: (value: string) => {
            this.vm.centerValue = value;
          }
        })
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
