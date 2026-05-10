/**
 * @file TnSticky 吸顶展示页面视图
 * @author JunBin.Yang
 */

import { AppNavDestination } from "@core/components";
import { P100, SpaceVerticalLarge, SpaceVerticalMedium } from "@core/designsystem";
import { getWindowSafeAreaState, WindowSafeAreaState } from "@core/layoutstate";
import { TnSticky, getThemeColor, TnUIBaseStyle, TnUIBaseStyleType, getFontSizeByKey } from "@tuniao/tn-ui";
import { TnAppStorageKey } from "@tuniao/tn-ui/src/main/ets/common/storage_key";
import { AppStorageV2 } from "@kit.ArkUI";
import TnStickyViewModel from "../viewmodel/TnStickyViewModel";

/**
 * TnSticky 吸顶展示页面
 */
@ComponentV2
export struct TnStickyPage {
  /**
   * 吸顶展示页面 ViewModel
   */
  @Local private vm: TnStickyViewModel = new TnStickyViewModel();
  /**
   * 窗口安全区状态
   */
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();
  /**
   * 全局基础样式
   */
  @Local private baseStyle: TnUIBaseStyleType =
    AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  /**
   * 滚动控制器
   */
  private scroller: Scroller = new Scroller();
  /**
   * 当前滚动偏移量
   */
  @Local private scrollTop: number = 0;

  build() {
    AppNavDestination({
      title: "吸顶",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.StickyContent();
    }
  }

  /**
   * 吸顶内容视图
   */
  @Builder
  private StickyContent(): void {
    Scroll(this.scroller) {
      Column() {
        // 1. 基础用法
        this.SectionTitle("基础用法");
        this.SectionDesc("向下滚动页面，内容将会在滚动到顶部时自动吸顶");
        SpaceVerticalMedium();
        this.PlaceholderBlock("向下滚动查看效果", 100);
        TnSticky({ scrollTop: this.scrollTop }) {
          Row() {
            Text("基础吸顶内容")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
              .fontColor($r("app.color.tn_color_white"))
          }
          .width(P100)
          .height(44)
          .justifyContent(FlexAlign.Center)
          .backgroundColor(getThemeColor(this.baseStyle, "primary"))
          .borderRadius(this.baseStyle.borderRadius)
        }
        this.PlaceholderBlock("占位内容 1", 150);

        SpaceVerticalLarge();

        // 2. 自定义偏移距离
        this.SectionTitle("自定义偏移距离");
        this.SectionDesc("设置 offsetTop 属性，指定吸顶时距离顶部的距离");
        SpaceVerticalMedium();
        TnSticky({ scrollTop: this.scrollTop, offsetTop: 50 }) {
          Row() {
            Text("距顶部 50vp 吸顶")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
              .fontColor($r("app.color.tn_color_white"))
          }
          .width(P100)
          .height(44)
          .justifyContent(FlexAlign.Center)
          .backgroundColor(getThemeColor(this.baseStyle, "success"))
          .borderRadius(this.baseStyle.borderRadius)
        }
        this.PlaceholderBlock("占位内容 2", 150);

        SpaceVerticalLarge();

        // 3. 自定义背景色
        this.SectionTitle("自定义背景色");
        this.SectionDesc("通过 bgColor 属性设置吸顶时的背景色");
        SpaceVerticalMedium();
        TnSticky({
          scrollTop: this.scrollTop,
          bgColor: getThemeColor(this.baseStyle, "warning")
        }) {
          Row() {
            Text("自定义背景色吸顶")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
              .fontColor($r("app.color.tn_color_white"))
          }
          .width(P100)
          .height(44)
          .justifyContent(FlexAlign.Center)
          .backgroundColor(getThemeColor(this.baseStyle, "warning"))
          .borderRadius(this.baseStyle.borderRadius)
        }
        this.PlaceholderBlock("占位内容 3", 150);

        SpaceVerticalLarge();

        // 4. 禁用吸顶
        this.SectionTitle("禁用吸顶");
        this.SectionDesc("设置 enabled 为 false 可禁用吸顶效果");
        SpaceVerticalMedium();
        TnSticky({ scrollTop: this.scrollTop, stickyEnabled: false }) {
          Row() {
            Text("此内容不会吸顶")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
              .fontColor($r("app.color.tn_text_color_secondary"))
          }
          .width(P100)
          .height(44)
          .justifyContent(FlexAlign.Center)
          .backgroundColor($r("app.color.tn_color_gray_disabled"))
          .borderRadius(this.baseStyle.borderRadius)
        }
        this.PlaceholderBlock("占位内容 4", 150);

        SpaceVerticalLarge();

        // 5. 事件回调
        this.SectionTitle("事件回调");
        this.SectionDesc("通过 onChange 监听吸顶状态变化");
        SpaceVerticalMedium();
        if (this.vm.changeLog.length > 0) {
          Text(this.vm.changeLog)
            .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
            .fontColor(getThemeColor(this.baseStyle, "primary"))
            .padding({
              left: this.baseStyle.space,
              right: this.baseStyle.space,
              top: this.baseStyle.spaceXsm,
              bottom: this.baseStyle.spaceXsm
            });
        }
        TnSticky({
          scrollTop: this.scrollTop,
          onChange: (fixed: boolean) => { this.vm.handleStickyChange(fixed); }
        }) {
          Row() {
            Text(this.vm.isFixed ? "已吸顶" : "未吸顶")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
              .fontColor($r("app.color.tn_color_white"))
          }
          .width(P100)
          .height(44)
          .justifyContent(FlexAlign.Center)
          .backgroundColor(getThemeColor(this.baseStyle, "danger"))
          .borderRadius(this.baseStyle.borderRadius)
        }
        this.PlaceholderBlock("占位内容 5", 200);

        SpaceVerticalLarge();

        // 6. 自定义 zIndex
        this.SectionTitle("自定义层级");
        this.SectionDesc("通过 zIndex 属性设置吸顶时的层叠顺序");
        SpaceVerticalMedium();
        TnSticky({ scrollTop: this.scrollTop, stickyZIndex: 99999 }) {
          Row() {
            Text("高层级吸顶 (stickyZIndex: 99999)")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
              .fontColor($r("app.color.tn_color_white"))
          }
          .width(P100)
          .height(44)
          .justifyContent(FlexAlign.Center)
          .backgroundColor(getThemeColor(this.baseStyle, "info"))
          .borderRadius(this.baseStyle.borderRadius)
        }
        this.PlaceholderBlock("页面底部占位", 700);
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
    .onDidScroll(() => {
      this.scrollTop = this.scroller.currentOffset().yOffset;
    })
  }

  /**
   * 区域标题
   */
  @Builder
  private SectionTitle(title: string): void {
    Text(title)
      .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeLg"))
      .fontColor($r("app.color.tn_text_color_primary"))
      .fontWeight(FontWeight.Bold)
      .width(P100);
  }

  /**
   * 区域描述
   */
  @Builder
  private SectionDesc(desc: string): void {
    Text(desc)
      .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
      .fontColor($r("app.color.tn_text_color_secondary"))
      .width(P100)
      .margin({ top: this.baseStyle.spaceBase });
  }

  /**
   * 占位块
   */
  @Builder
  private PlaceholderBlock(text: string, height: number): void {
    Column() {
      Text(text)
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
        .fontColor($r("app.color.tn_text_color_placeholder"))
    }
    .width(P100)
    .height(height)
    .justifyContent(FlexAlign.Center)
    .backgroundColor($r("app.color.tn_color_gray_disabled"))
    .borderRadius(this.baseStyle.borderRadiusLg)
    .margin({ top: this.baseStyle.spaceXsm, bottom: this.baseStyle.spaceXsm })
  }
}