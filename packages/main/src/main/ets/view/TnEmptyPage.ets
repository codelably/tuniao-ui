/**
 * @file TnEmpty 空白页展示页面视图
 * @author JunBin.Yang
 */
import { AppNavDestination } from "@core/components";
import {
  ColumnBase,
  MediumPaddingVerticalScroll,
  P100,
  SpaceVerticalLarge,
  SpaceVerticalSmall
} from "@core/designsystem";
import { getWindowSafeAreaState, WindowSafeAreaState } from "@core/layoutstate";
import {
  TnEmpty,
  TnEmptyMode,
  TnEmptySizeType,
  TnButton,
  TnIcon,
  TnUIBaseStyle,
  TnUIBaseStyleType,
  getThemeColor,
  SPACE
} from "@tuniao/tn-ui";
import { TnAppStorageKey } from "@tuniao/tn-ui/src/main/ets/common/storage_key";
import { AppStorageV2, LengthMetrics } from "@kit.ArkUI";
import TnEmptyViewModel from "../viewmodel/TnEmptyViewModel";

@ComponentV2
export struct TnEmptyPage {
  @Local private vm: TnEmptyViewModel = new TnEmptyViewModel();
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();
  @Local private baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  build() {
    AppNavDestination({
      title: "空白页",
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
        this.SectionDesc("通过 mode 设置空白页类型，默认为 data");
        SpaceVerticalSmall();
        Column() {
          TnEmpty({ mode: "data" })
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 所有模式展示 =====
        this.SectionTitle("所有模式");
        this.SectionDesc("14 种预设空白页模式，点击标签切换查看");
        SpaceVerticalSmall();
        Column({ space: this.baseStyle.spaceSm }) {
          Flex({
            wrap: FlexWrap.Wrap,
            space: {
              main: LengthMetrics.vp(SPACE.XSM),
              cross: LengthMetrics.vp(SPACE.XSM)
            }
          }) {
            ForEach(this.vm.allModes, (mode: TnEmptyMode) => {
              Text(this.vm.modeLabels[mode])
                .fontSize(this.baseStyle.fontSizeSm)
                .fontColor(
                  this.vm.currentMode === mode
                    ? $r("app.color.tn_color_white")
                    : $r("app.color.tn_text_color_primary")
                )
                .backgroundColor(
                  this.vm.currentMode === mode
                    ? getThemeColor(this.baseStyle, "primary")
                    : $r("app.color.tn_color_gray_disabled")
                )
                .borderRadius(this.baseStyle.borderRadiusMax)
                .padding({
                  left: this.baseStyle.spaceSm,
                  right: this.baseStyle.spaceSm,
                  top: this.baseStyle.spaceXs,
                  bottom: this.baseStyle.spaceXs
                })
                .onClick(() => {
                  this.vm.currentMode = mode;
                })
                .animation({ duration: this.baseStyle.animationDuration })
            })
          }

          TnEmpty({ mode: this.vm.currentMode })
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 自定义颜色 =====
        this.SectionTitle("自定义颜色");
        this.SectionDesc("通过 color 修改空白页内容颜色");
        SpaceVerticalSmall();
        Column({ space: this.baseStyle.spaceLg }) {
          TnEmpty({
            mode: "data",
            color: getThemeColor(this.baseStyle, "primary")
          })
          TnEmpty({
            mode: "search",
            color: getThemeColor(this.baseStyle, "danger")
          })
          TnEmpty({
            mode: "network",
            color: getThemeColor(this.baseStyle, "warning")
          })
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 自定义尺寸（预设） =====
        this.SectionTitle("预设尺寸");
        this.SectionDesc("通过 emptySize 设置 sm、lg、xl 预设尺寸");
        SpaceVerticalSmall();
        Column({ space: this.baseStyle.spaceSm }) {
          Row({ space: this.baseStyle.spaceXsm }) {
            ForEach(this.vm.sizeOptions, (label: string, index: number) => {
              Text(label)
                .fontSize(this.baseStyle.fontSizeSm)
                .fontColor(
                  this.vm.currentSizeIndex === index
                    ? $r("app.color.tn_color_white")
                    : $r("app.color.tn_text_color_primary")
                )
                .backgroundColor(
                  this.vm.currentSizeIndex === index
                    ? getThemeColor(this.baseStyle, "primary")
                    : $r("app.color.tn_color_gray_disabled")
                )
                .borderRadius(this.baseStyle.borderRadiusMax)
                .padding({
                  left: this.baseStyle.spaceSm,
                  right: this.baseStyle.spaceSm,
                  top: this.baseStyle.spaceXs,
                  bottom: this.baseStyle.spaceXs
                })
                .onClick(() => {
                  this.vm.currentSizeIndex = index;
                })
                .animation({ duration: this.baseStyle.animationDuration })
            })
          }

          if (this.vm.currentSizeIndex === 0) {
            TnEmpty({ mode: "data" })
          } else if (this.vm.currentSizeIndex === 1) {
            TnEmpty({ mode: "data", emptySize: "sm" as TnEmptySizeType })
          } else if (this.vm.currentSizeIndex === 2) {
            TnEmpty({ mode: "data", emptySize: "lg" as TnEmptySizeType })
          } else {
            TnEmpty({ mode: "data", emptySize: "xl" as TnEmptySizeType })
          }
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 自定义尺寸（数值） =====
        this.SectionTitle("自定义尺寸");
        this.SectionDesc("通过 emptySize 传入数值设置自定义图标大小");
        SpaceVerticalSmall();
        Column() {
          TnEmpty({ mode: "favor", emptySize: 60 })
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 隐藏提示文字 =====
        this.SectionTitle("隐藏提示文字");
        this.SectionDesc("设置 showTips 为 false 隐藏底部提示");
        SpaceVerticalSmall();
        Column() {
          TnEmpty({ mode: "data", showTips: false })
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 自定义提示文案 =====
        this.SectionTitle("自定义提示文案");
        this.SectionDesc("通过 tips 属性自定义提示文案");
        SpaceVerticalSmall();
        Column() {
          TnEmpty({ mode: "data", tips: "这里什么都没有哦~" })
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 自定义图标内容 =====
        this.SectionTitle("自定义图标内容");
        this.SectionDesc("通过 iconBuilder 插槽自定义图标展示");
        SpaceVerticalSmall();
        Column() {
          TnEmpty({
            mode: "data",
            tips: "用户不存在",
            iconBuilder: (): void => this.CustomIconBuilder()
          })
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 自定义提示文字内容 =====
        this.SectionTitle("自定义提示文字内容");
        this.SectionDesc("通过 tipsBuilder 插槽自定义提示文字");
        SpaceVerticalSmall();
        Column() {
          TnEmpty({
            mode: "search",
            tipsBuilder: (): void => this.CustomTipsBuilder()
          })
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 底部自定义内容 =====
        this.SectionTitle("底部自定义内容");
        this.SectionDesc("通过 defaultBuilder 在底部添加操作按钮等内容");
        SpaceVerticalSmall();
        Column() {
          TnEmpty({
            mode: "network",
            defaultBuilder: (): void => this.BottomActionBuilder()
          })
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();
      };
    };
  }

  @Builder private CustomIconBuilder(): void {
    TnIcon({
      name: "logo-tuniao",
      color: getThemeColor(this.baseStyle, "primary"),
      iconSize: 80
    })
  }

  @Builder private CustomTipsBuilder(): void {
    Column({ space: this.baseStyle.spaceXs }) {
      Text("没有找到相关结果")
        .fontSize(this.baseStyle.fontSizeLg)
        .fontColor($r("app.color.tn_text_color_primary"))
        .fontWeight(FontWeight.Medium)
        .lineHeight(this.baseStyle.lineHeightMd)
      Text("请尝试更换关键词重新搜索")
        .fontSize(this.baseStyle.fontSizeSm)
        .fontColor($r("app.color.tn_text_color_secondary"))
        .lineHeight(this.baseStyle.lineHeightXsm)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder private BottomActionBuilder(): void {
    Row({ space: this.baseStyle.spaceSm }) {
      TnButton({
        content: "重新加载",
        btnSize: "sm",
        type: "primary"
      })
      TnButton({
        content: "返回首页",
        btnSize: "sm",
        type: "info",
        plain: true
      })
    }
    .margin({ top: this.baseStyle.spaceSm })
  }

  @Builder private SectionTitle(title: string): void {
    Text(title)
      .fontSize($r("app.float.headline_medium"))
      .fontColor($r("app.color.text_primary"))
      .fontWeight(FontWeight.Bold);
  }

  @Builder private SectionDesc(desc: string): void {
    Text(desc)
      .fontSize($r("app.float.body_medium"))
      .fontColor($r("app.color.text_secondary"));
  }
}
