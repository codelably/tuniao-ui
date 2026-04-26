/**
 * @file TnActionSheet 操作面板展示页面视图
 * @description 展示操作面板组件的各种用法，包括标题、描述、自定义颜色、禁用、拦截关闭等
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
  TnButton,
  TnActionSheet,
  TnActionSheetItem,
  TnActionSheetCloseAction,
  TnToast,
  getThemeColor,
  getFontSizeByKey,
  TnUIBaseStyleType,
  TnUIBaseStyle
} from "@tuniao/tn-ui";
import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "@tuniao/tn-ui/src/main/ets/common/storage_key";
import TnActionSheetViewModel from "../viewmodel/TnActionSheetViewModel";

@ComponentV2
export struct TnActionSheetPage {
  @Local private vm: TnActionSheetViewModel = new TnActionSheetViewModel();
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();
  @Local private baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  build() {
    AppNavDestination({
      title: "操作面板",
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
          // 基础用法
          TnActionSheet({
            visible: this.vm.basicVisible,
            $visible: (val: boolean) => { this.vm.basicVisible = val; },
            actions: [
              new TnActionSheetItem("选项一"),
              new TnActionSheetItem("选项二"),
              new TnActionSheetItem("选项三")
            ],
            onSelect: (index: number, value: string) => {
              this.vm.selectResult = `选择了第 ${index + 1} 项`;
              TnToast.show(this.vm.selectResult);
            }
          });
          // 带标题
          TnActionSheet({
            visible: this.vm.withTitleVisible,
            $visible: (val: boolean) => { this.vm.withTitleVisible = val; },
            title: "请选择操作",
            actions: [
              new TnActionSheetItem("编辑", "", "edit"),
              new TnActionSheetItem("复制", "", "copy"),
              new TnActionSheetItem("分享", "", "share")
            ],
            onSelect: (index: number, value: string) => {
              TnToast.show(`操作: ${value}`);
            }
          });
          // 带标题和描述
          TnActionSheet({
            visible: this.vm.withDescVisible,
            $visible: (val: boolean) => { this.vm.withDescVisible = val; },
            title: "确认操作",
            description: "以下操作将对文件生效，请谨慎选择",
            actions: [
              new TnActionSheetItem("重命名"),
              new TnActionSheetItem("移动到回收站"),
              new TnActionSheetItem("永久删除")
            ],
            onSelect: (index: number) => {
              TnToast.show(`选择了第 ${index + 1} 项`);
            }
          });
          // 带选项描述
          TnActionSheet({
            visible: this.vm.itemDescVisible,
            $visible: (val: boolean) => { this.vm.itemDescVisible = val; },
            title: "分享到",
            actions: [
              new TnActionSheetItem("微信好友", "分享给微信通讯录中的好友"),
              new TnActionSheetItem("朋友圈", "分享到微信朋友圈"),
              new TnActionSheetItem("微博", "分享到新浪微博"),
              new TnActionSheetItem("复制链接", "复制分享链接到剪贴板")
            ],
            onSelect: (index: number) => {
              const names: string[] = ["微信好友", "朋友圈", "微博", "复制链接"];
              TnToast.show(`分享到${names[index]}`);
            }
          });
          // 自定义颜色
          TnActionSheet({
            visible: this.vm.customColorVisible,
            $visible: (val: boolean) => { this.vm.customColorVisible = val; },
            actions: [
              new TnActionSheetItem("默认颜色"),
              new TnActionSheetItem("主题色", "", "", false, getThemeColor(this.baseStyle, "primary")),
              new TnActionSheetItem("成功色", "", "", false, getThemeColor(this.baseStyle, "success")),
              new TnActionSheetItem("危险色", "", "", false, getThemeColor(this.baseStyle, "danger"))
            ],
            onSelect: (index: number) => {
              TnToast.show(`选择了第 ${index + 1} 项`);
            }
          });
          // 禁用选项
          TnActionSheet({
            visible: this.vm.disabledVisible,
            $visible: (val: boolean) => { this.vm.disabledVisible = val; },
            title: "部分选项已禁用",
            actions: [
              new TnActionSheetItem("可选项一"),
              new TnActionSheetItem("已禁用", "", "", true),
              new TnActionSheetItem("可选项二"),
              new TnActionSheetItem("已禁用", "此功能暂不可用", "", true)
            ],
            onSelect: (index: number) => {
              TnToast.show(`选择了第 ${index + 1} 项`);
            }
          });
          // 隐藏取消按钮
          TnActionSheet({
            visible: this.vm.noCancelVisible,
            $visible: (val: boolean) => { this.vm.noCancelVisible = val; },
            showCancel: false,
            actions: [
              new TnActionSheetItem("选项一"),
              new TnActionSheetItem("选项二")
            ],
            onSelect: (index: number) => {
              TnToast.show(`选择了第 ${index + 1} 项`);
            }
          });
          // 自定义取消文字
          TnActionSheet({
            visible: this.vm.customCancelVisible,
            $visible: (val: boolean) => { this.vm.customCancelVisible = val; },
            cancelText: "关闭面板",
            actions: [
              new TnActionSheetItem("选项一"),
              new TnActionSheetItem("选项二")
            ],
            onSelect: (index: number) => {
              TnToast.show(`选择了第 ${index + 1} 项`);
            },
            onCancel: () => {
              TnToast.show("点击了关闭面板");
            }
          });
          // 点击遮罩不可关闭
          TnActionSheet({
            visible: this.vm.noOverlayCloseVisible,
            $visible: (val: boolean) => { this.vm.noOverlayCloseVisible = val; },
            overlayCloseable: false,
            title: "点击遮罩不可关闭",
            actions: [
              new TnActionSheetItem("选项一"),
              new TnActionSheetItem("选项二")
            ],
            onSelect: (index: number) => {
              TnToast.show(`选择了第 ${index + 1} 项`);
            }
          });
          // beforeClose 拦截
          TnActionSheet({
            visible: this.vm.beforeCloseVisible,
            $visible: (val: boolean) => { this.vm.beforeCloseVisible = val; },
            title: "关闭拦截",
            actions: [
              new TnActionSheetItem("允许关闭"),
              new TnActionSheetItem("阻止关闭", "", "block")
            ],
            beforeClose: (action: TnActionSheetCloseAction, index?: number, value?: string): boolean => {
              if (action === "select" && value === "block") {
                TnToast.show("此选项已被拦截，无法关闭");
                return false;
              }
              return true;
            },
            onSelect: (index: number) => {
              TnToast.show(`选择了第 ${index + 1} 项`);
            }
          });
          // 异步 beforeClose 拦截
          TnActionSheet({
            visible: this.vm.asyncBeforeCloseVisible,
            $visible: (val: boolean) => { this.vm.asyncBeforeCloseVisible = val; },
            title: "异步验证",
            description: "选择后模拟异步请求（1秒）",
            actions: [
              new TnActionSheetItem("提交订单"),
              new TnActionSheetItem("取消订单")
            ],
            beforeClose: (action: TnActionSheetCloseAction): Promise<boolean> => {
              return new Promise<boolean>((resolve: Function) => {
                if (action === "select") {
                  TnToast.show("处理中...");
                  setTimeout(() => {
                    resolve(true);
                  }, 1000);
                } else {
                  resolve(true);
                }
              });
            },
            onSelect: (index: number) => {
              const names: string[] = ["提交订单", "取消订单"];
              TnToast.show(`${names[index]}成功`);
            }
          });
          // 自定义标题和描述
          TnActionSheet({
            visible: this.vm.customTitleVisible,
            $visible: (val: boolean) => { this.vm.customTitleVisible = val; },
            title: "自定义标题",
            description: "这里是自定义描述内容，可以提供更多说明信息",
            actions: [
              new TnActionSheetItem("选项一"),
              new TnActionSheetItem("选项二"),
              new TnActionSheetItem("选项三")
            ],
            onSelect: (index: number) => {
              TnToast.show(`选择了第 ${index + 1} 项`);
            }
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
        // 选择结果展示
        if (this.vm.selectResult) {
          Column() {
            Text(this.vm.selectResult)
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
              .fontColor(getThemeColor(this.baseStyle, "primary"))
              .textAlign(TextAlign.Center)
              .width(P100);
          }
          .width(P100)
          .padding($r("app.float.space_padding_medium"))
          .backgroundColor($r("app.color.bg_white"))
          .borderRadius($r("app.float.radius_medium"));

          SpaceVerticalLarge();
        }

        // 基础用法
        this.SectionTitle("基础用法");
        SpaceVerticalMedium();
        Column() {
          Column({ space: this.baseStyle.spaceXsm }) {
            Row({ space: this.baseStyle.spaceXsm }) {
              TnButton({
                content: "基础面板",
                btnSize: "sm",
                onBtnClick: () => { this.vm.basicVisible = true; }
              });
              TnButton({
                content: "带标题",
                btnSize: "sm",
                type: "success",
                onBtnClick: () => { this.vm.withTitleVisible = true; }
              });
            }
            .width(P100);

            Row({ space: this.baseStyle.spaceXsm }) {
              TnButton({
                content: "标题+描述",
                btnSize: "sm",
                type: "warning",
                onBtnClick: () => { this.vm.withDescVisible = true; }
              });
              TnButton({
                content: "选项描述",
                btnSize: "sm",
                type: "info",
                onBtnClick: () => { this.vm.itemDescVisible = true; }
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

        // 选项样式
        this.SectionTitle("选项样式");
        SpaceVerticalMedium();
        Column() {
          Row({ space: this.baseStyle.spaceXsm }) {
            TnButton({
              content: "自定义颜色",
              btnSize: "sm",
              type: "danger",
              onBtnClick: () => { this.vm.customColorVisible = true; }
            });
            TnButton({
              content: "禁用选项",
              btnSize: "sm",
              type: "warning",
              onBtnClick: () => { this.vm.disabledVisible = true; }
            });
          }
          .width(P100);
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 取消按钮
        this.SectionTitle("取消按钮");
        SpaceVerticalMedium();
        Column() {
          Row({ space: this.baseStyle.spaceXsm }) {
            TnButton({
              content: "隐藏取消按钮",
              btnSize: "sm",
              onBtnClick: () => { this.vm.noCancelVisible = true; }
            });
            TnButton({
              content: "自定义取消文字",
              btnSize: "sm",
              type: "success",
              onBtnClick: () => { this.vm.customCancelVisible = true; }
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
          TnButton({
            content: "点击遮罩不可关闭",
            btnSize: "sm",
            type: "warning",
            onBtnClick: () => { this.vm.noOverlayCloseVisible = true; }
          });
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
          Row({ space: this.baseStyle.spaceXsm }) {
            TnButton({
              content: "拦截关闭",
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

        // 自定义内容
        this.SectionTitle("自定义内容");
        SpaceVerticalMedium();
        Column() {
          TnButton({
            content: "标题+描述组合",
            btnSize: "sm",
            type: "info",
            onBtnClick: () => { this.vm.customTitleVisible = true; }
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
      .fontWeight(FontWeight.Bold);
  }
}
