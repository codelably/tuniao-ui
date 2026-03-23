/**
 * @file TnNotify 消息通知展示页面视图
 * @description 展示消息通知组件的各种用法，包括类型、时长、位置、自定义样式、事件回调等
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
  TnNotify,
  TnNotifyOption,
  getThemeColor,
  TnUIBaseStyleType,
  TnUIBaseStyle
} from "@tuniao/tn-ui";
import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "@tuniao/tn-ui/src/main/ets/common/storage_key";
import TnNotifyViewModel from "../viewmodel/TnNotifyViewModel";

@ComponentV2
export struct TnNotifyPage {
  @Local private vm: TnNotifyViewModel = new TnNotifyViewModel();
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();
  @Local private baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  build() {
    AppNavDestination({
      title: "消息通知",
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
                content: "基础通知",
                btnSize: "sm",
                type: "danger",
                onBtnClick: () => {
                  const option: TnNotifyOption = new TnNotifyOption();
                  option.message = "请填写正确的信息";
                  TnNotify.show(option);
                }
              });
              TnButton({
                content: "长文本通知",
                btnSize: "sm",
                type: "warning",
                onBtnClick: () => {
                  const option: TnNotifyOption = new TnNotifyOption();
                  option.message = "这是一段较长的通知文本，用于展示文本超出时的显示效果，最多支持三行文字";
                  option.type = "warning";
                  TnNotify.show(option);
                }
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

        // 通知类型
        this.SectionTitle("通知类型");
        SpaceVerticalMedium();
        Column() {
          Column({ space: "8vp" }) {
            Row({ space: "8vp" }) {
              TnButton({
                content: "主要通知",
                btnSize: "sm",
                type: "primary",
                onBtnClick: () => {
                  const option: TnNotifyOption = new TnNotifyOption();
                  option.message = "这是一条主要通知";
                  option.type = "primary";
                  TnNotify.show(option);
                }
              });
              TnButton({
                content: "成功通知",
                btnSize: "sm",
                type: "success",
                onBtnClick: () => {
                  const option: TnNotifyOption = new TnNotifyOption();
                  option.message = "操作成功，数据已保存";
                  option.type = "success";
                  TnNotify.show(option);
                }
              });
            }
            .width(P100);

            Row({ space: "8vp" }) {
              TnButton({
                content: "警告通知",
                btnSize: "sm",
                type: "warning",
                onBtnClick: () => {
                  const option: TnNotifyOption = new TnNotifyOption();
                  option.message = "请注意，该操作存在风险";
                  option.type = "warning";
                  TnNotify.show(option);
                }
              });
              TnButton({
                content: "危险通知",
                btnSize: "sm",
                type: "danger",
                onBtnClick: () => {
                  const option: TnNotifyOption = new TnNotifyOption();
                  option.message = "操作失败，请稍后重试";
                  option.type = "danger";
                  TnNotify.show(option);
                }
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

        // 自定义时长
        this.SectionTitle("自定义时长");
        SpaceVerticalMedium();
        Column() {
          Column({ space: "8vp" }) {
            Row({ space: "8vp" }) {
              TnButton({
                content: "1秒关闭",
                btnSize: "sm",
                onBtnClick: () => {
                  const option: TnNotifyOption = new TnNotifyOption();
                  option.message = "1秒后自动关闭";
                  option.type = "primary";
                  option.duration = 1000;
                  TnNotify.show(option);
                }
              });
              TnButton({
                content: "5秒关闭",
                btnSize: "sm",
                type: "success",
                onBtnClick: () => {
                  const option: TnNotifyOption = new TnNotifyOption();
                  option.message = "5秒后自动关闭";
                  option.type = "success";
                  option.duration = 5000;
                  TnNotify.show(option);
                }
              });
            }
            .width(P100);

            Row({ space: "8vp" }) {
              TnButton({
                content: "不自动关闭",
                btnSize: "sm",
                type: "warning",
                onBtnClick: () => {
                  const option: TnNotifyOption = new TnNotifyOption();
                  option.message = "此通知不会自动关闭，需手动关闭";
                  option.type = "warning";
                  option.duration = 0;
                  TnNotify.show(option);
                }
              });
              TnButton({
                content: "手动关闭",
                btnSize: "sm",
                type: "danger",
                onBtnClick: () => {
                  TnNotify.hide();
                }
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

        // 显示位置
        this.SectionTitle("显示位置");
        SpaceVerticalMedium();
        Column() {
          Row({ space: "8vp" }) {
            TnButton({
              content: "顶部通知",
              btnSize: "sm",
              onBtnClick: () => {
                const option: TnNotifyOption = new TnNotifyOption();
                option.message = "顶部显示的通知消息";
                option.type = "primary";
                option.position = "top";
                TnNotify.show(option);
              }
            });
            TnButton({
              content: "底部通知",
              btnSize: "sm",
              type: "success",
              onBtnClick: () => {
                const option: TnNotifyOption = new TnNotifyOption();
                option.message = "底部显示的通知消息";
                option.type = "success";
                option.position = "bottom";
                TnNotify.show(option);
              }
            });
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
                content: "自定义背景色",
                btnSize: "sm",
                type: "info",
                onBtnClick: () => {
                  const option: TnNotifyOption = new TnNotifyOption();
                  option.message = "自定义紫色背景的通知";
                  option.backgroundColor = "#8B5CF6";
                  TnNotify.show(option);
                }
              });
              TnButton({
                content: "自定义文字色",
                btnSize: "sm",
                type: "warning",
                onBtnClick: () => {
                  const option: TnNotifyOption = new TnNotifyOption();
                  option.message = "自定义文字颜色的通知";
                  option.type = "warning";
                  option.color = "#1A1A1A";
                  TnNotify.show(option);
                }
              });
            }
            .width(P100);

            Row({ space: "8vp" }) {
              TnButton({
                content: "自定义背景+文字",
                btnSize: "sm",
                type: "success",
                onBtnClick: () => {
                  const option: TnNotifyOption = new TnNotifyOption();
                  option.message = "深色背景浅色文字";
                  option.backgroundColor = "#1E293B";
                  option.color = "#E2E8F0";
                  TnNotify.show(option);
                }
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

        // 事件回调
        this.SectionTitle("事件回调");
        SpaceVerticalMedium();
        Column() {
          Column({ space: "8vp" }) {
            Row({ space: "8vp" }) {
              TnButton({
                content: "打开/关闭回调",
                btnSize: "sm",
                onBtnClick: () => {
                  const option: TnNotifyOption = new TnNotifyOption();
                  option.message = "关注打开和关闭事件";
                  option.type = "primary";
                  option.duration = 2000;
                  option.onOpen = () => {
                    this.vm.resultText = "通知已打开";
                  };
                  option.onClose = () => {
                    this.vm.resultText = "通知已关闭";
                  };
                  TnNotify.show(option);
                }
              });
              TnButton({
                content: "点击回调",
                btnSize: "sm",
                type: "success",
                onBtnClick: () => {
                  const option: TnNotifyOption = new TnNotifyOption();
                  option.message = "点击此通知触发回调";
                  option.type = "success";
                  option.duration = 5000;
                  option.onClick = () => {
                    this.vm.resultText = "通知被点击了";
                  };
                  TnNotify.show(option);
                }
              });
            }
            .width(P100);

            Row({ space: "8vp" }) {
              TnButton({
                content: "点击后关闭",
                btnSize: "sm",
                type: "warning",
                onBtnClick: () => {
                  const option: TnNotifyOption = new TnNotifyOption();
                  option.message = "点击此通知将立即关闭";
                  option.type = "warning";
                  option.duration = 0;
                  option.onClick = () => {
                    TnNotify.hide();
                    this.vm.resultText = "通知被点击并关闭";
                  };
                  TnNotify.show(option);
                }
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

        // 连续调用
        this.SectionTitle("连续调用");
        SpaceVerticalMedium();
        Column() {
          Row({ space: "8vp" }) {
            TnButton({
              content: "连续弹出",
              btnSize: "sm",
              type: "danger",
              onBtnClick: () => {
                const option: TnNotifyOption = new TnNotifyOption();
                option.message = "第一条通知";
                option.type = "danger";
                option.duration = 1500;
                TnNotify.show(option);
                setTimeout(() => {
                  const option2: TnNotifyOption = new TnNotifyOption();
                  option2.message = "第二条通知（替换上一条）";
                  option2.type = "success";
                  option2.duration = 2000;
                  TnNotify.show(option2);
                }, 800);
              }
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
