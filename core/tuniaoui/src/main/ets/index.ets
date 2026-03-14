import common from "@ohos.app.ability.common";
import { AppStorageV2, display, window } from "@kit.ArkUI";
import { ContextUtil } from "./utils/ContextUtil";
import { TnAppStorageKey } from "./common/storage_key";
import { saveBaseDataToStorage } from "./utils/Utils";
import { bundleManager } from "@kit.AbilityKit";
import { TnUISetUIBaseStyle } from "./theme-chalk";
import { ObjectAssign } from "./utils/ObjectAssign";
import { TnGlobalConfig, TnGlobalConfigType } from "./common/types";

/**
 * @file Tuniao UI 初始化管理器
 */
export class TnUIInitializer {
  public static windowStage: window.WindowStage;
  // 屏幕信息
  public static screenWidth: number = 0;
  public static screenHeight: number = 0;
  public static isApp: boolean = false;

  /**
   * 初始化 Tuniao UI 组件库
   * @param {window.WindowStage} windowStage - 窗口阶段
   * @param {common.UIAbilityContext} context - UIAbility 上下文
   * @returns {void} 无返回值
   */
  static initTnUI(windowStage: window.WindowStage, context: common.UIAbilityContext): void {
    TnUIInitializer.windowStage = windowStage;
    TnUIInitializer.setGlobalConfig();
    ContextUtil.init(context);
    // 获取屏幕尺寸 顶部和底部规避尺寸
    TnUIInitializer.getScreenAndAvoidSize();
    // 获取是否是应用
    TnUIInitializer.getBundleType();
    // 设置旋转监听
    TnUIInitializer.screenRotateListener();
    // 监听颜色模式变化
    TnUIInitializer.setColorModeListener();
    // 注册字体
    windowStage.getMainWindowSync().getUIContext().getFont().registerFont({
      familyName: 'TnFont',
      familySrc: $rawfile('tuniao_icon_font.woff')
    });
  }

  /**
   * 设置全局配置
   */
  public static setGlobalConfig(option?: Partial<TnGlobalConfigType>) {
    let config = AppStorageV2.connect(TnGlobalConfig, TnAppStorageKey.GLOBAL_CONFIG, () => new TnGlobalConfig(option));
    if (config) {
      ObjectAssign(config, option);
    } else {
      AppStorageV2.connect(TnGlobalConfig, TnAppStorageKey.GLOBAL_CONFIG, () => new TnGlobalConfig(option));
    }
    TnUISetUIBaseStyle();
  }

  /**
   * 获取规避尺寸
   */
  private static getScreenAndAvoidSize() {
    try {
      const mainWindow: window.Window = TnUIInitializer.windowStage.getMainWindowSync();
      const screenInfo: window.WindowProperties = mainWindow.getWindowProperties();
      const avoidArea = mainWindow.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
      const systemDht = mainWindow.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);
      const topSize = TnUIInitializer.px2vp(avoidArea.topRect.height);
      const navigationSize = TnUIInitializer.px2vp(systemDht.bottomRect.height);
      const o = display.getDefaultDisplaySync().orientation;
      TnUIInitializer.screenWidth = TnUIInitializer.px2vp(screenInfo.windowRect.width);
      TnUIInitializer.screenHeight = TnUIInitializer.px2vp(screenInfo.windowRect.height);
      saveBaseDataToStorage(TnAppStorageKey.IS_LANDSCAPE, o == 1 || o == 3)
      saveBaseDataToStorage(TnAppStorageKey.TOP_AVOID_HEIGHT, topSize)
      saveBaseDataToStorage(TnAppStorageKey.BOTTOM_BAR_HEIGHT, navigationSize)
      mainWindow.on("avoidAreaChange", data => {
        if (data.type == window.AvoidAreaType.TYPE_KEYBOARD) {
          saveBaseDataToStorage(TnAppStorageKey.KEYBOARD_HEIGHT, TnUIInitializer.px2vp(data.area.bottomRect.height))
        }
      })
    } catch (e) {
      console.error(e.code, e.message)
    }
  }

  /**
   * 是否是元服务
   */
  private static getBundleType() {
    TnUIInitializer.isApp = bundleManager.getBundleInfoForSelfSync(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION).appInfo.bundleType == bundleManager.BundleType.APP;
  }

  /**
   * 监听配置变化
   */
  private static setColorModeListener() {
    let appContext = ContextUtil.getAppCtx();
    saveBaseDataToStorage(TnAppStorageKey.COLOR_MODE, ContextUtil.getUIAbilityCtx().config.colorMode as number);
    saveBaseDataToStorage(TnAppStorageKey.LANGUAGE, ContextUtil.getUIAbilityCtx().config.language as string);
    appContext.on('environment', {
      onConfigurationUpdated(config) {
        saveBaseDataToStorage(TnAppStorageKey.COLOR_MODE, config.colorMode);
        saveBaseDataToStorage(TnAppStorageKey.LANGUAGE, config.language);
      },
      onMemoryLevel() {}
    })
  }

  /**
   * 监听屏幕旋转
   */
  private static screenRotateListener() {
    display.on("change", () => {
      setTimeout(() => {
        TnUIInitializer.getScreenAndAvoidSize()
      }, 300)
    })
  }

  /**
   * 尺寸转换
   */
  public static px2vp(value: number) {
    return ContextUtil.getUICtx().px2vp(value);
  }

  public static vp2px(value: number) {
    return ContextUtil.getUICtx().vp2px(value);
  }
}
