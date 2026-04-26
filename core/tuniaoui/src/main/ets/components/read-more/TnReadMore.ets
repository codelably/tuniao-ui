/**
 * @file TnReadMore 阅读更多组件
 * @description 用于收起长文本内容，点击展开全文；也可用于付费内容场景
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { getThemeColor, TnComponentColorType } from "../../common/theme_helpers";
import { getHexColorByResoure, mixWithBlack } from "../../utils/ColorUtils";
import { TnBaseDataTypeObs } from "../../common/types";
import { convertDimensionsWidthUnit } from "../../utils/Utils";
import { TnIcon } from "../icon/TnIcon";
import { TnReadMoreBeforeExpand } from "./TnReadMoreTypes";

@ComponentV2
export struct TnReadMore {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
  @Local colorMode: TnBaseDataTypeObs = AppStorageV2.connect(TnBaseDataTypeObs, TnAppStorageKey.COLOR_MODE,
    () => new TnBaseDataTypeObs(0))!;
  /**
   * 是否展开
   */
  @Param expand: boolean = false;
  /**
   * 收起时显示内容的高度，单位 vp
   */
  @Param collapseHeight: number = 125;
  /**
   * 是否显示收起按钮
   */
  @Param showFold: boolean = true;
  /**
   * 展开时操作文案
   */
  @Param expandText: string = "展开阅读全文";
  /**
   * 展开时显示的图标名称
   */
  @Param expandIcon: string = "down";
  /**
   * 收起时操作文案
   */
  @Param foldText: string = "收起";
  /**
   * 收起时显示的图标名称
   */
  @Param foldIcon: string = "up";
  /**
   * 操作区域文字颜色（不设置则使用主题色）
   */
  @Param tipColor: ResourceColor = "";
  /**
   * 主题颜色类型（不设置 tipColor 时生效）
   */
  @Param colorType: TnComponentColorType = "primary";
  /**
   * 动画时长，单位 ms
   */
  @Param duration: number = 0;
  /**
   * 是否一次性展开（展开后不再显示收起按钮）
   */
  @Param once: boolean = false;
  /**
   * 展开前回调
   */
  @Param beforeExpand: TnReadMoreBeforeExpand | undefined = undefined;
  /**
   * 展开时触发
   */
  @Event onExpand: () => void = () => {};
  /**
   * 收起时触发
   */
  @Event onFold: () => void = () => {};
  /**
   * 展开状态双向绑定
   */
  @Event $expand: (value: boolean) => void = () => {};
  /**
   * 默认内容插槽
   */
  @BuilderParam defaultBuilder: CustomBuilder;

  /**
   * 内容实际高度
   */
  @Local private contentHeight: number = 0;
  /**
   * 组件唯一标识
   */
  @Local private uniId: number = 0;
  /**
   * 高度测量完成标记
   */
  @Local private isReady: boolean = false;
  /**
   * 动画就绪标记（防止首次渲染时出现动画闪烁）
   */
  @Local private isAnimReady: boolean = false;

  private context: UIContext = this.getUIContext();

  aboutToAppear(): void {
    this.uniId = this.getUniqueId();
    setTimeout(() => {
      this.measureContentHeight();
    }, 50);
  }

  /**
   * 测量内容区域实际高度
   */
  private measureContentHeight(): void {
    let compUtils = this.context.getComponentUtils();
    let info = compUtils.getRectangleById(`tn_readmore_content_${this.uniId}`);
    let h = this.context.px2vp(info.size.height);
    if (h > 0) {
      this.contentHeight = h;
    }
    if (!this.isReady) {
      this.isReady = true;
      setTimeout(() => {
        this.isAnimReady = true;
      }, 50);
    }
  }

  /**
   * 获取遮罩渐变色数组
   * @returns 渐变色 stops
   */
  private getMaskGradientColors(): Array<[string, number]> {
    if (this.colorMode.value == 0) {
      let result: Array<[string, number]> = [["#000", 0], ["rgba(0,0,0,0)", 1]];
      return result;
    }
    let result: Array<[string, number]> =  [["#fff", 0], ["rgba(255, 255, 255, 0)", 1]];
    return result;
  }

  /**
   * 获取操作区域文字颜色
   * @returns 文字颜色
   */
  private getActionColor(): ResourceColor {
    if (this.tipColor) {
      return this.tipColor;
    }
    return getThemeColor(this.baseStyle, this.colorType);
  }

  /**
   * 获取实际动画时长（优先使用用户传入值，否则使用 baseStyle 默认值）
   * @returns 动画时长（ms）
   */
  private getAnimDuration(): number {
    return this.duration > 0 ? this.duration : this.baseStyle.animationDuration;
  }

  /**
   * 是否显示操作区域
   * @returns boolean
   */
  private isShowAction(): boolean {
    if (this.expand && this.once) {
      return false;
    }
    if (!this.expand) {
      return true;
    }
    return this.showFold;
  }

  /**
   * 切换展开/收起状态
   */
  private async toggleExpand(): Promise<void> {
    if (this.expand) {
      this.$expand(false);
      this.onFold();
    } else {
      if (this.beforeExpand) {
        let result = this.beforeExpand();
        if (result instanceof Promise) {
          let allowed: boolean = await result;
          if (!allowed) {
            return;
          }
        } else {
          if (!result) {
            return;
          }
        }
      }
      this.$expand(true);
      this.onExpand();
    }
  }

  /**
   * 重新测量内容高度（供外部在内容变更后调用）
   */
  public resetContentHeight(): void {
    setTimeout(() => {
      this.measureContentHeight();
    }, 50);
  }

  build() {
    Column({ space: this.baseStyle.spaceXs }) {
      Column() {
        Column() {
          if (this.defaultBuilder) {
            this.defaultBuilder();
          }
        }
        .width("100%")
        .alignItems(HorizontalAlign.Start)
        .id(`tn_readmore_content_${this.uniId}`)

        // 渐变遮罩（收起时显示）
        Row()
          .width("100%")
          .height(convertDimensionsWidthUnit(50))
          .position({ left: 0, bottom: 0 })
          .opacity(this.expand ? 0 : 1)
          .animation({
            duration: this.isAnimReady ? this.getAnimDuration() : 0
          })
          .linearGradient({
            direction: GradientDirection.Top,
            colors: this.getMaskGradientColors()
          })
      }
      .width("100%")
      .height(this.isReady ? (this.expand ? this.contentHeight : this.collapseHeight) : "auto")
      .clip(true)
      .animation({
        duration: this.isAnimReady ? this.getAnimDuration() : 0
      })

      // 操作区域
      if (this.isShowAction()) {
        Row({ space: this.baseStyle.spaceXs }) {
          Text(this.expand ? this.foldText : this.expandText)
            .fontColor(this.getActionColor())
            .fontSize(this.baseStyle.fontSize)
            .lineHeight(this.baseStyle.lineHeightSm)
          TnIcon({
            name: this.expand ? this.foldIcon : this.expandIcon,
            color: this.getActionColor(),
            iconSize: this.baseStyle.fontSize
          })
        }
        .width("100%")
        .justifyContent(FlexAlign.Center)
        .padding({
          top: this.baseStyle.spaceXs,
          bottom: this.baseStyle.spaceXs
        })
        .borderRadius(this.baseStyle.borderRadius)
        .onClick(() => {
          this.toggleExpand();
        })
        .stateStyles({
          normal: {
            .backgroundColor(Color.Transparent)
          },
          pressed: {
            .backgroundColor(mixWithBlack(getHexColorByResoure($r("app.color.tn_bg_color"))))
          }
        })
      }
    }
    .width("100%")
  }
}
