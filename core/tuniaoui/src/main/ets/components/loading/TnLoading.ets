/**
 * @file TnLoading 加载组件
 * @description 提供三种加载动画模式：圆圈（circle）、花瓣（flower）、半圆（semicircle）
 * @author JunBin.Yang
 */

import { AppStorageV2, curves } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { getThemeColor } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { getSizeByUnit } from "../../utils/Utils";
import {
  TnLoadingColorType,
  TnLoadingModeType,
  TnLoadingSizeConfig,
  TnLoadingSizeType
} from "./TnLoadingTypes";

/** 花瓣数量 */
const FLOWER_PETAL_COUNT: number = 12;

/** 花瓣单步旋转角度 */
const FLOWER_STEP_ANGLE: number = 360 / FLOWER_PETAL_COUNT;

/** 默认动画持续时间（毫秒） */
const DEFAULT_DURATION: number = 1000;

/** 半圆背景颜色 */
const SEMICIRCLE_BG_COLOR: ResourceColor = $r("app.color.tn_color_gray_disabled");

/**
 * 根据尺寸类型获取加载组件尺寸配置
 * @param size 尺寸类型
 * @returns 尺寸配置
 */
function getLoadingSizeConfig(size: TnLoadingSizeType | undefined): TnLoadingSizeConfig {
  switch (size) {
    case "sm":
      return {
        iconSize: 20,
        flowerBarWidth: 2,
        borderWidth: 2
      };
    case "lg":
      return {
        iconSize: 36,
        flowerBarWidth: 3,
        borderWidth: 4
      };
    case "xl":
      return {
        iconSize: 44,
        flowerBarWidth: 4,
        borderWidth: 5
      };
    default:
      return {
        iconSize: 28,
        flowerBarWidth: 3,
        borderWidth: 3
      };
  }
}

/**
 * TnLoading 加载组件
 *
 * @example
 * // 基础圆圈加载
 * TnLoading()
 *
 * // 花瓣模式
 * TnLoading({ mode: "flower" })
 *
 * // 半圆模式
 * TnLoading({ mode: "semicircle" })
 */
@ComponentV2
export struct TnLoading {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  /**
   * 是否显示加载动画
   */
  @Param show: boolean = true;

  /**
   * 加载动画模式
   */
  @Param mode: TnLoadingModeType = "circle";

  /**
   * 颜色类型
   */
  @Param type: TnLoadingColorType = "primary";

  /**
   * 自定义颜色（优先级高于 type）
   */
  @Param color: ResourceColor | undefined = undefined;

  /**
   * 加载图标尺寸类型
   */
  @Param loadingSize: TnLoadingSizeType | undefined = undefined;

  /**
   * 自定义尺寸数值（vp），优先级高于 loadingSize
   */
  @Param customSize: number | undefined = undefined;

  /**
   * 动画持续时间（毫秒）
   */
  @Param duration: number = DEFAULT_DURATION;

  /**
   * 动画缓动函数
   */
  @Param timingCurve: Curve = Curve.Linear;

  /**
   * 加载提示文字
   */
  @Param text: string = "";

  /**
   * 文字颜色
   */
  @Param textColor: ResourceColor | undefined = undefined;

  /**
   * 文字大小
   */
  @Param textSize: number | string | undefined = undefined;

  /**
   * 圆圈/半圆旋转角度（动画驱动）
   */
  @Local private rotateAngle: number = 0;

  /**
   * 花瓣索引数组
   */
  private flowerPetals: number[] = new Array(FLOWER_PETAL_COUNT).fill(1);

  /**
   * 获取当前尺寸配置
   * @returns 尺寸配置
   */
  private getSizeConfig(): TnLoadingSizeConfig {
    return getLoadingSizeConfig(this.loadingSize);
  }

  /**
   * 获取实际图标尺寸（vp）
   * @returns 图标尺寸
   */
  private getIconSize(): number {
    if (this.customSize !== undefined) {
      return this.customSize;
    }
    return this.getSizeConfig().iconSize;
  }

  /**
   * 获取解析后的颜色值
   * @returns 加载图标颜色
   */
  private getResolvedColor(): ResourceColor {
    if (this.color !== undefined) {
      return this.color;
    }
    return getThemeColor(this.baseStyle, this.type);
  }

  /**
   * 获取解析后的文字颜色
   * @returns 文字颜色
   */
  private getResolvedTextColor(): ResourceColor {
    if (this.textColor !== undefined) {
      return this.textColor;
    }
    return this.getResolvedColor();
  }

  /**
   * 获取解析后的文字大小
   * @returns 文字大小字符串
   */
  private getResolvedTextSize(): string {
    if (this.textSize !== undefined) {
      if (typeof this.textSize === "number") {
        return getSizeByUnit(this.textSize, true);
      }
      return this.textSize;
    }
    return this.baseStyle.fontSizeSm;
  }

  /**
   * 启动旋转动画
   */
  private startRotation(): void {
    this.rotateAngle = 360;
  }

  /**
   * 圆圈模式构建器
   * 使用 border 实现 1/4 圆弧旋转效果
   */
  @Builder
  private CircleBuilder(): void {
    Column() {
      // 颜色层：不附加 animation，主题切换时颜色即时变化
      Column()
        .width("100%")
        .height("100%")
        .borderRadius("50%")
        .borderWidth(this.getSizeConfig().borderWidth)
        .borderColor({
          top: this.getResolvedColor(),
          right: Color.Transparent,
          bottom: Color.Transparent,
          left: Color.Transparent
        });
    }
    .width(this.getIconSize())
    .height(this.getIconSize())
    .rotate({ angle: this.rotateAngle })
    .animation({
      duration: this.duration,
      iterations: -1,
      curve: this.timingCurve,
      playMode: PlayMode.Normal
    })
    .onAppear(() => {
      this.startRotation();
    });
  }

  /**
   * 花瓣模式构建器
   * 12 条花瓣围绕中心排列，使用步进动画旋转
   */
  @Builder
  private FlowerBuilder(): void {
    Column() {
      ForEach(this.flowerPetals, (petalVal: number, index: number) => {
        Column() {
          Column()
            .width(this.getSizeConfig().flowerBarWidth)
            .height("25%")
            .borderRadius(this.baseStyle.borderRadiusSm)
            .backgroundColor(this.getResolvedColor());
        }
        .width("100%")
        .height("100%")
        .position({ x: 0, y: 0 })
        .rotate({
          angle: (index + 1) * FLOWER_STEP_ANGLE
        })
        .opacity(1 - index * (1 / FLOWER_PETAL_COUNT));
      });
    }
    .width(this.getIconSize())
    .height(this.getIconSize())
    .rotate({ angle: this.rotateAngle })
    .animation({
      duration: this.duration,
      iterations: -1,
      curve: curves.stepsCurve(FLOWER_PETAL_COUNT, true),
      playMode: PlayMode.Normal
    })
    .onAppear(() => {
      this.startRotation();
    });
  }

  /**
   * 半圆模式构建器
   * 浅灰色半圆背景 + 彩色 1/4 弧旋转叠加
   */
  @Builder
  private SemicircleBuilder(): void {
    Stack() {
      // 底层：半圆灰色背景
      Column()
        .width(this.getIconSize())
        .height(this.getIconSize())
        .borderRadius("50%")
        .borderWidth(this.getSizeConfig().borderWidth)
        .borderColor(SEMICIRCLE_BG_COLOR);

      // 上层：旋转容器，animation 仅作用于 rotate
      Column() {
        // 颜色层：不附加 animation，主题切换时颜色即时变化
        Column()
          .width("100%")
          .height("100%")
          .borderRadius("50%")
          .borderWidth(this.getSizeConfig().borderWidth)
          .borderColor({
            top: this.getResolvedColor(),
            right: Color.Transparent,
            bottom: Color.Transparent,
            left: Color.Transparent
          });
      }
      .width(this.getIconSize())
      .height(this.getIconSize())
      .rotate({ angle: this.rotateAngle })
      .animation({
        duration: this.duration,
        iterations: -1,
        curve: this.timingCurve,
        playMode: PlayMode.Normal
      })
      .onAppear(() => {
        this.startRotation();
      });
    };
  }

  /**
   * 加载图标内容构建器
   */
  @Builder
  private LoadingIcon(): void {
    if (this.mode === "flower") {
      this.FlowerBuilder();
    } else if (this.mode === "semicircle") {
      this.SemicircleBuilder();
    } else {
      this.CircleBuilder();
    }
  }

  /**
   * 构建加载组件
   */
  build() {
    Column({ space: this.baseStyle.spaceXs }) {
      this.LoadingIcon();

      if (this.text.length > 0) {
        Text(this.text)
          .fontSize(this.getResolvedTextSize())
          .fontColor(this.getResolvedTextColor())
          .lineHeight(this.baseStyle.lineHeightXsm);
      }
    }
    .visibility(this.show ? Visibility.Visible : Visibility.None)
    .alignItems(HorizontalAlign.Center);
  }
}
