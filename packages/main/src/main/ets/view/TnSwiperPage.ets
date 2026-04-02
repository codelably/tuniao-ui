/**
 * @file TnSwiper 轮播图展示页面视图
 * @description 展示轮播图组件的各种用法，包括基础、自动播放、循环、多种动画效果、
 *              指示器类型与位置、卡片模式、前后露出等
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
import {
  TnSwiper,
  TnToast,
  TnUIBaseStyleType,
  TnUIBaseStyle,
  getThemeColor
} from "@tuniao/tn-ui";
import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "@tuniao/tn-ui/src/main/ets/common/storage_key";
import TnSwiperViewModel from "../viewmodel/TnSwiperViewModel";

@ComponentV2
export struct TnSwiperPage {
  @Local private vm: TnSwiperViewModel = new TnSwiperViewModel();
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();
  @Local private baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  build() {
    AppNavDestination({
      title: "轮播图",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset
      }
    }) {
      Stack({ alignContent: Alignment.TopStart }) {
        this.PageContent();
      }
      .width(P100)
      .layoutWeight(1);
    }
  }

  @Builder private PageContent(): void {
    MediumPaddingVerticalScroll() {
      ColumnBase({ widthValue: P100 }) {

        // ==================== 基础用法 ====================
        this.SectionTitle("基础用法");
        this.SectionDesc("通过 data 传递图片地址数组展示轮播图");
        SpaceVerticalMedium();
        Column() {
          TnSwiper({
            data: this.vm.allImages,
            onItemClick: (index: number) => {
              TnToast.show(`点击了第 ${index + 1} 张`);
            }
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ==================== 自动播放 ====================
        this.SectionTitle("自动播放");
        this.SectionDesc("设置 autoplay 开启自动轮播，interval 控制间隔");
        SpaceVerticalMedium();
        Column() {
          TnSwiper({
            data: this.vm.allImages,
            autoplay: true,
            interval: 3000,
            loop: true
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ==================== 指示器类型 ====================
        this.SectionTitle("指示器类型");
        this.SectionDesc("支持 dot、line、number 三种指示器");
        SpaceVerticalMedium();

        // 圆点指示器（默认）
        this.SubSectionTitle("圆点指示器（默认）");
        SpaceVerticalMedium();
        Column() {
          TnSwiper({
            data: this.vm.allImages,
            indicatorType: "dot",
            loop: true
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalMedium();

        // 线条指示器
        this.SubSectionTitle("线条指示器");
        SpaceVerticalMedium();
        Column() {
          TnSwiper({
            data: this.vm.allImages,
            indicatorType: "line",
            loop: true
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalMedium();

        // 数字指示器
        this.SubSectionTitle("数字指示器");
        SpaceVerticalMedium();
        Column() {
          TnSwiper({
            data: this.vm.allImages,
            indicatorType: "number",
            loop: true
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ==================== 指示器位置 ====================
        this.SectionTitle("指示器位置");
        this.SectionDesc("通过 indicatorPosition 控制指示器显示位置");
        SpaceVerticalMedium();

        // 右下角
        this.SubSectionTitle("右下角");
        SpaceVerticalMedium();
        Column() {
          TnSwiper({
            data: this.vm.fewImages,
            indicatorType: "number",
            indicatorPosition: "right-bottom"
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalMedium();

        // 左下角
        this.SubSectionTitle("左下角");
        SpaceVerticalMedium();
        Column() {
          TnSwiper({
            data: this.vm.fewImages,
            indicatorType: "dot",
            indicatorPosition: "left-bottom"
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalMedium();

        // 顶部居中
        this.SubSectionTitle("顶部居中");
        SpaceVerticalMedium();
        Column() {
          TnSwiper({
            data: this.vm.fewImages,
            indicatorType: "line",
            indicatorPosition: "center-top"
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ==================== 自定义指示器颜色 ====================
        this.SectionTitle("自定义指示器颜色");
        this.SectionDesc("自定义指示器的默认色和选中色");
        SpaceVerticalMedium();
        Column() {
          TnSwiper({
            data: this.vm.allImages,
            indicatorType: "dot",
            indicatorBgColor: $r("app.color.tn_color_white"),
            indicatorActiveBgColor: getThemeColor(this.baseStyle, "danger"),
            loop: true
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ==================== 动画效果 ====================
        this.SectionTitle("动画效果");
        this.SectionDesc("通过 effect 设置不同的切换动画效果");
        SpaceVerticalMedium();

        // 标准滑动（默认）
        this.SubSectionTitle("标准滑动 (slide)");
        SpaceVerticalMedium();
        Column() {
          TnSwiper({
            data: this.vm.allImages,
            effect: "slide",
            loop: true,
            autoplay: true,
            interval: 4000
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalMedium();

        // 淡入淡出
        this.SubSectionTitle("淡入淡出 (fade)");
        SpaceVerticalMedium();
        Column() {
          TnSwiper({
            data: this.vm.allImages,
            effect: "fade",
            loop: true,
            autoplay: true,
            interval: 4000
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalMedium();

        // 缩放切换
        this.SubSectionTitle("缩放切换 (scale)");
        SpaceVerticalMedium();
        Column() {
          TnSwiper({
            data: this.vm.allImages,
            effect: "scale",
            loop: true,
            autoplay: true,
            interval: 4000
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalMedium();

        // 卡片效果
        this.SubSectionTitle("卡片效果 (card)");
        SpaceVerticalMedium();
        Column() {
          TnSwiper({
            data: this.vm.allImages,
            effect: "card",
            loop: true,
            autoplay: true,
            interval: 4000
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalMedium();

        // 翻转效果
        this.SubSectionTitle("翻转效果 (flip)");
        SpaceVerticalMedium();
        Column() {
          TnSwiper({
            data: this.vm.allImages,
            effect: "flip",
            loop: true,
            autoplay: true,
            interval: 4000
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ==================== 前后露出 ====================
        this.SectionTitle("前后露出");
        this.SectionDesc("通过 previousMargin/nextMargin 显示相邻项");
        SpaceVerticalMedium();
        Column() {
          TnSwiper({
            data: this.vm.allImages,
            previousMargin: 30,
            nextMargin: 30,
            loop: true
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ==================== 隐藏指示器 ====================
        this.SectionTitle("隐藏指示器");
        this.SectionDesc("设置 showIndicator 为 false 隐藏指示器");
        SpaceVerticalMedium();
        Column() {
          TnSwiper({
            data: this.vm.fewImages,
            showIndicator: false
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ==================== 自定义高度 ====================
        this.SectionTitle("自定义高度");
        this.SectionDesc("通过 swiperHeight 设置轮播图高度");
        SpaceVerticalMedium();

        this.SubSectionTitle("高度 120vp");
        SpaceVerticalMedium();
        Column() {
          TnSwiper({
            data: this.vm.fewImages,
            swiperHeight: 120,
            loop: true
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalMedium();

        this.SubSectionTitle("高度 240vp");
        SpaceVerticalMedium();
        Column() {
          TnSwiper({
            data: this.vm.fewImages,
            swiperHeight: 240,
            loop: true
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ==================== 自定义圆角 ====================
        this.SectionTitle("自定义圆角");
        this.SectionDesc("通过 imgBorderRadius 修改图片圆角");
        SpaceVerticalMedium();

        this.SubSectionTitle("无圆角");
        SpaceVerticalMedium();
        Column() {
          TnSwiper({
            data: this.vm.fewImages,
            imgBorderRadius: 0,
            loop: true
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalMedium();

        this.SubSectionTitle("大圆角");
        SpaceVerticalMedium();
        Column() {
          TnSwiper({
            data: this.vm.fewImages,
            imgBorderRadius: 20,
            loop: true
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ==================== 自定义动画时长 ====================
        this.SectionTitle("自定义动画时长");
        this.SectionDesc("通过 duration 控制切换动画速度");
        SpaceVerticalMedium();

        this.SubSectionTitle("快速切换 (200ms)");
        SpaceVerticalMedium();
        Column() {
          TnSwiper({
            data: this.vm.allImages,
            duration: 200,
            loop: true,
            autoplay: true,
            interval: 2000
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalMedium();

        this.SubSectionTitle("慢速切换 (1000ms)");
        SpaceVerticalMedium();
        Column() {
          TnSwiper({
            data: this.vm.allImages,
            duration: 1000,
            loop: true,
            autoplay: true,
            interval: 4000
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();
      };
    };
  }

  /**
   * 章节标题
   * @param title 标题
   */
  @Builder private SectionTitle(title: string): void {
    Text(title)
      .fontSize($r("app.float.headline_medium"))
      .fontColor($r("app.color.text_primary"))
      .fontWeight(FontWeight.Bold)
      .lineHeight(this.baseStyle.lineHeightLg);
  }

  /**
   * 章节描述
   * @param desc 描述
   */
  @Builder private SectionDesc(desc: string): void {
    Text(desc)
      .fontSize($r("app.float.body_medium"))
      .fontColor($r("app.color.text_secondary"))
      .lineHeight(this.baseStyle.lineHeightSm)
      .margin({ top: this.baseStyle.spaceBase });
  }

  /**
   * 子章节标题
   * @param title 标题
   */
  @Builder private SubSectionTitle(title: string): void {
    Text(title)
      .fontSize($r("app.float.body_large"))
      .fontColor($r("app.color.text_primary"))
      .lineHeight(this.baseStyle.lineHeightMd);
  }
}
