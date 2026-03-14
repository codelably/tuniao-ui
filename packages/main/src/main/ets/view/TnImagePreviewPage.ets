/**
 * @file TnImagePreview 图片预览展示页面视图
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
import { TnButton, TnImagePreview, TnImagePreviewOption } from "@tuniao/tn-ui";
import TnImagePreviewViewModel from "../viewmodel/TnImagePreviewViewModel";

/**
 * TnImagePreview 图片预览展示页面
 */
@ComponentV2
export struct TnImagePreviewPage {
  /**
   * 图片预览展示页面 ViewModel
   */
  @Local
  private vm: TnImagePreviewViewModel = new TnImagePreviewViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  /**
   * 构建图片预览展示页面
   */
  build() {
    AppNavDestination({
      title: "图片预览",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.ImagePreviewContent();
    }
  }

  /**
   * 图片预览内容视图
   */
  @Builder
  private ImagePreviewContent() {
    MediumPaddingVerticalScroll() {
      ColumnBase({ widthValue: P100 }) {
        // 1. 基础用法
        this.SectionTitle("基础用法");
        SpaceVerticalMedium();
        this.BasicSection();

        SpaceVerticalLarge();

        // 2. 指定初始图片
        this.SectionTitle("指定初始图片");
        SpaceVerticalMedium();
        this.StartIndexSection();

        SpaceVerticalLarge();

        // 3. 页码位置
        this.SectionTitle("页码位置");
        SpaceVerticalMedium();
        this.IndexPositionSection();

        SpaceVerticalLarge();

        // 4. 隐藏页码
        this.SectionTitle("隐藏页码");
        SpaceVerticalMedium();
        this.HideIndexSection();

        SpaceVerticalLarge();

        // 5. 关闭循环滑动
        this.SectionTitle("关闭循环滑动");
        SpaceVerticalMedium();
        this.NoLoopSection();

        SpaceVerticalLarge();

        // 6. 点击图片不关闭
        this.SectionTitle("点击图片不关闭");
        SpaceVerticalMedium();
        this.NoCloseOnClickImageSection();

        SpaceVerticalLarge();

        // 7. 自定义缩放比例
        this.SectionTitle("自定义缩放比例");
        SpaceVerticalMedium();
        this.CustomScaleSection();

        SpaceVerticalLarge();

        // 8. 监听点击和长按事件
        this.SectionTitle("监听点击和长按事件");
        SpaceVerticalMedium();
        this.EventCallbackSection();
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
   * 1. 基础用法展示区
   */
  @Builder
  private BasicSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("点击按钮打开图片预览，支持左右滑动切换、双击缩放、双指缩放")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnButton({
          content: "基础图片预览",
          onBtnClick: () => {
            TnImagePreview.show(
              this.vm.imageList
            );
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
   * 2. 指定初始图片展示区
   */
  @Builder
  private StartIndexSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("通过 startIndex 指定初始显示的图片，默认从第一张开始")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Row({ space: 12 }) {
          TnButton({
            content: "从第1张开始",
            btnSize: "sm",
            onBtnClick: () => {
              const option = new TnImagePreviewOption();
              option.startIndex = 0;
              TnImagePreview.show(
                this.vm.imageList,
                option
              );
            }
          });

          TnButton({
            content: "从第3张开始",
            btnSize: "sm",
            onBtnClick: () => {
              const option = new TnImagePreviewOption();
              option.startIndex = 2;
              TnImagePreview.show(
                this.vm.imageList,
                option
              );
            }
          });

          TnButton({
            content: "从第5张开始",
            btnSize: "sm",
            onBtnClick: () => {
              const option = new TnImagePreviewOption();
              option.startIndex = 4;
              TnImagePreview.show(
                this.vm.imageList,
                option
              );
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
   * 3. 页码位置展示区
   */
  @Builder
  private IndexPositionSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("通过 indexPosition 设置页码显示位置，支持 top 和 bottom")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Row({ space: 12 }) {
          TnButton({
            content: "页码在顶部",
            btnSize: "sm",
            onBtnClick: () => {
              const option = new TnImagePreviewOption();
              option.indexPosition = "top";
              TnImagePreview.show(
                this.vm.imageList,
                option
              );
            }
          });

          TnButton({
            content: "页码在底部",
            btnSize: "sm",
            onBtnClick: () => {
              const option = new TnImagePreviewOption();
              option.indexPosition = "bottom";
              TnImagePreview.show(
                this.vm.imageList,
                option
              );
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
   * 4. 隐藏页码展示区
   */
  @Builder
  private HideIndexSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("通过 showIndex 设置为 false 隐藏页码指示器")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnButton({
          content: "隐藏页码",
          onBtnClick: () => {
            const option = new TnImagePreviewOption();
            option.showIndex = false;
            TnImagePreview.show(
              this.vm.imageList,
              option
            );
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
   * 5. 关闭循环滑动展示区
   */
  @Builder
  private NoLoopSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("通过 loop 设置为 false 禁用循环滑动，到达末尾后无法继续滑动")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnButton({
          content: "禁用循环滑动",
          onBtnClick: () => {
            const option = new TnImagePreviewOption();
            option.loop = false;
            TnImagePreview.show(
              this.vm.imageList,
              option
            );
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
   * 6. 点击图片不关闭展示区
   */
  @Builder
  private NoCloseOnClickImageSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("通过 closeOnClickImage 设置为 false，点击图片后不关闭预览（需点击遮罩关闭）")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnButton({
          content: "点击图片不关闭",
          onBtnClick: () => {
            const option = new TnImagePreviewOption();
            option.closeOnClickImage = false;
            TnImagePreview.show(
              this.vm.imageList,
              option
            );
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
   * 7. 自定义缩放比例展示区
   */
  @Builder
  private CustomScaleSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("通过 maxScale 和 minScale 自定义图片缩放范围")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Row({ space: 12 }) {
          TnButton({
            content: "最大5倍缩放",
            btnSize: "sm",
            onBtnClick: () => {
              const option = new TnImagePreviewOption();
              option.maxScale = 5;
              TnImagePreview.show(
                this.vm.imageList,
                option
              );
            }
          });

          TnButton({
            content: "默认3倍缩放",
            btnSize: "sm",
            onBtnClick: () => {
              TnImagePreview.show(
                this.vm.imageList
              );
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
   * 8. 监听点击和长按事件展示区
   */
  @Builder
  private EventCallbackSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("通过 onImageClick 和 onImageLongPress 监听图片的点击和长按事件")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        TnButton({
          content: "带事件回调的预览",
          onBtnClick: () => {
            const option = new TnImagePreviewOption();
            option.closeOnClickImage = false;
            option.onImageClick = (index: number): void => {
              this.vm.updateClickedIndex(index);
            };
            option.onImageLongPress = (index: number): void => {
              this.vm.updateLongPressIndex(index);
            };
            TnImagePreview.show(
              this.vm.imageList,
              option
            );
          }
        });

        SpaceVerticalMedium();

        if (this.vm.clickedIndex >= 0) {
          Text(`最近点击的图片索引: ${this.vm.clickedIndex}`)
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_primary"));
        }

        if (this.vm.longPressIndex >= 0) {
          Text(`最近长按的图片索引: ${this.vm.longPressIndex}`)
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_primary"));
        }
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }
}
