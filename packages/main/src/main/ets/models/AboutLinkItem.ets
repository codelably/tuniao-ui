/**
 * @file 关于页面链接数据模型
 * @author JunBin.Yang
 */
export interface AboutLinkItem {
  /** 标题 */
  title: Resource;
  /** 链接地址 */
  url: Resource;
  /** 描述（可选） */
  description?: Resource;
}
