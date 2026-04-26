/**
 * @file 主页模块
 * @description 实现 FeatureModule 接口，提供模块自动注册
 * @author JunBin.Yang
 */

import { Container } from '@core/di';
import { FeatureModule, RouteRegistry, ModuleContext } from '@core/module';
import { NavigationService } from '@core/navigation';
import { MainRoutes, IMainNavSvc, MAIN_NAV_SVC_KEY } from '@shared/contracts';
import { MainNavWrapper } from './navigation/HomeNav';
import { ThemeColorNavWrapper, BuiltInColorNavWrapper, GradientBackgroundNavWrapper, FontSizeNavWrapper, SpacingNavWrapper, SizeNavWrapper, TnThemeNavWrapper, ShadowNavWrapper, BlurEffectNavWrapper } from './navigation/StyleNav';
import { TnIconNavWrapper, TnButtonNavWrapper, TnTagNavWrapper, TnBadgeNavWrapper, TnLoadingNavWrapper } from './navigation/BasicComponentNav';
import {
  TnSwitchNavWrapper, TnRadioNavWrapper, TnCheckboxNavWrapper, TnRateNavWrapper,
  TnInputNavWrapper, TnNumberBoxNavWrapper, TnSliderNavWrapper,
  TnPickerNavWrapper, TnDateTimePickerNavWrapper, TnRegionPickerNavWrapper,
  TnImageUploadNavWrapper, TnCalendarNavWrapper, TnWeekCalendarNavWrapper, TnFormNavWrapper,
  TnImagePreviewNavWrapper
} from './navigation/FormComponentNav';
import { TnPopupNavWrapper, TnModalNavWrapper, TnNotifyNavWrapper, TnToastNavWrapper, TnNoticeBarNavWrapper, TnActionSheetNavWrapper, TnEmptyNavWrapper } from './navigation/FeedbackComponentNav';
import { TnListNavWrapper, TnCollapseNavWrapper } from './navigation/LayoutComponentNav';
import { TnPhotoAlbumNavWrapper, TnSwiperNavWrapper, TnProgressNavWrapper, TnCountDownNavWrapper, TnCountToNavWrapper, TnCountScrollNavWrapper, TnReadMoreNavWrapper } from './navigation/DisplayComponentNav';
import { MainNavSvcImpl } from './services/MainNavSvcImpl';
import { Logger } from '@core/util';

/**
 * 主页模块
 * 实现 FeatureModule 接口，支持自动注册
 */
export class MainModule implements FeatureModule {
  /**
   * 模块唯一标识
   */
  readonly moduleId: string = 'main';

  /**
   * 模块名称
   */
  readonly moduleName: string = '主页模块';

  /**
   * 模块版本
   */
  readonly version: string = '1.0.0';

  /**
   * 模块依赖
   * 用于确定多个功能包先后加载顺序
   */
  readonly dependencies: string[] = [];

  /**
   * 注册 DI 服务
   * @param container DI 容器
   */
  registerServices(container: Container): void {
    // 注册本模块的导航服务
    container.register<IMainNavSvc>(MAIN_NAV_SVC_KEY, () => new MainNavSvcImpl());
  }

  /**
   * 注册路由
   * @param registry 路由注册器
   */
  registerRoutes(registry: RouteRegistry): void {
    // 注册首页路由
    registry.register(MainRoutes.Main, MainNavWrapper);
    // 注册主题颜色页面路由
    registry.register(MainRoutes.ThemeColor, ThemeColorNavWrapper);
    // 注册内置颜色页面路由
    registry.register(MainRoutes.BuiltInColor, BuiltInColorNavWrapper);
    // 注册渐变背景页面路由
    registry.register(MainRoutes.GradientBackground, GradientBackgroundNavWrapper);
    // 注册字体大小页面路由
    registry.register(MainRoutes.FontSize, FontSizeNavWrapper);
    // 注册间距页面路由
    registry.register(MainRoutes.Spacing, SpacingNavWrapper);
    // 注册尺寸页面路由
    registry.register(MainRoutes.Size, SizeNavWrapper);
    // 注册主题切换页面路由
    registry.register(MainRoutes.TnTheme, TnThemeNavWrapper);
    // 注册图标页面路由
    registry.register(MainRoutes.TnIcon, TnIconNavWrapper);
    // 注册按钮页面路由
    registry.register(MainRoutes.TnButton, TnButtonNavWrapper);
    // 注册标签页面路由
    registry.register(MainRoutes.TnTag, TnTagNavWrapper);
    // 注册徽标页面路由
    registry.register(MainRoutes.TnBadge, TnBadgeNavWrapper);
    // 注册加载页面路由
    registry.register(MainRoutes.TnLoading, TnLoadingNavWrapper);
    // 注册表单组件页面路由
    registry.register(MainRoutes.TnSwitch, TnSwitchNavWrapper);
    registry.register(MainRoutes.TnRadio, TnRadioNavWrapper);
    registry.register(MainRoutes.TnCheckbox, TnCheckboxNavWrapper);
    registry.register(MainRoutes.TnRate, TnRateNavWrapper);
    registry.register(MainRoutes.TnInput, TnInputNavWrapper);
    registry.register(MainRoutes.TnNumberBox, TnNumberBoxNavWrapper);
    registry.register(MainRoutes.TnSlider, TnSliderNavWrapper);
    registry.register(MainRoutes.TnPicker, TnPickerNavWrapper);
    registry.register(MainRoutes.TnDateTimePicker, TnDateTimePickerNavWrapper);
    registry.register(MainRoutes.TnRegionPicker, TnRegionPickerNavWrapper);
    registry.register(MainRoutes.TnImageUpload, TnImageUploadNavWrapper);
    registry.register(MainRoutes.TnCalendar, TnCalendarNavWrapper);
    registry.register(MainRoutes.TnWeekCalendar, TnWeekCalendarNavWrapper);
    registry.register(MainRoutes.TnForm, TnFormNavWrapper);
    registry.register(MainRoutes.TnImagePreview, TnImagePreviewNavWrapper);
    // 注册反馈组件页面路由
    registry.register(MainRoutes.TnPopup, TnPopupNavWrapper);
    registry.register(MainRoutes.TnModal, TnModalNavWrapper);
    registry.register(MainRoutes.TnNotify, TnNotifyNavWrapper);
    registry.register(MainRoutes.TnToast, TnToastNavWrapper);
    registry.register(MainRoutes.TnNoticeBar, TnNoticeBarNavWrapper);
    registry.register(MainRoutes.TnActionSheet, TnActionSheetNavWrapper);
    registry.register(MainRoutes.TnEmpty, TnEmptyNavWrapper);
    // 注册展示组件页面路由
    registry.register(MainRoutes.TnPhotoAlbum, TnPhotoAlbumNavWrapper);
    registry.register(MainRoutes.TnSwiper, TnSwiperNavWrapper);
    registry.register(MainRoutes.TnProgress, TnProgressNavWrapper);
    registry.register(MainRoutes.TnCountDown, TnCountDownNavWrapper);
    registry.register(MainRoutes.TnCountTo, TnCountToNavWrapper);
    registry.register(MainRoutes.TnCountScroll, TnCountScrollNavWrapper);
    registry.register(MainRoutes.TnReadMore, TnReadMoreNavWrapper);
    // 注册布局组件页面路由
    registry.register(MainRoutes.TnList, TnListNavWrapper);
    registry.register(MainRoutes.TnCollapse, TnCollapseNavWrapper);
    // 注册阴影页面路由
    registry.register(MainRoutes.Shadow, ShadowNavWrapper);
    // 注册毛玻璃效果页面路由
    registry.register(MainRoutes.BlurEffect, BlurEffectNavWrapper);
  }

  /**
   * 注册路由守卫
   * @param navigationService 导航服务
   */
  registerGuards(navigationService: NavigationService): void {
    // 主页模块不需要额外的守卫
  }

  /**
   * 模块初始化
   * @param context 模块上下文
   */
  async onInit(context: ModuleContext): Promise<void> {
    Logger.info(`[MainModule] 模块初始化完成: ${this.moduleName} v${this.version}`);
  }

  /**
   * 模块销毁
   */
  onDestroy(): void {
    Logger.info(`[MainModule] 模块已销毁: ${this.moduleName}`);
  }
}

/**
 * 创建主页模块实例
 */
export function createMainModule(): MainModule {
  return new MainModule();
}
