/**
 * 字符串或数字类型
 */
export type TnStringNumber = string | number;

/**
 * 基础数据类型
 */
export type TnBaseDataType = TnStringNumber | boolean;

@ObservedV2
export class TnBaseDataTypeObs {
  @Trace value: TnBaseDataType;

  constructor(value: TnBaseDataType) {
    this.value = value;
  }
}

type TnLengthUnit = "vp" | "px" | "lpx";
type TnFontUnit = TnLengthUnit | "fp";

/**
 * 全局配置信息
 */
export class TnGlobalConfigType {
  /**
   * 标识页面设计基准宽度 默认720px
   */
  designWidth: number = 720
  /**
   * 尺寸单位, 默认vp
   */
  unit: TnLengthUnit = 'vp'
  /**
   * 字体单位, 默认fp
   */
  fontUnit: TnFontUnit = 'fp'
  /**
   * 自定义字体名称
   */
  fontNames: ResourceStr[] = []
}

export class TnGlobalConfig extends TnGlobalConfigType {
  constructor(option?: Partial<TnGlobalConfigType>) {
    super()
    this.designWidth = option?.designWidth || 720
    this.unit = option?.unit || "vp";
    this.fontUnit = option?.fontUnit || "fp";
    this.fontNames = option?.fontNames || [];
  }
}