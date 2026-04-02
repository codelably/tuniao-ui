/**
 * @file TnNoticeBar 通知栏展示页面视图
 * @description 展示通知栏组件的各种用法，包括基础、滚动、垂直轮播、可关闭、自定义样式等
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
  TnNoticeBar,
  TnButton,
  TnToast,
  getThemeColor,
  getThemeColorLight,
  TnUIBaseStyleType,
  TnUIBaseStyle
} from "@tuniao/tn-ui";
import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "@tuniao/tn-ui/src/main/ets/common/storage_key";
import TnNoticeBarViewModel from "../viewmodel/TnNoticeBarViewModel";

@ComponentV2
export struct TnNoticeBarPage {
  @Local private vm: TnNoticeBarViewModel = new TnNoticeBarViewModel();
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();
  @Local private baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  build() {
    AppNavDestination({
      title: "通知栏",
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
        // 基础用法
        this.SectionTitle("基础用法");
        SpaceVerticalMedium();
        Column({ space: "12vp" }) {
          TnNoticeBar({
            text: "这是一条普通的通知消息"
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 滚动播放
        this.SectionTitle("滚动播放");
        SpaceVerticalMedium();
        Column({ space: "12vp" }) {
          TnNoticeBar({
            text: "这是一条很长的通知消息，当文本内容超出通知栏宽度时会自动滚动播放，实现跑马灯效果展示完整内容",
            leftIcon: "sound"
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 强制不滚动
        this.SectionTitle("禁止滚动");
        SpaceVerticalMedium();
        Column({ space: "12vp" }) {
          TnNoticeBar({
            text: "这是一条很长的通知消息，设置 scrollable 为 false 后即使文本溢出也不会滚动，超出部分用省略号表示",
            scrollable: false
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 文字换行
        this.SectionTitle("文字换行");
        SpaceVerticalMedium();
        Column({ space: "12vp" }) {
          TnNoticeBar({
            text: "这是一条开启换行的通知消息，当文本内容超出通知栏宽度时会自动换行显示，不会滚动也不会省略",
            wrapable: true,
            leftIcon: "tip"
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 通知栏模式
        this.SectionTitle("通知栏模式");
        SpaceVerticalMedium();
        Column({ space: "12vp" }) {
          // 可关闭模式
          if (this.vm.closeableVisible) {
            TnNoticeBar({
              text: "可关闭的通知消息",
              mode: "closeable",
              leftIcon: "sound",
              onClose: () => {
                this.vm.closeableVisible = false;
                TnToast.show("通知栏已关闭");
              }
            });
          }

          // 重置按钮
          if (!this.vm.closeableVisible) {
            TnButton({
              content: "重置可关闭通知",
              btnSize: "sm",
              onBtnClick: () => {
                this.vm.closeableVisible = true;
              }
            });
          }

          // 链接模式
          TnNoticeBar({
            text: "链接模式，点击右侧箭头跳转",
            mode: "link",
            leftIcon: "tip",
            onRightIconClick: () => {
              TnToast.show("点击了链接箭头");
            }
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 垂直滚动
        this.SectionTitle("垂直滚动");
        SpaceVerticalMedium();
        Column({ space: "12vp" }) {
          TnNoticeBar({
            scrollDirection: "vertical",
            data: [
              "图鸟UI v1.0.3 版本已发布",
              "新增 NoticeBar 通知栏组件",
              "修复已知问题，提升稳定性",
              "欢迎提交 Issue 反馈问题"
            ],
            leftIcon: "sound",
            onTextClick: (index: number) => {
              TnToast.show(`点击了第 ${index + 1} 条通知`);
            }
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 垂直滚动 - 自定义间隔
        this.SectionTitle("自定义垂直滚动间隔");
        SpaceVerticalMedium();
        Column({ space: "12vp" }) {
          TnNoticeBar({
            scrollDirection: "vertical",
            data: [
              "快速切换 - 间隔2秒",
              "第二条通知消息",
              "第三条通知消息"
            ],
            verticalInterval: 2,
            leftIcon: "tip"
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
        Column({ space: "12vp" }) {
          // 自定义颜色 - 主题色
          TnNoticeBar({
            text: "主题色背景通知栏",
            bgColor: getThemeColorLight(this.baseStyle, "primary", "light_9"),
            textColor: getThemeColor(this.baseStyle, "primary"),
            leftIcon: "tip",
            leftIconColor: getThemeColor(this.baseStyle, "primary")
          });

          // 自定义颜色 - 危险色
          TnNoticeBar({
            text: "危险提示：系统将于今晚进行维护升级",
            bgColor: getThemeColorLight(this.baseStyle, "danger", "light_9"),
            textColor: getThemeColor(this.baseStyle, "danger"),
            leftIcon: "tip",
            leftIconColor: getThemeColor(this.baseStyle, "danger"),
            mode: "closeable",
            rightIconColor: getThemeColor(this.baseStyle, "danger")
          });

          // 自定义颜色 - 成功色
          TnNoticeBar({
            text: "操作成功，数据已保存",
            bgColor: getThemeColorLight(this.baseStyle, "success", "light_9"),
            textColor: getThemeColor(this.baseStyle, "success"),
            leftIcon: "check",
            leftIconColor: getThemeColor(this.baseStyle, "success")
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 圆角和自定义高度
        this.SectionTitle("圆角与高度");
        SpaceVerticalMedium();
        Column({ space: "12vp" }) {
          TnNoticeBar({
            text: "大圆角通知栏",
            radius: this.baseStyle.borderRadiusXl,
            leftIcon: "sound"
          });

          TnNoticeBar({
            text: "胶囊形通知栏",
            radius: this.baseStyle.borderRadiusMax,
            leftIcon: "sound"
          });

          TnNoticeBar({
            text: "自定义高度通知栏（50vp）",
            barHeight: 50,
            leftIcon: "tip"
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 自定义滚动速度
        this.SectionTitle("自定义滚动速度");
        SpaceVerticalMedium();
        Column({ space: "12vp" }) {
          TnNoticeBar({
            text: "慢速滚动（30vp/s）：这是一条很长的通知消息，用于展示慢速滚动效果，阅读起来更加轻松",
            speed: 30,
            leftIcon: "sound"
          });

          TnNoticeBar({
            text: "快速滚动（120vp/s）：这是一条很长的通知消息，用于展示快速滚动效果，信息传递更加迅速",
            speed: 120,
            leftIcon: "sound"
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 事件回调
        this.SectionTitle("事件回调");
        SpaceVerticalMedium();
        Column({ space: "12vp" }) {
          TnNoticeBar({
            text: "点击通知栏触发回调",
            leftIcon: "tip",
            mode: "link",
            onBarClick: () => {
              TnToast.show("点击了通知栏");
            },
            onLeftIconClick: () => {
              TnToast.show("点击了左侧图标");
            },
            onRightIconClick: () => {
              TnToast.show("点击了右侧图标");
            }
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
