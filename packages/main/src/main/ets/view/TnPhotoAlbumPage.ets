/**
 * @file TnPhotoAlbum 相册展示页面视图
 * @description 展示相册组件的各种用法，包括基础、列数变化、最大数量限制、图片模式、圆角、间距等
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
  TnPhotoAlbum,
  TnToast,
  TnUIBaseStyleType,
  TnUIBaseStyle
} from "@tuniao/tn-ui";
import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "@tuniao/tn-ui/src/main/ets/common/storage_key";
import TnPhotoAlbumViewModel from "../viewmodel/TnPhotoAlbumViewModel";

@ComponentV2
export struct TnPhotoAlbumPage {
  @Local private vm: TnPhotoAlbumViewModel = new TnPhotoAlbumViewModel();
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();
  @Local private baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  build() {
    AppNavDestination({
      title: "相册",
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
        this.SectionDesc("通过 data 传递图片地址数组，默认 3 列显示");
        SpaceVerticalMedium();
        Column() {
          TnPhotoAlbum({
            data: this.vm.allImages,
            onImageClick: (index: number) => {
              TnToast.show(`点击了第 ${index + 1} 张图片`);
            }
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 修改列数
        this.SectionTitle("修改列数");
        this.SectionDesc("通过 column 属性修改一行显示图片的数量");
        SpaceVerticalMedium();

        // 2列
        this.SubSectionTitle("2列显示");
        SpaceVerticalMedium();
        Column() {
          TnPhotoAlbum({
            data: this.vm.mediumImages.slice(0, 2),
            column: 2
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalMedium();

        // 4列
        this.SubSectionTitle("4列显示");
        SpaceVerticalMedium();
        Column() {
          TnPhotoAlbum({
            data: this.vm.allImages,
            column: 4
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalMedium();

        // 5列
        this.SubSectionTitle("5列显示");
        SpaceVerticalMedium();
        Column() {
          TnPhotoAlbum({
            data: this.vm.allImages,
            column: 5,
            max: 10
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 最大显示数量
        this.SectionTitle("最大显示数量");
        this.SectionDesc("通过 max 属性限制最大显示图片数量");
        SpaceVerticalMedium();

        this.SubSectionTitle("最多显示 4 张");
        SpaceVerticalMedium();
        Column() {
          TnPhotoAlbum({
            data: this.vm.allImages,
            max: 4
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalMedium();

        this.SubSectionTitle("最多显示 6 张");
        SpaceVerticalMedium();
        Column() {
          TnPhotoAlbum({
            data: this.vm.allImages,
            max: 6
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 图片模式
        this.SectionTitle("图片显示模式");
        this.SectionDesc("通过 imgMode 修改图片的显示模式");
        SpaceVerticalMedium();

        this.SubSectionTitle("contain 模式（完整显示）");
        SpaceVerticalMedium();
        Column() {
          TnPhotoAlbum({
            data: this.vm.fewImages,
            imgMode: "contain"
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalMedium();

        this.SubSectionTitle("fill 模式（拉伸填充）");
        SpaceVerticalMedium();
        Column() {
          TnPhotoAlbum({
            data: this.vm.fewImages,
            imgMode: "fill"
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 自定义圆角
        this.SectionTitle("自定义圆角");
        this.SectionDesc("通过 imgBorderRadius 修改图片的圆角大小");
        SpaceVerticalMedium();

        this.SubSectionTitle("大圆角");
        SpaceVerticalMedium();
        Column() {
          TnPhotoAlbum({
            data: this.vm.mediumImages,
            imgBorderRadius: this.baseStyle.borderRadiusLg
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalMedium();

        this.SubSectionTitle("圆形");
        SpaceVerticalMedium();
        Column() {
          TnPhotoAlbum({
            data: this.vm.fewImages,
            imgBorderRadius: this.baseStyle.borderRadiusMax
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 自定义间距
        this.SectionTitle("自定义间距");
        this.SectionDesc("通过 gap 属性修改图片之间的间距");
        SpaceVerticalMedium();

        this.SubSectionTitle("间距 2vp");
        SpaceVerticalMedium();
        Column() {
          TnPhotoAlbum({
            data: this.vm.mediumImages,
            gap: 2
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalMedium();

        this.SubSectionTitle("间距 16vp");
        SpaceVerticalMedium();
        Column() {
          TnPhotoAlbum({
            data: this.vm.mediumImages,
            gap: 16
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 禁用预览
        this.SectionTitle("禁用预览");
        this.SectionDesc("设置 preview 为 false 禁用点击预览功能");
        SpaceVerticalMedium();
        Column() {
          TnPhotoAlbum({
            data: this.vm.fewImages,
            preview: false,
            onImageClick: (index: number) => {
              TnToast.show(`点击了第 ${index + 1} 张，已禁用预览`);
            }
          });
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 少量图片
        this.SectionTitle("少量图片");
        this.SectionDesc("只有 1-2 张图片时的显示效果");
        SpaceVerticalMedium();
        Column() {
          TnPhotoAlbum({
            data: this.vm.allImages.slice(0, 1)
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

  /**
   * 章节描述
   * @param desc 描述
   */
  @Builder private SectionDesc(desc: string): void {
    Text(desc)
      .fontSize($r("app.float.body_medium"))
      .fontColor($r("app.color.text_secondary"))
      .margin({ top: 4 });
  }

  /**
   * 子章节标题
   * @param title 标题
   */
  @Builder private SubSectionTitle(title: string): void {
    Text(title)
      .fontSize($r("app.float.body_large"))
      .fontColor($r("app.color.text_primary"));
  }
}
