<p align="center">
    <img src="https://hm.tuniaokj.com/tuniao-logo.svg" width="150">
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

本项目将 [TuniaoUI Vue3](https://github.com/tuniaoTech/tuniaoui-rc-vue3-uniapp) 设计体系移植到鸿蒙生态，为 HarmonyOS 应用开发者提供开箱即用的高质量组件。

## 特性

- **原生 ArkTS** -- 完全使用 ArkTS 编写，无跨平台桥接开销
- **主题系统** -- 全局主题化，支持 6 大主题色 + 19 种内置命名色
- **设计规范** -- 完整的间距、字体、圆角、阴影、毛玻璃分级体系
- **V2 状态管理** -- 全面采用 `@ObservedV2` / `AppStorageV2` 等最新状态管理方案
- **MVVM 架构** -- View 层纯渲染，业务逻辑封装在 ViewModel 中

## 组件列表

| 分类 | 组件                                                                                                                               |
|------|----------------------------------------------------------------------------------------------------------------------------------|
| 基础组件 | Icon 图标、Button 按钮、Tag 标签、Badge 徽标、Loading 加载                                                                                     |
| 表单组件 | Switch 开关、Radio 单选框、Checkbox 复选框、Rate 评分、Input 输入框、NumberBox 步进器、Slider 滑块、ImageUpload 图片上传、Calendar 日历、WeekCalendar 周日历、Form 表单 |
| 选择器 | Picker 选择器、DateTimePicker 日期时间选择器、RegionPicker 地区选择器                                                                             |
| 展示组件 | ImagePreview 图片预览、PhotoAlbum 相册、Swiper 轮播图、Progress 进度条、CountDown 倒计时、CountTo 数字跳转、CountScroll 数字滚动                                              |
| 反馈组件 | Popup 弹出框、Modal 模态框、Notify 消息通知、Toast 轻提示、NoticeBar 通知栏                                                                          |
| 布局组件 | List 列表、Collapse 折叠面板                                                                                                            |

> 持续开发中，更多组件正在移植适配。

## 项目结构

```
tuniao-ui/
  entry/             # 应用入口
  core/
    tuniaoui/        # TuniaoUI 组件库（核心开发目录）
    base/            # 基础层
    common/          # 公共工具
    designsystem/    # 设计系统
    navigation/      # 导航框架
    ...
  shared/
    contracts/       # 共享契约
    state/           # 共享状态
    types/           # 共享类型
  packages/
    main/            # 组件示例展示应用
```

采用 HCompass 四层架构：`entry` -> `core` -> `shared` -> `packages`。

## 快速开始

### 环境要求

- **DevEco Studio** 5.0 或更高版本
- **HarmonyOS SDK** API 12+

### 克隆与构建

```bash
git clone https://github.com/codelably/tuniao-ui.git
```

1. 使用 DevEco Studio 打开项目
2. 等待 IDE 自动同步依赖
3. 选择设备或模拟器，点击 Run 即可运行示例应用

### 命令行构建

```bash
# 构建 HAP
node "path/to/DevEco Studio/tools/node/node.exe" \
  "path/to/DevEco Studio/tools/hvigor/bin/hvigorw.js" \
  assembleHap -p product=default
```

## 使用示例

```typescript
import { TnButton } from "@tuniao/tn-ui";

@Entry
@ComponentV2
struct MyPage {
  build() {
    Column() {
      TnButton({ text: "主要按钮", type: "primary" })
      TnButton({ text: "成功按钮", type: "success" })
      TnButton({ text: "警告按钮", type: "warning" })
    }
  }
}
```

## 主题定制

所有组件通过 `baseStyle` 获取主题样式，支持全局统一配置颜色、字体、间距、圆角等：

```typescript
import { getThemeColor, getFontSizeByKey } from "@tuniao/tn-ui";

// 获取主题色
const primaryColor = getThemeColor(this.baseStyle, "primary");

// 获取字体大小
const fontSize = getFontSizeByKey(this.baseStyle, "fontSize");
```

支持的主题色：`primary` / `success` / `warning` / `danger` / `error` / `info`，每种均含标准、浅色、深色变种。

## 参与贡献

欢迎开发者参与共建！无论是提交 Bug 报告、改进文档，还是贡献新组件，我们都非常欢迎。

### 贡献流程

1. **Fork** 本仓库
2. 基于 `master` 分支创建特性分支：`git checkout -b feat/my-component`
3. 编写代码并确保遵循项目编码规范（见下方）
4. 提交变更，使用约定式提交格式：`feat: add xxx component`
5. 推送分支并创建 Pull Request

### 开发规范

- **ArkTS 语法约束** -- 请严格遵循 ArkTS 与标准 TypeScript 的差异（不支持 `any`、解构、`for...in` 等）
- **主题规范** -- 所有颜色、字体、间距、圆角均通过 baseStyle 获取，严禁硬编码
- **V2 状态管理** -- 使用 `@ObservedV2` / `@Local` / `AppStorageV2`，禁用 V1 API
- **代码风格** -- `camelCase` 变量、`PascalCase` 类、双引号、分号结尾、禁用 `var`/`any`
- **提交规范** -- `feat:` / `fix:` / `refactor:` / `docs:` / `test:`

### 新组件贡献指南

1. 在 `core/tuniaoui/src/main/ets/components/` 下创建组件目录
2. 在 `packages/main/` 中添加对应的示例页面，覆盖主要参数场景

## 微信群
如微信群链接失效，请添加微信好友, 备注 "图鸟UI"
<div style="display: flex; gap: 20px;">
  <img src="https://hm.tuniaokj.com/wx.jpg" alt="微信群" style="height: 350px; width: auto;" />
  <img src="https://hm.tuniaokj.com/robot_wx.jpg" alt="微信助手" style="height: 350px; width: auto;" />
</div>

## 相关资源

- [TuniaoUI Vue3 版](https://vue3.tuniaokj.com/) -- 原版 Vue3 组件库
- [HarmonyOS 开发者文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/application-dev-guide) -- ArkTS 开发指南

## 开源协议

本项目基于 [Apache License](./LICENSE) 开源。
