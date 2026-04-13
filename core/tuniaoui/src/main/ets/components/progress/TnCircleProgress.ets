/**
 * @file TnCircleProgress 圆形进度条组件
 * @description 圆形进度条，使用 ArkUI Circle + strokeDashArray 实现，支持主题色、圆环宽度、半径配置等
 * @author JunBin.Yang
 */

import { AppStorageV2, matrix4 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { TnComponentColorType, getThemeColor, THEME_COLOR_NAMES, getFontSizeByKey } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { getSizeByUnit } from "../../utils/Utils";

/**
 * strokeDashArray 动画辅助类
 */
class DashPoint {
  x: number;
  y: number;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }

  plus(rhs: DashPoint): DashPoint {
    return new DashPoint(this.x + rhs.x, this.y + rhs.y);
  }

  subtract(rhs: DashPoint): DashPoint {
    return new DashPoint(this.x - rhs.x, this.y - rhs.y);
  }

  multiply(scale: number): DashPoint {
    return new DashPoint(this.x * scale, this.y * scale);
  }

  equals(rhs: DashPoint): boolean {
    return this.x === rhs.x && this.y === rhs.y;
  }
}

/**
 * 扩展 Circle 的 strokeDashArray 以支持动画插值
 */
@AnimatableExtend(Circle) function animatableDashArray(point: DashPoint) {
  .strokeDashArray([point.x, point.y])
}

/**
 * TnCircleProgress 圆形进度条组件
 *
 * @example
 * // 基础用法
 * TnCircleProgress({ percent: 50 })
 *
 * // 自定义半径和圆环宽度
 * TnCircleProgress({ percent: 70, radius: 80, ringWidth: 10 })
 */
@ComponentV2
export struct TnCircleProgress {
  /**
   * 全局基础样式
   */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  /** 当前进度百分比，0-100 */
  @Param percent: number = 0;
  /** 激活时的颜色（主题色名或自定义颜色值） */
  @Param activeColor: string = "";
  /** 未激活时的颜色 */
  @Param inactiveColor: string = "";
  /** 是否显示进度文字 */
  @Param showPercent: boolean = true;
  /** 圆的半径(vp) */
  @Param radius: number = 50;
  /** 圆环宽度(vp) */
  @Param ringWidth: number = 6;
  /** 动画执行时间(ms)，0 表示使用主题默认值 */
  @Param duration: number = 0;
  /** 格式化进度文本函数 */
  @Param format: ((percent: number) => string) | null = null;
  /** 进度到达 100 时的回调 */
  @Event onComplete: () => void = () => {};

  /** 圆周长 */
  @Local private maxPerimeter: number = 0;
  /** 进度弧线是否可见 */
  @Local private isShow: boolean = false;
  /** strokeDashArray 动画目标值 */
  @Local private strokeDashArray: DashPoint = new DashPoint(0, 0);

  aboutToAppear(): void {
    this.maxPerimeter = Math.PI * (this.radius * 2 - this.ringWidth);
    this.isShow = this.getSafePercent() > 0;
    this.updateDashArray();
  }

  /**
   * 获取安全的进度值（限制在 0-100）
   * @returns 规范化后的进度值
   */
  private getSafePercent(): number {
    return Math.min(100, Math.max(0, this.percent));
  }

  /**
   * 获取激活色（返回 ResourceColor，由 ArkUI 框架解析）
   * @returns 激活颜色值
   */
  private getActiveColor(): ResourceColor {
    if (this.activeColor.length > 0) {
      if (THEME_COLOR_NAMES.includes(this.activeColor)) {
        return getThemeColor(this.baseStyle, this.activeColor as TnComponentColorType);
      }
      return this.activeColor;
    }
    return getThemeColor(this.baseStyle, "primary");
  }

  /**
   * 获取未激活色
   * @returns 未激活颜色值
   */
  private getInactiveColor(): ResourceColor {
    if (this.inactiveColor.length > 0) {
      return this.inactiveColor;
    }
    return $r("app.color.tn_color_gray_disabled");
  }

  /**
   * 获取进度文本
   * @returns 格式化后的进度文本
   */
  private getText(): string {
    const safePercent: number = this.getSafePercent();
    if (this.format !== null) {
      return this.format(safePercent);
    }
    return `${safePercent}%`;
  }

  /**
   * 获取 Circle 组件的直径（= radius * 2 - ringWidth）
   * @returns Circle 组件的宽高
   */
  private getCircleSize(): number {
    return this.radius * 2 - this.ringWidth;
  }

  /**
   * 获取容器尺寸
   * @returns 容器宽高
   */
  private getContainerSize(): number {
    return this.radius * 2;
  }

  /**
   * 更新 strokeDashArray 值以反映当前进度
   */
  private updateDashArray(): void {
    const safePercent: number = this.getSafePercent();
    const dashLength: number = safePercent > 0 ? (this.maxPerimeter * safePercent) / 100 : 0.01;
    this.strokeDashArray = new DashPoint(dashLength, this.maxPerimeter);
  }

  /**
   * 获取旋转矩阵，使进度从顶部（12 点钟方向）开始
   * @returns 旋转变换矩阵
   */
  private getTransformMatrix(): matrix4.Matrix4Transit {
    const m: matrix4.Matrix4Transit = matrix4.identity();
    return m.rotate({ z: 1, angle: -90 });
  }

  @Monitor("percent")
  onPercentChange(): void {
    if (this.getSafePercent() > 0) {
      this.isShow = true;
    }
    this.updateDashArray();
    if (this.getSafePercent() >= 100) {
      this.onComplete();
    }
  }

  @Monitor("radius", "ringWidth")
  onRingSizeChange(): void {
    this.maxPerimeter = Math.PI * (this.radius * 2 - this.ringWidth);
    this.updateDashArray();
  }

  build() {
    Row() {
      // 背景圆环
      Circle({ width: this.getCircleSize(), height: this.getCircleSize() })
        .fill("transparent")
        .strokeWidth(this.ringWidth)
        .stroke(this.getInactiveColor())
        .strokeLineCap(LineCapStyle.Round)
        .position({ left: this.ringWidth / 2, top: this.ringWidth / 2 });

      // 进度圆环
      Circle({ width: this.getCircleSize(), height: this.getCircleSize() })
        .fill("transparent")
        .strokeWidth(this.ringWidth)
        .stroke(this.getActiveColor())
        .strokeLineCap(LineCapStyle.Round)
        .position({ left: this.ringWidth / 2, top: this.ringWidth / 2 })
        .animatableDashArray(this.strokeDashArray)
        .animation({
          duration: this.duration > 0 ? this.duration : this.baseStyle.animationDuration,
          onFinish: () => {
            this.isShow = this.getSafePercent() > 0;
          }
        })
        .transform(this.getTransformMatrix())
        .visibility(this.isShow ? Visibility.Visible : Visibility.Hidden);

      // 进度文字
      if (this.showPercent) {
        Text(this.getText())
          .width("100%")
          .textAlign(TextAlign.Center)
          .fontSize(getFontSizeByKey(this.baseStyle, this.radius >= 50 ? "fontSizeLg" : "fontSizeSm"))
          .fontColor($r("app.color.tn_text_color_primary"))
          .fontWeight(FontWeight.Bold)
          .padding({ left: this.ringWidth, right: this.ringWidth })
          .position({ left: 0, top: "50%" })
          .translate({ y: "-50%" });
      }
    }
    .width(getSizeByUnit(this.getContainerSize()))
    .aspectRatio(1);
  }
}
