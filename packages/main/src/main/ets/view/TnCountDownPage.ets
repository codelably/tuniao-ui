/**
 * @file TnCountDown 倒计时展示页面视图
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
import { TnCountDown, TnButton } from "@tuniao/tn-ui";
import TnCountDownViewModel from "../viewmodel/TnCountDownViewModel";

@ComponentV2
export struct TnCountDownPage {
  @Local private vm: TnCountDownViewModel = new TnCountDownViewModel();
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  build() {
    AppNavDestination({
      title: "倒计时",
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

  @Builder private PageContent() {
    MediumPaddingVerticalScroll() {
      ColumnBase({ widthValue: P100 }) {
        // ===== 基础用法 =====
        this.SectionTitle("基础用法");
        SpaceVerticalMedium();
        Column() {
          Text("默认显示 时:分:秒（5分钟）")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountDown({ time: this.vm.basicTime });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 显示天数 =====
        this.SectionTitle("显示天数");
        SpaceVerticalMedium();
        Column() {
          Text("showDay = true（1天零1小时）")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountDown({ time: this.vm.dayTime, showDay: true });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 只显示分秒 =====
        this.SectionTitle("只显示分秒");
        SpaceVerticalMedium();
        Column() {
          Text("showHour = false（10分钟）")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountDown({ time: this.vm.minuteSecondTime, showHour: false });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 中文分割符 =====
        this.SectionTitle("中文分割符");
        SpaceVerticalMedium();
        Column() {
          Text("separatorMode = 'cn'")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountDown({ time: this.vm.cnSeparatorTime, separatorMode: 'cn' });
          SpaceVerticalMedium();
          Text("中文分割符 + 显示天数")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountDown({ time: this.vm.borderCnTime, separatorMode: 'cn', showDay: true });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 自定义颜色 =====
        this.SectionTitle("自定义颜色");
        SpaceVerticalMedium();
        Column() {
          Text("主题色 - primary")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountDown({
            time: this.vm.customColorTime,
            textColor: "primary",
            separatorColor: "primary"
          });
          SpaceVerticalMedium();

          Text("主题色 - danger")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountDown({
            time: this.vm.customColorTime,
            textColor: "danger",
            separatorColor: "danger"
          });
          SpaceVerticalMedium();

          Text("自定义 hex 色值")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountDown({
            time: this.vm.customColorTime,
            textColor: "#01beff",
            separatorColor: "#01beff"
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 显示边框 =====
        this.SectionTitle("显示边框");
        SpaceVerticalMedium();
        Column() {
          Text("英文分割符 + 边框")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountDown({ time: this.vm.borderTime, showBorder: true });
          SpaceVerticalMedium();

          Text("中文分割符 + 边框")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountDown({ time: this.vm.borderTime, showBorder: true, separatorMode: 'cn' });
          SpaceVerticalMedium();

          Text("自定义边框颜色 + 主题色文字")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountDown({
            time: this.vm.borderTime,
            showBorder: true,
            itemBorderColor: "primary",
            textColor: "primary",
            separatorColor: "primary"
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 自定义字体大小 =====
        this.SectionTitle("自定义字体大小");
        SpaceVerticalMedium();
        Column() {
          Text("fontSize = 12")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountDown({ time: this.vm.fontSizeTime, fontSize: 12 });
          SpaceVerticalMedium();

          Text("fontSize = 20")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountDown({ time: this.vm.fontSizeTime, fontSize: 20 });
          SpaceVerticalMedium();

          Text("fontSize = 28")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountDown({ time: this.vm.fontSizeTime, fontSize: 28 });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 手动控制 =====
        this.SectionTitle("手动控制（控制器）");
        SpaceVerticalMedium();
        Column() {
          Text(`状态：${this.vm.controlStatusText}`)
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_subtitle"));
          SpaceVerticalSmall();
          TnCountDown({
            time: this.vm.controlTime,
            autoStart: false,
            controller: this.vm.controlController,
            textColor: "primary",
            fontSize: 20,
            separatorColor: "primary",
            onStart: () => {
              this.vm.onControlStart();
            },
            onEnd: () => {
              this.vm.onControlEnd();
            }
          });
          SpaceVerticalMedium();
          Row({ space: 12 }) {
            TnButton({
              content: "开始",
              btnSize: "sm",
              type: "primary",
              onBtnClick: () => {
                this.vm.startControl();
              }
            });
            TnButton({
              content: "暂停",
              btnSize: "sm",
              type: "warning",
              onBtnClick: () => {
                this.vm.pauseControl();
              }
            });
            TnButton({
              content: "重置",
              btnSize: "sm",
              type: "info",
              onBtnClick: () => {
                this.vm.resetControl();
              }
            });
          };
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();
      };
    };
  }

  @Builder private SectionTitle(title: string): void {
    Text(title)
      .fontSize($r("app.float.headline_medium"))
      .fontColor($r("app.color.text_primary"))
      .fontWeight(FontWeight.Bold);
  }
}
