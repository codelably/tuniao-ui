/**
 * @file TnSwitchTab 选项卡切换展示页面视图
 * @author JunBin.Yang
 */

import { AppNavDestination } from "@core/components";
import { P100, SpaceVerticalLarge, SpaceVerticalMedium } from "@core/designsystem";
import { getWindowSafeAreaState, WindowSafeAreaState } from "@core/layoutstate";
import { TnSwitchTab, getThemeColor, getThemeColorLight, TnUIBaseStyle, TnUIBaseStyleType, getFontSizeByKey } from "@tuniao/tn-ui";
import { TnAppStorageKey } from "@tuniao/tn-ui/src/main/ets/common/storage_key";
import { AppStorageV2 } from "@kit.ArkUI";
import TnSwitchTabViewModel from "../viewmodel/TnSwitchTabViewModel";

/**
 * TnSwitchTab 选项卡切换展示页面
 */
@ComponentV2
export struct TnSwitchTabPage {
  @Local private vm: TnSwitchTabViewModel = new TnSwitchTabViewModel();
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();
  @Local private baseStyle: TnUIBaseStyleType =
    AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  build() {
    AppNavDestination({
      title: "选项卡切换",
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
        this.SectionDesc("默认三个选项卡切换，激活选项卡凸起效果");
        SpaceVerticalMedium();
        TnSwitchTab({
          modelValue: this.vm.basicIndex,
          tabs: this.vm.basicTabs,
          onChange: (index: number) => {
            this.vm.basicIndex = index;
          }
        }) {
          this.BasicContent();
        }
        SpaceVerticalLarge();

        // 2. 两个选项卡
        this.SectionTitle("两个选项卡");
        this.SectionDesc("仅两个选项卡的切换效果");
        SpaceVerticalMedium();
        TnSwitchTab({
          modelValue: this.vm.twoTabIndex,
          tabs: this.vm.twoTabs,
          onChange: (index: number) => {
            this.vm.twoTabIndex = index;
          }
        }) {
          this.TwoTabContent();
        }

        SpaceVerticalLarge();

        // 3. 多个选项卡
        this.SectionTitle("多个选项卡");
        this.SectionDesc("支持 5 个选项卡的切换");
        SpaceVerticalMedium();
        TnSwitchTab({
          modelValue: this.vm.multiTabIndex,
          tabs: this.vm.multiTabs,
          onChange: (index: number) => {
            this.vm.multiTabIndex = index;
          }
        }) {
          this.MultiTabContent();
        }

        SpaceVerticalLarge();

        // 4. 自定义颜色
        this.SectionTitle("自定义颜色");
        this.SectionDesc("自定义激活/非激活背景色和文字颜色");
        SpaceVerticalMedium();
        TnSwitchTab({
          modelValue: this.vm.colorIndex,
          tabs: this.vm.colorTabs,
          inactiveBgColor: getThemeColorLight(this.baseStyle, "success"),
          activeBgColor: $r("app.color.tn_color_white"),
          inactiveTextColor: $r("app.color.tn_color_orange_dark"),
          activeTextColor: getThemeColor(this.baseStyle, "success"),
          onChange: (index: number) => {
            this.vm.colorIndex = index;
          }
        }) {
          this.ColorContent();
        }

        SpaceVerticalLarge();

        // 5. 自定义背景色
        this.SectionTitle("自定义背景色");
        this.SectionDesc("激活项使用主题实色，未激活项使用浅色");
        SpaceVerticalMedium();
        TnSwitchTab({
          modelValue: this.vm.bgColorIndex,
          tabs: this.vm.bgColorTabs,
          inactiveBgColor: getThemeColorLight(this.baseStyle, "warning"),
          activeBgColor: getThemeColor(this.baseStyle, "warning"),
          inactiveTextColor: getThemeColor(this.baseStyle, "warning"),
          activeTextColor: $r("app.color.tn_color_white"),
          onChange: (index: number) => {
            this.vm.bgColorIndex = index;
          }
        }) {
          this.BgColorContent();
        }

        SpaceVerticalLarge();

        // 6. 禁用状态
        this.SectionTitle("禁用状态");
        this.SectionDesc("设置 disabled 后无法切换选项卡");
        SpaceVerticalMedium();
        TnSwitchTab({
          modelValue: this.vm.disabledIndex,
          tabs: this.vm.disabledTabs,
          disabled: true,
          onChange: (index: number) => {
            this.vm.disabledIndex = index;
          }
        }) {
          this.DisabledContent();
        }

        SpaceVerticalLarge();
      }
      .width(P100)
      .padding({
        left: this.baseStyle.space,
        right: this.baseStyle.space,
        bottom: this.baseStyle.spaceXl
      })
    }
    .width(P100)
    .height(P100)
    .scrollBar(BarState.Off)
  }

  @Builder
  private BasicContent(): void {
    Column() {
      Text(`当前选中: ${this.vm.basicTabs[this.vm.basicIndex]}`)
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
        .fontColor($r("app.color.tn_text_color_primary"))
    }
    .width(P100)
    .height(120)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  private TwoTabContent(): void {
    Column() {
      Text(`当前选中: ${this.vm.twoTabs[this.vm.twoTabIndex]}`)
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
        .fontColor($r("app.color.tn_text_color_primary"))
    }
    .width(P100)
    .height(100)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  private MultiTabContent(): void {
    Column() {
      Text(`当前选中: ${this.vm.multiTabs[this.vm.multiTabIndex]}`)
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
        .fontColor($r("app.color.tn_text_color_primary"))
    }
    .width(P100)
    .height(100)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  private ColorContent(): void {
    Column() {
      Text(`当前选中: ${this.vm.colorTabs[this.vm.colorIndex]}`)
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
        .fontColor(getThemeColor(this.baseStyle, "success"))
    }
    .width(P100)
    .height(100)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  private DisabledContent(): void {
    Column() {
      Text(`当前固定在: ${this.vm.disabledTabs[this.vm.disabledIndex]}`)
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
        .fontColor($r("app.color.tn_text_color_secondary"))
      Text("(禁用状态，无法切换)")
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
        .fontColor($r("app.color.tn_text_color_placeholder"))
        .margin({ top: this.baseStyle.spaceXsm })
    }
    .width(P100)
    .height(100)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  private BgColorContent(): void {
    Column() {
      Text(`当前选中: ${this.vm.bgColorTabs[this.vm.bgColorIndex]}`)
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
        .fontColor($r("app.color.tn_color_white"))
    }
    .width(P100)
    .height(100)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(getThemeColor(this.baseStyle, "warning"))
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