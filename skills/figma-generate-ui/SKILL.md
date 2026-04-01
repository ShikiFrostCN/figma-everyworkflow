---
name: figma-generate-ui
description: "AI-powered UI generation directly in Figma — equivalent to UX Pilot's design generation. Use when the user wants to generate Figma UI from: (1) natural language descriptions ('create a SaaS dashboard', 'design a login page'), (2) HTML files or source code, (3) wireframe/prototype images or screenshots. Supports using a specified design system to keep generated designs consistent. Triggers: 'generate UI in Figma', 'create a design for', 'build this screen in Figma', 'convert this HTML to Figma', 'generate from wireframe', 'design this page', 'create UI from description', 'make a Figma design for'."
disable-model-invocation: false
author: shiki
version: "2.0"
updated: "2026-04-01"
---

<!--
  figma-generate-ui SKILL v2.0
  Author / 作者: shiki
  Updated / 更新日期: 2026-04-01
  Upgraded with: UI/UX Pro Max design intelligence · Figma component registry · HTML-first pipeline
  升级内容: UI/UX Pro Max 设计智能 · Figma 组件注册表 · HTML 优先生成流程
-->

# figma-generate-ui — AI UI Generation in Figma (v2)
# figma-generate-ui — Figma AI 界面生成技能（v2）

---

> **Author / 作者**: shiki  
> **Version / 版本**: 2.0  
> **Updated / 更新**: 2026-04-01  
> **Changelog / 更新说明**: Integrated UI/UX Pro Max design intelligence, Figma component registry scanning, and HTML-first generation pipeline.  
> 集成 UI/UX Pro Max 设计智能引擎、Figma 组件注册表扫描、HTML 优先生成流程。

---

Generate polished, design-system-consistent Figma screens from natural language, HTML files, or wireframe images — directly inside Figma. This skill replicates the AI design generation workflow of tools like UX Pilot, powered by the Figma Plugin API, UI/UX Pro Max design intelligence, and the HTML-first generation pipeline.

直接在 Figma 内部，从自然语言、HTML 文件或线框图生成精美、符合设计系统的 Figma 界面。本技能融合了 Figma Plugin API、UI/UX Pro Max 设计智能引擎和 HTML 优先生成流程，复现 UX Pilot 等工具的 AI 设计生成体验。

**MANDATORY prerequisites / 必须加载的前置技能** (load before any `use_figma` call):
- [figma-use](../figma-use/SKILL.md) — critical Plugin API rules (color ranges, font loading, etc.) / 关键 Plugin API 规则（颜色范围、字体加载等）
- [figma-generate-design](../figma-generate-design/SKILL.md) — core screen-building workflow reference / 核心页面构建工作流参考

**Always pass `skillNames: "figma-generate-ui"` when calling `use_figma` as part of this skill.**  
**在本技能中所有 `use_figma` 调用时，始终传入 `skillNames: "figma-generate-ui"`。**

---

## Core Architecture / 核心架构

This skill uses a **three-engine pipeline** / 本技能采用**三引擎流水线**：

```
┌─────────────────────────────────────────────────────────────────┐
│  ENGINE 1 / 引擎 1: UI/UX Pro Max — Design Intelligence        │
│  设计智能引擎                                                    │
│  Generates: style, color palette, typography, UX rules,        │
│  生成：样式、色彩方案、字体排版、UX 规则、                        │
│  anti-patterns tailored to the product type & industry         │
│  以及针对产品类型和行业的反模式清单                               │
└──────────────────────────┬──────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────────┐
│  ENGINE 2 / 引擎 2: Figma Component Registry                   │
│  Figma 组件注册表                                                │
│  Scans: existing components, frames, variables, styles         │
│  扫描：现有组件、框架、变量、样式                                 │
│  in the current Figma file → builds a reusable component map   │
│  → 构建可复用的组件映射表                                        │
└──────────────────────────┬──────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────────┐
│  ENGINE 3 / 引擎 3: HTML-First Generation                      │
│  HTML 优先生成                                                   │
│  Generates: complete semantic HTML + CSS using design tokens   │
│  生成：使用设计 token 的完整语义化 HTML + CSS                     │
│  Converts: HTML structure → Figma component instances          │
│  转换：HTML 结构 → Figma 组件实例                                │
│  Validates: renders HTML as pixel-perfect Figma reference      │
│  验证：将 HTML 渲染为像素级 Figma 参考                           │
└─────────────────────────────────────────────────────────────────┘
```

**Golden rule / 黄金法则**: All UI creation and modification work starts with HTML generation. The HTML is the single source of truth. Figma output is derived from it.  
所有 UI 创建和修改工作均从 HTML 生成开始。HTML 是唯一事实来源，Figma 输出从中派生。

---

## Supported Input Modes / 支持的输入模式

| Input Mode / 输入模式 | Description / 描述 | Example Trigger / 示例触发语 |
|---|---|---|
| **Natural Language / 自然语言** | Describe the UI in plain text / 用纯文本描述 UI | "Create a SaaS pricing page with 3 tiers" / "创建一个有三档定价的 SaaS 页面" |
| **HTML / Source File / HTML/源文件** | Read an HTML or component file and convert to a Figma screen / 读取 HTML 或组件文件并转换为 Figma 界面 | "Convert this HTML file to Figma" / "将这个 HTML 文件转换到 Figma" |
| **Wireframe / Image / 线框图/图片** | Analyze a wireframe screenshot and reproduce it in Figma / 分析线框截图并在 Figma 中重现 | "Recreate this wireframe using our design system" / "用我们的设计系统重建这个线框图" |
| **Combined / 组合输入** | Mix inputs: wireframe + text, or HTML + design system override / 混合输入：线框图+文字，或 HTML+设计系统覆盖 | "Take this HTML but use our dark theme" / "用这个 HTML，但换用深色主题" |

---

## Required Workflow / 必须遵循的工作流

**Follow these steps in order. Do not skip steps.**  
**按顺序执行以下步骤，不得跳过。**

---

### Step 0: Determine Input Source / 步骤 0：确认输入来源

Before doing anything, identify the input source(s):  
在做任何事之前，先确认输入来源：

1. **Natural language only / 仅自然语言** → proceed to Step 1 directly / 直接进入步骤 1
2. **HTML file provided / 提供了 HTML 文件** → read the file to extract layout structure, sections, components, and content / 读取文件提取布局结构、区块、组件和内容
3. **Image / wireframe provided / 提供了图片/线框图** → use `get_screenshot` or analyze the image to extract layout structure / 使用 `get_screenshot` 或分析图片提取布局结构
4. **Figma URL of existing prototype / 现有原型的 Figma URL** → use `get_design_context` to extract the layout / 使用 `get_design_context` 提取布局

For HTML files, extract / 对于 HTML 文件，提取：
- Page title / heading hierarchy (h1, h2, h3) / 页面标题/标题层级
- Major sections by semantic tags (header, nav, main, section, aside, footer) / 语义标签标识的主要区块
- Form elements (inputs, buttons, labels) / 表单元素（输入框、按钮、标签）
- Repeated elements (card grids, list items, table rows) / 重复元素（卡片网格、列表项、表格行）
- Class names that hint at intent (e.g., `.hero`, `.pricing-card`) / 暗示意图的类名

---

### Step 1: Generate Design Intelligence (UI/UX Pro Max) / 步骤 1：生成设计智能（UI/UX Pro Max）

> **This step is mandatory for all UI generation. It runs before any Figma or HTML work.**  
> **此步骤对所有 UI 生成强制执行，在任何 Figma 或 HTML 工作之前运行。**

Check if `ui-ux-pro-max` scripts exist at `~/.codex/skills/ui-ux-pro-max/scripts/search.py` or `.claude/skills/ui-ux-pro-max/scripts/search.py`.  
检查 `ui-ux-pro-max` 脚本是否存在于 `~/.codex/skills/ui-ux-pro-max/scripts/search.py` 或 `.claude/skills/ui-ux-pro-max/scripts/search.py`。

#### 1a: Run Design System Generator / 运行设计系统生成器

```bash
# Primary: generate complete design system with reasoning engine
# 主命令：用推理引擎生成完整设计系统
python3 ~/.codex/skills/ui-ux-pro-max/scripts/search.py "<product_type> <industry> <keywords>" --design-system -p "<Project Name>"

# Example: SaaS dashboard / 示例：SaaS 仪表盘
python3 ~/.codex/skills/ui-ux-pro-max/scripts/search.py "SaaS analytics dashboard enterprise" --design-system -p "AnalyticsPro"

# Example: Wellness landing page / 示例：健康类落地页
python3 ~/.codex/skills/ui-ux-pro-max/scripts/search.py "beauty spa wellness service landing" --design-system -p "SerenityApp"
```

The command searches 5 domains in parallel and returns:  
该命令并行搜索 5 个领域并返回：

- **Pattern / 模式** — recommended page structure and conversion strategy / 推荐页面结构和转化策略
- **Style / 样式** — best matching UI style (glassmorphism, minimalism, etc.) / 最匹配的 UI 风格
- **Colors / 色彩** — primary, secondary, CTA, background, text hex values / 主色、辅色、CTA、背景、文字颜色
- **Typography / 字体排版** — heading/body font pairing with Google Fonts link / 标题/正文字体搭配及 Google Fonts 链接
- **Key Effects / 关键效果** — shadows, animations, transitions / 阴影、动画、过渡
- **Anti-Patterns / 反模式** — what to explicitly avoid for this industry / 该行业应明确避免的设计

#### 1b: Supplement with Domain Searches / 补充领域搜索

```bash
# Get more style detail / 获取更多样式细节
python3 ~/.codex/skills/ui-ux-pro-max/scripts/search.py "<style>" --domain style

# Get UX best practices / 获取 UX 最佳实践
python3 ~/.codex/skills/ui-ux-pro-max/scripts/search.py "<topic>" --domain ux

# Get chart recommendations for dashboards / 仪表盘图表推荐
python3 ~/.codex/skills/ui-ux-pro-max/scripts/search.py "<chart type>" --domain chart

# Get color palettes / 获取色彩方案
python3 ~/.codex/skills/ui-ux-pro-max/scripts/search.py "<industry>" --domain color
```

#### 1c: Persist the Design System / 持久化设计系统

Save the design system for reuse across sessions / 保存设计系统以便跨会话复用：

```bash
python3 ~/.codex/skills/ui-ux-pro-max/scripts/search.py "<query>" --design-system --persist -p "<Project Name>"
# Creates: design-system/MASTER.md (global) and design-system/pages/<page>.md (overrides)
# 创建：design-system/MASTER.md（全局）和 design-system/pages/<page>.md（覆盖）
```

#### 1d: Build the Design Token Map / 构建设计 Token 映射表

From the generator output, extract and record:  
从生成器输出中提取并记录：

```
DESIGN TOKEN MAP / 设计 Token 映射表:
─────────────────────────────────────────────────────
Style / 样式:       Glassmorphism / Modern SaaS
─────────────────────────────────────────────────────
Colors / 色彩:
  Primary / 主色:      #6366F1  (Indigo / 靛蓝)
  Secondary / 辅色:    #8B5CF6  (Violet / 紫罗兰)
  CTA:                 #F59E0B  (Amber / 琥珀)
  Background / 背景:   #0F172A  (Slate 900 / 深石板)
  Surface / 表面:      rgba(255,255,255,0.08)
  Text / 文字:         #F8FAFC  (Slate 50 / 浅石板)
  Border / 边框:       rgba(255,255,255,0.12)
─────────────────────────────────────────────────────
Typography / 字体排版:
  Heading / 标题:  Inter Bold / 700
  Body / 正文:     Inter Regular / 400
  Caption / 说明:  Inter Medium / 500
─────────────────────────────────────────────────────
Effects / 效果:
  Shadows / 阴影:      0 8px 32px rgba(0,0,0,0.3)
  Blur / 模糊:         backdrop-filter: blur(12px)
  Radius / 圆角:       8px cards, 6px buttons, 12px modals
  Transitions / 过渡:  200ms ease-out
─────────────────────────────────────────────────────
Anti-Patterns / 反模式:
  ✗ Flat design / no depth / 扁平设计/无层次感
  ✗ Bright neon backgrounds / 明亮霓虹背景
  ✗ More than 3 accent colors / 超过 3 种强调色
─────────────────────────────────────────────────────
```

---

### Step 2: Scan Figma File — Build Component Registry / 步骤 2：扫描 Figma 文件——构建组件注册表

> This step discovers what already exists in the Figma file before generating anything new.  
> 此步骤在生成任何新内容之前，发现 Figma 文件中已有的内容。

#### 2a: Scan Existing Components and Frames / 扫描现有组件和框架

Run a `use_figma` call to scan the entire current page / 运行 `use_figma` 扫描当前整页：

```js
// Scan for components and component sets
// 扫描组件和组件集
const componentRegistry = [];
const frameRegistry = [];

// Walk all top-level children / 遍历所有顶层子节点
for (const node of figma.currentPage.children) {
  if (node.type === "COMPONENT" || node.type === "COMPONENT_SET") {
    componentRegistry.push({
      id: node.id,
      name: node.name,
      type: node.type,
      key: node.key,
      width: node.width,
      height: node.height,
    });
  }
  if (node.type === "FRAME") {
    frameRegistry.push({
      id: node.id,
      name: node.name,
      width: node.width,
      height: node.height,
      childCount: node.children.length,
    });
  }
}

// Walk frames for nested instances (authoritative design system source)
// 遍历框架内的嵌套实例（权威设计系统来源）
const instanceMap = new Map();
for (const frame of figma.currentPage.children.filter(n => n.type === "FRAME")) {
  frame.findAll(n => n.type === "INSTANCE").forEach(inst => {
    const mc = inst.mainComponent;
    if (!mc) return;
    const cs = mc?.parent?.type === "COMPONENT_SET" ? mc.parent : null;
    const key = cs ? cs.key : mc?.key;
    const name = cs ? cs.name : mc?.name;
    if (key && !instanceMap.has(key)) {
      instanceMap.set(key, { name, key, isSet: !!cs, sampleVariant: mc.name, instanceId: inst.id });
    }
  });
}

return {
  localComponents: componentRegistry,
  existingFrames: frameRegistry,
  designSystemInstances: [...instanceMap.values()],
};
```

#### 2b: Discover Variables and Styles / 发现变量和样式

```js
// Discover bound variables from existing screens
// 从现有界面中发现绑定的变量
const varMap = new Map();
const styleMap = { text: new Map(), effect: new Map() };

for (const frame of figma.currentPage.children.filter(n => n.type === "FRAME" && n.children.length > 2)) {
  frame.findAll(() => true).forEach(node => {
    const bv = node.boundVariables;
    if (bv) {
      for (const [, binding] of Object.entries(bv)) {
        const bindings = Array.isArray(binding) ? binding : [binding];
        for (const b of bindings) {
          if (b?.id && !varMap.has(b.id)) varMap.set(b.id, { id: b.id });
        }
      }
    }
    if ('textStyleId' in node && node.textStyleId) {
      const s = figma.getStyleById(node.textStyleId);
      if (s) styleMap.text.set(s.id, { name: s.name, id: s.id, key: s.key });
    }
    if ('effectStyleId' in node && node.effectStyleId) {
      const s = figma.getStyleById(node.effectStyleId);
      if (s) styleMap.effect.set(s.id, { name: s.name, id: s.id, key: s.key });
    }
  });
  break; // Only need one frame / 只需一个框架
}

const variables = [];
for (const [id] of varMap) {
  const v = await figma.variables.getVariableByIdAsync(id);
  if (v) variables.push({ name: v.name, id: v.id, key: v.key, type: v.resolvedType, remote: v.remote });
}

return { variables, textStyles: [...styleMap.text.values()], effectStyles: [...styleMap.effect.values()] };
```

#### 2c: Build the Figma Component Registry / 构建 Figma 组件注册表

Consolidate everything into a registry / 将所有内容整合到注册表：

```
FIGMA COMPONENT REGISTRY / Figma 组件注册表:
──────────────────────────────────────────────────────────────────
Local Components / 本地组件:
  [Button]          id: "1:23"   key: "abc123"  type: COMPONENT_SET
  [Card]            id: "1:45"   key: "def456"  type: COMPONENT_SET
  [NavBar]          id: "1:67"   key: "ghi789"  type: COMPONENT

Design System (from instances) / 设计系统（来自实例）:
  [Input/Text]      key: "jkl012"  variant: "size=md, state=default"
  [Badge]           key: "mno345"  variant: "variant=success"
  [Avatar]          key: "pqr678"

Existing Frames / 现有框架:
  [Dashboard v2]    id: "2:10"   1440×900
  [Mobile Home]     id: "2:20"   390×844

Variables / 变量:
  color/primary     key: "var-001"  type: COLOR
  color/surface     key: "var-002"  type: COLOR
  space/lg          key: "var-003"  type: FLOAT

Text Styles / 文字样式:
  Heading/H1        key: "ts-001"
  Body/Regular      key: "ts-002"

Effect Styles / 效果样式:
  Shadow/Card       key: "es-001"
──────────────────────────────────────────────────────────────────
```

---

### Step 3: Understand the Screen Specification / 步骤 3：理解界面规格

Synthesize all inputs into a clear screen specification / 将所有输入整合为清晰的界面规格：

1. **Screen name / 界面名称** — e.g., "Pricing Page", "Dashboard", "Login" / 例如"定价页"、"仪表盘"、"登录页"
2. **Target device / 目标设备** — Desktop (1440px), Tablet (768px), or Mobile (390px)? Default: Desktop / 桌面、平板或移动端？默认桌面
3. **Sections list / 区块列表** — list every major section top to bottom / 从上到下列出所有主要区块
4. **Components per section / 每个区块的组件** — list component types AND whether a Figma registry match exists / 列出组件类型及是否有注册表匹配
5. **Content / 内容** — key text, labels, CTA copy / 关键文字、标签、CTA 文案

**Example specification / 示例规格：**

```
Screen: SaaS Pricing Page (Desktop 1440px) / SaaS 定价页（桌面 1440px）
Design Style: Glassmorphism / Dark Mode / 毛玻璃 / 深色模式
Sections / 区块:
  1. Navbar   — Logo + nav links + CTA button      [NavBar: key ghi789 ✓]
  2. Hero     — Headline + subtitle + 2 CTAs        [Button: key abc123 ✓] [custom frame / 自定义框架]
  3. Pricing  — 3 cards (Starter, Pro, Enterprise)  [Card: key def456 ✓]
  4. FAQ      — 6 questions accordion               [no match → build manually / 无匹配 → 手动构建]
  5. Footer   — Links + social + copyright          [no match → build manually / 无匹配 → 手动构建]
```

---

### Step 4: Resolve the Target Figma File / 步骤 4：确定目标 Figma 文件

The user must have a Figma file open or provide a URL. If neither:  
用户必须有打开的 Figma 文件或提供 URL。如果都没有：

1. Ask the user if they want to create a new file or target an existing one / 询问用户是创建新文件还是使用已有文件
2. If creating new / 新建：load [figma-create-new-file](../figma-create-new-file/SKILL.md), then use its `file_key`
3. If targeting existing / 使用已有：extract the `file_key` from the provided Figma URL

---

### Step 5: Generate HTML (Source of Truth) / 步骤 5：生成 HTML（唯一事实来源）

> **All UI creation begins here. Generate HTML first. Figma output is derived from the HTML.**  
> **所有 UI 创建从这里开始。首先生成 HTML。Figma 输出从 HTML 派生。**

#### 5a: Write the Full HTML Document / 编写完整 HTML 文档

Using the Design Token Map (Step 1d) and Screen Specification (Step 3), generate a complete, self-contained HTML file.  
使用设计 Token 映射表（步骤 1d）和界面规格（步骤 3），生成完整的自包含 HTML 文件。

**HTML generation rules / HTML 生成规则：**
- Use semantic HTML5 elements / 使用语义化 HTML5 元素 (`<header>`, `<nav>`, `<main>`, `<section>`, `<article>`, `<footer>`)
- Embed all CSS in a `<style>` block — no external stylesheets / 所有 CSS 内嵌在 `<style>` 块中，不使用外部样式表
- Use CSS custom properties that map exactly to the Design Token Map / 使用与设计 Token 映射表精确对应的 CSS 自定义属性
- Write real content (no Lorem Ipsum) / 使用真实内容（不用占位符文本）
- Add `data-figma-component` attributes on elements that map to Figma registry components / 在映射到 Figma 注册表组件的元素上添加 `data-figma-component` 属性
- Add `data-figma-section` attributes on top-level section containers / 在顶层区块容器上添加 `data-figma-section` 属性

**HTML template structure / HTML 模板结构：**

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>[Screen Name / 界面名称]</title>
  <!-- Font from UI/UX Pro Max typography recommendation -->
  <!-- 来自 UI/UX Pro Max 排版推荐的字体 -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    /* ── Design Tokens / 设计 Token ── */
    :root {
      --color-primary:    #6366F1;
      --color-secondary:  #8B5CF6;
      --color-cta:        #F59E0B;
      --color-bg:         #0F172A;
      --color-surface:    rgba(255,255,255,0.08);
      --color-text:       #F8FAFC;
      --color-text-muted: rgba(248,250,252,0.6);
      --color-border:     rgba(255,255,255,0.12);

      --font-heading: 'Inter', sans-serif;
      --font-body:    'Inter', sans-serif;
      --font-size-h1: 56px;
      --font-size-h2: 36px;
      --font-size-h3: 24px;
      --font-size-body: 16px;
      --font-size-sm:   14px;

      --radius-sm:   6px;
      --radius-md:   8px;
      --radius-lg:   12px;
      --radius-xl:   16px;

      --shadow-card: 0 8px 32px rgba(0,0,0,0.3);
      --shadow-btn:  0 4px 12px rgba(99,102,241,0.4);

      --space-xs:  8px;
      --space-sm:  16px;
      --space-md:  24px;
      --space-lg:  48px;
      --space-xl:  80px;
      --space-2xl: 120px;

      --transition: 200ms ease-out;
      --blur:       blur(12px);
    }

    /* ── Global Reset / 全局重置 ── */
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      font-family: var(--font-body);
      font-size: var(--font-size-body);
      background: var(--color-bg);
      color: var(--color-text);
      line-height: 1.6;
    }
    /* ... section-by-section styles / 逐区块样式 ... */
  </style>
</head>
<body>
  <!-- data-figma-section and data-figma-component map to the Figma registry -->
  <!-- data-figma-section 和 data-figma-component 映射到 Figma 注册表 -->
  <header data-figma-section="navbar" data-figma-component="NavBar">
    <!-- content / 内容 -->
  </header>
  <section data-figma-section="hero">
    <!-- content with data-figma-component="Button" on CTAs -->
    <!-- CTA 上带有 data-figma-component="Button" -->
  </section>
  <!-- ... remaining sections / 其余区块 ... -->
</body>
</html>
```

#### 5b: Data Attributes for Figma Mapping / 用于 Figma 映射的 Data 属性

| Attribute / 属性 | Value / 值 | Purpose / 用途 |
|---|---|---|
| `data-figma-section` | `"hero"`, `"navbar"`, `"footer"` | Top-level section containers / 顶层区块容器 |
| `data-figma-component` | `"Button"`, `"Card"`, `"NavBar"` | Elements mapping to Figma component registry / 映射到 Figma 组件注册表的元素 |
| `data-figma-variant` | `"variant=primary,size=md"` | Specific variant to instantiate / 实例化时使用的特定变体 |
| `data-figma-text` | `"Label#2:0"` | Component text property key for `setProperties()` / `setProperties()` 的组件文本属性键 |
| `data-figma-skip` | `"true"` | Skip this element (decorative only) / 跳过此元素（仅装饰性） |

#### 5c: Save and Present the HTML / 保存并呈现 HTML

Save the HTML to the workspace / 保存 HTML 到工作区：

```
[project-folder]/figma-exports/[screen-name]-[timestamp].html
```

Present a summary to the user / 向用户呈现摘要：
- Section count and names / 区块数量和名称
- Components mapped to Figma registry / 映射到 Figma 注册表的组件
- Components that will be built manually / 将手动构建的组件
- Anti-patterns from UI/UX Pro Max that were avoided / 已避免的 UI/UX Pro Max 反模式

Ask the user to review and approve. Once approved, proceed to Step 6.  
请用户审阅并批准。批准后进入步骤 6。

---

### Step 6: Convert HTML to Figma / 步骤 6：将 HTML 转换为 Figma

> Convert the approved HTML into Figma. Uses a hybrid approach: pixel-perfect capture + component instances.  
> 将已批准的 HTML 转换为 Figma，采用混合方式：像素级捕获 + 组件实例。

#### 6a: Pixel-Perfect Capture (Web Apps) / 像素级捕获（Web 应用）

If the HTML file can be rendered in a browser / 如果 HTML 文件可以在浏览器中渲染：

1. Use `generate_figma_design` on the running page to capture a pixel-perfect layout reference / 使用 `generate_figma_design` 捕获像素级布局参考
2. This reference frame is placed in Figma as a visual target — not the final output / 此参考框架放置在 Figma 中作为视觉目标，不是最终输出
3. **After building component-instance output (Step 6b), delete this reference frame / 在构建组件实例输出（步骤 6b）后删除此参考框架**

#### 6b: Build Figma from HTML Structure / 从 HTML 结构构建 Figma

Parse the `data-figma-section` and `data-figma-component` attributes to drive the Figma build.  
解析 `data-figma-section` 和 `data-figma-component` 属性来驱动 Figma 构建。

**Build pipeline / 构建流程：**

```
HTML Section (data-figma-section="hero")
    → Create Figma section frame with auto-layout / 创建带自动布局的 Figma 区块框架
    → Apply background color from CSS var → Figma variable / 应用背景色：CSS 变量 → Figma 变量
    → For each child with data-figma-component / 对每个带 data-figma-component 的子元素:
        → Look up component key in Figma Component Registry / 在 Figma 组件注册表中查找组件键
        → If found / 如果找到: importComponentSetByKeyAsync → createInstance → setProperties()
        → If not found / 如果未找到: build manually with frames + text nodes / 手动构建
    → Set FILL sizing after appending to wrapper / 追加到包装器后设置 FILL 尺寸
    → Validate with get_screenshot / 用 get_screenshot 验证
```

**Step 6b-1: Create the page wrapper / 创建页面包装框架**

```js
let maxX = 0;
for (const child of figma.currentPage.children) {
  maxX = Math.max(maxX, child.x + child.width);
}

const wrapper = figma.createFrame();
wrapper.name = "AI Generated — [Screen Name]";
wrapper.layoutMode = "VERTICAL";
wrapper.primaryAxisAlignItems = "MIN";
wrapper.counterAxisAlignItems = "CENTER";
wrapper.resize(1440, 100);
wrapper.layoutSizingHorizontal = "FIXED";
wrapper.layoutSizingVertical = "HUG";
wrapper.x = maxX + 200;
wrapper.y = 0;

return { success: true, wrapperId: wrapper.id };
```

**Step 6b-2: Build each section (one `use_figma` call per section) / 构建每个区块（每个区块一次 `use_figma` 调用）**

For each section: parse HTML structure → apply auto-layout → bind variables → instantiate components → `setProperties()` with content from HTML → append to wrapper → set `FILL`.  
对每个区块：解析 HTML 结构 → 应用自动布局 → 绑定变量 → 实例化组件 → 用 HTML 内容 `setProperties()` → 追加到包装框 → 设置 `FILL`。

**CSS → Figma property mapping / CSS → Figma 属性映射：**

| CSS Property / CSS 属性 | Figma Equivalent / Figma 等价属性 |
|---|---|
| `display:flex` + `flex-direction:row` | `layoutMode = "HORIZONTAL"` |
| `display:flex` + `flex-direction:column` | `layoutMode = "VERTICAL"` |
| `gap: Xpx` | `itemSpacing = X` |
| `padding: Xpx Ypx` | `paddingTop/Bottom = X`, `paddingLeft/Right = Y` |
| `justify-content: center` | `primaryAxisAlignItems = "CENTER"` |
| `align-items: center` | `counterAxisAlignItems = "CENTER"` |
| `border-radius: Xpx` | `cornerRadius = X` |
| `background-color: hex` | `fills = [{ type:'SOLID', color: hexToRGB(hex) }]` |
| `font-size: Xpx` | `fontSize = X` |
| `font-weight: 700` | `fontName = { family:"Inter", style:"Bold" }` |
| `width: 100%` | `layoutSizingHorizontal = "FILL"` (after append / 追加后) |
| `height: auto` | `layoutSizingVertical = "HUG"` |

---

### Step 7: Validate the Full Screen / 步骤 7：验证完整界面

After all sections are built / 所有区块构建完成后：

1. Call `get_screenshot` on the wrapper frame ID for a full-page visual / 对包装框架 ID 调用 `get_screenshot` 获取整页视图
2. **Compare against the HTML reference** — ensure layout, spacing, and content match / **与 HTML 参考对比**——确保布局、间距和内容匹配
3. If pixel-perfect capture was used, compare against that reference frame / 如果使用了像素级捕获，与参考框架对比
4. Fix issues with targeted `use_figma` calls — do NOT rebuild the entire screen / 用精准的 `use_figma` 调用修复问题——不要重建整个界面
5. Check for / 检查：
   - Placeholder text still showing ("Title", "Button", "Label") / 占位文字仍然显示
   - Clipped/cropped text (line heights too small) / 文字被裁剪（行高太小）
   - Overlapping elements / 元素重叠
   - Wrong component variants / 错误的组件变体
   - Missing sections / 缺少区块
   - Colors diverging from Design Token Map / 颜色偏离设计 Token 映射表
6. Delete the pixel-perfect capture reference frame (if used) / 删除像素级捕获参考框架（如果使用了的话）

---

### Step 8: Post-Generation Handoff / 步骤 8：生成后交接

After validation, report to the user / 验证后向用户报告：

```
✅ Generation complete / 生成完成: [Screen Name]

Design System Used / 使用的设计系统:
  Style / 样式:      Glassmorphism / Dark Mode (UI/UX Pro Max)
  Colors / 色彩:     Primary #6366F1 · CTA #F59E0B · BG #0F172A
  Typography / 字体: Inter Bold / Regular

Built Sections / 已构建区块:
  ✓ Navbar    — NavBar component (key: ghi789)
  ✓ Hero      — Custom frame + Button instances / 自定义框架 + 按钮实例
  ✓ Pricing   — 3× Card instances (key: def456)
  ✓ FAQ       — Manual build / 手动构建 (no registry match / 无注册表匹配)
  ✓ Footer    — Manual build / 手动构建 (no registry match / 无注册表匹配)

HTML Source / HTML 源文件:
  figma-exports/pricing-page-[timestamp].html

Figma Frame / Figma 框架:
  "AI Generated — Pricing Page" (1440px)

Next steps / 后续步骤:
  — Select the frame in Figma to review / 在 Figma 中选择该框架进行审阅
  — Edit the HTML and re-run to update Figma / 编辑 HTML 并重新运行以更新 Figma
  — Use /figma-implement-design to convert this screen to code / 将此界面转换为代码
  — Use /figma-generate-library to extract a reusable component library / 提取可复用组件库
```

---

## Modification Workflow / 修改工作流

> **When modifying an existing Figma screen, always edit the HTML source first, then re-sync to Figma.**  
> **修改现有 Figma 界面时，始终先编辑 HTML 源文件，再同步到 Figma。**

### How to Update an Existing Screen / 如何更新现有界面

1. **Locate the HTML source / 找到 HTML 源文件** — find the saved `.html` file in `figma-exports/`
2. **Edit the HTML / 编辑 HTML** — apply the requested changes (add section, change copy, swap component, restyle) / 应用请求的修改
3. **Re-run UI/UX Pro Max / 重新运行 UI/UX Pro Max** if the style/color/typography is changing / 如果样式/颜色/字体排版发生变化
4. **Re-sync to Figma / 重新同步到 Figma** — identify which sections changed (by `data-figma-section`) / 确定哪些区块发生了变化
5. **Update only changed sections / 只更新变更的区块** — do NOT rebuild the entire wrapper / 不要重建整个包装框架：

```js
// Find existing section by name / 按名称查找现有区块
const wrapper = await figma.getNodeByIdAsync("WRAPPER_ID");
const existingSection = wrapper.findOne(n => n.name === "Hero");
if (existingSection) {
  existingSection.remove(); // Remove old section / 删除旧区块
}
// Rebuild only the changed section / 只重建变更的区块
// Insert at correct position / 插入到正确位置
wrapper.insertChild(heroIndex, newSection);
```

6. Validate with `get_screenshot` / 用 `get_screenshot` 验证

---

## HTML-to-Figma Section Mapping / HTML 到 Figma 区块映射

| HTML Element / Class / HTML 元素/类 | Figma Section Type / Figma 区块类型 | Auto-Layout Direction / 自动布局方向 |
|---|---|---|
| `<header>`, `.navbar`, `.nav` | Navbar / 导航栏 | HORIZONTAL |
| `.hero`, `.banner`, first `<section>` | Hero / 英雄区 | VERTICAL |
| `.features`, `.card-grid`, `.grid` | Feature Grid / 功能网格 | HORIZONTAL + WRAP |
| `.pricing`, `.plans`, `.tiers` | Pricing Grid / 定价网格 | HORIZONTAL |
| `.testimonials`, `.reviews` | Testimonials / 证言区 | HORIZONTAL + WRAP |
| `.faq`, `.accordion` | FAQ / 常见问题 | VERTICAL |
| `.cta-section`, `.cta-banner` | CTA Banner / CTA 横幅 | VERTICAL |
| `<form>`, `.login`, `.signup` | Form / 表单 | VERTICAL |
| `<table>`, `.data-table` | Data Table / 数据表格 | VERTICAL |
| `<footer>`, `.footer` | Footer / 页脚 | HORIZONTAL |
| `.sidebar` | Sidebar / 侧边栏 | VERTICAL |
| `.dashboard`, `.analytics` | Dashboard / 仪表盘 | HORIZONTAL (wrapper / 包装) |

---

## Design Quality Guidelines / 设计质量准则

### Layout / 布局
- Use proper auto-layout for every container / 每个容器使用正确的自动布局（不使用绝对定位）
- Sections span full width / 区块全宽（包装器内 `layoutSizingHorizontal = "FILL"`）
- Consistent padding / 一致内边距：区块上下内边距 ≥ 64px，桌面端内容最大宽度 ≤ 1200px
- Card grids: use `HORIZONTAL` auto-layout with `WRAP` / 卡片网格使用 `HORIZONTAL` 自动布局 + `WRAP`

### Typography / 字体排版
- Maximum 3 font sizes per section / 每个区块最多 3 个字体大小（标题、正文、说明）
- Use imported text styles from registry whenever available / 尽量使用注册表中的导入文字样式
- Heading sizes / 标题大小: H1 = 48–64px, H2 = 32–40px, H3 = 24–28px, Body = 16px, Caption = 12–14px
- **Always load fonts with `figma.loadFontAsync()` before setting `characters` / 设置 `characters` 前始终用 `figma.loadFontAsync()` 加载字体**

### Color / 色彩
- Prefer Figma variable bindings when variables exist / 当变量存在时优先使用 Figma 变量绑定
- Fall back to Design Token Map hex values when no variables found / 无变量时使用设计 Token 映射表的十六进制值
- Ensure WCAG AA minimum contrast (4.5:1) / 确保满足 WCAG AA 最低对比度（4.5:1）

### Spacing / 间距
- Use design system spacing tokens from registry when available / 有注册表时使用设计系统间距 token
- Fallback: 4px grid (8, 16, 24, 32, 48, 64, 96px) from Design Token Map / 回退：使用设计 Token 映射表中的 4px 网格

### Components / 组件
- Always prefer imported design system components over manual recreation / 始终优先导入设计系统组件而非手动重建
- Set real text content on every component instance / 每个组件实例设置真实文本内容（不使用占位文字）
- Use correct component variants (primary/secondary, size, state) / 使用正确的组件变体

### Anti-Patterns (from UI/UX Pro Max) / 反模式（来自 UI/UX Pro Max）
- Apply the anti-pattern list from Step 1d — explicitly avoid those patterns / 应用步骤 1d 的反模式清单
- Never use emoji as icons — use SVG (Heroicons, Lucide) / 不使用 emoji 作为图标，使用 SVG
- Always `cursor-pointer` on all clickable elements / 所有可点击元素始终添加 `cursor-pointer`
- Hover states with smooth transitions (150–300ms) / 悬停状态使用平滑过渡（150–300ms）

---

## Special Modes / 特殊模式

### Mode: Natural Language → HTML → Figma / 模式：自然语言 → HTML → Figma

1. Run UI/UX Pro Max design system generator (Step 1) / 运行 UI/UX Pro Max 设计系统生成器
2. Scan Figma file for components (Step 2) / 扫描 Figma 文件中的组件
3. Synthesize screen spec (Step 3) / 整合界面规格
4. Generate HTML with full design tokens embedded (Step 5) / 生成内嵌完整设计 token 的 HTML
5. Convert HTML to Figma (Step 6) / 将 HTML 转换为 Figma

### Mode: HTML File → Figma / 模式：HTML 文件 → Figma

1. Read the provided HTML file / 读取提供的 HTML 文件
2. Run UI/UX Pro Max on the content/product type / 根据内容/产品类型运行 UI/UX Pro Max
3. **Enhance the HTML** with design tokens / **增强 HTML**，注入 CSS 变量匹配设计 token
4. Add `data-figma-*` attributes based on semantic structure analysis / 根据语义结构分析添加 `data-figma-*` 属性
5. Convert enhanced HTML to Figma (Step 6) / 将增强后的 HTML 转换为 Figma

### Mode: Wireframe → HTML → Figma / 模式：线框图 → HTML → Figma

1. Analyze the wireframe image to extract section structure / 分析线框图提取区块结构
2. Run UI/UX Pro Max to get the design system / 运行 UI/UX Pro Max 获取设计系统
3. **Generate HTML** that reproduces the wireframe structure + applies the design system / **生成 HTML**，重现线框结构并应用设计系统
4. Convert HTML to Figma (Step 6) / 将 HTML 转换为 Figma
5. Use the wireframe as a layout reference during validation / 验证时将线框图作为布局参考

### Mode: Multi-Style Variants / 模式：多样式变体

When the user wants to see multiple design directions / 当用户想查看多种设计方向时：

1. Run UI/UX Pro Max twice with different style keywords / 用不同样式关键词运行两次 UI/UX Pro Max
2. Generate 2 HTML files — one per style variant / 生成 2 个 HTML 文件，每种样式一个
3. Build 2 Figma wrapper frames side by side / 并排构建 2 个 Figma 包装框架，各自从对应 HTML 派生
4. Label each variant frame clearly / 清晰标记每个变体框架

---

## Error Recovery / 错误恢复

Follow the error recovery process from [figma-use](../figma-use/SKILL.md):  
遵循 [figma-use](../figma-use/SKILL.md) 的错误恢复流程：

1. **STOP on error / 出错时停止** — do not retry immediately / 不要立即重试
2. Read the error message to understand what failed / 阅读错误信息了解失败原因
3. If unclear, call `get_metadata` or `get_screenshot` to inspect the file / 如不清楚，调用 `get_metadata` 或 `get_screenshot` 检查文件
4. Fix the script / 修复脚本 — since each section is a separate call, failures are isolated / 每个区块是单独调用，失败被隔离
5. Retry the corrected script / 重试修正后的脚本

**HTML-specific errors / HTML 特定错误：**
- If `data-figma-component` references a non-existent registry key → build manually instead / 如果引用了不存在的注册表键 → 改为手动构建
- If a component import fails → fall back to manual frame building with Design Token Map values / 如果组件导入失败 → 回退到用设计 Token 映射表值手动构建
- If font loading fails → try `{ family: "Inter", style: "Regular" }` as universal fallback / 字体加载失败 → 尝试 `{ family: "Inter", style: "Regular" }` 作为通用回退

---

## Reference Docs / 参考文档

Load these as needed / 按需加载：

- [figma-generate-design](../figma-generate-design/SKILL.md) — Core screen-building workflow / 核心页面构建工作流
- [figma-use](../figma-use/SKILL.md) — Plugin API rules and critical gotchas / Plugin API 规则和关键注意事项
- [figma-create-new-file](../figma-create-new-file/SKILL.md) — Creating a new Figma file / 创建新 Figma 文件
- [component-patterns.md](../figma-use/references/component-patterns.md) — Importing components, setProperties, text overrides / 导入组件、setProperties、文字覆盖
- [variable-patterns.md](../figma-use/references/variable-patterns.md) — Binding variables, importing library variables / 绑定变量、导入库变量
- [text-style-patterns.md](../figma-use/references/text-style-patterns.md) — Applying text styles / 应用文字样式
- [gotchas.md](../figma-use/references/gotchas.md) — Critical layout pitfalls / 关键布局陷阱

**UI/UX Pro Max search script / UI/UX Pro Max 搜索脚本**: `~/.codex/skills/ui-ux-pro-max/scripts/search.py`
- `--design-system` — Full design system generation / 完整设计系统生成
- `--domain style/color/typography/ux/chart/product` — Domain-specific searches / 领域专项搜索
- `--persist` — Save design system to `design-system/MASTER.md` / 保存设计系统
- `-p "Name"` — Set project name / 设置项目名称
- `-f markdown` — Markdown output format / Markdown 输出格式

---

*figma-generate-ui v2.0 — authored by shiki · 2026-04-01*  
*figma-generate-ui v2.0 — 作者：shiki · 2026-04-01*
