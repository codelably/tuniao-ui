import { COLOR_TYPE, GradientBgType, ResourceColorWrapper } from "./color.type";

/**
 * 主题色
 */
export class ThemeColor {
  static Primary: ResourceColorWrapper = new ResourceColorWrapper(COLOR_TYPE.PRIMARY);
  static Success: ResourceColorWrapper = new ResourceColorWrapper(COLOR_TYPE.SUCCESS);
  static Warning: ResourceColorWrapper = new ResourceColorWrapper(COLOR_TYPE.WARNING);
  static Danger: ResourceColorWrapper = new ResourceColorWrapper(COLOR_TYPE.DANGER);
  static Error: ResourceColorWrapper = new ResourceColorWrapper(COLOR_TYPE.ERROR);
  static Info: ResourceColorWrapper = new ResourceColorWrapper(COLOR_TYPE.INFO);
}

/**
 * 图鸟渐变色背景和酷炫背景配置
 */
export const TnGradientBackground: (color: GradientBgType) => LinearGradientOptions = (color: GradientBgType) => {
  let tn_cool_bg_start_color: ResourceColor|string = $r("app.color.tn_color_red");
  let tn_cool_bg_end_color: ResourceColor|string = $r("app.color.tn_color_purplered");
  switch (color) {
    // 主题色渐变：主题色 → 主题色 light_3 变种
    case "primary":
      tn_cool_bg_start_color = $r("app.color.tn_color_primary");
      tn_cool_bg_end_color = $r("app.color.tn_color_primary_light_3");
      break;
    case "primary-light_3":
      tn_cool_bg_start_color = $r("app.color.tn_color_primary_light_3");
      tn_cool_bg_end_color = $r("app.color.tn_color_primary_light_5");
      break;
    case "primary-light_5":
      tn_cool_bg_start_color = $r("app.color.tn_color_primary_light_5");
      tn_cool_bg_end_color = $r("app.color.tn_color_primary_light_7");
      break;
    case "primary-light_7":
      tn_cool_bg_start_color = $r("app.color.tn_color_primary_light_7");
      tn_cool_bg_end_color = $r("app.color.tn_color_primary_light_9");
      break;
    case "primary-light_8":
      tn_cool_bg_start_color = $r("app.color.tn_color_primary_light_8");
      tn_cool_bg_end_color = $r("app.color.tn_color_primary_light_9");
      break;
    case "primary-light_9":
      tn_cool_bg_start_color = $r("app.color.tn_color_primary");
      tn_cool_bg_end_color = $r("app.color.tn_color_primary_light_9");
      break;
    case "primary-dark_2":
      tn_cool_bg_start_color = $r("app.color.tn_color_primary_dark_2");
      tn_cool_bg_end_color = $r("app.color.tn_color_primary");
      break;

    case "success":
      tn_cool_bg_start_color = $r("app.color.tn_color_success");
      tn_cool_bg_end_color = $r("app.color.tn_color_success_light_3");
      break;
    case "success-light_3":
      tn_cool_bg_start_color = $r("app.color.tn_color_success_light_3");
      tn_cool_bg_end_color = $r("app.color.tn_color_success_light_5");
      break;
    case "success-light_5":
      tn_cool_bg_start_color = $r("app.color.tn_color_success_light_5");
      tn_cool_bg_end_color = $r("app.color.tn_color_success_light_7");
      break;
    case "success-light_7":
      tn_cool_bg_start_color = $r("app.color.tn_color_success_light_7");
      tn_cool_bg_end_color = $r("app.color.tn_color_success_light_9");
      break;
    case "success-light_8":
      tn_cool_bg_start_color = $r("app.color.tn_color_success_light_8");
      tn_cool_bg_end_color = $r("app.color.tn_color_success_light_9");
      break;
    case "success-light_9":
      tn_cool_bg_start_color = $r("app.color.tn_color_success");
      tn_cool_bg_end_color = $r("app.color.tn_color_success_light_9");
      break;
    case "success-dark_2":
      tn_cool_bg_start_color = $r("app.color.tn_color_success_dark_2");
      tn_cool_bg_end_color = $r("app.color.tn_color_success");
      break;

    case "warning":
      tn_cool_bg_start_color = $r("app.color.tn_color_warning");
      tn_cool_bg_end_color = $r("app.color.tn_color_warning_light_3");
      break;
    case "warning-light_3":
      tn_cool_bg_start_color = $r("app.color.tn_color_warning_light_3");
      tn_cool_bg_end_color = $r("app.color.tn_color_warning_light_5");
      break;
    case "warning-light_5":
      tn_cool_bg_start_color = $r("app.color.tn_color_warning_light_5");
      tn_cool_bg_end_color = $r("app.color.tn_color_warning_light_7");
      break;
    case "warning-light_7":
      tn_cool_bg_start_color = $r("app.color.tn_color_warning_light_7");
      tn_cool_bg_end_color = $r("app.color.tn_color_warning_light_9");
      break;
    case "warning-light_8":
      tn_cool_bg_start_color = $r("app.color.tn_color_warning_light_8");
      tn_cool_bg_end_color = $r("app.color.tn_color_warning_light_9");
      break;
    case "warning-light_9":
      tn_cool_bg_start_color = $r("app.color.tn_color_warning");
      tn_cool_bg_end_color = $r("app.color.tn_color_warning_light_9");
      break;
    case "warning-dark_2":
      tn_cool_bg_start_color = $r("app.color.tn_color_warning_dark_2");
      tn_cool_bg_end_color = $r("app.color.tn_color_warning");
      break;

    case "danger":
      tn_cool_bg_start_color = $r("app.color.tn_color_danger");
      tn_cool_bg_end_color = $r("app.color.tn_color_danger_light_3");
      break;
    case "danger-light_3":
      tn_cool_bg_start_color = $r("app.color.tn_color_danger_light_3");
      tn_cool_bg_end_color = $r("app.color.tn_color_danger_light_5");
      break;
    case "danger-light_5":
      tn_cool_bg_start_color = $r("app.color.tn_color_danger_light_5");
      tn_cool_bg_end_color = $r("app.color.tn_color_danger_light_7");
      break;
    case "danger-light_7":
      tn_cool_bg_start_color = $r("app.color.tn_color_danger_light_7");
      tn_cool_bg_end_color = $r("app.color.tn_color_danger_light_9");
      break;
    case "danger-light_8":
      tn_cool_bg_start_color = $r("app.color.tn_color_danger_light_8");
      tn_cool_bg_end_color = $r("app.color.tn_color_danger_light_9");
      break;
    case "danger-light_9":
      tn_cool_bg_start_color = $r("app.color.tn_color_danger");
      tn_cool_bg_end_color = $r("app.color.tn_color_danger_light_9");
      break;
    case "danger-dark_2":
      tn_cool_bg_start_color = $r("app.color.tn_color_danger_dark_2");
      tn_cool_bg_end_color = $r("app.color.tn_color_danger");
      break;

    case "error":
      tn_cool_bg_start_color = $r("app.color.tn_color_error");
      tn_cool_bg_end_color = $r("app.color.tn_color_error_light_3");
      break;
    case "error-light_3":
      tn_cool_bg_start_color = $r("app.color.tn_color_error_light_3");
      tn_cool_bg_end_color = $r("app.color.tn_color_error_light_5");
      break;
    case "error-light_5":
      tn_cool_bg_start_color = $r("app.color.tn_color_error_light_5");
      tn_cool_bg_end_color = $r("app.color.tn_color_error_light_7");
      break;
    case "error-light_7":
      tn_cool_bg_start_color = $r("app.color.tn_color_error_light_7");
      tn_cool_bg_end_color = $r("app.color.tn_color_error_light_9");
      break;
    case "error-light_8":
      tn_cool_bg_start_color = $r("app.color.tn_color_error_light_8");
      tn_cool_bg_end_color = $r("app.color.tn_color_error_light_9");
      break;
    case "error-light_9":
      tn_cool_bg_start_color = $r("app.color.tn_color_error");
      tn_cool_bg_end_color = $r("app.color.tn_color_error_light_9");
      break;
    case "error-dark_2":
      tn_cool_bg_start_color = $r("app.color.tn_color_error_dark_2");
      tn_cool_bg_end_color = $r("app.color.tn_color_error");
      break;

    case "info":
      tn_cool_bg_start_color = $r("app.color.tn_color_info");
      tn_cool_bg_end_color = $r("app.color.tn_color_info_light_3");
      break;
    case "info-light_3":
      tn_cool_bg_start_color = $r("app.color.tn_color_info_light_3");
      tn_cool_bg_end_color = $r("app.color.tn_color_info_light_5");
      break;
    case "info-light_5":
      tn_cool_bg_start_color = $r("app.color.tn_color_info_light_5");
      tn_cool_bg_end_color = $r("app.color.tn_color_info_light_7");
      break;
    case "info-light_7":
      tn_cool_bg_start_color = $r("app.color.tn_color_info_light_7");
      tn_cool_bg_end_color = $r("app.color.tn_color_info_light_9");
      break;
    case "info-light_8":
      tn_cool_bg_start_color = $r("app.color.tn_color_info_light_8");
      tn_cool_bg_end_color = $r("app.color.tn_color_info_light_9");
      break;
    case "info-light_9":
      tn_cool_bg_start_color = $r("app.color.tn_color_info");
      tn_cool_bg_end_color = $r("app.color.tn_color_info_light_9");
      break;
    case "info-dark_2":
      tn_cool_bg_start_color = $r("app.color.tn_color_info_dark_2");
      tn_cool_bg_end_color = $r("app.color.tn_color_info");
      break;

    // 内置色渐变
    case "red":
      tn_cool_bg_start_color = $r("app.color.tn_color_red");
      tn_cool_bg_end_color = $r("app.color.tn_color_purplered");
      break;
    case "red-light":
      tn_cool_bg_start_color = $r("app.color.tn_color_red_light");
      tn_cool_bg_end_color = $r("app.color.tn_color_purplered_light");
      break;
    case "red-single":
      tn_cool_bg_start_color = $r("app.color.tn_color_red");
      tn_cool_bg_end_color = $r("app.color.tn_color_red_light");
      break;

    case "purplered":
      tn_cool_bg_start_color = $r("app.color.tn_color_purplered");
      tn_cool_bg_end_color = $r("app.color.tn_color_purple");
      break;
    case "purplered-light":
      tn_cool_bg_start_color = $r("app.color.tn_color_purplered_light");
      tn_cool_bg_end_color = $r("app.color.tn_color_purple_light");
      break;
    case "purplered-single":
      tn_cool_bg_start_color = $r("app.color.tn_color_purplered");
      tn_cool_bg_end_color = $r("app.color.tn_color_purplered_light");
      break;

    case "purple":
      tn_cool_bg_start_color = $r("app.color.tn_color_purple");
      tn_cool_bg_end_color = $r("app.color.tn_color_bluepurple");
      break;
    case "purple-light":
      tn_cool_bg_start_color = $r("app.color.tn_color_purple_light");
      tn_cool_bg_end_color = $r("app.color.tn_color_bluepurple_light");
      break;
    case "purple-single":
      tn_cool_bg_start_color = $r("app.color.tn_color_purple");
      tn_cool_bg_end_color = $r("app.color.tn_color_purple_light");
      break;

    case "bluepurple":
      tn_cool_bg_start_color = $r("app.color.tn_color_bluepurple");
      tn_cool_bg_end_color = $r("app.color.tn_color_aquablue");
      break;
    case "bluepurple-light":
      tn_cool_bg_start_color = $r("app.color.tn_color_bluepurple_light");
      tn_cool_bg_end_color = $r("app.color.tn_color_aquablue_light");
      break;
    case "bluepurple-single":
      tn_cool_bg_start_color = $r("app.color.tn_color_bluepurple");
      tn_cool_bg_end_color = $r("app.color.tn_color_bluepurple_light");
      break;

    case "aquablue":
      tn_cool_bg_start_color = $r("app.color.tn_color_aquablue");
      tn_cool_bg_end_color = $r("app.color.tn_color_blue");
      break;
    case "aquablue-light":
      tn_cool_bg_start_color = $r("app.color.tn_color_aquablue_light");
      tn_cool_bg_end_color = $r("app.color.tn_color_blue_light");
      break;
    case "aquablue-single":
      tn_cool_bg_start_color = $r("app.color.tn_color_aquablue");
      tn_cool_bg_end_color = $r("app.color.tn_color_aquablue_light");
      break;

    case "blue":
      tn_cool_bg_start_color = $r("app.color.tn_color_blue");
      tn_cool_bg_end_color = $r("app.color.tn_color_indigo");
      break;
    case "blue-light":
      tn_cool_bg_start_color = $r("app.color.tn_color_blue_light");
      tn_cool_bg_end_color = $r("app.color.tn_color_indigo_light");
      break;
    case "blue-single":
      tn_cool_bg_start_color = $r("app.color.tn_color_blue");
      tn_cool_bg_end_color = $r("app.color.tn_color_blue_light");
      break;

    case "indigo":
      tn_cool_bg_start_color = $r("app.color.tn_color_indigo");
      tn_cool_bg_end_color = $r("app.color.tn_color_cyan");
      break;
    case "indigo-light":
      tn_cool_bg_start_color = $r("app.color.tn_color_indigo_light");
      tn_cool_bg_end_color = $r("app.color.tn_color_cyan_light");
      break;
    case "indigo-single":
      tn_cool_bg_start_color = $r("app.color.tn_color_indigo");
      tn_cool_bg_end_color = $r("app.color.tn_color_indigo_light");
      break;

    case "cyan":
      tn_cool_bg_start_color = $r("app.color.tn_color_cyan");
      tn_cool_bg_end_color = $r("app.color.tn_color_teal");
      break;
    case "cyan-light":
      tn_cool_bg_start_color = $r("app.color.tn_color_cyan_light");
      tn_cool_bg_end_color = $r("app.color.tn_color_teal_light");
      break;
    case "cyan-single":
      tn_cool_bg_start_color = $r("app.color.tn_color_cyan");
      tn_cool_bg_end_color = $r("app.color.tn_color_cyan_light");
      break;

    case "teal":
      tn_cool_bg_start_color = $r("app.color.tn_color_teal");
      tn_cool_bg_end_color = $r("app.color.tn_color_green");
      break;
    case "teal-light":
      tn_cool_bg_start_color = $r("app.color.tn_color_teal_light");
      tn_cool_bg_end_color = $r("app.color.tn_color_green_light");
      break;
    case "teal-single":
      tn_cool_bg_start_color = $r("app.color.tn_color_teal");
      tn_cool_bg_end_color = $r("app.color.tn_color_teal_light");
      break;

    case "green":
      tn_cool_bg_start_color = $r("app.color.tn_color_green");
      tn_cool_bg_end_color = $r("app.color.tn_color_yellowgreen");
      break;
    case "green-light":
      tn_cool_bg_start_color = $r("app.color.tn_color_green_light");
      tn_cool_bg_end_color = $r("app.color.tn_color_yellowgreen_light");
      break;
    case "green-single":
      tn_cool_bg_start_color = $r("app.color.tn_color_green");
      tn_cool_bg_end_color = $r("app.color.tn_color_green_light");
      break;

    case "yellowgreen":
      tn_cool_bg_start_color = $r("app.color.tn_color_yellowgreen");
      tn_cool_bg_end_color = $r("app.color.tn_color_lime");
      break;
    case "yellowgreen-light":
      tn_cool_bg_start_color = $r("app.color.tn_color_yellowgreen_light");
      tn_cool_bg_end_color = $r("app.color.tn_color_lime_light");
      break;
    case "yellowgreen-single":
      tn_cool_bg_start_color = $r("app.color.tn_color_yellowgreen");
      tn_cool_bg_end_color = $r("app.color.tn_color_yellowgreen_light");
      break;

    case "lime":
      tn_cool_bg_start_color = $r("app.color.tn_color_lime");
      tn_cool_bg_end_color = $r("app.color.tn_color_yellow");
      break;
    case "lime-light":
      tn_cool_bg_start_color = $r("app.color.tn_color_lime_light");
      tn_cool_bg_end_color = $r("app.color.tn_color_yellow_light");
      break;
    case "lime-single":
      tn_cool_bg_start_color = $r("app.color.tn_color_lime");
      tn_cool_bg_end_color = $r("app.color.tn_color_lime_light");
      break;

    case "yellow":
      tn_cool_bg_start_color = $r("app.color.tn_color_yellow");
      tn_cool_bg_end_color = $r("app.color.tn_color_orangeyellow");
      break;
    case "yellow-light":
      tn_cool_bg_start_color = $r("app.color.tn_color_yellow_light");
      tn_cool_bg_end_color = $r("app.color.tn_color_orangeyellow_light");
      break;
    case "yellow-single":
      tn_cool_bg_start_color = $r("app.color.tn_color_yellow");
      tn_cool_bg_end_color = $r("app.color.tn_color_yellow_light");
      break;

    case "orangeyellow":
      tn_cool_bg_start_color = $r("app.color.tn_color_orangeyellow");
      tn_cool_bg_end_color = $r("app.color.tn_color_orange");
      break;
    case "orangeyellow-light":
      tn_cool_bg_start_color = $r("app.color.tn_color_orangeyellow_light");
      tn_cool_bg_end_color = $r("app.color.tn_color_orange_light");
      break;
    case "orangeyellow-single":
      tn_cool_bg_start_color = $r("app.color.tn_color_orangeyellow");
      tn_cool_bg_end_color = $r("app.color.tn_color_orangeyellow_light");
      break;

    case "orange":
      tn_cool_bg_start_color = $r("app.color.tn_color_orange");
      tn_cool_bg_end_color = $r("app.color.tn_color_orangered");
      break;
    case "orange-light":
      tn_cool_bg_start_color = $r("app.color.tn_color_orange_light");
      tn_cool_bg_end_color = $r("app.color.tn_color_orangered_light");
      break;
    case "orange-single":
      tn_cool_bg_start_color = $r("app.color.tn_color_orange");
      tn_cool_bg_end_color = $r("app.color.tn_color_orange_light");
      break;

    case "orangered-single":
      tn_cool_bg_start_color = $r("app.color.tn_color_orangered");
      tn_cool_bg_end_color = $r("app.color.tn_color_orangered_light");
      break;
    case "brown-single":
      tn_cool_bg_start_color = $r("app.color.tn_color_brown");
      tn_cool_bg_end_color = $r("app.color.tn_color_brown_light");
      break;

    case "grey":
      tn_cool_bg_start_color = $r("app.color.tn_color_grey");
      tn_cool_bg_end_color = $r("app.color.tn_color_gray");
      break;
    case "grey-light":
      tn_cool_bg_start_color = $r("app.color.tn_color_grey_light");
      tn_cool_bg_end_color = $r("app.color.tn_color_gray_light");
      break;
    case "grey-single":
      tn_cool_bg_start_color = $r("app.color.tn_color_grey");
      tn_cool_bg_end_color = $r("app.color.tn_color_grey_light");
      break;

    case "gray-single":
      tn_cool_bg_start_color = $r("app.color.tn_color_gray");
      tn_cool_bg_end_color = $r("app.color.tn_color_gray_light");
      break;

    case "cool-1":
      tn_cool_bg_start_color = "#f5317f";
      tn_cool_bg_end_color = "#ff7c6e";
      break;
    case "cool-2":
      tn_cool_bg_start_color = "#ca26ff";
      tn_cool_bg_end_color = "#f360a7";
      break;
    case "cool-3":
      tn_cool_bg_start_color = "#a26ffc";
      tn_cool_bg_end_color = "#9d12ff";
      break;
    case "cool-4":
      tn_cool_bg_start_color = "#aa77f0";
      tn_cool_bg_end_color = "#e871e5";
      break;
    case "cool-5":
      tn_cool_bg_start_color = "#40a0f7";
      tn_cool_bg_end_color = "#4866e6";
      break;
    case "cool-6":
      tn_cool_bg_start_color = "#209cff";
      tn_cool_bg_end_color = "#68e0cf";
      break;
    case "cool-7":
      tn_cool_bg_start_color = "#00c3ff";
      tn_cool_bg_end_color = "#58fff5";
      break;
    case "cool-8":
      tn_cool_bg_start_color = "#00d1ff";
      tn_cool_bg_end_color = "#69ff97";
      break;
    case "cool-9":
      tn_cool_bg_start_color = "#0fd893";
      tn_cool_bg_end_color = "#29ecbf";
      break;
    case "cool-10":
      tn_cool_bg_start_color = "#0fd850";
      tn_cool_bg_end_color = "#f9f047";
      break;
    case "cool-11":
      tn_cool_bg_start_color = "#24fe41";
      tn_cool_bg_end_color = "#f7fd47";
      break;
    case "cool-12":
      tn_cool_bg_start_color = "#d6ff7f";
      tn_cool_bg_end_color = "#00f657";
      break;
    case "cool-13":
      tn_cool_bg_start_color = "#fa709a";
      tn_cool_bg_end_color = "#fee140";
      break;
    case "cool-14":
      tn_cool_bg_start_color = "#fe5e9c";
      tn_cool_bg_end_color = "#f1aa76";
      break;
    case "cool-15":
      tn_cool_bg_start_color = "#ff3181";
      tn_cool_bg_end_color = "#ff8331";
      break;
    case "cool-16":
      tn_cool_bg_start_color = "#ed1c24";
      tn_cool_bg_end_color = "#fece12";
      break;
  }

  return {
    angle: "45deg",
    colors: [[tn_cool_bg_start_color, 0], [tn_cool_bg_end_color, 1.0]]
  }
}