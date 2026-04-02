/**
 * @file 组件演示页面 ViewModel
 * @author JunBin.Yang
 */

import { BaseViewModel } from "@core/base";
import { CoreCardItem } from "../models/CoreCardItem";
import { ComponentGroupItem } from "../models/ComponentGroupItem";
import { getContainer, CoreServiceKeys } from "@core/di";
import { NavigationService } from "@core/navigation";
import { MainRoutes } from "@shared/contracts";

@ObservedV2
export default class TnComponentsViewModel extends BaseViewModel {
  /**
   * 组件分组数据
   */
  @Trace
  readonly groups: ComponentGroupItem[] = [
    new ComponentGroupItem(
      "样式",
      "主题颜色、内置颜色、渐变背景、字体等样式配置",
      [
        new CoreCardItem(
          "主题颜色",
          "Primary、Success、Warning等主题色",
          () => {
            this.navigateTo(MainRoutes.ThemeColor);
          }
        ),
        new CoreCardItem(
          "内置颜色",
          "Red、Blue、Green等内置颜色",
          () => {
            this.navigateTo(MainRoutes.BuiltInColor);
          }
        ),
        new CoreCardItem(
          "背景",
          "普通渐变背景和酷炫渐变背景",
          () => {
            this.navigateTo(MainRoutes.GradientBackground);
          }
        ),
        new CoreCardItem(
          "字体",
          "字体大小等配置",
          () => {
            this.navigateTo(MainRoutes.FontSize);
          }
        ),
        new CoreCardItem(
          "间距",
          "内边距和外边距配置",
          () => {
            this.navigateTo(MainRoutes.Spacing);
          }
        ),
        new CoreCardItem(
          "尺寸",
          "内置宽度和高度配置",
          () => {
            this.navigateTo(MainRoutes.Size);
          }
        ),
        new CoreCardItem(
          "阴影",
          "4 级阴影分级效果展示",
          () => {
            this.navigateTo(MainRoutes.Shadow);
          }
        ),
        new CoreCardItem(
          "毛玻璃",
          "backdropBlur 毛玻璃效果展示",
          () => {
            this.navigateTo(MainRoutes.BlurEffect);
          }
        )
      ]
    ),
    new ComponentGroupItem(
      "主题",
      "动态切换主题色，所有组件跟随主题样式变化",
      [
        new CoreCardItem(
          "主题切换",
          "动态切换全局主题色，展示组件响应效果",
          () => {
            this.navigateTo(MainRoutes.TnTheme);
          }
        )
      ]
    ),
    new ComponentGroupItem(
      "基础组件",
      "图标、按钮等基础UI组件",
      [
        new CoreCardItem(
          "图标",
          "Icon 图标组件",
          () => {
            this.navigateTo(MainRoutes.TnIcon);
          }
        ),
        new CoreCardItem(
          "按钮",
          "Button 按钮组件",
          () => {
            this.navigateTo(MainRoutes.TnButton);
          }
        ),
        new CoreCardItem(
          "标签",
          "Tag 标签组件",
          () => {
            this.navigateTo(MainRoutes.TnTag);
          }
        ),
        new CoreCardItem(
          "徽标",
          "Badge 徽标组件",
          () => {
            this.navigateTo(MainRoutes.TnBadge);
          }
        ),
        new CoreCardItem(
          "加载",
          "Loading 加载组件",
          () => {
            this.navigateTo(MainRoutes.TnLoading);
          }
        )
      ]
    ),
    new ComponentGroupItem(
      "表单组件",
      "开关、单选、复选、评分、输入框、步进器、滑块、图片上传、日历、表单等表单交互组件",
      [
        new CoreCardItem(
          "开关",
          "Switch 开关组件",
          () => {
            this.navigateTo(MainRoutes.TnSwitch);
          }
        ),
        new CoreCardItem(
          "单选框",
          "Radio 单选框组件",
          () => {
            this.navigateTo(MainRoutes.TnRadio);
          }
        ),
        new CoreCardItem(
          "复选框",
          "Checkbox 复选框组件",
          () => {
            this.navigateTo(MainRoutes.TnCheckbox);
          }
        ),
        new CoreCardItem(
          "评分",
          "Rate 评分组件",
          () => {
            this.navigateTo(MainRoutes.TnRate);
          }
        ),
        new CoreCardItem(
          "输入框",
          "Input 输入框组件",
          () => {
            this.navigateTo(MainRoutes.TnInput);
          }
        ),
        new CoreCardItem(
          "步进器",
          "NumberBox 步进器组件",
          () => {
            this.navigateTo(MainRoutes.TnNumberBox);
          }
        ),
        new CoreCardItem(
          "滑块",
          "Slider 滑块组件",
          () => {
            this.navigateTo(MainRoutes.TnSlider);
          }
        ),
        new CoreCardItem(
          "图片上传",
          "ImageUpload 图片上传组件",
          () => {
            this.navigateTo(MainRoutes.TnImageUpload);
          }
        ),
        new CoreCardItem(
          "日历",
          "Calendar 日历组件",
          () => {
            this.navigateTo(MainRoutes.TnCalendar);
          }
        ),
        new CoreCardItem(
          "周日历",
          "WeekCalendar 周日历组件",
          () => {
            this.navigateTo(MainRoutes.TnWeekCalendar);
          }
        ),
        new CoreCardItem(
          "表单",
          "Form 表单组件",
          () => {
            this.navigateTo(MainRoutes.TnForm);
          }
        )
      ]
    ),
    new ComponentGroupItem(
      "选择器",
      "选择器、日期时间选择器、地区选择器等弹出选择组件",
      [
        new CoreCardItem(
          "选择器",
          "Picker 选择器组件",
          () => {
            this.navigateTo(MainRoutes.TnPicker);
          }
        ),
        new CoreCardItem(
          "日期时间选择器",
          "DateTimePicker 日期时间选择器组件",
          () => {
            this.navigateTo(MainRoutes.TnDateTimePicker);
          }
        ),
        new CoreCardItem(
          "地区选择器",
          "RegionPicker 地区选择器组件",
          () => {
            this.navigateTo(MainRoutes.TnRegionPicker);
          }
        )
      ]
    ),
    new ComponentGroupItem(
      "展示组件",
      "图片预览、相册、轮播图等内容展示组件",
      [
        new CoreCardItem(
          "图片预览",
          "ImagePreview 图片预览组件",
          () => {
            this.navigateTo(MainRoutes.TnImagePreview);
          }
        ),
        new CoreCardItem(
          "相册",
          "PhotoAlbum 相册组件",
          () => {
            this.navigateTo(MainRoutes.TnPhotoAlbum);
          }
        ),
        new CoreCardItem(
          "轮播图",
          "Swiper 轮播图组件",
          () => {
            this.navigateTo(MainRoutes.TnSwiper);
          }
        )
      ]
    ),
    new ComponentGroupItem(
      "反馈组件",
      "弹出框、模态框等用户反馈交互组件",
      [
        new CoreCardItem(
          "弹出框",
          "Popup 弹出框组件",
          () => {
            this.navigateTo(MainRoutes.TnPopup);
          }
        ),
        new CoreCardItem(
          "模态框",
          "Modal 模态框组件",
          () => {
            this.navigateTo(MainRoutes.TnModal);
          }
        ),
        new CoreCardItem(
          "消息通知",
          "Notify 消息通知组件",
          () => {
            this.navigateTo(MainRoutes.TnNotify);
          }
        ),
        new CoreCardItem(
          "轻提示",
          "Toast 轻提示组件",
          () => {
            this.navigateTo(MainRoutes.TnToast);
          }
        ),
        new CoreCardItem(
          "通知栏",
          "NoticeBar 通知栏组件",
          () => {
            this.navigateTo(MainRoutes.TnNoticeBar);
          }
        )
      ]
    ),
    new ComponentGroupItem(
      "布局组件",
      "列表等页面布局组件",
      [
        new CoreCardItem(
          "列表",
          "List 列表组件",
          () => {
            this.navigateTo(MainRoutes.TnList);
          }
        ),
        new CoreCardItem(
          "折叠面板",
          "Collapse 折叠面板组件",
          () => {
            this.navigateTo(MainRoutes.TnCollapse);
          }
        )
      ]
    )
  ];

  /**
   * 导航到指定路由
   * @param route 目标路由路径
   * @returns {void} 无返回值
   */
  private navigateTo(route: string): void {
    const navigation = getContainer().tryResolve<NavigationService>(CoreServiceKeys.NavigationService);
    navigation?.navigateTo(route);
  }
}
