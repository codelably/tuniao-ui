/**
 * @file TnToast 轻提示展示页面视图
 * @description 展示轻提示组件的各种用法，包括类型、时长、位置、加载、动态更新、遮罩、事件回调等
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
  TnToast,
  TnToastOption,
  TnToastLoadingOption,
  getThemeColor,
  TnUIBaseStyleType,
  TnUIBaseStyle
} from "@tuniao/tn-ui";
import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "@tuniao/tn-ui/src/main/ets/common/storage_key";
import TnToastViewModel from "../viewmodel/TnToastViewModel";

@ComponentV2
export struct TnToastPage {
  @Local private vm: TnToastViewModel = new TnToastViewModel();
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();
  @Local private baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  build() {
    AppNavDestination({
      title: "轻提示",
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
          Row({ space: "8vp" }) {
            TnButton({
              content: "文字提示",
              btnSize: "sm",
              onBtnClick: () => {
                TnToast.show("操作成功");
              }
            });
            TnButton({
              content: "长文本提示",
              btnSize: "sm",
              type: "warning",
              onBtnClick: () => {
                TnToast.show("这是一段比较长的轻提示文本，用于展示超长文字的显示效果");
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

        // Toast 类型
        this.SectionTitle("Toast 类型");
        SpaceVerticalMedium();
        Column() {
          Column({ space: "8vp" }) {
            Row({ space: "8vp" }) {
              TnButton({
                content: "成功提示",
                btnSize: "sm",
                type: "success",
                onBtnClick: () => {
                  const opt: TnToastOption = new TnToastOption();
                  opt.message = "操作成功";
                  opt.type = "success";
                  TnToast.show(opt);
                }
              });
              TnButton({
                content: "警告提示",
                btnSize: "sm",
                type: "warning",
                onBtnClick: () => {
                  const opt: TnToastOption = new TnToastOption();
                  opt.message = "请注意操作";
                  opt.type = "warning";
                  TnToast.show(opt);
                }
              });
            }
            .width(P100);

            Row({ space: "8vp" }) {
              TnButton({
                content: "失败提示",
                btnSize: "sm",
                type: "danger",
                onBtnClick: () => {
                  const opt: TnToastOption = new TnToastOption();
                  opt.message = "操作失败";
                  opt.type = "fail";
                  TnToast.show(opt);
                }
              });
              TnButton({
                content: "加载提示",
                btnSize: "sm",
                onBtnClick: () => {
                  const opt: TnToastOption = new TnToastOption();
                  opt.message = "加载中...";
                  opt.type = "loading";
                  opt.duration = 2000;
                  TnToast.show(opt);
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

        // 自定义图标
        this.SectionTitle("自定义图标");
        SpaceVerticalMedium();
        Column() {
          Row({ space: "8vp" }) {
            TnButton({
              content: "自定义图标",
              btnSize: "sm",
              onBtnClick: () => {
                const opt: TnToastOption = new TnToastOption();
                opt.message = "自定义图标提示";
                opt.icon = $r("app.media.ic_logo");
                TnToast.show(opt);
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

        // 显示位置
        this.SectionTitle("显示位置");
        SpaceVerticalMedium();
        Column() {
          Row({ space: "8vp" }) {
            TnButton({
              content: "顶部",
              btnSize: "sm",
              onBtnClick: () => {
                const opt: TnToastOption = new TnToastOption();
                opt.message = "顶部提示";
                opt.position = "top";
                opt.offsetY = 80;
                TnToast.show(opt);
              }
            });
            TnButton({
              content: "居中",
              btnSize: "sm",
              type: "primary",
              onBtnClick: () => {
                TnToast.show("居中提示");
              }
            });
            TnButton({
              content: "底部",
              btnSize: "sm",
              type: "success",
              onBtnClick: () => {
                const opt: TnToastOption = new TnToastOption();
                opt.message = "底部提示";
                opt.position = "bottom";
                opt.offsetY = -80;
                TnToast.show(opt);
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

        // 文字换行
        this.SectionTitle("文字换行");
        SpaceVerticalMedium();
        Column() {
          Column({ space: "8vp" }) {
            Row({ space: "8vp" }) {
              TnButton({
                content: "normal",
                btnSize: "sm",
                onBtnClick: () => {
                  const opt: TnToastOption = new TnToastOption();
                  opt.message = "Hello World Abcdefghijklmnopqrstuvwxyz12345 End";
                  opt.wordBreak = "normal";
                  opt.duration = 3000;
                  TnToast.show(opt);
                }
              });
              TnButton({
                content: "break-all",
                btnSize: "sm",
                type: "primary",
                onBtnClick: () => {
                  const opt: TnToastOption = new TnToastOption();
                  opt.message = "Hello World Abcdefghijklmnopqrstuvwxyz12345 End";
                  opt.wordBreak = "break-all";
                  opt.duration = 3000;
                  TnToast.show(opt);
                }
              });
            }
            .width(P100);

            Row({ space: "8vp" }) {
              TnButton({
                content: "break-word",
                btnSize: "sm",
                type: "success",
                onBtnClick: () => {
                  const opt: TnToastOption = new TnToastOption();
                  opt.message = "Hello World Abcdefghijklmnopqrstuvwxyz12345 End";
                  opt.wordBreak = "break-word";
                  opt.duration = 3000;
                  TnToast.show(opt);
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
                  const opt: TnToastOption = new TnToastOption();
                  opt.message = "1秒后关闭";
                  opt.duration = 1000;
                  TnToast.show(opt);
                }
              });
              TnButton({
                content: "5秒关闭",
                btnSize: "sm",
                type: "primary",
                onBtnClick: () => {
                  const opt: TnToastOption = new TnToastOption();
                  opt.message = "5秒后关闭";
                  opt.duration = 5000;
                  TnToast.show(opt);
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
                  const opt: TnToastOption = new TnToastOption();
                  opt.message = "需手动关闭";
                  opt.type = "success";
                  opt.duration = 0;
                  TnToast.show(opt);
                }
              });
              TnButton({
                content: "手动关闭",
                btnSize: "sm",
                type: "danger",
                onBtnClick: () => {
                  TnToast.hide();
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

        // 加载提示
        this.SectionTitle("加载提示");
        SpaceVerticalMedium();
        Column() {
          Column({ space: "8vp" }) {
            Row({ space: "8vp" }) {
              TnButton({
                content: "圆圈加载",
                btnSize: "sm",
                onBtnClick: () => {
                  const opt: TnToastLoadingOption = new TnToastLoadingOption();
                  opt.message = "加载中...";
                  opt.loadingMode = "circle";
                  TnToast.showLoading(opt);
                  setTimeout(() => {
                    TnToast.hide();
                  }, 2000);
                }
              });
              TnButton({
                content: "花瓣加载",
                btnSize: "sm",
                type: "primary",
                onBtnClick: () => {
                  const opt: TnToastLoadingOption = new TnToastLoadingOption();
                  opt.message = "请稍候...";
                  opt.loadingMode = "flower";
                  TnToast.showLoading(opt);
                  setTimeout(() => {
                    TnToast.hide();
                  }, 2000);
                }
              });
            }
            .width(P100);

            Row({ space: "8vp" }) {
              TnButton({
                content: "半圆加载",
                btnSize: "sm",
                type: "success",
                onBtnClick: () => {
                  const opt: TnToastLoadingOption = new TnToastLoadingOption();
                  opt.message = "处理中...";
                  opt.loadingMode = "semicircle";
                  opt.loadingColor = "#01beff";
                  TnToast.showLoading(opt);
                  setTimeout(() => {
                    TnToast.hide();
                  }, 2000);
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

        // 动态更新
        this.SectionTitle("动态更新");
        SpaceVerticalMedium();
        Column() {
          Row({ space: "8vp" }) {
            TnButton({
              content: "动态更新文本",
              btnSize: "sm",
              onBtnClick: () => {
                const opt: TnToastOption = new TnToastOption();
                opt.message = "正在上传... 0%";
                opt.type = "loading";
                opt.duration = 0;
                TnToast.show(opt);
                let progress: number = 0;
                const timer: number = setInterval(() => {
                  progress += 10;
                  TnToast.message = `正在上传... ${progress}%`;
                  if (progress >= 100) {
                    clearInterval(timer);
                    TnToast.hide();
                  }
                }, 300);
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

        // 偏移量
        this.SectionTitle("偏移量");
        SpaceVerticalMedium();
        Column() {
          Row({ space: "8vp" }) {
            TnButton({
              content: "底部偏移-100",
              btnSize: "sm",
              onBtnClick: () => {
                const opt: TnToastOption = new TnToastOption();
                opt.message = "自定义偏移";
                opt.position = "bottom";
                opt.offsetY = -100;
                TnToast.show(opt);
              }
            });
            TnButton({
              content: "顶部偏移+100",
              btnSize: "sm",
              type: "primary",
              onBtnClick: () => {
                const opt: TnToastOption = new TnToastOption();
                opt.message = "自定义偏移";
                opt.position = "top";
                opt.offsetY = 100;
                TnToast.show(opt);
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

        // 背景遮罩
        this.SectionTitle("背景遮罩");
        SpaceVerticalMedium();
        Column() {
          Row({ space: "8vp" }) {
            TnButton({
              content: "显示遮罩",
              btnSize: "sm",
              onBtnClick: () => {
                const opt: TnToastOption = new TnToastOption();
                opt.message = "带遮罩的提示";
                opt.type = "success";
                opt.isShowMask = true;
                opt.duration = 2000;
                TnToast.show(opt);
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

        // 事件回调
        this.SectionTitle("事件回调");
        SpaceVerticalMedium();
        Column() {
          Row({ space: "8vp" }) {
            TnButton({
              content: "打开/关闭回调",
              btnSize: "sm",
              onBtnClick: () => {
                const opt: TnToastOption = new TnToastOption();
                opt.message = "监听事件回调";
                opt.type = "success";
                opt.duration = 2000;
                opt.onOpen = () => {
                  this.vm.resultText = "Toast 已打开";
                };
                opt.onClose = () => {
                  this.vm.resultText = "Toast 已关闭";
                };
                TnToast.show(opt);
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
