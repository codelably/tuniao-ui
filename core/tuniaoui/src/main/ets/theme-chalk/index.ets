import { TnAppStorageKey } from "../common/storage_key";
import { ObjectAssign } from "../utils/ObjectAssign";
import { AppStorageV2 } from "@kit.ArkUI";
import { TnUIBaseStyle, TnUIBaseStyleType } from "./index.type";
export { TnGradientBackground } from "./color";

/**
 * 获取全局样式
 */
export function TnUIGetUIBaseStyle(): TnUIBaseStyleType {
  return AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;
}

/**
 * 设置全局样式
 * @param TnUIBaseStyleType
 */
export const TnUISetUIBaseStyle = (styleData?: Partial<TnUIBaseStyleType>) => {
  let baseStyle = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE, () => new TnUIBaseStyle({}));
  if(baseStyle && styleData){
    ObjectAssign(baseStyle, styleData);
  }else{
    AppStorageV2.remove(TnAppStorageKey.BASE_STYLE);
    AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE, () => new TnUIBaseStyle({}));
  }
}