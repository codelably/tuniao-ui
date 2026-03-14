import { AppStorageV2 } from "@kit.ArkUI"
import { TnUIInitializer } from "..";
import { TnAppStorageKey } from "../common/storage_key";
import { TnBaseDataType, TnBaseDataTypeObs, TnGlobalConfig, TnStringNumber } from "../common/types"

/**
 * 保存AppStorage
 */
export function saveBaseDataToStorage(key: string, value: TnBaseDataType) {
  let val = AppStorageV2.connect(TnBaseDataTypeObs, key, () => new TnBaseDataTypeObs(0));
  if (val != undefined) {
    val.value = value;
  } else {
    AppStorageV2.connect(TnBaseDataTypeObs, key, () => new TnBaseDataTypeObs(value));
  }
}

/**
 * 根据类型和单位拼接尺寸 用于组件输入的参数尺寸类属性格式化
 */
export function getSizeByUnit(val: TnStringNumber, isFont?: boolean): string {
  if (typeof val == "number") {
    let config: TnGlobalConfig = AppStorageV2.connect(TnGlobalConfig, TnAppStorageKey.GLOBAL_CONFIG)!
    let unit = isFont ? config.fontUnit : config.unit
    return `${val}${unit}`
  }
  return val
}

/**
 * 根据单位转换尺寸 用于框架固定尺寸格式化 带单位
 */
export function convertDimensionsWidthUnit(val: number, isFont?: boolean): string {
  let config: TnGlobalConfig = AppStorageV2.connect(TnGlobalConfig, TnAppStorageKey.GLOBAL_CONFIG)!
  let unit = isFont ? "fp" : "vp"
  let value = val
  if (config) {
    unit = isFont ? config.fontUnit : config.unit
    switch (unit) {
      case "lpx":
        value = val * TnUIInitializer.screenWidth / config.designWidth
        break
      case "px":
        value = TnUIInitializer.vp2px(val)
        break
    }
  }
  return value + unit
}