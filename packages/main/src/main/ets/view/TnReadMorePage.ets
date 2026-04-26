/**
 * @file TnReadMore 阅读更多展示页面视图
 * @author JunBin.Yang
 */
import { AppNavDestination } from "@core/components";
import {
  ColumnBase,
  MediumPaddingVerticalScroll,
  P100,
  SpaceVerticalLarge,
  SpaceVerticalMedium,
  SpaceVerticalSmall
} from "@core/designsystem";
import { getWindowSafeAreaState, WindowSafeAreaState } from "@core/layoutstate";
import { TnReadMore, TnUIBaseStyle, TnUIBaseStyleType } from "@tuniao/tn-ui";
import { TnAppStorageKey } from "@tuniao/tn-ui/src/main/ets/common/storage_key";
import { AppStorageV2 } from "@kit.ArkUI";
import TnReadMoreViewModel from "../viewmodel/TnReadMoreViewModel";

@ComponentV2
export struct TnReadMorePage {
  @Local private vm: TnReadMoreViewModel = new TnReadMoreViewModel();
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();
  @Local private baseStyle: TnUIBaseStyleType = AppStorageV2.connect(TnUIBaseStyle, TnAppStorageKey.BASE_STYLE)!;

  build() {
    AppNavDestination({
      title: "阅读更多",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.PageContent();
    }
  }

  @Builder private PageContent() {
    MediumPaddingVerticalScroll() {
      ColumnBase({ widthValue: P100 }) {
        // ===== 基础用法 =====
        this.SectionTitle("基础用法");
        this.SectionDesc("默认收起高度 125vp，超出内容可展开查看");
        SpaceVerticalSmall();
        Column() {
          TnReadMore({
            expand: this.vm.basicExpand,
            $expand: (val: boolean) => { this.vm.basicExpand = val; }
          }) {
            this.LongTextContent();
          }
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 自定义收起高度 =====
        this.SectionTitle("自定义收起高度");
        this.SectionDesc("设置 height 为 80，收起时只显示较少内容");
        SpaceVerticalSmall();
        Column() {
          TnReadMore({
            expand: this.vm.customHeightExpand,
            $expand: (val: boolean) => { this.vm.customHeightExpand = val; },
            collapseHeight: 80
          }) {
            this.LongTextContent();
          }
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 自定义文案和图标 =====
        this.SectionTitle("自定义文案和图标");
        this.SectionDesc("自定义展开/收起的文案和图标");
        SpaceVerticalSmall();
        Column() {
          TnReadMore({
            expand: this.vm.customTextExpand,
            $expand: (val: boolean) => { this.vm.customTextExpand = val; },
            expandText: "付费查看全文",
            expandIcon: "lock",
            foldText: "收起全文",
            foldIcon: "up-arrow"
          }) {
            this.LongTextContent();
          }
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 隐藏收起按钮 =====
        this.SectionTitle("隐藏收起按钮");
        this.SectionDesc("设置 showFold 为 false，展开后不显示收起按钮");
        SpaceVerticalSmall();
        Column() {
          TnReadMore({
            expand: this.vm.hideFoldExpand,
            $expand: (val: boolean) => { this.vm.hideFoldExpand = val; },
            showFold: false
          }) {
            this.LongTextContent();
          }
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 自定义颜色 =====
        this.SectionTitle("自定义颜色");
        this.SectionDesc("通过 tipColor 或 colorType 设置操作区域颜色");
        SpaceVerticalSmall();
        Column() {
          TnReadMore({
            expand: this.vm.customColorExpand,
            $expand: (val: boolean) => { this.vm.customColorExpand = val; },
            colorType: "danger"
          }) {
            this.LongTextContent();
          }
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 一次性展开 =====
        this.SectionTitle("一次性展开");
        this.SectionDesc("设置 once 为 true，展开后不再显示收起按钮");
        SpaceVerticalSmall();
        Column() {
          TnReadMore({
            expand: this.vm.onceExpand,
            $expand: (val: boolean) => { this.vm.onceExpand = val; },
            once: true
          }) {
            this.LongTextContent();
          }
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 默认展开 =====
        this.SectionTitle("默认展开");
        this.SectionDesc("设置 expand 为 true，初始时内容已展开");
        SpaceVerticalSmall();
        Column() {
          TnReadMore({
            expand: this.vm.defaultExpand,
            $expand: (val: boolean) => { this.vm.defaultExpand = val; }
          }) {
            this.LongTextContent();
          }
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 展开前拦截 =====
        this.SectionTitle("展开前拦截");
        this.SectionDesc("通过 beforeExpand 回调拦截展开操作，模拟异步校验");
        SpaceVerticalSmall();
        Column() {
          TnReadMore({
            expand: this.vm.beforeExpandDemo,
            $expand: (val: boolean) => { this.vm.beforeExpandDemo = val; },
            expandText: "验证后查看",
            beforeExpand: (): Promise<boolean> => {
              return new Promise<boolean>((resolve) => {
                setTimeout(() => {
                  resolve(true);
                }, 1000);
              });
            }
          }) {
            this.LongTextContent();
          }
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // ===== 事件回调 =====
        this.SectionTitle("事件回调");
        this.SectionDesc("监听展开和收起事件");
        SpaceVerticalSmall();
        Column() {
          TnReadMore({
            expand: this.vm.eventExpand,
            $expand: (val: boolean) => { this.vm.eventExpand = val; },
            onExpand: () => { this.vm.logExpand(); },
            onFold: () => { this.vm.logFold(); }
          }) {
            this.LongTextContent();
          }
          if (this.vm.eventLog) {
            SpaceVerticalSmall();
            Text(this.vm.eventLog)
              .fontSize($r("app.float.body_medium"))
              .fontColor($r("app.color.text_secondary"))
              .width(P100);
          }
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();
      };
    };
  }

  @Builder private SectionTitle(title: string): void {
    Text(title)
      .fontSize($r("app.float.headline_medium"))
      .fontColor($r("app.color.text_primary"))
      .fontWeight(FontWeight.Bold);
  }

  @Builder private SectionDesc(desc: string): void {
    Text(desc)
      .fontSize($r("app.float.body_medium"))
      .fontColor($r("app.color.text_secondary"));
  }

  @Builder private LongTextContent(): void {
    Text("噫吁嚱，危乎高哉！蜀道之难，难于上青天！蚕丛及鱼凫，开国何茫然！尔来四万八千岁，" +
      "不与秦塞通人烟。西当太白有鸟道，可以横绝峨眉巅。地崩山摧壮士死，然后天梯石栈相钩连。" +
      "上有六龙回日之高标，下有冲波逆折之回川。黄鹤之飞尚不得过，猿猱欲度愁攀援。青泥何盘盘，" +
      "百步九折萦岩峦。扪参历井仰胁息，以手抚膺坐长叹。\n\n" +
      "问君西游何时还？畏途巉岩不可攀。但见悲鸟号古木，雄飞雌从绕林间。又闻子规啼夜月，" +
      "愁空山。蜀道之难，难于上青天，使人听此凋朱颜！连峰去天不盈尺，枯松倒挂倚绝壁。" +
      "飞湍瀑流争喧豗，砯崖转石万壑雷。其险也如此，嗟尔远道之人胡为乎来哉！\n\n" +
      "剑阁峥嵘而崔嵬，一夫当关，万夫莫开。所守或匪亲，化为狼与豺。朝避猛虎，夕避长蛇，" +
      "磨牙吮血，杀人如麻。锦城虽云乐，不如早还家。蜀道之难，难于上青天，侧身西望长咨嗟！")
      .fontSize($r("app.float.body_medium"))
      .fontColor($r("app.color.text_primary"))
      .lineHeight(this.baseStyle.lineHeightLg)
      .width(P100);
  }
}
