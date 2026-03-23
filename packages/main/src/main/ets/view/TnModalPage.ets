/**
 * @file TnModal 模态框展示页面视图
 * @description 展示模态框组件的各种用法，包括标题、按钮、遮罩、拦截、自定义内容等
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
import { TnButton, TnModal, TnModalAction, getThemeColor, TnUIBaseStyleType, TnUIBaseStyle, getFontSizeByKey } from "@tuniao/tn-ui";
import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "@tuniao/tn-ui/src/main/ets/common/storage_key";
import TnModalViewModel from "../viewmodel/TnModalViewModel";

@ComponentV2
export struct TnModalPage {
  @Local private vm: TnModalViewModel = new TnModalViewModel();
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();
  @Local private baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  build() {
    AppNavDestination({
      title: "模态框",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset
      }
    }) {
      Stack({ alignContent: Alignment.TopStart }) {
        this.PageContent();
        Column() {
          // 基础模态框
          TnModal({
            visible: this.vm.basicVisible,
            $visible: (val: boolean) => { this.vm.basicVisible = val; },
            title: "提示",
            content: "这是一个基础模态框示例"
          });
          // 无标题模态框
          TnModal({
            visible: this.vm.noTitleVisible,
            $visible: (val: boolean) => { this.vm.noTitleVisible = val; },
            content: "这是一个没有标题的模态框"
          });
          // 带取消按钮
          TnModal({
            visible: this.vm.showCancelVisible,
            $visible: (val: boolean) => { this.vm.showCancelVisible = val; },
            title: "确认操作",
            content: "是否确认删除此项目？删除后不可恢复。",
            showCancel: true,
            onConfirm: () => { this.vm.resultText = "点击了确认"; },
            onCancel: () => { this.vm.resultText = "点击了取消"; }
          });
          // 自定义按钮文字
          TnModal({
            visible: this.vm.customBtnTextVisible,
            $visible: (val: boolean) => { this.vm.customBtnTextVisible = val; },
            title: "退出登录",
            content: "确定要退出当前账号吗？",
            showCancel: true,
            cancelText: "再想想",
            confirmText: "立即退出"
          });
          // 自定义按钮颜色
          TnModal({
            visible: this.vm.customBtnColorVisible,
            $visible: (val: boolean) => { this.vm.customBtnColorVisible = val; },
            title: "危险操作",
            content: "此操作不可逆，请谨慎确认。",
            showCancel: true,
            confirmButtonColor: getThemeColor(this.baseStyle, "danger"),
            cancelButtonColor: $r("app.color.tn_text_color_secondary")
          });
          // 点击遮罩关闭
          TnModal({
            visible: this.vm.overlayCloseVisible,
            $visible: (val: boolean) => { this.vm.overlayCloseVisible = val; },
            title: "提示",
            content: "点击遮罩层可关闭此模态框",
            overlayCloseable: true
          });
          // 无遮罩
          TnModal({
            visible: this.vm.noOverlayVisible,
            $visible: (val: boolean) => { this.vm.noOverlayVisible = val; },
            title: "无遮罩",
            content: "这个模态框没有遮罩层",
            showOverlay: false
          });
          // beforeClose 拦截
          TnModal({
            visible: this.vm.beforeCloseVisible,
            $visible: (val: boolean) => { this.vm.beforeCloseVisible = val; },
            title: "拦截关闭",
            content: "点击取消将被拦截，只能点击确认关闭。",
            showCancel: true,
            beforeClose: (action: TnModalAction): boolean => {
              if (action === "cancel") {
                return false;
              }
              return true;
            }
          });
          // 异步 beforeClose 拦截
          TnModal({
            visible: this.vm.asyncBeforeCloseVisible,
            $visible: (val: boolean) => { this.vm.asyncBeforeCloseVisible = val; },
            title: "异步验证",
            content: "点击确认后将模拟异步请求（1秒），成功后关闭。",
            showCancel: true,
            beforeClose: (action: TnModalAction): Promise<boolean> => {
              return new Promise<boolean>((resolve: Function) => {
                if (action === "confirm") {
                  setTimeout(() => {
                    resolve(true);
                  }, 1000);
                } else {
                  resolve(true);
                }
              });
            }
          });
          // 左对齐标题
          TnModal({
            visible: this.vm.leftAlignVisible,
            $visible: (val: boolean) => { this.vm.leftAlignVisible = val; },
            title: "用户协议",
            content: "请仔细阅读并同意我们的用户服务协议和隐私政策。继续使用表示您已同意上述条款。",
            showCancel: true,
            titleTextAlign: "left",
            contentTextAlign: "left",
            cancelText: "不同意",
            confirmText: "同意"
          });
          // 自定义宽度
          TnModal({
            visible: this.vm.customWidthVisible,
            $visible: (val: boolean) => { this.vm.customWidthVisible = val; },
            title: "宽模态框",
            content: "这是一个宽度为 320vp 的模态框",
            dialogWidth: 320
          });
          // 自定义圆角
          TnModal({
            visible: this.vm.customRadiusVisible,
            $visible: (val: boolean) => { this.vm.customRadiusVisible = val; },
            title: "大圆角",
            content: "这是一个圆角为 20vp 的模态框",
            dialogBorderRadius: 20
          });
          // 自定义内容
          TnModal({
            visible: this.vm.customContentVisible,
            $visible: (val: boolean) => { this.vm.customContentVisible = val; },
            title: "自定义内容",
            showCancel: true,
            defaultBuilder: () => { this.CustomContent(); }
          });
          // 自定义底部按钮
          TnModal({
            visible: this.vm.customFooterVisible,
            $visible: (val: boolean) => { this.vm.customFooterVisible = val; },
            title: "自定义底部",
            content: "底部按钮使用自定义样式",
            footerBuilder: () => { this.CustomFooter(); }
          });
          // 长内容模态框
          TnModal({
            visible: this.vm.longContentVisible,
            $visible: (val: boolean) => { this.vm.longContentVisible = val; },
            title: "服务条款",
            content: "1. 用户应当遵守法律法规，不得利用本服务从事违法违规活动。\n\n2. 用户不得利用本服务侵犯他人合法权益，包括但不限于知识产权、隐私权等。\n\n3. 用户应当妥善保管账号信息，因个人原因导致的损失由用户自行承担。\n\n4. 本平台有权对违规行为进行处理，包括但不限于警告、限制功能、封禁账号等。\n\n5. 本协议的最终解释权归本平台所有。",
            showCancel: true,
            titleTextAlign: "left",
            contentTextAlign: "left"
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
        // 操作结果展示
        if (this.vm.resultText) {
          Text(this.vm.resultText)
            .fontSize($r("app.float.body_medium"))
            .fontColor(getThemeColor(this.baseStyle, "primary"))
            .padding($r("app.float.space_padding_medium"))
            .width(P100)
            .textAlign(TextAlign.Center);
          SpaceVerticalMedium();
        }

        // 基础用法
        this.SectionTitle("基础用法");
        SpaceVerticalMedium();
        Column() {
          Column({ space: "8vp" }) {
            Row({ space: "8vp" }) {
              TnButton({
                content: "基础模态框",
                btnSize: "sm",
                onBtnClick: () => { this.vm.basicVisible = true; }
              });
              TnButton({
                content: "无标题",
                btnSize: "sm",
                type: "success",
                onBtnClick: () => { this.vm.noTitleVisible = true; }
              });
            }
            .width(P100);

            Row({ space: "8vp" }) {
              TnButton({
                content: "带取消按钮",
                btnSize: "sm",
                type: "warning",
                onBtnClick: () => { this.vm.showCancelVisible = true; }
              });
              TnButton({
                content: "长内容",
                btnSize: "sm",
                type: "info",
                onBtnClick: () => { this.vm.longContentVisible = true; }
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

        // 按钮定制
        this.SectionTitle("按钮定制");
        SpaceVerticalMedium();
        Column() {
          Column({ space: "8vp" }) {
            Row({ space: "8vp" }) {
              TnButton({
                content: "自定义文字",
                btnSize: "sm",
                onBtnClick: () => { this.vm.customBtnTextVisible = true; }
              });
              TnButton({
                content: "自定义颜色",
                btnSize: "sm",
                type: "danger",
                onBtnClick: () => { this.vm.customBtnColorVisible = true; }
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

        // 遮罩层控制
        this.SectionTitle("遮罩层控制");
        SpaceVerticalMedium();
        Column() {
          Row({ space: "8vp" }) {
            TnButton({
              content: "点击遮罩关闭",
              btnSize: "sm",
              type: "warning",
              onBtnClick: () => { this.vm.overlayCloseVisible = true; }
            });
            TnButton({
              content: "无遮罩",
              btnSize: "sm",
              type: "info",
              onBtnClick: () => { this.vm.noOverlayVisible = true; }
            });
          }
          .width(P100);
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 关闭拦截
        this.SectionTitle("关闭拦截");
        SpaceVerticalMedium();
        Column() {
          Row({ space: "8vp" }) {
            TnButton({
              content: "拦截取消",
              btnSize: "sm",
              type: "danger",
              onBtnClick: () => { this.vm.beforeCloseVisible = true; }
            });
            TnButton({
              content: "异步验证",
              btnSize: "sm",
              type: "warning",
              onBtnClick: () => { this.vm.asyncBeforeCloseVisible = true; }
            });
          }
          .width(P100);
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 文本对齐
        this.SectionTitle("文本对齐");
        SpaceVerticalMedium();
        Column() {
          TnButton({
            content: "左对齐标题与内容",
            btnSize: "sm",
            type: "success",
            onBtnClick: () => { this.vm.leftAlignVisible = true; }
          });
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
          Row({ space: "8vp" }) {
            TnButton({
              content: "自定义宽度",
              btnSize: "sm",
              onBtnClick: () => { this.vm.customWidthVisible = true; }
            });
            TnButton({
              content: "自定义圆角",
              btnSize: "sm",
              type: "success",
              onBtnClick: () => { this.vm.customRadiusVisible = true; }
            });
          }
          .width(P100);
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 自定义内容
        this.SectionTitle("自定义内容");
        SpaceVerticalMedium();
        Column() {
          Row({ space: "8vp" }) {
            TnButton({
              content: "自定义内容区",
              btnSize: "sm",
              type: "warning",
              onBtnClick: () => { this.vm.customContentVisible = true; }
            });
            TnButton({
              content: "自定义底部按钮",
              btnSize: "sm",
              type: "info",
              onBtnClick: () => { this.vm.customFooterVisible = true; }
            });
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
   * 自定义内容区域
   */
  @Builder private CustomContent(): void {
    Column({ space: "12vp" }) {
      Row({ space: "12vp" }) {
        Column() {
          Text("128")
            .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXXl"))
            .fontColor(getThemeColor(this.baseStyle, "primary"))
            .fontWeight(FontWeight.Bold);
          SpaceVerticalSmall();
          Text("积分余额")
            .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
            .fontColor($r("app.color.tn_text_color_secondary"));
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center);

        Column() {
          Text("5")
            .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXXl"))
            .fontColor(getThemeColor(this.baseStyle, "warning"))
            .fontWeight(FontWeight.Bold);
          SpaceVerticalSmall();
          Text("优惠券")
            .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
            .fontColor($r("app.color.tn_text_color_secondary"));
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center);
      }
      .width("100%");

      Text("是否使用积分兑换优惠券？")
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
        .fontColor($r("app.color.tn_text_color_primary"))
        .textAlign(TextAlign.Center)
        .width("100%");
    }
    .width("100%");
  }

  /**
   * 自定义底部按钮
   */
  @Builder private CustomFooter(): void {
    Row({ space: "12vp" }) {
      TnButton({
        content: "取消",
        btnSize: "sm",
        plain: true,
        onBtnClick: () => { this.vm.customFooterVisible = false; }
      });
      TnButton({
        content: "确认提交",
        btnSize: "sm",
        type: "success",
        onBtnClick: () => { this.vm.customFooterVisible = false; }
      });
    }
    .width("100%")
    .justifyContent(FlexAlign.Center)
    .padding({
      left: this.baseStyle.spaceLg,
      right: this.baseStyle.spaceLg,
      top: this.baseStyle.spaceSm,
      bottom: this.baseStyle.spaceLg
    });
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
