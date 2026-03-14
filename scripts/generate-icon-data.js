/**
 * @file 从 iconfont.json 自动生成 TnIconData.ets 映射文件
 * @author JunBin.Yang
 *
 * 用法: node scripts/generate-icon-data.js
 */

const fs = require("fs");
const path = require("path");

const INPUT_PATH = path.resolve(
  __dirname,
  "../context_/tuniao_icon_font/iconfont.json"
);
const OUTPUT_PATH = path.resolve(
  __dirname,
  "../core/tuniaoui/src/main/ets/components/icon/TnIconData.ets"
);

function main() {
  if (!fs.existsSync(INPUT_PATH)) {
    console.error(`[ERROR] iconfont.json not found: ${INPUT_PATH}`);
    process.exit(1);
  }

  const raw = fs.readFileSync(INPUT_PATH, "utf-8");
  const json = JSON.parse(raw);
  const glyphs = json.glyphs;

  if (!Array.isArray(glyphs) || glyphs.length === 0) {
    console.error("[ERROR] No glyphs found in iconfont.json");
    process.exit(1);
  }

  console.log(`[INFO] Found ${glyphs.length} glyphs`);

  // 去重：相同 name 保留首次出现的条目
  const seen = new Set();
  const uniqueGlyphs = glyphs.filter((g) => {
    if (seen.has(g.name)) {
      console.log(`[WARN] Duplicate icon name skipped: "${g.name}"`);
      return false;
    }
    seen.add(g.name);
    return true;
  });

  console.log(`[INFO] Unique glyphs after dedup: ${uniqueGlyphs.length}`);

  const entries = uniqueGlyphs.map((g) => {
    const name = g.name;
    const unicode = g.unicode.toLowerCase();
    return `  "${name}": "\\u${unicode}"`;
  });

  const lines = [
    "/**",
    " * @file 图标名称到 Unicode 的映射数据（自动生成，勿手动修改）",
    " * @author JunBin.Yang",
    " */",
    "",
    "/**",
    " * 图标名称到 Unicode 字符的映射表",
    " */",
    "export const TN_ICON_DATA: Record<string, string> = {",
    entries.join(",\n"),
    "};",
    "",
    "/**",
    " * 图标名称列表（从 TN_ICON_DATA 的键动态生成，避免数据冗余）",
    " */",
    "export const TN_ICON_NAMES: string[] = Object.keys(TN_ICON_DATA);",
    "",
  ];

  const output = lines.join("\n");

  const outputDir = path.dirname(OUTPUT_PATH);
  if (!fs.existsSync(outputDir)) {
    fs.mkdirSync(outputDir, { recursive: true });
  }

  fs.writeFileSync(OUTPUT_PATH, output, "utf-8");
  console.log(`[OK] Generated ${uniqueGlyphs.length} icon entries -> ${OUTPUT_PATH}`);
}

main();
