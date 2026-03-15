<p align="center">
    <img src="https://vue3.tuniaokj.com/images/tuniao-logo.svg" width="150">
</p>

<p align="center">TuniaoUI - 基于 HarmonyOS ArkTS 的原生 UI 组件库</p>

<p align="center">
    <a href="https://hm.tuniaokj.com/" target="_blank">文档</a>
    ❤️
    <a href="https://github.com/codelably/tuniao-ui" target="_blank">Github</a>
    ❤️
    <a href="https://gitcode.com/codelably/tuniao-ui" target="_blank">AtomGit</a>
</p>

---

## 特性

- 基于 ArkTS + ArkUI 声明式开发，使用 V2 状态管理
- 完整的主题系统，统一管理颜色、字体、间距、圆角、阴影等设计令牌
- 6 大主题色 + 19 种内置颜色，支持运行时主题切换
- 几十款高质量组件，持续扩展中

## 环境要求

- HarmonyOS SDK: API 12+
- DevEco Studio: 5.0+

## 安装

```bash
ohpm install @tuniao/tn-ui
```

## 快速开始

### 初始化

在 `EntryAbility.ets` 中初始化：

```typescript
import { TnUIInitializer } from "@tuniao/tn-ui";

export default class EntryAbility extends UIAbility {
  onWindowStageCreate(windowStage: window.WindowStage): void {
    TnUIInitializer.initTnUI(windowStage, this.context);
  }
}
```

### 使用组件

```typescript
import { TnButton } from "@tuniao/tn-ui";

@Entry
@ComponentV2
struct DemoPage {
  build() {
    Column() {
      TnButton({
        content: "主要按钮",
        type: "primary",
        onBtnClick: () => {
          console.info("按钮被点击了");
        },
      })
    }
  }
}
```

## 组件列表

| 分类 | 组件 |
|------|------|
| 基础组件 | Icon 图标、Button 按钮、Tag 标签、Badge 徽标、Loading 加载 |
| 表单组件 | Switch 开关、Radio 单选框、Checkbox 复选框、Rate 评分、Input 输入框、NumberBox 步进器、Slider 滑块、ImageUpload 图片上传、Calendar 日历、WeekCalendar 周日历、Form 表单 |
| 选择器 | Picker 选择器、DateTimePicker 日期时间选择器、RegionPicker 地区选择器 |
| 展示组件 | ImagePreview 图片预览 |
| 反馈组件 | Popup 弹出框 |
| 布局组件 | List 列表 |

## 微信群
请添加微信好友, 备注 "图鸟UI"
<div style="display: flex; gap: 20px;">
  <img src="./example/wx.jpg" alt="微信群" style="height: 500px; width: auto;" />
</div>

## 许可证

[Apache License](./LICENSE)
