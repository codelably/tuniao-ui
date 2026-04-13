/**
 * @file TnCountScroll 数字滚动组件
 * @description 数字滚动组件，用于数字的变化展示，每位数字以垂直滚动动画切换
 * @author JunBin.Yang
 */

import { AppStorageV2 } from "@kit.ArkUI";
import { TnAppStorageKey } from "../../common/storage_key";
import { TnComponentColorType, getThemeColor, THEME_COLOR_NAMES, getFontSizeByKey } from "../../common/theme_helpers";
import { TnUIBaseStyle, TnUIBaseStyleType } from "../../theme-chalk/index.type";
import { getSizeByUnit } from "../../utils/Utils";

/** 默认数字列表 0-9 */
const DEFAULT_DIGITS: string[] = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

/** 等待 UI 布局完成后触发动画的延迟时间(ms) */
const ANIMATION_START_DELAY: number = 50;

/**
 * TnCountScroll 数字滚动组件
 *
 * @example
 * TnCountScroll({ value: "7865" })
 * TnCountScroll({ value: "7865.23", duration: 2000 })
 * TnCountScroll({ value: "123,456.78", textColor: "primary", fontSize: 24 })
 */
@ComponentV2
export struct TnCountScroll {
  /** 全局基础样式 */
  @Local baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  /** 显示的值 */
  @Param value: string = '';
  /** 文字颜色（主题色名或自定义颜色值） */
  @Param textColor: string = '';
  /** 字体大小(vp)，0 表示使用主题默认值 */
  @Param fontSize: number = 0;
  /** 字重 */
  @Param fontWeight: FontWeight = FontWeight.Normal;
  /** 小数点分隔符 */
  @Param decimalSeparator: string = '.';
  /** 千分位分隔符，空字符串表示不使用千分位 */
  @Param thousandsSeparator: string = ',';
  /** 动画执行时间（毫秒） */
  @Param duration: number = 1500;

  /** 解析后的字符列表 */
  @Local private chars: string[] = [];
  /** 每个字符对应的目标数字索引（分隔符为 -1） */
  @Local private targetIndices: number[] = [];
  /** 单个数字的实际像素高度（由 onAreaChange 测量） */
  @Local private textHeight: number = 0;
  /** 是否已触发初始动画 */
  private started: boolean = false;

  aboutToAppear(): void {
    this.parseValue();
  }

  @Monitor("value")
  onValueChange(): void {
    this.parseValue();
  }

  /**
   * 获取分隔符集合
   * @returns 当前生效的分隔符字符数组
   */
  private getSeparators(): string[] {
    const list: string[] = [];
    if (this.decimalSeparator.length > 0) {
      list.push(this.decimalSeparator);
    }
    if (this.thousandsSeparator.length > 0) {
      list.push(this.thousandsSeparator);
    }
    return list;
  }

  /**
   * 解析 value 为字符数组和目标索引
   */
  private parseValue(): void {
    const valueStr: string = String(this.value);
    const charArr: string[] = valueStr.split('');
    const separators: string[] = this.getSeparators();
    const indices: number[] = [];
    for (let i = 0; i < charArr.length; i++) {
      if (separators.includes(charArr[i])) {
        indices.push(-1);
      } else {
        indices.push(Number(charArr[i]));
      }
    }
    this.chars = charArr;
    this.targetIndices = indices;
  }

  /**
   * 初始化：高度测量完成后标记就绪
   */
  private init(): void {
    if (!this.started) {
      this.started = true;
    }
  }

  // ========== 样式方法 ==========

  /**
   * 获取文字颜色
   * @returns 解析后的颜色值
   */
  private getTextColor(): ResourceColor {
    if (this.textColor.length > 0) {
      if (THEME_COLOR_NAMES.includes(this.textColor)) {
        return getThemeColor(this.baseStyle, this.textColor as TnComponentColorType);
      }
      return this.textColor;
    }
    return $r("app.color.tn_text_color_primary");
  }

  /**
   * 获取字体大小字符串
   * @returns 带单位的字体大小（如 "14fp"）
   */
  private getTextFontSize(): string {
    if (this.fontSize > 0) {
      return getSizeByUnit(this.fontSize, true);
    }
    return getFontSizeByKey(this.baseStyle, "fontSize");
  }

  /**
   * 获取数字行高度字符串（与字体大小一致，保证 1em 效果）
   * @returns 带单位的行高度
   */
  private getDigitRowHeight(): string {
    return this.getTextFontSize();
  }

  // ========== 构建 ==========

  build() {
    Row() {
      ForEach(this.chars, (ch: string, index: number) => {
        if (this.targetIndices[index] === -1) {
          // 分隔符：直接渲染文本
          Text(ch)
            .fontColor(this.getTextColor())
            .fontSize(this.getTextFontSize())
            .fontWeight(this.fontWeight)
            .lineHeight(this.getDigitRowHeight())
        } else {
          // 数字列：使用子组件做滚动动画
          TnCountScrollDigit({
            targetIndex: this.targetIndices[index],
            textHeight: this.textHeight,
            digitRowHeight: this.getDigitRowHeight(),
            duration: this.duration,
            fontColor: this.getTextColor(),
            fontSizeStr: this.getTextFontSize(),
            fontWeight: this.fontWeight,
            isStarted: this.started,
          })
        }
      }, (_ch: string, index: number) => index.toString())
    }
    .height(this.getDigitRowHeight())
    .alignItems(VerticalAlign.Center)
    .onAreaChange((_oldVal, newVal) => {
      const h: number = newVal.height as number;
      if (h > 0) {
        this.textHeight = h;
        this.init();
      }
    })
  }
}

/**
 * 单个数字滚动列组件
 * @description 内部包含 0-9 共 10 个数字纵向排列，通过 translate 和 clip 实现滚动效果
 */
@ComponentV2
struct TnCountScrollDigit {
  /** 目标数字索引 (0-9) */
  @Param @Require targetIndex: number;
  /** 单个数字的像素高度（由父组件测量提供） */
  @Param @Require textHeight: number;
  /** 数字行高度字符串（如 "14fp"），用于设置布局尺寸 */
  @Param @Require digitRowHeight: string;
  /** 动画时长（毫秒） */
  @Param @Require duration: number;
  /** 字体颜色 */
  @Param @Require fontColor: ResourceColor;
  /** 字体大小字符串 */
  @Param @Require fontSizeStr: string;
  /** 字重 */
  @Param @Require fontWeight: FontWeight;
  /** 父组件是否已完成初始化 */
  @Param @Require isStarted: boolean;

  /** 当前纵向偏移量（像素） */
  @Local transY: number = 0;
  /** 是否已执行过初始动画 */
  private initialized: boolean = false;
  private uiContext: UIContext = this.getUIContext();

  aboutToAppear(): void {
    this.tryStartInitialAnimation();
  }

  @Monitor("targetIndex")
  onTargetChange(): void {
    if (this.textHeight > 0) {
      this.animateToTarget();
    }
  }

  @Monitor("isStarted")
  onStarted(): void {
    this.tryStartInitialAnimation();
  }

  @Monitor("textHeight")
  onTextHeightReady(): void {
    this.tryStartInitialAnimation();
  }

  /**
   * 尝试启动初始动画（条件满足时执行一次）
   * 处理三种触发场景：aboutToAppear / isStarted 变化 / textHeight 就绪
   */
  private tryStartInitialAnimation(): void {
    if (this.isStarted && this.textHeight > 0 && !this.initialized) {
      this.initialized = true;
      setTimeout(() => {
        this.animateToTarget();
      }, ANIMATION_START_DELAY);
    }
  }

  /**
   * 动画滚动到目标位置
   */
  private animateToTarget(): void {
    const targetY: number = -(this.targetIndex * this.textHeight);
    this.uiContext.animateTo({
      duration: this.duration,
      curve: Curve.EaseInOut,
    }, () => {
      this.transY = targetY;
    });
  }

  build() {
    // 外层容器：固定一位数字高度，裁剪溢出
    Column() {
      // 内层纵向列：包含 0-9 共 10 个数字，通过 translate 移动
      Column() {
        ForEach(DEFAULT_DIGITS, (digit: string) => {
          Text(digit)
            .fontColor(this.fontColor)
            .fontSize(this.fontSizeStr)
            .fontWeight(this.fontWeight)
            .textAlign(TextAlign.Center)
            .height(this.digitRowHeight)
            .lineHeight(this.digitRowHeight)
        }, (digit: string) => digit)
      }
      .translate({ y: this.transY })
    }
    .height(this.digitRowHeight)
    .clip(true)
  }
}
