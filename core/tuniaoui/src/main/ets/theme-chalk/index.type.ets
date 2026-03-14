import { convertDimensionsWidthUnit } from "../utils/Utils";
import { BORDER_RADIUS } from "./border";
import { BorderRadiusData } from "./border.type";
import { ThemeColor } from "./color";
import { ColorData, ResourceColorWrapper } from "./color.type";
import { FONT_SIZE } from "./font";
import { FontSizeData } from "./font.type";
import { LINE_HEIGHT } from "./line-height";
import { LineHeightData } from "./line-height.type";
import { ShadowData, ShadowLevelConfig } from "./shadow.type";
import { SPACE } from "./space";
import { SpaceData } from "./space.type";

export interface TnUIBaseStyleType extends ColorData, FontSizeData, SpaceData, BorderRadiusData, LineHeightData, ShadowData {
  animationDuration: number
}

@ObservedV2
export class TnUIBaseStyle implements TnUIBaseStyleType {
  @Trace primary: ResourceColorWrapper;
  @Trace success: ResourceColorWrapper;
  @Trace warning: ResourceColorWrapper;
  @Trace danger: ResourceColorWrapper;
  @Trace error: ResourceColorWrapper;
  @Trace info: ResourceColorWrapper;
  @Trace fontSizeXxs: string;
  @Trace fontSizeXs: string;
  @Trace fontSizeSm: string;
  @Trace fontSize: string;
  @Trace fontSizeLg: string;
  @Trace fontSizeXl: string;
  @Trace fontSizeXXl: string;
  @Trace fontSizeXXXl: string;
  @Trace fontSizeXXXXl: string;
  @Trace spaceMini: string;
  @Trace spaceBase: string;
  @Trace spaceXs: string;
  @Trace spaceXsm: string;
  @Trace spaceSm: string;
  @Trace spaceMd: string;
  @Trace space: string;
  @Trace spaceMlg: string;
  @Trace spaceLg: string;
  @Trace spaceXl: string;
  @Trace borderRadiusSm: string;
  @Trace borderRadius: string;
  @Trace borderRadiusLg: string;
  @Trace borderRadiusXl: string;
  @Trace borderRadiusXxl: string;
  @Trace borderRadiusMax: string;
  @Trace lineHeightXs: string;
  @Trace lineHeightXsm: string;
  @Trace lineHeightSm: string;
  @Trace lineHeightMd: string;
  @Trace lineHeightLg: string;
  @Trace shadowSm: ShadowLevelConfig;
  @Trace shadowDefault: ShadowLevelConfig;
  @Trace shadowMd: ShadowLevelConfig;
  @Trace shadowLg: ShadowLevelConfig;
  @Trace animationDuration: number;

  constructor(value: Partial<TnUIBaseStyleType>) {
    this.primary = value.primary ?? ThemeColor.Primary;
    this.success = value.success ?? ThemeColor.Success;
    this.warning = value.warning ?? ThemeColor.Warning;
    this.danger = value.danger ?? ThemeColor.Danger;
    this.error = value.error ?? ThemeColor.Error;
    this.info = value.info ?? ThemeColor.Info;

    this.fontSizeXxs = value.fontSizeXxs ?? convertDimensionsWidthUnit(FONT_SIZE.XXS, true);
    this.fontSizeXs = value.fontSizeXs ?? convertDimensionsWidthUnit(FONT_SIZE.XS, true);
    this.fontSizeSm = value.fontSizeSm ?? convertDimensionsWidthUnit(FONT_SIZE.SM, true);
    this.fontSize = value.fontSize ?? convertDimensionsWidthUnit(FONT_SIZE.DEFAULT, true);
    this.fontSizeLg = value.fontSizeLg ?? convertDimensionsWidthUnit(FONT_SIZE.LG, true);
    this.fontSizeXl = value.fontSizeXl ?? convertDimensionsWidthUnit(FONT_SIZE.XL, true);
    this.fontSizeXXl = value.fontSizeXXl ?? convertDimensionsWidthUnit(FONT_SIZE.XXL, true);
    this.fontSizeXXXl = value.fontSizeXXXl ?? convertDimensionsWidthUnit(FONT_SIZE.XXXL, true);
    this.fontSizeXXXXl = value.fontSizeXXXXl ?? convertDimensionsWidthUnit(FONT_SIZE.XXXXL, true);

    this.spaceMini = value.spaceMini ?? convertDimensionsWidthUnit(SPACE.MINI);
    this.spaceBase = value.spaceBase ?? convertDimensionsWidthUnit(SPACE.BASE);
    this.spaceXs = value.spaceXs ?? convertDimensionsWidthUnit(SPACE.XS);
    this.spaceXsm = value.spaceXsm ?? convertDimensionsWidthUnit(SPACE.XSM);
    this.spaceSm = value.spaceSm ?? convertDimensionsWidthUnit(SPACE.SM);
    this.spaceMd = value.spaceMd ?? convertDimensionsWidthUnit(SPACE.MD);
    this.space = value.space ?? convertDimensionsWidthUnit(SPACE.NORMAL);
    this.spaceMlg = value.spaceMlg ?? convertDimensionsWidthUnit(SPACE.MLG);
    this.spaceLg = value.spaceLg ?? convertDimensionsWidthUnit(SPACE.LG);
    this.spaceXl = value.spaceXl ?? convertDimensionsWidthUnit(SPACE.XL);

    this.borderRadiusSm = value.borderRadiusSm ?? convertDimensionsWidthUnit(BORDER_RADIUS.SM);
    this.borderRadius = value.borderRadius ?? convertDimensionsWidthUnit(BORDER_RADIUS.NORMAL);
    this.borderRadiusLg = value.borderRadiusLg ?? convertDimensionsWidthUnit(BORDER_RADIUS.LG);
    this.borderRadiusXl = value.borderRadiusXl ?? convertDimensionsWidthUnit(BORDER_RADIUS.XL);
    this.borderRadiusXxl = value.borderRadiusXxl ?? convertDimensionsWidthUnit(BORDER_RADIUS.XXL);
    this.borderRadiusMax = value.borderRadiusMax ?? convertDimensionsWidthUnit(BORDER_RADIUS.MAX);

    this.lineHeightXs = value.lineHeightXs ?? convertDimensionsWidthUnit(LINE_HEIGHT.XS);
    this.lineHeightXsm = value.lineHeightXsm ?? convertDimensionsWidthUnit(LINE_HEIGHT.XSM);
    this.lineHeightSm = value.lineHeightSm ?? convertDimensionsWidthUnit(LINE_HEIGHT.SM);
    this.lineHeightMd = value.lineHeightMd ?? convertDimensionsWidthUnit(LINE_HEIGHT.MD);
    this.lineHeightLg = value.lineHeightLg ?? convertDimensionsWidthUnit(LINE_HEIGHT.LG);

    this.shadowSm = value.shadowSm ?? { radius: 4, offsetX: 0, offsetY: 2 } as ShadowLevelConfig;
    this.shadowDefault = value.shadowDefault ?? { radius: 8, offsetX: 0, offsetY: 4 } as ShadowLevelConfig;
    this.shadowMd = value.shadowMd ?? { radius: 16, offsetX: 0, offsetY: 8 } as ShadowLevelConfig;
    this.shadowLg = value.shadowLg ?? { radius: 24, offsetX: 0, offsetY: 12 } as ShadowLevelConfig;

    this.animationDuration = value.animationDuration ?? 200
  }
}
