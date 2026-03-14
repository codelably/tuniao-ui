/**
 * @file TnTag 标签展示页面视图
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
import { LengthMetrics } from "@kit.ArkUI";
import { TnTag, TnButton } from "@tuniao/tn-ui";
import TnTagViewModel from "../viewmodel/TnTagViewModel";

/**
 * TnTag 标签展示页面
 */
@ComponentV2
export struct TnTagPage {
  /**
   * 标签展示页面 ViewModel
   */
  @Local
  private vm: TnTagViewModel = new TnTagViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  /**
   * 构建标签展示页面
   */
  build() {
    AppNavDestination({
      title: "标签",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.TagContent();
    }
  }

  /**
   * 标签内容视图
   */
  @Builder
  private TagContent() {
    MediumPaddingVerticalScroll() {
      ColumnBase({ widthValue: P100 }) {
        // 1. 基础类型
        this.SectionTitle("基础类型");
        SpaceVerticalMedium();
        this.BasicTypeSection();

        SpaceVerticalLarge();

        // 2. 朴素标签
        this.SectionTitle("朴素标签");
        SpaceVerticalMedium();
        this.PlainSection();

        SpaceVerticalLarge();

        // 3. 标签形状
        this.SectionTitle("标签形状");
        SpaceVerticalMedium();
        this.ShapeSection();

        SpaceVerticalLarge();

        // 4. 标签尺寸
        this.SectionTitle("标签尺寸");
        SpaceVerticalMedium();
        this.SizeSection();

        SpaceVerticalLarge();

        // 5. 自定义字体大小
        this.SectionTitle("自定义字体大小");
        SpaceVerticalMedium();
        this.CustomFontSizeSection();

        SpaceVerticalLarge();

        // 6. 边框样式
        this.SectionTitle("边框样式");
        SpaceVerticalMedium();
        this.BorderSection();

        SpaceVerticalLarge();

        // 7. 加粗文字
        this.SectionTitle("加粗文字");
        SpaceVerticalMedium();
        this.BoldSection();

        SpaceVerticalLarge();

        // 8. 自定义颜色
        this.SectionTitle("自定义颜色");
        SpaceVerticalMedium();
        this.CustomColorSection();

        SpaceVerticalLarge();

        // 9. 自定义尺寸
        this.SectionTitle("自定义尺寸");
        SpaceVerticalMedium();
        this.CustomSizeSection();

        SpaceVerticalLarge();

        // 10. 可关闭标签
        this.SectionTitle("可关闭标签");
        SpaceVerticalMedium();
        this.CloseableSection();

        SpaceVerticalLarge();

        // 11. 点击事件
        this.SectionTitle("点击事件");
        SpaceVerticalMedium();
        this.ClickEventSection();

        SpaceVerticalLarge();

        // 12. 自定义内容
        this.SectionTitle("自定义内容");
        SpaceVerticalMedium();
        this.CustomContentSection();
      };
    };
  }

  /**
   * 区域标题
   * @param title 标题文本
   */
  @Builder
  private SectionTitle(title: string): void {
    Text(title)
      .fontSize($r("app.float.headline_medium"))
      .fontColor($r("app.color.text_primary"))
      .fontWeight(FontWeight.Bold);
  }

  /**
   * 1. 基础类型展示区
   */
  @Builder
  private BasicTypeSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 type 设置标签颜色类型，默认使用浅色背景 + 主题色文字")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) } }) {
          TnTag({ text: "Primary", type: "primary" });
          TnTag({ text: "Success", type: "success" });
          TnTag({ text: "Warning", type: "warning" });
          TnTag({ text: "Danger", type: "danger" });
          TnTag({ text: "Info", type: "info" });
        }
        .width(P100);
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 2. 朴素标签展示区
   */
  @Builder
  private PlainSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 plain 显示朴素标签（透明背景 + 主题色边框和文字）")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) } }) {
          TnTag({ text: "Primary", type: "primary", plain: true });
          TnTag({ text: "Success", type: "success", plain: true });
          TnTag({ text: "Warning", type: "warning", plain: true });
          TnTag({ text: "Danger", type: "danger", plain: true });
          TnTag({ text: "Info", type: "info", plain: true });
        }
        .width(P100);
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 3. 标签形状展示区
   */
  @Builder
  private ShapeSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 shape 设置标签形状")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) } }) {
          TnTag({ text: "默认", type: "primary" });
          TnTag({ text: "圆形", type: "success", shape: "circle" });
          TnTag({ text: "圆角", type: "warning", shape: "round" });
          TnTag({ text: "左侧圆形", type: "danger", shape: "circleLeft" });
          TnTag({ text: "右侧圆形", type: "info", shape: "circleRight" });
        }
        .width(P100);
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 4. 标签尺寸展示区
   */
  @Builder
  private SizeSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 tagSize 设置标签尺寸")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          wrap: FlexWrap.Wrap,
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) }
        }) {
          TnTag({ text: "小 sm", type: "primary", tagSize: "sm" });
          TnTag({ text: "默认", type: "primary" });
          TnTag({ text: "大 lg", type: "primary", tagSize: "lg" });
          TnTag({ text: "超大 xl", type: "primary", tagSize: "xl" });
        }
        .width(P100);
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 5. 自定义字体大小展示区
   */
  @Builder
  private CustomFontSizeSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 fontSize 自定义字体大小")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          wrap: FlexWrap.Wrap,
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) }
        }) {
          TnTag({ text: "10fp", type: "primary", fontSize: 10 });
          TnTag({ text: "默认", type: "primary" });
          TnTag({ text: "16fp", type: "primary", fontSize: 16 });
          TnTag({ text: "20fp", type: "primary", fontSize: 20 });
        }
        .width(P100);
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 6. 边框样式展示区
   */
  @Builder
  private BorderSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 showBorder 开启边框，tagBorderColor 自定义边框颜色，borderBold 加粗边框")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) } }) {
          TnTag({ text: "默认边框", type: "primary", showBorder: true });
          TnTag({ text: "自定义边框色", type: "success", tagBorderColor: "#7232dd" });
          TnTag({ text: "加粗边框", type: "warning", showBorder: true, borderBold: true });
          TnTag({ text: "朴素+加粗", type: "danger", plain: true, borderBold: true });
        }
        .width(P100);
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 7. 加粗文字展示区
   */
  @Builder
  private BoldSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 bold 加粗标签文字")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) } }) {
          TnTag({ text: "普通文字", type: "primary" });
          TnTag({ text: "加粗文字", type: "primary", bold: true });
          TnTag({ text: "加粗成功", type: "success", bold: true });
          TnTag({ text: "加粗警告", type: "warning", bold: true });
        }
        .width(P100);
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 8. 自定义颜色展示区
   */
  @Builder
  private CustomColorSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 bgColor / textColor 自定义标签颜色，支持内置颜色资源")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) } }) {
          TnTag({
            text: "紫色背景",
            bgColor: $r("app.color.tn_color_purple"),
            textColor: $r("app.color.tn_color_white")
          });
          TnTag({
            text: "靛蓝文字",
            type: "primary",
            textColor: $r("app.color.tn_color_indigo")
          });
          TnTag({
            text: "橙色背景",
            bgColor: $r("app.color.tn_color_orange"),
            textColor: $r("app.color.tn_color_white")
          });
          TnTag({
            text: "青色浅底",
            bgColor: $r("app.color.tn_color_cyan_light"),
            textColor: $r("app.color.tn_color_cyan")
          });
          TnTag({
            text: "棕色朴素",
            plain: true,
            tagBorderColor: $r("app.color.tn_color_brown"),
            textColor: $r("app.color.tn_color_brown")
          });
          TnTag({
            text: "红色背景",
            bgColor: $r("app.color.tn_color_red"),
            textColor: $r("app.color.tn_color_white")
          });
          TnTag({
            text: "灰色标签",
            bgColor: $r("app.color.tn_color_gray_light"),
            textColor: $r("app.color.tn_color_grey")
          });
        }
        .width(P100);
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 9. 自定义尺寸展示区
   */
  @Builder
  private CustomSizeSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 tagWidth / tagHeight 自定义标签尺寸")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          wrap: FlexWrap.Wrap,
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) }
        }) {
          TnTag({ text: "固定宽高", type: "primary", tagWidth: 80, tagHeight: 30 });
          TnTag({ text: "高标签", type: "success", tagHeight: 36 });
          TnTag({ text: "宽标签", type: "warning", tagWidth: 100 });
        }
        .width(P100);
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 10. 可关闭标签展示区
   */
  @Builder
  private CloseableSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("设置 closeable 显示关闭图标，点击后标签消失")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) } }) {
          if (this.vm.closeable1Visible) {
            TnTag({
              text: "可关闭",
              type: "primary",
              closeable: true,
              onClose: () => {
                this.vm.closeable1Visible = false;
              }
            });
          }
          if (this.vm.closeable2Visible) {
            TnTag({
              text: "朴素可关闭",
              type: "success",
              plain: true,
              closeable: true,
              onClose: () => {
                this.vm.closeable2Visible = false;
              }
            });
          }
          if (this.vm.closeable3Visible) {
            TnTag({
              text: "带边框可关闭",
              type: "danger",
              showBorder: true,
              closeable: true,
              onClose: () => {
                this.vm.closeable3Visible = false;
              }
            });
          }
        }
        .width(P100);

        SpaceVerticalMedium();

        TnButton({
          content: "重置标签",
          type: "primary",
          btnSize: "sm",
          onBtnClick: () => {
            this.vm.resetCloseableTags();
          }
        });
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 11. 点击事件展示区
   */
  @Builder
  private ClickEventSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("点击标签触发回调")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) } }) {
          TnTag({
            text: `点击计数: ${this.vm.clickCount}`,
            type: "primary",
            onTagClick: () => {
              this.vm.incrementClickCount();
            }
          });
          TnTag({
            text: "点我试试",
            type: "success",
            shape: "circle",
            onTagClick: () => {
              this.vm.incrementClickCount();
            }
          });
        }
        .width(P100);
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 12. 自定义内容展示区
   */
  @Builder
  private CustomContentSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 defaultBuilder 自定义标签内容")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({
          wrap: FlexWrap.Wrap,
          alignItems: ItemAlign.Center,
          space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) }
        }) {
          TnTag({ type: "primary", tagHeight: 28 }) {
            Row({ space: 4 }) {
              Text("VIP")
                .fontSize(10)
                .fontColor("#ff6700")
                .fontWeight(FontWeight.Bold);
              Text("会员专享")
                .fontSize(10)
                .fontColor($r("app.color.text_primary"));
            }
          };
          TnTag({ type: "success", shape: "circle", tagHeight: 28 }) {
            Row({ space: 4 }) {
              Text("NEW")
                .fontSize(10)
                .fontColor("#ffffff")
                .fontWeight(FontWeight.Bold);
            }
          };
          TnTag({ bgColor: "rgba(245, 108, 108, 0.1)", tagHeight: 28 }) {
            Row({ space: 2 }) {
              Text("HOT")
                .fontSize(10)
                .fontColor("#f56c6c")
                .fontWeight(FontWeight.Bold);
              Text("热门")
                .fontSize(10)
                .fontColor("#f56c6c");
            }
          };
        }
        .width(P100);
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }
}
