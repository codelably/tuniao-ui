/**
 * @file TnPopup 弹出框展示页面视图
 * @description 展示弹出框组件的各种用法，包括弹出方向、遮罩层、关闭按钮、自定义样式等
 * @author JunBin.Yang
 */
import { AppNavDestination } from "@core/components";
import {
  ColumnBase,
  MediumPaddingVerticalScroll,
  P100,
  SpaceVerticalLarge,
  SpaceVerticalMedium,
  SpaceVerticalSmall
} from "@core/designsystem";
import { getWindowSafeAreaState, WindowSafeAreaState } from "@core/layoutstate";
import { TnButton, TnPopup } from "@tuniao/tn-ui";
import TnPopupViewModel from "../viewmodel/TnPopupViewModel";

@ComponentV2
export struct TnPopupPage {
  @Local private vm: TnPopupViewModel = new TnPopupViewModel();
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  build() {
    AppNavDestination({
      title: "弹出框",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      Stack({ alignContent: Alignment.TopStart }) {
        this.PageContent();
        Column() {
          // 中心弹出
          TnPopup({
            visible: this.vm.centerPopupVisible,
            $visible: (val: boolean) => { this.vm.centerPopupVisible = val; },
            contentBuilder: () => { this.CenterContent(); }
          });
          // 顶部弹出
          TnPopup({
            visible: this.vm.topPopupVisible,
            $visible: (val: boolean) => { this.vm.topPopupVisible = val; },
            openDirection: "top",
            contentBuilder: () => { this.DirectionContent("顶部弹出"); }
          });
          // 底部弹出
          TnPopup({
            visible: this.vm.bottomPopupVisible,
            $visible: (val: boolean) => { this.vm.bottomPopupVisible = val; },
            openDirection: "bottom",
            contentBuilder: () => { this.DirectionContent("底部弹出"); }
          });
          // 左侧弹出
          TnPopup({
            visible: this.vm.leftPopupVisible,
            $visible: (val: boolean) => { this.vm.leftPopupVisible = val; },
            openDirection: "left",
            contentBuilder: () => { this.DirectionContent("左侧弹出"); }
          });
          // 右侧弹出
          TnPopup({
            visible: this.vm.rightPopupVisible,
            $visible: (val: boolean) => { this.vm.rightPopupVisible = val; },
            openDirection: "right",
            contentBuilder: () => { this.DirectionContent("右侧弹出"); }
          });
          // 带关闭按钮（右上）
          TnPopup({
            visible: this.vm.closeBtnRightTopVisible,
            $visible: (val: boolean) => { this.vm.closeBtnRightTopVisible = val; },
            closeBtn: true,
            closeBtnPosition: "right-top",
            contentBuilder: () => { this.CenterContent(); }
          });
          // 带关闭按钮（左上）
          TnPopup({
            visible: this.vm.closeBtnLeftTopVisible,
            $visible: (val: boolean) => { this.vm.closeBtnLeftTopVisible = val; },
            closeBtn: true,
            closeBtnPosition: "left-top",
            contentBuilder: () => { this.CenterContent(); }
          });
          // 带关闭按钮（右下）
          TnPopup({
            visible: this.vm.closeBtnRightBottomVisible,
            $visible: (val: boolean) => { this.vm.closeBtnRightBottomVisible = val; },
            closeBtn: true,
            closeBtnPosition: "right-bottom",
            contentBuilder: () => { this.CenterContent(); }
          });
          // 禁止遮罩关闭（需关闭按钮关闭）
          TnPopup({
            visible: this.vm.noOverlayCloseVisible,
            $visible: (val: boolean) => { this.vm.noOverlayCloseVisible = val; },
            overlayCloseable: false,
            closeBtn: true,
            contentBuilder: () => { this.CenterContent(); }
          });
          // 不显示遮罩
          TnPopup({
            visible: this.vm.noOverlayVisible,
            $visible: (val: boolean) => { this.vm.noOverlayVisible = val; },
            showOverlay: false,
            closeBtn: true,
            contentBuilder: () => { this.CenterContent(); }
          });
          // 自定义遮罩透明度
          TnPopup({
            visible: this.vm.customOverlayVisible,
            $visible: (val: boolean) => { this.vm.customOverlayVisible = val; },
            overlayOpacity: 0.8,
            contentBuilder: () => { this.CenterContent(); }
          });
          // 自定义圆角
          TnPopup({
            visible: this.vm.customRadiusVisible,
            $visible: (val: boolean) => { this.vm.customRadiusVisible = val; },
            radius: 30,
            contentBuilder: () => { this.CenterContent(); }
          });
          // 自定义背景色
          TnPopup({
            visible: this.vm.customBgColorVisible,
            $visible: (val: boolean) => { this.vm.customBgColorVisible = val; },
            bgColor: "#f0f9eb",
            contentBuilder: () => { this.CenterContent(); }
          });
          // 自定义宽高
          TnPopup({
            visible: this.vm.customSizeVisible,
            $visible: (val: boolean) => { this.vm.customSizeVisible = val; },
            popupWidth: "80%",
            popupHeight: "300vp",
            contentBuilder: () => { this.CenterContent(); }
          });
          // 底部弹出 + 安全区
          TnPopup({
            visible: this.vm.safeAreaVisible,
            $visible: (val: boolean) => { this.vm.safeAreaVisible = val; },
            openDirection: "bottom",
            safeAreaInsetBottom: true,
            contentBuilder: () => { this.DirectionContent("底部弹出（安全区）"); }
          });
        }
        .width(P100);
      }
      .width(P100)
      .layoutWeight(1);
    }
  }

  @Builder private PageContent(): void {
    MediumPaddingVerticalScroll() {
      ColumnBase({ widthValue: P100 }) {
        // 弹出方向
        this.SectionTitle("弹出方向");
        SpaceVerticalMedium();
        Column() {
          Row({ space: "8vp" }) {
            TnButton({
              content: "中心",
              btnSize: "sm",
              onBtnClick: () => { this.vm.toggleCenterPopup(); }
            });
            TnButton({
              content: "顶部",
              btnSize: "sm",
              type: "success",
              onBtnClick: () => { this.vm.toggleTopPopup(); }
            });
            TnButton({
              content: "底部",
              btnSize: "sm",
              type: "warning",
              onBtnClick: () => { this.vm.toggleBottomPopup(); }
            });
            TnButton({
              content: "左侧",
              btnSize: "sm",
              type: "danger",
              onBtnClick: () => { this.vm.toggleLeftPopup(); }
            });
            TnButton({
              content: "右侧",
              btnSize: "sm",
              type: "info",
              onBtnClick: () => { this.vm.toggleRightPopup(); }
            });
          }
          .width(P100);
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 关闭按钮
        this.SectionTitle("关闭按钮");
        SpaceVerticalMedium();
        Column() {
          Row({ space: "8vp" }) {
            TnButton({
              content: "右上关闭",
              btnSize: "sm",
              onBtnClick: () => { this.vm.closeBtnRightTopVisible = true; }
            });
            TnButton({
              content: "左上关闭",
              btnSize: "sm",
              type: "success",
              onBtnClick: () => { this.vm.closeBtnLeftTopVisible = true; }
            });
            TnButton({
              content: "右下关闭",
              btnSize: "sm",
              type: "warning",
              onBtnClick: () => { this.vm.closeBtnRightBottomVisible = true; }
            });
          }
          .width(P100);
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 遮罩层控制
        this.SectionTitle("遮罩层控制");
        SpaceVerticalMedium();
        Column() {
          Column({ space: "8vp" }) {
            Row({ space: "8vp" }) {
              TnButton({
                content: "禁止遮罩关闭",
                btnSize: "sm",
                type: "danger",
                onBtnClick: () => { this.vm.noOverlayCloseVisible = true; }
              });
              TnButton({
                content: "无遮罩",
                btnSize: "sm",
                type: "info",
                onBtnClick: () => { this.vm.noOverlayVisible = true; }
              });
            }
            .width(P100);

            Row({ space: "8vp" }) {
              TnButton({
                content: "高透明度遮罩",
                btnSize: "sm",
                type: "warning",
                onBtnClick: () => { this.vm.customOverlayVisible = true; }
              });
            }
            .width(P100);
          }
          .width(P100);
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 自定义样式
        this.SectionTitle("自定义样式");
        SpaceVerticalMedium();
        Column() {
          Column({ space: "8vp" }) {
            Row({ space: "8vp" }) {
              TnButton({
                content: "自定义圆角",
                btnSize: "sm",
                onBtnClick: () => { this.vm.customRadiusVisible = true; }
              });
              TnButton({
                content: "自定义背景色",
                btnSize: "sm",
                type: "success",
                onBtnClick: () => { this.vm.customBgColorVisible = true; }
              });
            }
            .width(P100);

            Row({ space: "8vp" }) {
              TnButton({
                content: "自定义宽高",
                btnSize: "sm",
                type: "warning",
                onBtnClick: () => { this.vm.customSizeVisible = true; }
              });
              TnButton({
                content: "底部安全区",
                btnSize: "sm",
                type: "info",
                onBtnClick: () => { this.vm.safeAreaVisible = true; }
              });
            }
            .width(P100);
          }
          .width(P100);
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
   * 中心弹出内容
   */
  @Builder private CenterContent(): void {
    Column() {
      Text("弹出框内容")
        .fontSize($r("app.float.body_large"))
        .fontColor($r("app.color.text_primary"))
        .fontWeight(FontWeight.Medium);
      SpaceVerticalSmall();
      Text("这是一个弹出框示例，点击遮罩层可关闭")
        .fontSize($r("app.float.body_medium"))
        .fontColor($r("app.color.text_secondary"));
    }
    .padding("20vp")
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center);
  }

  /**
   * 方向弹出内容
   * @param title 标题文本
   */
  @Builder private DirectionContent(title: string): void {
    Column() {
      Text(title)
        .fontSize($r("app.float.body_large"))
        .fontColor($r("app.color.text_primary"))
        .fontWeight(FontWeight.Medium);
      SpaceVerticalSmall();
      Text("从指定方向滑入的弹出框内容")
        .fontSize($r("app.float.body_medium"))
        .fontColor($r("app.color.text_secondary"));
    }
    .width(P100)
    .padding("20vp");
  }

  /**
   * 章节标题
   * @param title 标题
   */
  @Builder private SectionTitle(title: string): void {
    Text(title)
      .fontSize($r("app.float.headline_medium"))
      .fontColor($r("app.color.text_primary"))
      .fontWeight(FontWeight.Bold);
  }
}
