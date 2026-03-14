/**
 * @file TnRegionPicker 地区选择器展示页面视图
 * @description 使用 TnPopup 从底部弹出地区选择器，展示内置数据和自定义数据用法
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
import { TnButton, TnRegionPicker, RegionItem, TnPopup } from "@tuniao/tn-ui";
import TnRegionPickerViewModel from "../viewmodel/TnRegionPickerViewModel";

@ComponentV2
export struct TnRegionPickerPage {
  @Local private vm: TnRegionPickerViewModel = new TnRegionPickerViewModel();
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  /** 自定义区域数据：海外地区 */
  @Local private customRegionData: RegionItem[] = [
    {
      name: "亚洲", code: "AS", children: [
        {
          name: "日本", code: "JP", children: [
            { name: "东京", code: "JP-TK" },
            { name: "大阪", code: "JP-OS" },
            { name: "京都", code: "JP-KT" }
          ]
        },
        {
          name: "韩国", code: "KR", children: [
            { name: "首尔", code: "KR-SE" },
            { name: "釜山", code: "KR-BS" }
          ]
        },
        {
          name: "泰国", code: "TH", children: [
            { name: "曼谷", code: "TH-BK" },
            { name: "清迈", code: "TH-CM" },
            { name: "普吉", code: "TH-PK" }
          ]
        }
      ]
    },
    {
      name: "欧洲", code: "EU", children: [
        {
          name: "法国", code: "FR", children: [
            { name: "巴黎", code: "FR-PA" },
            { name: "里昂", code: "FR-LY" },
            { name: "马赛", code: "FR-MA" }
          ]
        },
        {
          name: "德国", code: "DE", children: [
            { name: "柏林", code: "DE-BE" },
            { name: "慕尼黑", code: "DE-MU" },
            { name: "法兰克福", code: "DE-FF" }
          ]
        },
        {
          name: "英国", code: "GB", children: [
            { name: "伦敦", code: "GB-LN" },
            { name: "曼彻斯特", code: "GB-MC" }
          ]
        }
      ]
    },
    {
      name: "北美洲", code: "NA", children: [
        {
          name: "美国", code: "US", children: [
            { name: "纽约", code: "US-NY" },
            { name: "洛杉矶", code: "US-LA" },
            { name: "旧金山", code: "US-SF" }
          ]
        },
        {
          name: "加拿大", code: "CA", children: [
            { name: "多伦多", code: "CA-TO" },
            { name: "温哥华", code: "CA-VA" }
          ]
        }
      ]
    }
  ];

  build() {
    AppNavDestination({
      title: "地区选择器",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.PageContent();
      // 内置数据选择器
      TnPopup({
        visible: this.vm.regionOpen,
        $visible: (val: boolean) => { this.vm.regionOpen = val; },
        openDirection: "bottom",
        radius: 0,
        contentBuilder: () => { this.RegionPickerContent(); }
      });
      // 自定义数据选择器
      TnPopup({
        visible: this.vm.customRegionOpen,
        $visible: (val: boolean) => { this.vm.customRegionOpen = val; },
        openDirection: "bottom",
        radius: 0,
        contentBuilder: () => { this.CustomRegionPickerContent(); }
      });
    }
  }

  /**
   * 内置数据选择器内容
   */
  @Builder private RegionPickerContent(): void {
    TnRegionPicker({
      open: true,
      onConfirm: (names: string[], codes: string[]) => {
        this.vm.onRegionConfirm(names, codes);
      },
      onCancel: () => { this.vm.closeRegionPicker(); },
      onClose: () => { this.vm.closeRegionPicker(); }
    });
  }

  /**
   * 自定义数据选择器内容
   */
  @Builder private CustomRegionPickerContent(): void {
    TnRegionPicker({
      open: true,
      title: "选择海外地区",
      customData: this.customRegionData,
      onConfirm: (names: string[], codes: string[]) => {
        this.vm.onCustomRegionConfirm(names, codes);
      },
      onCancel: () => { this.vm.customRegionOpen = false; },
      onClose: () => { this.vm.customRegionOpen = false; }
    });
  }

  @Builder private PageContent(): void {
    MediumPaddingVerticalScroll() {
      ColumnBase({ widthValue: P100 }) {
        // 基础用法（内置数据）
        this.SectionTitle("基础用法");
        SpaceVerticalMedium();
        Column() {
          TnButton({
            content: "选择地区",
            onBtnClick: () => { this.vm.toggleRegionPicker(); }
          });
          SpaceVerticalMedium();
          Text(`已选地区：${this.vm.regionDisplayText || "（未选择）"}`)
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_secondary"));
          if (this.vm.regionCodeText.length > 0) {
            SpaceVerticalMedium();
            Text(`区域编码：${this.vm.regionCodeText}`)
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_secondary"));
          }
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 自定义区域数据
        this.SectionTitle("自定义区域数据");
        SpaceVerticalMedium();
        Column() {
          TnButton({
            content: "选择海外地区",
            onBtnClick: () => { this.vm.toggleCustomRegionPicker(); }
          });
          SpaceVerticalMedium();
          Text(`已选地区：${this.vm.customRegionDisplayText || "（未选择）"}`)
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_secondary"));
          if (this.vm.customRegionCodeText.length > 0) {
            SpaceVerticalMedium();
            Text(`区域编码：${this.vm.customRegionCodeText}`)
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_secondary"));
          }
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
