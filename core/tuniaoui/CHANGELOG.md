# 版本记录

## 1.0.3

##### 新增：
1. 新增 TnToast 轻提示 组件；
2. 新增 TnNoticeBar 通知栏 组件；
3. 新增 TnPhotoAlbum 相册 组件；
4. 新增 TnSwiper 轮播图 组件；

## 1.0.2

##### 新增：
1. 新增 TnModal 模态框 组件；
2. 新增 TnNotify 消息通知 组件；
3. 新增 TnCollapse 折叠面板 组件；

##### bug修复：
1. 修复 TnCalendar 日历 组件范围选择时渲染错误问题。

## 1.0.1

更新开源协议

## 1.0.0 - 6.0.1(21)

_2026-03 首个正式版本_

### 基础组件

- **Icon 图标** — 字体图标与图片图标，支持主题色、自定义颜色/尺寸/圆角
- **Button 按钮** — 多类型/尺寸/形状，朴素、文本、图标模式，阴影、加载、禁用、点击防抖
- **Tag 标签** — 多类型/尺寸/形状，朴素模式，可关闭标签
- **Badge 徽标** — 数字/圆点模式，最大值溢出，绝对定位偏移
- **Loading 加载** — circle/flower/semicircle 三种动画模式，自定义尺寸与加载文字

### 表单组件

- **Switch 开关** — 自定义激活值/颜色/文字/图标，square/round 形状，加载态
- **Radio 单选框** — RadioGroup 分组管理，自定义颜色，边框样式，水平/换行排列
- **Checkbox 复选框** — CheckboxGroup 分组管理，min/max 限制数量，半选状态，square/circle 形状
- **Rate 评分** — 半星评分，自定义图标/颜色/间距，只读模式
- **Input 输入框** — text/number/password/textarea/digit/idcard 输入类型，清除、密码可见、字数统计、下划线样式、前后插槽
- **NumberBox 步进器** — 步长/范围限制，长按连续增减，自定义样式
- **Slider 滑块** — 步长控制，自定义轨道颜色/尺寸，拖动中与松手回调
- **ImageUpload 图片上传** — 多选、限制数量、多列布局、预览大图、删除
- **Calendar 日历** — 单选/多选/范围三种模式，农历显示，周末颜色，法定节假日标注
- **WeekCalendar 周日历** — 周视图日历，自定义数据标注，日期范围限制
- **Form 表单** — FormController 表单控制器，required/pattern/validator 校验规则，标签布局配置

### 选择器

- **Picker 选择器** — 单列/多列/级联选择，自定义按钮文字
- **DateTimePicker 日期时间选择器** — year/yearmonth/date/datetime/time 五种模式，格式化，范围限制
- **RegionPicker 地区选择器** — 省市区三级联动，支持自定义地区数据

### 展示组件

- **ImagePreview 图片预览** — 函数式调用，手势缩放，循环浏览，页码指示器

### 反馈组件

- **Popup 弹出框** — center/top/bottom/left/right 五个方向，遮罩层，关闭按钮，自定义内容

### 布局组件

- **List 列表** — 分组标题/描述，卡片/缩进模式，右侧图标，底部分割线

### 设计系统

- 6 大主题色（primary/success/warning/danger/error/info）及浅色/深色变种
- 19 种内置命名色，每种含 normal/dark/light/disabled 四个变种
- 16 种酷炫渐变背景 + 颜色渐变
- 9 级字体大小体系 + 5 级行高体系
- 10 级间距体系 + SPACE 枚举
- 6 级圆角体系
- 4 级阴影分级（sm/default/md/lg）
- 4 级毛玻璃效果（BLUR_LEVEL 枚举）
- 主题系统，通过 AppStorageV2 全局共享设计令牌
