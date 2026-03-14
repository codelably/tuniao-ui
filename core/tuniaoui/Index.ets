import { HAR_VERSION } from './BuildProfile';
export const TuniaoUIVersion = HAR_VERSION;
export { TnUIInitializer } from './src/main/ets/index';
export { TnUIGetUIBaseStyle, TnUISetUIBaseStyle, TnGradientBackground } from './src/main/ets/theme-chalk';
export { TnUIBaseStyleType, TnUIBaseStyle } from './src/main/ets/theme-chalk/index.type';
export { ResourceColorWrapper, CustomColorWrapper, COLOR_TYPE, ColorVariant } from './src/main/ets/theme-chalk/color.type';
export { ThemeColor } from './src/main/ets/theme-chalk/color';
export { SPACE } from './src/main/ets/theme-chalk/space';
export { SHADOW } from './src/main/ets/theme-chalk/shadow';
export { ShadowLevelConfig, ShadowData } from './src/main/ets/theme-chalk/shadow.type';
export { BLUR_LEVEL } from './src/main/ets/theme-chalk/blur';
export { tn_w_full, tn_w_auto, tn_w_screen, tn_w, tn_h_full, tn_h_auto, tn_h_screen, tn_h } from './src/main/ets/theme-chalk/size';
export { TnComponentColorType, TnShadowLevelType, getThemeColor, getThemeColorLight, getFontSizeByKey, getTnShadow } from './src/main/ets/common/theme_helpers';
export { getRandomHexColor } from './src/main/ets/utils/ColorUtils';
export { TnIcon } from './src/main/ets/components/icon/TnIcon';
export { TN_ICON_DATA, TN_ICON_NAMES } from './src/main/ets/components/icon/TnIconData';
export { TnIconColorType, TnIconProps } from './src/main/ets/components/icon/TnIconTypes';
export { TnButton } from './src/main/ets/components/button/TnButton';
export { TnButtonColorType, TnButtonSizeType, TnButtonShapeType, TnButtonProps } from './src/main/ets/components/button/TnButtonTypes';
export { TnTag } from './src/main/ets/components/tag/TnTag';
export { TnTagColorType, TnTagSizeType, TnTagShapeType, TnTagProps } from './src/main/ets/components/tag/TnTagTypes';
export { TnBadge } from './src/main/ets/components/badge/TnBadge';
export { TnBadgeColorType, TnBadgeSizeType, TnBadgePositionType, TnBadgeProps } from './src/main/ets/components/badge/TnBadgeTypes';
export { TnLoading } from './src/main/ets/components/loading/TnLoading';
export { TnLoadingColorType, TnLoadingModeType, TnLoadingSizeType, TnLoadingProps } from './src/main/ets/components/loading/TnLoadingTypes';

// Phase 0: 表单基础设施
export { TnFormItem } from './src/main/ets/components/form/TnFormItem';
export { TnFormItemProps } from './src/main/ets/components/form/TnFormItemTypes';
export {
  TnFormRuleItem,
  TnFormRules,
  TnFieldValueType,
  TnFieldValidateInfo,
  TnFormValidateResult,
  TnFieldValidateResult,
  TnFieldItem,
  TnLabelPosition,
  TnRequireAsteriskPosition,
  TnFormSendFieldCallResult,
  TN_FORM_EVENT,
  TN_FORM_COMPONENT_NAME,
  getTnFormEventName,
  TnFormController
} from './src/main/ets/components/form/TnFormTypes';

// Phase 1: 简单表单控件
export { TnSwitch } from './src/main/ets/components/switch/TnSwitch';
export { TnSwitchShapeType, TnSwitchValueType, TnSwitchProps } from './src/main/ets/components/switch/TnSwitchTypes';
export { TnRadio } from './src/main/ets/components/radio/TnRadio';
export { TnRadioGroup } from './src/main/ets/components/radio/TnRadioGroup';
export {
  TnRadioValueType,
  TnRadioProps,
  TnRadioGroupProps,
  TN_RADIO_GROUP_EVENT,
  getTnRadioGroupEventName,
  TnRadioGroupConfig
} from './src/main/ets/components/radio/TnRadioTypes';
export { TnCheckbox } from './src/main/ets/components/checkbox/TnCheckbox';
export { TnCheckboxGroup } from './src/main/ets/components/checkbox/TnCheckboxGroup';
export {
  TnCheckboxValueType,
  TnCheckboxShape,
  TnCheckboxProps,
  TnCheckboxGroupProps,
  TN_CHECKBOX_GROUP_EVENT,
  getTnCheckboxGroupEventName,
  TnCheckboxGroupConfig
} from './src/main/ets/components/checkbox/TnCheckboxTypes';
export { TnRate } from './src/main/ets/components/rate/TnRate';
export { TnRateProps } from './src/main/ets/components/rate/TnRateTypes';

// Phase 2: 输入型控件
export { TnInput } from './src/main/ets/components/input/TnInput';
export { TnInputType, TnInputTextAlign, TnInputSize, TnInputSizeConfig, TnInputProps } from './src/main/ets/components/input/TnInputTypes';
export { TnNumberBox } from './src/main/ets/components/number-box/TnNumberBox';
export { TnNumberBoxProps } from './src/main/ets/components/number-box/TnNumberBoxTypes';
export { TnSlider } from './src/main/ets/components/slider/TnSlider';
export { TnSliderProps } from './src/main/ets/components/slider/TnSliderTypes';

// Phase 3: 弹出选择器
export { TnPicker } from './src/main/ets/components/picker/TnPicker';
export { TnPickerColumnItem, TnPickerValueType, TnPickerProps } from './src/main/ets/components/picker/TnPickerTypes';
export { TnDateTimePicker } from './src/main/ets/components/date-time-picker/TnDateTimePicker';
export { TnDateTimePickerMode, TnDateTimePickerProps } from './src/main/ets/components/date-time-picker/TnDateTimePickerTypes';
export { TnRegionPicker } from './src/main/ets/components/region-picker/TnRegionPicker';
export { TnRegionPickerProps } from './src/main/ets/components/region-picker/TnRegionPickerTypes';
export { RegionItem, REGION_DATA } from './src/main/ets/components/region-picker/data/region';

// Phase 4: 复杂组件
export { TnImageUpload } from './src/main/ets/components/image-upload/TnImageUpload';
export { TnUploadFile, TnUploadFileStatus, TnImageUploadProps } from './src/main/ets/components/image-upload/TnImageUploadTypes';
export { TnCalendar } from './src/main/ets/components/calendar/TnCalendar';
export { TnCalendarMode, TnCalendarDateItem, TnCalendarProps, TnCalendarHolidayType, TnCalendarHolidayItem } from './src/main/ets/components/calendar/TnCalendarTypes';
export { Lunar, lunar } from './src/main/ets/utils/lunar';
export { TnWeekCalendar } from './src/main/ets/components/week-calendar/TnWeekCalendar';
export { TnWeekCalendarCustomData, TnWeekCalendarDateItem, TnWeekCalendarChangeData, TnWeekCalendarProps } from './src/main/ets/components/week-calendar/TnWeekCalendarTypes';

// Phase 5: 表单容器
export { TnForm } from './src/main/ets/components/form/TnForm';

// Phase 6: 图片预览
export { default as TnImagePreview } from './src/main/ets/components/image-preview/TnImagePreview';
export { TnImagePreviewOption } from './src/main/ets/components/image-preview/TnImagePreviewTypes';

// Phase 7: 反馈组件
export { TnPopup } from './src/main/ets/components/popup/TnPopup';
export { TnPopupOpenDirection, TnPopupCloseBtnPosition } from './src/main/ets/components/popup/TnPopupTypes';

// Phase 8: 布局组件
export { TnList } from './src/main/ets/components/list/TnList';
export { TnListItem } from './src/main/ets/components/list/TnListItem';
export { TnListItemProps, TnListProps } from './src/main/ets/components/list/TnListTypes';