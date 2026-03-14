/**
 * @file TnSlider 滑块展示页面视图
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
import { TnSlider } from "@tuniao/tn-ui";
import TnSliderViewModel from "../viewmodel/TnSliderViewModel";

@ComponentV2
export struct TnSliderPage {
  @Local private vm: TnSliderViewModel = new TnSliderViewModel();
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  build() {
    AppNavDestination({
      title: "滑块",
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
          TnSlider({
            modelValue: this.vm.sliderValue1,
            onChange: (value: number) => {
              this.vm.sliderValue1 = value;
            }
          });
          SpaceVerticalMedium();
          Text(`当前值：${this.vm.sliderValue1}`)
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_secondary"));
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        this.SectionTitle("自定义范围和步长");
        SpaceVerticalMedium();
        Column() {
          TnSlider({
            modelValue: this.vm.sliderValue2,
            min: 0,
            max: 200,
            step: 10,
            onChange: (value: number) => {
              this.vm.sliderValue2 = value;
            }
          });
          SpaceVerticalMedium();
          Text(`当前值：${this.vm.sliderValue2}（范围 0~200，步长 10）`)
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_secondary"));
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        this.SectionTitle("自定义颜色");
        SpaceVerticalMedium();
        Column() {
          TnSlider({
            modelValue: this.vm.sliderValue3,
            activeColor: "success",
            onChange: (value: number) => {
              this.vm.sliderValue3 = value;
            }
          });
          SpaceVerticalMedium();
          Text(`当前值：${this.vm.sliderValue3}（成功色主题）`)
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
          TnSlider({
            modelValue: this.vm.sliderValue4,
            disabled: true,
            onChange: (value: number) => {
              this.vm.sliderValue4 = value;
            }
          });
          SpaceVerticalMedium();
          Text("滑块已禁用，无法拖动")
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_secondary"));
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
