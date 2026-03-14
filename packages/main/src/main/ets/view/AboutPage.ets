/**
 * @file 关于页面视图
 * @author JunBin.Yang
 */
import {
  TnList, TnListItem, TnTag,
  TnUIGetUIBaseStyle, TnUIBaseStyleType,
  getFontSizeByKey,
  TnGradientBackground,
} from "@tuniao/tn-ui";
import { P100, size } from "@core/designsystem";
import { getWindowSafeAreaState, WindowSafeAreaState } from "@core/layoutstate";
import { AppNavDestination } from "@core/components";
import { AboutLinkItem } from "../models/AboutLinkItem";
import AboutViewModel from "../viewmodel/AboutViewModel";

@ComponentV2
export struct AboutPage {
  /** 关于页面 ViewModel */
  @Local private vm: AboutViewModel = new AboutViewModel();
  /** 窗口安全区状态 */
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();
  /** 基础样式 */
  @Local private baseStyle: TnUIBaseStyleType = TnUIGetUIBaseStyle();

  build() {
    AppNavDestination({
      title: $r("app.string.about"),
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.AboutContent();
    }
  }

  /** 关于页面内容 */
  @Builder
  private AboutContent() {
    Column() {
      Scroll() {
        Column({ space: this.baseStyle.spaceMd }) {
          this.AboutHeader();
          this.AboutInfoGroup();
          this.AboutFriendLinks();
        }
        .width(P100)
        .padding({
          left: this.baseStyle.space,
          right: this.baseStyle.space,
          top: this.baseStyle.spaceLg,
          bottom: this.baseStyle.spaceMd,
        })
      }
      .layoutWeight(1)
      .align(Alignment.Top)

      this.AboutFooter();
    }
    .width(P100)
    .height("100%")
  }

  /** 头部：Logo + 名称 + 描述 + 版本标签 */
  @Builder
  private AboutHeader() {
    Column({ space: this.baseStyle.spaceXsm }) {
      Image($r("app.media.logo_tuniao_bugou"))
        //.attributeModifier(size(150))
        .width(250)
        .objectFit(ImageFit.Contain)
      /*
      Text($r("app.string.app_name"))
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXXl"))
        .fontColor($r("app.color.tn_text_color_primary"))
        .fontWeight(FontWeight.Bold)
      */
      Text($r("app.string.main_about_desc"))
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXXl"))
        .fontWeight(FontWeight.Bold)
        .shaderStyle(new LinearGradientStyle(TnGradientBackground("indigo")))
      /*
      Text($r("app.string.main_about_desc"))
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
        .fontColor($r("app.color.tn_text_color_secondary"))
        .textAlign(TextAlign.Center)
        .lineHeight(this.baseStyle.lineHeightXsm)
        */
    }
    .width(P100)
    .padding({
      top: this.baseStyle.spaceXl,
      bottom: this.baseStyle.spaceLg,
    })
    .alignItems(HorizontalAlign.Center)
  }

  /** 项目信息分组列表 */
  @Builder
  private AboutInfoGroup() {
    TnList({
      title: $r("app.string.main_about_group_info"),
      card: true,
    }) {
      TnListItem({
        bottomBorder: true,
      }) {
        Row() {
          Text($r("app.string.component_current_version"))
            .fontSize(getFontSizeByKey(this.baseStyle, "fontSize"))
            .fontColor($r("app.color.tn_text_color_primary"))
            .lineHeight(this.baseStyle.lineHeightSm)
            .layoutWeight(1)
          TnTag({
            text: `v${this.vm.tnVersion}`,
            type: "primary",
            tagSize: "sm",
          })
        }
        .width("100%")
        .alignItems(VerticalAlign.Center)
      }
      ForEach(this.vm.infoLinks, (item: AboutLinkItem, index: number) => {
        TnListItem({
          title: item.title,
          rightIcon: "right",
          clickable: true,
          bottomBorder: index !== this.vm.infoLinks.length - 1,
          onItemClick: () => this.vm.openUrl(item.url),
        })
      }, (_item: AboutLinkItem, index: number) => `info_${index}`)
    }
  }

  /** 友情链接分组列表 */
  @Builder
  private AboutFriendLinks() {
    TnList({
      title: $r("app.string.main_about_group_links"),
      card: true,
    }) {
      ForEach(this.vm.friendLinks, (item: AboutLinkItem, index: number) => {
        TnListItem({
          title: item.title,
          description: item.description,
          rightIcon: "right",
          clickable: true,
          bottomBorder: index !== this.vm.friendLinks.length - 1,
          onItemClick: () => this.vm.openUrl(item.url),
        })
      }, (_item: AboutLinkItem, index: number) => `friend_${index}`)
    }
  }

  /** 底部版权信息 */
  @Builder
  private AboutFooter() {
    Column({ space: this.baseStyle.spaceBase }) {
      Text($r("app.string.main_about_copyright"))
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
        .fontColor($r("app.color.tn_text_color_placeholder"))
        .lineHeight(this.baseStyle.lineHeightXs)
    }
    .width(P100)
    .padding({
      top: this.baseStyle.spaceXsm,
      bottom: this.baseStyle.spaceMd,
    })
    .alignItems(HorizontalAlign.Center)
  }
}
