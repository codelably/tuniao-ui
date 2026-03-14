/**
 * @file 关于页面 ViewModel
 * @author JunBin.Yang
 */
import { BaseViewModel } from "@core/base";
import { Want } from "@kit.AbilityKit";
import { bundleManager } from "@kit.AbilityKit";
import common from "@ohos.app.ability.common";
import { ContextUtil } from "@core/util";
import { AboutLinkItem } from "../models/AboutLinkItem";
import { TuniaoUIVersion } from "@tuniao/tn-ui";

@ObservedV2
export default class AboutViewModel extends BaseViewModel {
  /** UIAbility 上下文 */
  private context: common.UIAbilityContext = ContextUtil.getUIAbilityCtx();

  /** 版本号 */
  readonly tnVersion: string = TuniaoUIVersion;

  /** 项目信息链接列表 */
  readonly infoLinks: AboutLinkItem[] = [
    {
      title: $r("app.string.main_component_link_doc_title"),
      url: $r("app.string.main_component_link_doc_url")
    },
    {
      title: $r("app.string.main_about_link_github_title"),
      url: $r("app.string.main_about_link_github_url")
    },
    {
      title: $r("app.string.main_about_link_atomgit_title"),
      url: $r("app.string.main_about_link_atomgit_url")
    },
  ];

  /** 友情链接列表 */
  readonly friendLinks: AboutLinkItem[] = [
    {
      title: $r("app.string.main_about_link_hcompass_title"),
      description: $r("app.string.main_about_link_hcompass_desc"),
      url: $r("app.string.main_about_link_doc_url")
    },
    {
      title: $r("app.string.main_about_link_ibest_title"),
      description: $r("app.string.main_about_link_ibest_desc"),
      url: $r("app.string.main_about_link_ibest_url")
    },
    {
      title: $r("app.string.main_about_link_orm_title"),
      description: $r("app.string.main_about_link_orm_desc"),
      url: $r("app.string.main_about_link_orm_url")
    }
  ];

  /**
   * 打开链接
   * @param urlRes 链接资源
   */
  openUrl(urlRes: Resource): void {
    try {
      const url: string = this.context.resourceManager.getStringSync(urlRes.id);
      const want: Want = {
        action: "ohos.want.action.viewData",
        entities: ["entity.system.browsable"],
        uri: url
      };
      this.context.startAbility(want).catch((error: Error) => {
        console.error(`打开链接失败: ${JSON.stringify(error)}`);
      });
    } catch (error) {
      console.error(`打开链接失败: ${JSON.stringify(error)}`);
    }
  }
}
