/**
 * @file 中国地区数据（省市区三级联动）
 * @description 精简版地区数据，包含主要省市区信息及区域编码
 * @author JunBin.Yang
 */

/**
 * 地区数据项
 */
export interface RegionItem {
  /** 地区名称 */
  name: string;
  /** 区域编码 */
  code?: string;
  /** 下级地区列表 */
  children?: RegionItem[];
}

/**
 * 中国地区数据（精简版）
 */
export const REGION_DATA: RegionItem[] = [
  {
    name: "北京市", code: "110000",
    children: [
      { name: "北京市", code: "110100", children: [{ name: "东城区", code: "110101" }, { name: "西城区", code: "110102" }, { name: "朝阳区", code: "110105" }, { name: "丰台区", code: "110106" }, { name: "石景山区", code: "110107" }, { name: "海淀区", code: "110108" }, { name: "顺义区", code: "110113" }, { name: "通州区", code: "110112" }, { name: "大兴区", code: "110115" }, { name: "房山区", code: "110111" }, { name: "昌平区", code: "110114" }] }
    ]
  },
  {
    name: "上海市", code: "310000",
    children: [
      { name: "上海市", code: "310100", children: [{ name: "黄浦区", code: "310101" }, { name: "徐汇区", code: "310104" }, { name: "长宁区", code: "310105" }, { name: "静安区", code: "310106" }, { name: "普陀区", code: "310107" }, { name: "虹口区", code: "310109" }, { name: "杨浦区", code: "310110" }, { name: "浦东新区", code: "310115" }, { name: "闵行区", code: "310112" }, { name: "宝山区", code: "310113" }, { name: "嘉定区", code: "310114" }, { name: "松江区", code: "310117" }] }
    ]
  },
  {
    name: "广东省", code: "440000",
    children: [
      { name: "广州市", code: "440100", children: [{ name: "天河区", code: "440106" }, { name: "海珠区", code: "440105" }, { name: "荔湾区", code: "440103" }, { name: "越秀区", code: "440104" }, { name: "白云区", code: "440111" }, { name: "番禺区", code: "440113" }, { name: "黄埔区", code: "440112" }] },
      { name: "深圳市", code: "440300", children: [{ name: "福田区", code: "440304" }, { name: "罗湖区", code: "440303" }, { name: "南山区", code: "440305" }, { name: "宝安区", code: "440306" }, { name: "龙岗区", code: "440307" }, { name: "龙华区", code: "440309" }, { name: "坪山区", code: "440310" }] },
      { name: "珠海市", code: "440400", children: [{ name: "香洲区", code: "440402" }, { name: "斗门区", code: "440403" }, { name: "金湾区", code: "440404" }] },
      { name: "东莞市", code: "441900", children: [{ name: "东莞市", code: "441900" }] },
      { name: "佛山市", code: "440600", children: [{ name: "禅城区", code: "440604" }, { name: "南海区", code: "440605" }, { name: "顺德区", code: "440606" }] }
    ]
  },
  {
    name: "江苏省", code: "320000",
    children: [
      { name: "南京市", code: "320100", children: [{ name: "玄武区", code: "320102" }, { name: "秦淮区", code: "320104" }, { name: "鼓楼区", code: "320106" }, { name: "建邺区", code: "320105" }, { name: "栖霞区", code: "320113" }, { name: "江宁区", code: "320115" }] },
      { name: "苏州市", code: "320500", children: [{ name: "姑苏区", code: "320508" }, { name: "虎丘区", code: "320505" }, { name: "吴中区", code: "320506" }, { name: "相城区", code: "320507" }, { name: "吴江区", code: "320509" }] },
      { name: "无锡市", code: "320200", children: [{ name: "锡山区", code: "320205" }, { name: "惠山区", code: "320206" }, { name: "滨湖区", code: "320211" }, { name: "梁溪区", code: "320213" }] }
    ]
  },
  {
    name: "浙江省", code: "330000",
    children: [
      { name: "杭州市", code: "330100", children: [{ name: "上城区", code: "330102" }, { name: "拱墅区", code: "330105" }, { name: "西湖区", code: "330106" }, { name: "滨江区", code: "330108" }, { name: "萧山区", code: "330109" }, { name: "余杭区", code: "330110" }] },
      { name: "宁波市", code: "330200", children: [{ name: "海曙区", code: "330203" }, { name: "江北区", code: "330205" }, { name: "北仑区", code: "330206" }, { name: "鄞州区", code: "330212" }] },
      { name: "温州市", code: "330300", children: [{ name: "鹿城区", code: "330302" }, { name: "龙湾区", code: "330303" }, { name: "瓯海区", code: "330304" }] }
    ]
  },
  {
    name: "四川省", code: "510000",
    children: [
      { name: "成都市", code: "510100", children: [{ name: "锦江区", code: "510104" }, { name: "青羊区", code: "510105" }, { name: "金牛区", code: "510106" }, { name: "武侯区", code: "510107" }, { name: "成华区", code: "510108" }, { name: "高新区", code: "510132" }] },
      { name: "绵阳市", code: "510700", children: [{ name: "涪城区", code: "510703" }, { name: "游仙区", code: "510704" }] }
    ]
  },
  {
    name: "湖北省", code: "420000",
    children: [
      { name: "武汉市", code: "420100", children: [{ name: "江岸区", code: "420102" }, { name: "江汉区", code: "420103" }, { name: "硚口区", code: "420104" }, { name: "汉阳区", code: "420105" }, { name: "武昌区", code: "420106" }, { name: "洪山区", code: "420111" }] },
      { name: "宜昌市", code: "420500", children: [{ name: "西陵区", code: "420502" }, { name: "伍家岗区", code: "420503" }] }
    ]
  },
  {
    name: "湖南省", code: "430000",
    children: [
      { name: "长沙市", code: "430100", children: [{ name: "芙蓉区", code: "430102" }, { name: "天心区", code: "430103" }, { name: "岳麓区", code: "430104" }, { name: "开福区", code: "430105" }, { name: "雨花区", code: "430111" }] }
    ]
  },
  {
    name: "山东省", code: "370000",
    children: [
      { name: "济南市", code: "370100", children: [{ name: "历下区", code: "370102" }, { name: "市中区", code: "370103" }, { name: "槐荫区", code: "370104" }, { name: "天桥区", code: "370105" }] },
      { name: "青岛市", code: "370200", children: [{ name: "市南区", code: "370202" }, { name: "市北区", code: "370203" }, { name: "黄岛区", code: "370211" }, { name: "崂山区", code: "370212" }] }
    ]
  },
  {
    name: "河南省", code: "410000",
    children: [
      { name: "郑州市", code: "410100", children: [{ name: "中原区", code: "410102" }, { name: "二七区", code: "410103" }, { name: "金水区", code: "410105" }, { name: "惠济区", code: "410108" }] }
    ]
  }
];
