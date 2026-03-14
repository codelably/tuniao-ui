/**
 * @file TnList / TnListItem 组件类型定义
 * @author JunBin.Yang
 */

/**
 * TnListItem 组件属性接口
 */
export interface TnListItemProps {
  /** 列表项文本内容 */
  title?: ResourceStr;
  /** 列表项描述（显示在标题下方，次要色小字） */
  description?: ResourceStr;
  /** 自定义字体大小 */
  fontSize?: number | string;
  /** 自定义背景色 */
  bgColor?: ResourceColor;
  /** 自定义文字色 */
  textColor?: ResourceColor;
  /** 右侧图标名称（不填则不显示） */
  rightIcon?: string;
  /** 右侧图标颜色 */
  rightIconColor?: ResourceColor;
  /** 右侧图标大小 */
  rightIconSize?: number | string;
  /** 是否显示圆角 */
  radius?: boolean;
  /** 是否显示底部边框 */
  bottomBorder?: boolean;
  /** 底部边框是否缩进 */
  bottomBorderIndent?: boolean;
  /** 底部边框颜色 */
  dividerColor?: ResourceColor;
  /** 是否可点击（开启点击反馈） */
  clickable?: boolean;
  /** 是否禁用 */
  disabled?: boolean;
  /** 自定义内边距 */
  listPadding?: Padding | Length;
  /** 点击事件回调 */
  onItemClick?: () => void;
}

/**
 * TnList 组件属性接口
 */
export interface TnListProps {
  /** 分组标题 */
  title?: ResourceStr;
  /** 分组描述（显示在标题下方） */
  description?: ResourceStr;
  /** 是否为卡片风格（白色背景 + 圆角 + 内边距，列表项自动缩进） */
  card?: boolean;
  /** 是否为卡片风格（圆角 + 外边距），用于列表项内嵌缩进 */
  inset?: boolean;
  /** 是否显示外边框 */
  hasBorder?: boolean;
  /** 圆角大小（card / inset 模式有效） */
  radius?: Length;
  /** 标题字重 */
  titleFontWeight?: FontWeight;
  /** 标题内边距 */
  titlePadding?: Padding | Length;
  /** 外边距（inset 模式有效） */
  outerMargin?: Padding | Length;
}
