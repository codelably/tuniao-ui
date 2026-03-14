/**
 * @file TnList / TnListItem 列表展示页面视图
 * @author JunBin.Yang
 */

import { AppNavDestination } from "@core/components";
import {
  MediumPaddingVerticalScroll,
  P100,
  SpaceVerticalLarge,
  SpaceVerticalMedium
} from "@core/designsystem";
import { getWindowSafeAreaState, WindowSafeAreaState } from "@core/layoutstate";
import { TnList, TnListItem, TnIcon } from "@tuniao/tn-ui";
import TnListViewModel from "../viewmodel/TnListViewModel";

/**
 * TnList / TnListItem 列表展示页面
 */
@ComponentV2
export struct TnListPage {
  /**
   * 列表展示页面 ViewModel
   */
  @Local
  private vm: TnListViewModel = new TnListViewModel();
  /**
   * 窗口安全区状态
   */
  @Local
  private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  /**
   * 构建列表展示页面
   */
  build() {
    AppNavDestination({
      title: "列表",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.ListContent();
    }
  }

  /**
   * 列表内容视图
   */
  @Builder
  private ListContent(): void {
    MediumPaddingVerticalScroll() {
      Column() {
        // 1. 基础列表
        TnList({ title: "基础列表", description: "简单的文本列表项", card: true }) {
          TnListItem({ title: "联系客服", bottomBorder: true });
          TnListItem({ title: "帮助中心", bottomBorder: true });
          TnListItem({ title: "意见反馈" });
        }

        SpaceVerticalLarge();

        // 2. 带右侧图标与描述
        TnList({ title: "带右侧图标与描述", description: "rightIcon 设置图标，description 设置描述", card: true }) {
          TnListItem({
            title: "我的订单",
            description: "查看全部订单",
            rightIcon: "right",
            bottomBorder: true
          });
          TnListItem({
            title: "收货地址",
            description: "管理收货地址信息",
            rightIcon: "right",
            bottomBorder: true
          });
          TnListItem({ title: "联系客服", rightIcon: "right" });
        }

        SpaceVerticalLarge();

        // 3. 底部边框
        TnList({ title: "底部边框", description: "bottomBorder 显示边框，bottomBorderIndent 控制缩进", card: true }) {
          TnListItem({ title: "默认边框一", bottomBorder: true });
          TnListItem({ title: "默认边框二", bottomBorder: true });
          TnListItem({ title: "缩进边框一", bottomBorder: true, bottomBorderIndent: true });
          TnListItem({ title: "缩进边框二", bottomBorder: true, bottomBorderIndent: true });
          TnListItem({
            title: "自定义边框颜色",
            bottomBorder: true,
            dividerColor: $r("app.color.tn_color_primary_light_7")
          });
          TnListItem({ title: "最后一项" });
        }

        SpaceVerticalLarge();

        // 4. 圆角列表项
        TnList({ title: "圆角列表项", description: "使用 radius 显示圆角", card: true }) {
          Column({ space: 8 }) {
            TnListItem({ title: "圆角列表项一", radius: true, rightIcon: "right" });
            TnListItem({ title: "圆角列表项二", radius: true, rightIcon: "right" });
            TnListItem({ title: "圆角列表项三", radius: true, rightIcon: "right" });
          }
          .width(P100)
        }

        SpaceVerticalLarge();

        // 5. 列表分组（普通模式）
        TnList({ title: "基本设置" }) {
          TnListItem({ title: "账号与安全", rightIcon: "right", bottomBorder: true });
          TnListItem({ title: "消息通知", rightIcon: "right", bottomBorder: true });
          TnListItem({ title: "隐私设置", rightIcon: "right" });
        }

        SpaceVerticalMedium();

        TnList({ title: "其他设置" }) {
          TnListItem({ title: "清除缓存", rightIcon: "right", bottomBorder: true });
          TnListItem({ title: "关于我们", rightIcon: "right", bottomBorder: true });
          TnListItem({ title: "检查更新", rightIcon: "right" });
        }

        SpaceVerticalLarge();

        // 6. 卡片风格（inset 模式）
        TnList({ title: "卡片分组一", inset: true }) {
          TnListItem({ title: "列表项一", rightIcon: "right", bottomBorder: true });
          TnListItem({ title: "列表项二", rightIcon: "right", bottomBorder: true });
          TnListItem({ title: "列表项三", rightIcon: "right" });
        }

        SpaceVerticalMedium();

        TnList({ title: "卡片分组二", inset: true }) {
          TnListItem({ title: "设置A", rightIcon: "right", bottomBorder: true });
          TnListItem({ title: "设置B", rightIcon: "right" });
        }

        SpaceVerticalLarge();

        // 7. 自定义样式
        TnList({ title: "自定义样式", description: "bgColor / textColor / fontSize", card: true }) {
          Column({ space: 8 }) {
            TnListItem({
              title: "自定义背景色",
              bgColor: $r("app.color.tn_color_primary_light_9"),
              rightIcon: "right",
              radius: true
            });
            TnListItem({
              title: "自定义文字色",
              textColor: $r("app.color.tn_color_primary"),
              rightIcon: "right",
              radius: true
            });
            TnListItem({
              title: "自定义字体大小",
              fontSize: 18,
              rightIcon: "right",
              radius: true
            });
            TnListItem({
              title: "组合自定义样式",
              bgColor: $r("app.color.tn_color_success_light_9"),
              textColor: $r("app.color.tn_color_success"),
              fontSize: 16,
              rightIcon: "right",
              rightIconColor: $r("app.color.tn_color_success"),
              radius: true
            });
          }
          .width(P100)
        }

        SpaceVerticalLarge();

        // 8. 可点击与禁用
        TnList({ title: "可点击与禁用", description: "clickable 开启点击反馈，disabled 禁用", card: true }) {
          TnListItem({
            title: "可点击列表项（按下查看反馈）",
            clickable: true,
            rightIcon: "right",
            bottomBorder: true
          });
          TnListItem({
            title: "禁用列表项",
            disabled: true,
            rightIcon: "right",
            bottomBorder: true
          });
          TnListItem({
            title: "普通列表项（无点击反馈）",
            rightIcon: "right"
          });
        }

        SpaceVerticalLarge();

        // 9. 自定义内容（插槽）
        TnList({ title: "自定义内容", description: "使用 defaultBuilder 插槽", card: true }) {
          TnListItem({ rightIcon: "right", bottomBorder: true }) {
            Row({ space: 8 }) {
              TnIcon({ name: "home", iconSize: 20, color: $r("app.color.tn_color_primary") });
              Text("首页")
                .fontSize(14)
                .fontColor($r("app.color.tn_text_color_primary"));
            }
          }

          TnListItem({ rightIcon: "right", bottomBorder: true }) {
            Row({ space: 8 }) {
              TnIcon({ name: "my", iconSize: 20, color: $r("app.color.tn_color_success") });
              Text("个人中心")
                .fontSize(14)
                .fontColor($r("app.color.tn_text_color_primary"));
            }
          }

          TnListItem({ rightIcon: "right" }) {
            Row({ space: 8 }) {
              TnIcon({ name: "setting", iconSize: 20, color: $r("app.color.tn_color_warning") });
              Column({ space: 2 }) {
                Text("系统设置")
                  .fontSize(14)
                  .fontColor($r("app.color.tn_text_color_primary"));
                Text("管理应用配置和偏好")
                  .fontSize(12)
                  .fontColor($r("app.color.tn_text_color_secondary"));
              }
              .alignItems(HorizontalAlign.Start);
            }
          }
        }

        SpaceVerticalLarge();

        // 10. 点击事件
        TnList({ title: "点击事件", description: "点击列表项触发回调", card: true }) {
          if (this.vm.lastClickedItem.length > 0) {
            Text(`已点击: ${this.vm.lastClickedItem}  (共${this.vm.clickCount}次)`)
              .fontSize(12)
              .fontColor($r("app.color.tn_color_primary"))
              .padding({ left: 15, right: 15, top: 8, bottom: 8 });
          }

          TnListItem({
            title: "订单管理",
            rightIcon: "right",
            clickable: true,
            bottomBorder: true,
            onItemClick: () => {
              this.vm.handleItemClick("订单管理");
            }
          });
          TnListItem({
            title: "收藏夹",
            rightIcon: "right",
            clickable: true,
            bottomBorder: true,
            onItemClick: () => {
              this.vm.handleItemClick("收藏夹");
            }
          });
          TnListItem({
            title: "浏览历史",
            rightIcon: "right",
            clickable: true,
            bottomBorder: true,
            onItemClick: () => {
              this.vm.handleItemClick("浏览历史");
            }
          });
          TnListItem({
            title: "客服中心",
            rightIcon: "right",
            clickable: true,
            onItemClick: () => {
              this.vm.handleItemClick("客服中心");
            }
          });
        }
      }
      .width(P100);
    };
  }
}
