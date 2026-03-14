/**
 * @file 核心模块卡片信息
 * @author Joker.X
 */
export class CoreCardItem {
  /**
   * 标题
   */
  title: string;

  /**
   * 描述内容
   */
  description: string;

  /**
   * 点击事件
   */
  onClick: () => void;

  constructor(title: string, description: string, onClick: () => void) {
    this.title = title;
    this.description = description;
    this.onClick = onClick;
  }
}
