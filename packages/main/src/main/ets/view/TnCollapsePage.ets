/**
 * @file TnCollapse 折叠面板展示页面视图
 * @author JunBin.Yang
 */

import { AppNavDestination } from "@core/components";
import {
  MediumPaddingVerticalScroll,
  P100,
  SpaceVerticalLarge,
  SpaceVerticalMedium
} from "@core/designsystem";
import { getWindowSafeAreaState, WindowSafeAreaState } from "@core/layoutstate";
import { TnCollapse, TnCollapseItem, TnIcon, getThemeColor, TnUIBaseStyle, TnUIBaseStyleType, getFontSizeByKey } from "@tuniao/tn-ui";
import { TnAppStorageKey } from "@tuniao/tn-ui/src/main/ets/common/storage_key";
import { AppStorageV2 } from "@kit.ArkUI";
import TnCollapseViewModel from "../viewmodel/TnCollapseViewModel";

/**
 * TnCollapse 折叠面板展示页面
 */
@ComponentV2
export struct TnCollapsePage {
  /**
   * 折叠面板展示页面 ViewModel
   */
  @Local
  private vm: TnCollapseViewModel = new TnCollapseViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();
  /**
   * 全局基础样式
   */
  @Local
  private baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  build() {
    AppNavDestination({
      title: "折叠面板",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.CollapseContent();
    }
  }

  /**
   * 折叠面板内容视图
   */
  @Builder
  private CollapseContent(): void {
    MediumPaddingVerticalScroll() {
      Column() {
        // 1. 基础用法（手风琴模式）
        this.SectionTitle("基础用法");
        this.SectionDesc("默认手风琴模式，同时只展开一个面板");
        SpaceVerticalMedium();
        TnCollapse({
          groupId: "basic",
          value: this.vm.accordionValue,
          $value: (val: number | number[]) => { this.vm.accordionValue = val as number; }
        }) {
          TnCollapseItem({ groupId: "basic", name: 0, title: "标题一" }) {
            Text("这是第一个面板的内容。折叠面板可以将较长的内容区域进行折叠/展开操作。")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
              .fontColor($r("app.color.tn_text_color_secondary"))
              .lineHeight(this.baseStyle.lineHeightXsm);
          }
          TnCollapseItem({ groupId: "basic", name: 1, title: "标题二" }) {
            Text("这是第二个面板的内容。手风琴模式下，展开当前面板会自动关闭其他面板。")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
              .fontColor($r("app.color.tn_text_color_secondary"))
              .lineHeight(this.baseStyle.lineHeightXsm);
          }
          TnCollapseItem({ groupId: "basic", name: 2, title: "标题三" }) {
            Text("这是第三个面板的内容。可以通过 value 属性控制默认展开的面板。")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
              .fontColor($r("app.color.tn_text_color_secondary"))
              .lineHeight(this.baseStyle.lineHeightXsm);
          }
        }

        SpaceVerticalLarge();

        // 2. 多面板同时展开
        this.SectionTitle("多面板展开");
        this.SectionDesc("关闭手风琴模式，允许同时展开多个面板");
        SpaceVerticalMedium();
        TnCollapse({
          groupId: "multiple",
          value: this.vm.multipleValue,
          accordion: false,
          $value: (val: number | number[]) => { this.vm.multipleValue = val as number[]; }
        }) {
          TnCollapseItem({ groupId: "multiple", name: 0, title: "标题一" }) {
            Text("第一个面板的内容，可以与其他面板同时展开。")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
              .fontColor($r("app.color.tn_text_color_secondary"))
              .lineHeight(this.baseStyle.lineHeightXsm);
          }
          TnCollapseItem({ groupId: "multiple", name: 1, title: "标题二" }) {
            Text("第二个面板的内容，设置 accordion 为 false 即可开启多选模式。")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
              .fontColor($r("app.color.tn_text_color_secondary"))
              .lineHeight(this.baseStyle.lineHeightXsm);
          }
          TnCollapseItem({ groupId: "multiple", name: 2, title: "标题三" }) {
            Text("第三个面板的内容，value 为数组类型。")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
              .fontColor($r("app.color.tn_text_color_secondary"))
              .lineHeight(this.baseStyle.lineHeightXsm);
          }
        }

        SpaceVerticalLarge();

        // 3. 自定义箭头颜色
        this.SectionTitle("自定义箭头颜色");
        this.SectionDesc("通过 arrowColor 属性设置箭头颜色");
        SpaceVerticalMedium();
        TnCollapse({
          groupId: "arrowColor",
          value: this.vm.arrowColorValue,
          arrowColor: getThemeColor(this.baseStyle, "primary"),
          $value: (val: number | number[]) => { this.vm.arrowColorValue = val as number; }
        }) {
          TnCollapseItem({ groupId: "arrowColor", name: 0, title: "主题色箭头" }) {
            Text("箭头使用了主题色。")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
              .fontColor($r("app.color.tn_text_color_secondary"))
              .lineHeight(this.baseStyle.lineHeightXsm);
          }
          TnCollapseItem({ groupId: "arrowColor", name: 1, title: "主题色箭头" }) {
            Text("所有面板的箭头颜色统一设置。")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
              .fontColor($r("app.color.tn_text_color_secondary"))
              .lineHeight(this.baseStyle.lineHeightXsm);
          }
        }

        SpaceVerticalLarge();

        // 4. 隐藏箭头
        this.SectionTitle("隐藏箭头");
        this.SectionDesc("设置 showArrow 为 false 隐藏箭头图标");
        SpaceVerticalMedium();
        TnCollapse({
          groupId: "hideArrow",
          value: this.vm.hideArrowValue,
          showArrow: false,
          $value: (val: number | number[]) => { this.vm.hideArrowValue = val as number; }
        }) {
          TnCollapseItem({ groupId: "hideArrow", name: 0, title: "无箭头面板一" }) {
            Text("隐藏箭头后，用户可以通过点击标题区域展开/收起。")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
              .fontColor($r("app.color.tn_text_color_secondary"))
              .lineHeight(this.baseStyle.lineHeightXsm);
          }
          TnCollapseItem({ groupId: "hideArrow", name: 1, title: "无箭头面板二" }) {
            Text("适用于不需要箭头指示的简洁场景。")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
              .fontColor($r("app.color.tn_text_color_secondary"))
              .lineHeight(this.baseStyle.lineHeightXsm);
          }
        }

        SpaceVerticalLarge();

        // 5. 禁用面板
        this.SectionTitle("禁用面板");
        this.SectionDesc("通过 disabled 属性禁用某个面板的展开/收起");
        SpaceVerticalMedium();
        TnCollapse({
          groupId: "disabled",
          value: this.vm.disabledValue,
          $value: (val: number | number[]) => { this.vm.disabledValue = val as number; }
        }) {
          TnCollapseItem({ groupId: "disabled", name: 0, title: "正常面板" }) {
            Text("此面板可正常展开和收起。")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
              .fontColor($r("app.color.tn_text_color_secondary"))
              .lineHeight(this.baseStyle.lineHeightXsm);
          }
          TnCollapseItem({ groupId: "disabled", name: 1, title: "禁用面板", disabled: true }) {
            Text("此面板被禁用，无法点击展开。")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
              .fontColor($r("app.color.tn_text_color_secondary"))
              .lineHeight(this.baseStyle.lineHeightXsm);
          }
          TnCollapseItem({ groupId: "disabled", name: 2, title: "正常面板" }) {
            Text("此面板可正常展开和收起。")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
              .fontColor($r("app.color.tn_text_color_secondary"))
              .lineHeight(this.baseStyle.lineHeightXsm);
          }
        }

        SpaceVerticalLarge();

        // 6. 带图标标题
        this.SectionTitle("带图标标题");
        this.SectionDesc("通过 icon 和 iconColor 属性设置标题左侧图标");
        SpaceVerticalMedium();
        TnCollapse({
          groupId: "customTitle",
          value: this.vm.customTitleValue,
          $value: (val: number | number[]) => { this.vm.customTitleValue = val as number; }
        }) {
          TnCollapseItem({
            groupId: "customTitle",
            name: 0,
            title: "收藏夹",
            icon: "star-fill",
            iconColor: $r("app.color.tn_color_warning")
          }) {
            Text("标题左侧可以显示图标，支持自定义图标颜色。")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
              .fontColor($r("app.color.tn_text_color_secondary"))
              .lineHeight(this.baseStyle.lineHeightXsm);
          }
          TnCollapseItem({
            groupId: "customTitle",
            name: 1,
            title: "相册",
            icon: "photo",
            iconColor: getThemeColor(this.baseStyle, "primary")
          }) {
            Text("可以为每个面板设置不同的图标和颜色。")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
              .fontColor($r("app.color.tn_text_color_secondary"))
              .lineHeight(this.baseStyle.lineHeightXsm);
          }
        }

        SpaceVerticalLarge();

        // 7. 无边框
        this.SectionTitle("无边框模式");
        this.SectionDesc("设置 hasBorder 为 false 隐藏分割线");
        SpaceVerticalMedium();
        TnCollapse({
          groupId: "noBorder",
          value: this.vm.noBorderValue,
          hasBorder: false,
          $value: (val: number | number[]) => { this.vm.noBorderValue = val as number; }
        }) {
          TnCollapseItem({ groupId: "noBorder", name: 0, title: "无边框面板一" }) {
            Text("隐藏分割线后呈现更加简洁的外观。")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
              .fontColor($r("app.color.tn_text_color_secondary"))
              .lineHeight(this.baseStyle.lineHeightXsm);
          }
          TnCollapseItem({ groupId: "noBorder", name: 1, title: "无边框面板二" }) {
            Text("适用于需要紧凑布局的场景。")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
              .fontColor($r("app.color.tn_text_color_secondary"))
              .lineHeight(this.baseStyle.lineHeightXsm);
          }
          TnCollapseItem({ groupId: "noBorder", name: 2, title: "无边框面板三" }) {
            Text("面板之间没有分割线。")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
              .fontColor($r("app.color.tn_text_color_secondary"))
              .lineHeight(this.baseStyle.lineHeightXsm);
          }
        }

        SpaceVerticalLarge();

        // 8. 自定义内容
        this.SectionTitle("自定义内容");
        this.SectionDesc("面板内容区域可以放置任意组件");
        SpaceVerticalMedium();
        TnCollapse({
          groupId: "customContent",
          value: this.vm.customContentValue,
          accordion: false,
          $value: (val: number | number[]) => { this.vm.customContentValue = val as number[]; }
        }) {
          TnCollapseItem({ groupId: "customContent", name: 0, title: "图标列表" }) {
            Column({ space: this.baseStyle.spaceXsm }) {
              this.IconRow("home", "首页");
              this.IconRow("my", "个人中心");
              this.IconRow("setting", "系统设置");
            }
            .width(P100)
          }
          TnCollapseItem({ groupId: "customContent", name: 1, title: "图片展示" }) {
            Row({ space: this.baseStyle.spaceXsm }) {
              ForEach([1, 2, 3], (item: number) => {
                Column()
                  .width(80)
                  .height(80)
                  .borderRadius(this.baseStyle.borderRadiusLg)
                  .backgroundColor($r("app.color.tn_color_gray_disabled"))
              })
            }
          }
        }

        SpaceVerticalLarge();

        // 9. 事件回调
        this.SectionTitle("事件回调");
        this.SectionDesc("通过 onChange 监听展开/收起事件");
        SpaceVerticalMedium();
        if (this.vm.changeLog.length > 0) {
          Text(this.vm.changeLog)
            .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
            .fontColor(getThemeColor(this.baseStyle, "primary"))
            .padding({
              left: this.baseStyle.space,
              right: this.baseStyle.space,
              top: this.baseStyle.spaceXsm,
              bottom: this.baseStyle.spaceXsm
            });
        }
        TnCollapse({
          groupId: "event",
          value: this.vm.eventValue,
          $value: (val: number | number[]) => { this.vm.eventValue = val as number; },
          onChange: (val: number | number[]) => { this.vm.handleChange(val); }
        }) {
          TnCollapseItem({ groupId: "event", name: 0, title: "面板一" }) {
            Text("点击标题区域可以触发 onChange 回调。")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
              .fontColor($r("app.color.tn_text_color_secondary"))
              .lineHeight(this.baseStyle.lineHeightXsm);
          }
          TnCollapseItem({ groupId: "event", name: 1, title: "面板二" }) {
            Text("onChange 回调返回当前展开面板的标识。")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
              .fontColor($r("app.color.tn_text_color_secondary"))
              .lineHeight(this.baseStyle.lineHeightXsm);
          }
          TnCollapseItem({ groupId: "event", name: 2, title: "面板三" }) {
            Text("手风琴模式返回 number，多选模式返回 number[]。")
              .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
              .fontColor($r("app.color.tn_text_color_secondary"))
              .lineHeight(this.baseStyle.lineHeightXsm);
          }
        }
      }
      .width(P100);
    };
  }

  /**
   * 区域标题
   */
  @Builder
  private SectionTitle(title: string): void {
    Text(title)
      .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeLg"))
      .fontColor($r("app.color.tn_text_color_primary"))
      .fontWeight(FontWeight.Bold)
      .width(P100)
      .padding({ left: this.baseStyle.space, right: this.baseStyle.space });
  }

  /**
   * 区域描述
   */
  @Builder
  private SectionDesc(desc: string): void {
    Text(desc)
      .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeXs"))
      .fontColor($r("app.color.tn_text_color_secondary"))
      .width(P100)
      .padding({ left: this.baseStyle.space, right: this.baseStyle.space })
      .margin({ top: this.baseStyle.spaceBase });
  }

  /**
   * 图标行
   */
  @Builder
  private IconRow(iconName: string, label: string): void {
    Row({ space: this.baseStyle.spaceXsm }) {
      TnIcon({ name: iconName, iconSize: getFontSizeByKey(this.baseStyle, "fontSizeXl"), color: getThemeColor(this.baseStyle, "primary") });
      Text(label)
        .fontSize(getFontSizeByKey(this.baseStyle, "fontSizeSm"))
        .fontColor($r("app.color.tn_text_color_primary"));
    }
    .width(P100)
    .padding({ top: this.baseStyle.spaceBase, bottom: this.baseStyle.spaceBase });
  }
}
