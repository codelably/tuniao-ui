/**
 * @file TnIcon 图标展示页面视图
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
import { TnIcon, TnIconColorType } from "@tuniao/tn-ui";
import { promptAction } from "@kit.ArkUI";
import TnIconViewModel, {
  IconDemoItem,
  IconTypeItem,
  IconSizeItem
} from "../viewmodel/TnIconViewModel";

/**
 * TnIcon 图标展示页面
 */
@ComponentV2
export struct TnIconPage {
  /**
   * 图标展示页面 ViewModel
   */
  @Local
  private vm: TnIconViewModel = new TnIconViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  /**
   * 构建图标展示页面
   * @returns {void} 无返回值
   */
  build() {
    AppNavDestination({
      title: "图标",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.IconContent();
    }
  }

  /**
   * 图标内容视图
   * @returns {void} 无返回值
   */
  @Builder
  private IconContent() {
    MediumPaddingVerticalScroll() {
      ColumnBase({ widthValue: P100 }) {
        // 基础用法
        this.SectionTitle("基础用法");
        SpaceVerticalMedium();
        this.BasicIconSection();

        SpaceVerticalLarge();

        // 主题颜色
        this.SectionTitle("主题颜色");
        SpaceVerticalMedium();
        this.TypeIconSection();

        SpaceVerticalLarge();

        // 自定义颜色
        this.SectionTitle("自定义颜色");
        SpaceVerticalMedium();
        this.CustomColorSection();

        SpaceVerticalLarge();

        // 尺寸变化
        this.SectionTitle("尺寸变化");
        SpaceVerticalMedium();
        this.SizeIconSection();

        SpaceVerticalLarge();

        // 加粗
        this.SectionTitle("加粗");
        SpaceVerticalMedium();
        this.BoldIconSection();

        SpaceVerticalLarge();

        // 图片图标
        this.SectionTitle("图片图标");
        SpaceVerticalMedium();
        this.ImageIconSection();

        SpaceVerticalLarge();

        // 圆角
        this.SectionTitle("圆角");
        SpaceVerticalMedium();
        this.RadiusIconSection();

        SpaceVerticalLarge();

        // 点击事件
        this.SectionTitle("点击事件");
        SpaceVerticalMedium();
        this.ClickIconSection();

        SpaceVerticalLarge();

        // 全部图标
        this.SectionTitle(`全部图标 (${this.vm.getTotalIconCount()})`);
        SpaceVerticalMedium();
        this.AllIconsSection();
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
   * 基础用法展示区
   */
  @Builder
  private BasicIconSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("默认展示的字体图标")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap }) {
          ForEach(this.vm.getBasicIcons(), (item: IconDemoItem) => {
            Column() {
              TnIcon({ name: item.name });

              SpaceVerticalSmall();

              Text(item.description)
                .fontSize($r("app.float.body_medium"))
                .fontColor($r("app.color.text_subtitle"))
                .textAlign(TextAlign.Center);
            }
            .width("25%")
            .alignItems(HorizontalAlign.Center)
            .margin({ bottom: 12 });
          }, (item: IconDemoItem) => item.name);
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
   * 主题颜色展示区
   */
  @Builder
  private TypeIconSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 type 设置主题颜色")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Flex({ wrap: FlexWrap.Wrap }) {
          ForEach(this.vm.getTypeIcons(), (item: IconTypeItem) => {
            Column() {
              TnIcon({
                name: item.iconName,
                type: item.typeName as TnIconColorType,
                iconSize: 36
              });

              SpaceVerticalSmall();

              Text(item.typeName)
                .fontSize($r("app.float.body_medium"))
                .fontColor($r("app.color.text_subtitle"))
                .textAlign(TextAlign.Center);
            }
            .width("20%")
            .alignItems(HorizontalAlign.Center)
            .margin({ bottom: 12 });
          }, (item: IconTypeItem) => item.typeName);
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
   * 自定义颜色展示区
   */
  @Builder
  private CustomColorSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 color 设置自定义颜色")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Row({ space: 20 }) {
          Column() {
            TnIcon({ name: "home-capsule-fill", color: "#f56c6c", iconSize: 36 });
            SpaceVerticalSmall();
            Text("#f56c6c")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);

          Column() {
            TnIcon({ name: "home-capsule-fill", color: "#67c23a", iconSize: 36 });
            SpaceVerticalSmall();
            Text("#67c23a")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);

          Column() {
            TnIcon({ name: "home-capsule-fill", color: "#409eff", iconSize: 36 });
            SpaceVerticalSmall();
            Text("#409eff")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);
        };
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 尺寸变化展示区
   */
  @Builder
  private SizeIconSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 iconSize 设置不同尺寸")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Row({ space: 16 }) {
          ForEach(this.vm.getSizeIcons(), (item: IconSizeItem) => {
            Column() {
              TnIcon({ name: "home-capsule-fill", type: "primary", iconSize: item.size });

              SpaceVerticalSmall();

              Text(`${item.label}`)
                .fontSize($r("app.float.body_medium"))
                .fontColor($r("app.color.text_subtitle"));
            }
            .alignItems(HorizontalAlign.Center);
          }, (item: IconSizeItem) => item.label);
        };
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 加粗展示区
   */
  @Builder
  private BoldIconSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 bold 设置加粗效果")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Row({ space: 30 }) {
          Column() {
            TnIcon({ name: "home-capsule-fill", type: "primary", iconSize: 40 });
            SpaceVerticalSmall();
            Text("普通")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);

          Column() {
            TnIcon({ name: "home-capsule-fill", type: "primary", iconSize: 40, bold: true });
            SpaceVerticalSmall();
            Text("加粗")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);
        };
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 图片图标展示区
   */
  @Builder
  private ImageIconSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("传入图片路径或网络地址作为图标")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Row({ space: 20 }) {
          Column() {
            TnIcon({
              name: $r("app.media.ic_logo"),
              iconSize: 48
            });
            SpaceVerticalSmall();
            Text("本地图片")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);

          Column() {
            TnIcon({
              name: "https://vue3.tuniaokj.com/images/tuniao-logo.svg",
              iconSize: 48
            });
            SpaceVerticalSmall();
            Text("网络图片")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);
        };
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 圆角展示区（通过 bgColor + iconPadding + iconRadius 展示圆角效果）
   */
  @Builder
  private RadiusIconSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("使用 bgColor + iconPadding + iconRadius 设置图标圆角")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Row({ space: 20 }) {
          Column() {
            TnIcon({
              name: "home-capsule-fill",
              color: Color.White,
              iconSize: 28,
              bgColor: $r("app.color.tn_color_primary"),
              iconPadding: 10,
              iconRadius: 0
            });

            SpaceVerticalSmall();
            Text("无圆角")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);

          Column() {
            TnIcon({
              name: "home-capsule-fill",
              color: Color.White,
              iconSize: 28,
              bgColor: $r("app.color.tn_color_success"),
              iconPadding: 10,
              iconRadius: 8
            });

            SpaceVerticalSmall();
            Text("小圆角")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);

          Column() {
            TnIcon({
              name: "home-capsule-fill",
              color: Color.White,
              iconSize: 28,
              bgColor: $r("app.color.tn_color_warning"),
              iconPadding: 10,
              iconRadius: 24
            });

            SpaceVerticalSmall();
            Text("全圆角")
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_subtitle"));
          }
          .alignItems(HorizontalAlign.Center);
        };
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 点击事件展示区
   */
  @Builder
  private ClickIconSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        Text("点击图标触发回调")
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalMedium();

        Row({ space: 20 }) {
          TnIcon({
            name: "home-capsule-fill",
            type: "primary",
            iconSize: 48,
            onIconClick: () => {
              promptAction.showToast({ message: "点击了图标" });
            }
          });
        };
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }

  /**
   * 全部图标展示区（Grid + LazyForEach 懒加载）
   */
  @Builder
  private AllIconsSection(): void {
    Column() {
      ColumnBase({ widthValue: P100 }) {
        // 搜索框
        TextInput({ placeholder: "搜索图标名称...", text: this.vm.searchKeyword })
          .width(P100)
          .height(40)
          .onChange((value: string) => {
            this.vm.updateSearchKeyword(value);
          });

        SpaceVerticalMedium();

        Text(`共 ${this.vm.getFilteredIconNames().length} 个图标`)
          .fontSize($r("app.float.body_medium"))
          .fontColor($r("app.color.text_subtitle"));

        SpaceVerticalSmall();

        // 图标网格 - 使用 Grid + LazyForEach 懒加载
        Grid() {
          LazyForEach(this.vm.iconDataSource, (iconName: string) => {
            GridItem() {
              Column() {
                TnIcon({ name: iconName, iconSize: 28 });

                Text(iconName)
                  .fontSize($r("app.float.body_medium"))
                  .fontColor($r("app.color.text_subtitle"))
                  .textAlign(TextAlign.Center)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .margin({ top: 4 });
              }
              .width(P100)
              .alignItems(HorizontalAlign.Center)
              .padding({ top: 8, bottom: 8 })
              .onClick(() => {
                promptAction.showToast({ message: iconName });
              });
            }
          }, (iconName: string) => iconName);
        }
        .columnsTemplate("1fr 1fr 1fr 1fr 1fr")
        .rowsGap(4)
        .width(P100)
        .height(400);
      };
    }
    .width(P100)
    .padding($r("app.float.space_padding_medium"))
    .backgroundColor($r("app.color.bg_white"))
    .borderRadius($r("app.float.radius_medium"));
  }
}
