/**
 * @file 组件分组数据模型
 * @author JunBin.Yang
 */

import { CoreCardItem } from "./CoreCardItem";

/**
 * 组件分组项
 */
export class ComponentGroupItem {
  /**
   * 分组标题
   */
  title: string;
  /**
   * 分组描述
   */
  description: string;
  /**
   * 分组内的卡片列表
   */
  cards: CoreCardItem[];

  constructor(title: string, description: string, cards: CoreCardItem[]) {
    this.title = title;
    this.description = description;
    this.cards = cards;
  }
}
