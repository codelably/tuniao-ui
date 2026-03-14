/**
 * @file TnPicker 选择器展示页面视图
 * @description 使用 TnPopup 从底部弹出选择器，展示各种选择器用法
 * @author JunBin.Yang
 */
import { AppNavDestination } from "@core/components";
import {
  ColumnBase,
  MediumPaddingVerticalScroll,
  P100,
  SpaceVerticalLarge,
  SpaceVerticalMedium
} from "@core/designsystem";
import { getWindowSafeAreaState, WindowSafeAreaState } from "@core/layoutstate";
import { TnButton, TnPicker, TnPickerColumnItem, TnPickerValueType, TnPopup } from "@tuniao/tn-ui";
import TnPickerViewModel from "../viewmodel/TnPickerViewModel";

@ComponentV2
export struct TnPickerPage {
  @Local private vm: TnPickerViewModel = new TnPickerViewModel();
  @Local private windowSafeAreaState: WindowSafeAreaState = getWindowSafeAreaState();

  /** 单列数据 */
  @Local private pickerData: TnPickerColumnItem[][] = [
    [
      { label: "选项一", value: "1" },
      { label: "选项二", value: "2" },
      { label: "选项三", value: "3" }
    ]
  ];

  /** 多列数组数据：星期 + 时段 */
  @Local private multiColumnData: TnPickerColumnItem[][] = [
    [
      { label: "星期一", value: "mon" },
      { label: "星期二", value: "tue" },
      { label: "星期三", value: "wed" },
      { label: "星期四", value: "thu" },
      { label: "星期五", value: "fri" },
      { label: "星期六", value: "sat" },
      { label: "星期日", value: "sun" }
    ],
    [
      { label: "上午", value: "am" },
      { label: "下午", value: "pm" },
      { label: "晚上", value: "evening" }
    ]
  ];

  /** 多列对象数组数据：3列数值组 */
  @Local private multiObjData: TnPickerColumnItem[][] = [
    [
      { label: "2022", value: 2022 },
      { label: "2023", value: 2023 },
      { label: "2024", value: 2024 },
      { label: "2025", value: 2025 },
      { label: "2026", value: 2026 }
    ],
    [
      { label: "第一季度", value: 1 },
      { label: "第二季度", value: 2 },
      { label: "第三季度", value: 3 },
      { label: "第四季度", value: 4 }
    ],
    [
      { label: "第1周", value: 1 },
      { label: "第2周", value: 2 },
      { label: "第3周", value: 3 },
      { label: "第4周", value: 4 }
    ]
  ];

  /** 联动数据：菜系分类 */
  @Local private cascadeData: TnPickerColumnItem[] = [
    {
      label: "中餐", value: "chinese", children: [
        {
          label: "川菜", value: "sichuan", children: [
            { label: "麻婆豆腐", value: "mapo_tofu" },
            { label: "回锅肉", value: "twice_cooked_pork" },
            { label: "水煮鱼", value: "boiled_fish" }
          ]
        },
        {
          label: "粤菜", value: "cantonese", children: [
            { label: "白切鸡", value: "white_cut_chicken" },
            { label: "烧鹅", value: "roast_goose" },
            { label: "叉烧", value: "char_siu" }
          ]
        }
      ]
    },
    {
      label: "西餐", value: "western", children: [
        {
          label: "意餐", value: "italian", children: [
            { label: "披萨", value: "pizza" },
            { label: "意面", value: "pasta" },
            { label: "烩饭", value: "risotto" }
          ]
        },
        {
          label: "法餐", value: "french", children: [
            { label: "牛排", value: "steak" },
            { label: "鹅肝", value: "foie_gras" },
            { label: "蜗牛", value: "escargot" }
          ]
        }
      ]
    },
    {
      label: "日料", value: "japanese", children: [
        {
          label: "寿司", value: "sushi", children: [
            { label: "三文鱼寿司", value: "salmon_sushi" },
            { label: "金枪鱼寿司", value: "tuna_sushi" }
          ]
        },
        {
          label: "拉面", value: "ramen", children: [
            { label: "豚骨拉面", value: "tonkotsu" },
            { label: "味噌拉面", value: "miso" }
          ]
        }
      ]
    }
  ];

  build() {
    AppNavDestination({
      title: "选择器",
      viewModel: this.vm,
      paddingValue: {
        top: this.windowSafeAreaState.topInset,
        left: this.windowSafeAreaState.leftInset,
        right: this.windowSafeAreaState.rightInset,
      }
    }) {
      this.PageContent();
      // 基础单列选择器
      TnPopup({
        visible: this.vm.pickerOpen,
        $visible: (val: boolean) => { this.vm.pickerOpen = val; },
        openDirection: "bottom",
        radius: 0,
        contentBuilder: () => { this.PickerSingle(); }
      });
      // 多列数组选择器
      TnPopup({
        visible: this.vm.multiColumnOpen,
        $visible: (val: boolean) => { this.vm.multiColumnOpen = val; },
        openDirection: "bottom",
        radius: 0,
        contentBuilder: () => { this.PickerMultiColumn(); }
      });
      // 多列对象数组选择器
      TnPopup({
        visible: this.vm.multiObjOpen,
        $visible: (val: boolean) => { this.vm.multiObjOpen = val; },
        openDirection: "bottom",
        radius: 0,
        contentBuilder: () => { this.PickerMultiObj(); }
      });
      // 联动选择器
      TnPopup({
        visible: this.vm.cascadeOpen,
        $visible: (val: boolean) => { this.vm.cascadeOpen = val; },
        openDirection: "bottom",
        radius: 0,
        contentBuilder: () => { this.PickerCascade(); }
      });
    }
  }

  /**
   * 单列选择器内容
   */
  @Builder private PickerSingle(): void {
    TnPicker({
      open: true,
      data: this.pickerData,
      onConfirm: (value: TnPickerValueType, _index: number | number[]) => {
        if (typeof value === "string") {
          this.vm.onPickerConfirm(value);
        } else if (Array.isArray(value)) {
          const strArr: string[] = [];
          for (let i = 0; i < value.length; i++) {
            strArr.push(String(value[i]));
          }
          this.vm.onPickerConfirm(strArr);
        }
      },
      onCancel: () => { this.vm.closePicker(); },
      onClose: () => { this.vm.closePicker(); }
    });
  }

  /**
   * 多列数组选择器内容
   */
  @Builder private PickerMultiColumn(): void {
    TnPicker({
      open: true,
      data: this.multiColumnData,
      title: "选择星期和时段",
      onConfirm: (value: TnPickerValueType, _index: number | number[]) => {
        if (Array.isArray(value)) {
          this.vm.onMultiColumnConfirm(value as Array<string | number>);
        }
      },
      onCancel: () => { this.vm.multiColumnOpen = false; },
      onClose: () => { this.vm.multiColumnOpen = false; }
    });
  }

  /**
   * 多列对象数组选择器内容
   */
  @Builder private PickerMultiObj(): void {
    TnPicker({
      open: true,
      data: this.multiObjData,
      title: "选择年/季度/周",
      onConfirm: (value: TnPickerValueType, _index: number | number[]) => {
        if (Array.isArray(value)) {
          this.vm.onMultiObjConfirm(value as Array<string | number>);
        }
      },
      onCancel: () => { this.vm.multiObjOpen = false; },
      onClose: () => { this.vm.multiObjOpen = false; }
    });
  }

  /**
   * 联动选择器内容
   */
  @Builder private PickerCascade(): void {
    TnPicker({
      open: true,
      cascadeData: this.cascadeData,
      title: "选择菜系",
      onConfirm: (value: TnPickerValueType, _index: number | number[]) => {
        if (Array.isArray(value)) {
          this.vm.onCascadeConfirm(value as Array<string | number>);
        }
      },
      onCancel: () => { this.vm.cascadeOpen = false; },
      onClose: () => { this.vm.cascadeOpen = false; }
    });
  }

  @Builder private PageContent(): void {
    MediumPaddingVerticalScroll() {
      ColumnBase({ widthValue: P100 }) {
        // 基础用法
        this.SectionTitle("基础用法");
        SpaceVerticalMedium();
        Column() {
          TnButton({
            content: "打开选择器",
            onBtnClick: () => { this.vm.togglePicker(); }
          });
          SpaceVerticalMedium();
          Text(`已选择：${this.vm.selectedLabel || "（未选择）"}`)
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_secondary"));
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 多列数组
        this.SectionTitle("多列数组");
        SpaceVerticalMedium();
        Column() {
          TnButton({
            content: "打开多列选择器",
            onBtnClick: () => { this.vm.toggleMultiColumn(); }
          });
          SpaceVerticalMedium();
          Text(`已选择：${this.vm.multiColumnLabel || "（未选择）"}`)
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_secondary"));
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 多列对象数组
        this.SectionTitle("多列对象数组");
        SpaceVerticalMedium();
        Column() {
          TnButton({
            content: "打开多列对象选择器",
            onBtnClick: () => { this.vm.toggleMultiObj(); }
          });
          SpaceVerticalMedium();
          Text(`已选择：${this.vm.multiObjLabel || "（未选择）"}`)
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_secondary"));
        }
        .width(P100)
        .padding($r("app.float.space_padding_medium"))
        .backgroundColor($r("app.color.bg_white"))
        .borderRadius($r("app.float.radius_medium"));

        SpaceVerticalLarge();

        // 联动选择器
        this.SectionTitle("联动选择器");
        SpaceVerticalMedium();
        Column() {
          TnButton({
            content: "打开联动选择器",
            onBtnClick: () => { this.vm.toggleCascade(); }
          });
          SpaceVerticalMedium();
          Text(`已选择：${this.vm.cascadeLabel || "（未选择）"}`)
            .fontSize($r("app.float.body_medium"))
            .fontColor($r("app.color.text_secondary"));
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
}
