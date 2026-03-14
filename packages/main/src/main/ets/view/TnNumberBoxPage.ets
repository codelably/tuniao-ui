/**
 * @file TnNumberBox 步进器展示页面视图
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
import { TnNumberBox } from "@tuniao/tn-ui";
import TnNumberBoxViewModel from "../viewmodel/TnNumberBoxViewModel";

@ComponentV2
export struct TnNumberBoxPage {
  @Local private vm: TnNumberBoxViewModel = new TnNumberBoxViewModel();
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  build() {
    AppNavDestination({
      title: "步进器",
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
        this.SectionTitle("基础用法");
        SpaceVerticalMedium();
        Column() {
          TnNumberBox({
            modelValue: this.vm.numberValue1,
            onChange: (value: number) => {
              this.vm.numberValue1 = value;
            }
          });
          SpaceVerticalMedium();
          Text(`当前值：${this.vm.numberValue1}`)
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_secondary"));
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        this.SectionTitle("范围限制");
        SpaceVerticalMedium();
        Column() {
          TnNumberBox({
            modelValue: this.vm.numberValue2,
            min: 0,
            max: 10,
            step: 2,
            onChange: (value: number) => {
              this.vm.numberValue2 = value;
            }
          });
          SpaceVerticalMedium();
          Text(`当前值：${this.vm.numberValue2}（范围 0~10，步长 2）`)
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_secondary"));
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        this.SectionTitle("禁用状态");
        SpaceVerticalMedium();
        Column() {
          TnNumberBox({
            modelValue: this.vm.numberValue3,
            disabled: true,
            onChange: (value: number) => {
              this.vm.numberValue3 = value;
            }
          });
          SpaceVerticalMedium();
          Text("组件已禁用，无法操作")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_secondary"));
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        this.SectionTitle("禁用输入");
        SpaceVerticalMedium();
        Column() {
          TnNumberBox({
            modelValue: this.vm.numberValue4,
            inputDisabled: true,
            onChange: (value: number) => {
              this.vm.numberValue4 = value;
            }
          });
          SpaceVerticalMedium();
          Text("输入框已禁用，仅可通过按钮调整")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_secondary"));
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        this.SectionTitle("长按增减");
        SpaceVerticalMedium();
        Column() {
          TnNumberBox({
            modelValue: this.vm.numberValue5,
            longPress: true,
            longPressInterval: 150,
            onChange: (value: number) => {
              this.vm.numberValue5 = value;
            }
          });
          SpaceVerticalMedium();
          Text(`当前值：${this.vm.numberValue5}（长按可持续增减，间隔 150ms）`)
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_secondary"));
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        this.SectionTitle("不同尺寸");
        SpaceVerticalMedium();
        Column({ space: 12 }) {
          Row({ space: 16 }) {
            Text("小")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_secondary"))
              .width(40);
            TnNumberBox({
              modelValue: this.vm.numberValue6,
              componentSize: 22,
              onChange: (value: number) => {
                this.vm.numberValue6 = value;
              }
            });
          }
          .width(P100)
          .alignItems(VerticalAlign.Center);

          Row({ space: 16 }) {
            Text("默认")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_secondary"))
              .width(40);
            TnNumberBox({
              modelValue: this.vm.numberValue7,
              onChange: (value: number) => {
                this.vm.numberValue7 = value;
              }
            });
          }
          .width(P100)
          .alignItems(VerticalAlign.Center);

          Row({ space: 16 }) {
            Text("大")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_secondary"))
              .width(40);
            TnNumberBox({
              modelValue: this.vm.numberValue8,
              componentSize: 40,
              onChange: (value: number) => {
                this.vm.numberValue8 = value;
              }
            });
          }
          .width(P100)
          .alignItems(VerticalAlign.Center);
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
