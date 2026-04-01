# Figma MCP Server Guide / Figma MCP 服务器指南

<!--
  Author / 作者: shiki
  Updated / 更新: 2026-04-01
  figma-generate-ui upgraded to v2: UI/UX Pro Max design intelligence + Figma component registry + HTML-first pipeline
  figma-generate-ui 升级至 v2：UI/UX Pro Max 设计智能 + Figma 组件注册表 + HTML 优先生成流程
-->

> **Author / 作者**: shiki &nbsp;·&nbsp; **Updated / 更新**: 2026-04-01

The Figma MCP server brings Figma directly into your workflow by providing important design information and context to AI agents generating code from Figma design files.  
Figma MCP 服务器将 Figma 直接引入你的工作流，为 AI 智能体提供重要的设计信息和上下文，帮助从 Figma 设计文件生成代码。

> [!NOTE]
> Rate limits apply to Figma MCP server tools that read data from Figma. Some tools, such as those that write to Figma files, are exempt from the rate limits.  
> 速率限制适用于从 Figma 读取数据的 MCP 工具，写入 Figma 文件的工具不受限制。
> <br><br>
> Users on the Starter plan or with View or Collab seats on paid plans will be limited to up to 6 tool calls per month.  
> Starter 计划用户或付费计划中的 View/Collab 席位每月最多 6 次工具调用。
> <br><br>
> Users with a [Dev or Full seat](https://help.figma.com/hc/en-us/articles/27468498501527) on the [Professional, Organization, or Enterprise plans](https://help.figma.com/hc/en-us/articles/360040328273) have per-minute rate limits following Tier 1 [Figma REST API](https://developers.figma.com/docs/rest-api/rate-limits/) limits.  
> Professional/Organization/Enterprise 计划的 Dev 或 Full 席位用户遵循 Tier 1 Figma REST API 每分钟速率限制。

For the complete set of Figma MCP server docs, see our [developer documentation](https://developers.figma.com/docs/figma-mcp-server/). By using the Figma MCP server and the related resources (including these skills), you agree to the [Figma Developer Terms](https://www.figma.com/legal/developer-terms/). These skills are currently available as a Beta feature.  
完整 Figma MCP 服务器文档请查看[开发者文档](https://developers.figma.com/docs/figma-mcp-server/)。使用 Figma MCP 服务器及相关资源（包括这些技能），即表示同意 [Figma 开发者条款](https://www.figma.com/legal/developer-terms/)。这些技能目前处于 Beta 阶段。

---

## Features / 功能特性

### ✦ AI-powered UI generation in Figma (v2) *(upgraded / 已升级)*
### ✦ Figma AI 界面生成（v2）

Generate polished, design-system-consistent Figma screens directly from your IDE using the **three-engine pipeline**: UI/UX Pro Max design intelligence, Figma component registry scanning, and HTML-first generation.  
通过**三引擎流水线**直接在 IDE 中生成精美的 Figma 界面：UI/UX Pro Max 设计智能、Figma 组件注册表扫描、HTML 优先生成。

**v2 新增功能 / v2 New Capabilities:**

- **UI/UX Pro Max Design Intelligence** — Before any generation, automatically runs a design system reasoning engine across 161 product types, 67 UI styles, 161 color palettes, and 57 font pairings to produce a complete design token map (style, colors, typography, effects, anti-patterns).  
  **UI/UX Pro Max 设计智能** —— 生成前自动运行设计系统推理引擎，覆盖 161 种产品类型、67 种 UI 样式、161 个色彩方案和 57 种字体搭配，输出完整设计 token 映射表（样式、色彩、字体排版、效果、反模式）。

- **Figma Component Registry** — Scans the current Figma file for all existing components, frames, variables, and styles before generating, building an authoritative component map that guides which design system assets to reuse.  
  **Figma 组件注册表** —— 生成前扫描当前 Figma 文件中所有现有组件、框架、变量和样式，构建权威组件映射表，指导哪些设计系统资产可以复用。

- **HTML-First Pipeline** — All UI generation and modification work starts by producing a complete, semantic HTML file with embedded CSS design tokens. The HTML is the single source of truth; Figma output is derived from it via `data-figma-*` attribute mapping.  
  **HTML 优先流程** —— 所有 UI 创建和修改工作首先生成一个完整的语义化 HTML 文件（内嵌 CSS 设计 token）。HTML 是唯一事实来源，Figma 输出通过 `data-figma-*` 属性映射从 HTML 派生。

**Supported input modes / 支持的输入模式:**
- **Natural language / 自然语言** — "Create a SaaS pricing page with 3 tiers" / "创建有三档定价的 SaaS 页面"
- **HTML / source files / HTML/源文件** — "Convert src/pages/landing.html to a Figma design" / "将 landing.html 转换为 Figma 设计"
- **Wireframe or prototype images / 线框图或原型图** — "Reproduce this wireframe in high-fidelity using our design system" / "用我们的设计系统高保真重建这个线框图"
- **Multiple design directions / 多设计方向** — "Generate a light and dark version side by side" / "并排生成亮色和深色两个版本"

Powered by the `use_figma` + `search_design_system` tools and the `figma-generate-ui` skill (v2).  
由 `use_figma` + `search_design_system` 工具以及 `figma-generate-ui` 技能（v2）驱动。

---

### ✦ Write to the canvas / 写入画布

Create and modify native Figma content directly from your MCP client. With the right skills, agents can build and update frames, components, variables, and auto layout in your Figma files using your design system as the source of truth.  
直接从 MCP 客户端创建和修改原生 Figma 内容。借助合适的技能，AI 智能体可以以设计系统为事实来源，在 Figma 文件中构建和更新框架、组件、变量和自动布局。

> **Note / 注意:** We're quickly improving how Figma supports AI agents. The write to canvas feature will eventually be a usage-based paid feature, but is currently available for free during the beta period.  
> 我们正在快速改进 Figma 对 AI 智能体的支持。写入画布功能最终将成为按用量收费的付费功能，但目前在 Beta 期间免费使用。

---

### ✦ Generate code from selected frames / 从选定框架生成代码

Select a Figma frame and turn it into code. Great for product teams building new flows or iterating on app features.  
选择 Figma 框架并将其转为代码。适合构建新流程或迭代应用功能的产品团队。

---

### ✦ Extract design context / 提取设计上下文

Pull in variables, components, and layout data directly into your IDE. Especially useful for design systems and component-based workflows.  
将变量、组件和布局数据直接拉取到 IDE 中，特别适合设计系统和基于组件的工作流。

---

### ✦ Code smarter with Code Connect / 用 Code Connect 更智能地生成代码

Boost output quality by reusing your actual components. Code Connect keeps your generated code consistent with your codebase.  
通过复用实际组件提升输出质量。Code Connect 让生成的代码与代码库保持一致。

[Learn more about Code Connect / 了解更多 →](https://help.figma.com/hc/en-us/articles/23920389749655-Code-Connect)

---

### ✦ Generate Figma designs from running web pages *(specific clients only / 特定客户端)*

Capture a live, locally-running web page as pixel-perfect Figma design layers via `generate_figma_design`. Best used as a visual reference alongside the AI-powered generation workflow above.  
通过 `generate_figma_design` 将本地运行的网页捕获为像素级 Figma 设计图层，最好与上述 AI 生成工作流结合作为视觉参考。

---

## Installation & Setup / 安装与配置

### Connect to the Figma MCP server / 连接 Figma MCP 服务器

#### VS Code

1. Use the shortcut `⌘ Shift P` to search for `MCP:Add Server` / 使用快捷键 `⌘ Shift P` 搜索 `MCP:Add Server`
2. Select `HTTP` / 选择 `HTTP`
3. Paste the server url `https://mcp.figma.com/mcp` / 粘贴服务器地址
4. Enter server ID: `figma` / 输入服务器 ID: `figma`
5. Switch to **Agent** mode via `⌥⌘B` / 通过 `⌥⌘B` 切换到 **Agent** 模式

```json
{
  "servers": {
    "figma": {
      "type": "http",
      "url": "https://mcp.figma.com/mcp"
    }
  }
}
```

> Requires [GitHub Copilot](https://github.com/features/copilot). See [VS Code docs](https://code.visualstudio.com/docs/copilot/chat/mcp-servers).  
> 需要 GitHub Copilot。参见 [VS Code 官方文档](https://code.visualstudio.com/docs/copilot/chat/mcp-servers)。

#### Cursor

The recommended way is installing the Figma Plugin (includes MCP + skills):  
推荐方式是安装 Figma 插件（包含 MCP + 技能）：

```
/add-plugin figma
```

Plugin includes / 插件包含:
- MCP server configuration / MCP 服务器配置
- Skills for **generating UI designs in Figma** (figma-generate-ui v2) / **在 Figma 中生成 UI 设计**的技能
- Skills for implementing designs, Code Connect, and design system rules / 实现设计、Code Connect 和设计系统规则的技能
- Rules for proper asset handling / 资产处理规则

<details>
<summary>Manual setup / 手动配置</summary>

1. Open `Cursor → Settings → MCP` / 打开 `Cursor → 设置 → MCP`
2. Click `+ Add new global MCP server` / 点击 `+ 添加新全局 MCP 服务器`
3. Enter configuration and save / 输入配置并保存:

```json
{
  "mcpServers": {
    "figma": {
      "url": "https://mcp.figma.com/mcp"
    }
  }
}
```

</details>

#### Claude Code

```bash
# Install plugin (recommended) / 安装插件（推荐）
claude plugin install figma@claude-plugins-official

# Or manual / 或手动
claude mcp add --transport http figma https://mcp.figma.com/mcp
```

#### Other editors / 其他编辑器

Any editor supporting Streamable HTTP can connect using:  
任何支持 Streamable HTTP 的编辑器均可使用以下配置连接：

```json
{
  "mcpServers": {
    "figma": {
      "url": "https://mcp.figma.com/mcp"
    }
  }
}
```

---

## Prompting your MCP client / 提示词指南

### Generate UI designs in Figma (text → Figma) / 在 Figma 中生成 UI 设计（文字 → Figma）

The agent uses the `figma-generate-ui` v2 skill — which first generates a complete HTML prototype using UI/UX Pro Max design intelligence, then converts it to Figma component instances:  
AI 智能体使用 `figma-generate-ui` v2 技能——首先用 UI/UX Pro Max 设计智能生成完整 HTML 原型，再转换为 Figma 组件实例：

- "Create a SaaS dashboard for a project management tool in Figma, using our design system"  
  "在 Figma 中为项目管理工具创建一个 SaaS 仪表盘，使用我们的设计系统"
- "Convert src/pages/pricing.html to a Figma design"  
  "将 src/pages/pricing.html 转换为 Figma 设计"
- "Reproduce this wireframe [attach image] in high-fidelity using our component library"  
  "用我们的组件库将这个线框图高保真重建为 Figma 设计"
- "Generate a login screen and a signup screen in Figma, desktop 1440px"  
  "在 Figma 中生成登录和注册界面，桌面端 1440px"
- "Design a mobile onboarding flow (390px) for a fintech app"  
  "为金融科技应用设计移动端引导流程（390px）"

**Generation workflow / 生成工作流 (v2):**  
1. Run UI/UX Pro Max to generate design tokens (style, colors, typography, anti-patterns) / 运行 UI/UX Pro Max 生成设计 token
2. Scan Figma file for existing components and variables / 扫描 Figma 文件中的现有组件和变量
3. Synthesize screen specification / 整合界面规格
4. Generate complete semantic HTML with embedded CSS design tokens / 生成内嵌 CSS 设计 token 的完整语义化 HTML
5. Present HTML for user review and approval / 向用户展示 HTML 供审阅
6. Convert HTML to Figma component instances section-by-section / 逐区块将 HTML 转换为 Figma 组件实例
7. Validate with screenshots, report completion / 截图验证，报告完成

### Implement Figma designs as code (Figma → code) / 将 Figma 设计实现为代码（Figma → 代码）

1. Copy the link to a frame or layer in Figma / 复制 Figma 中框架或图层的链接
2. Prompt your client to implement the design at the selected URL / 提示客户端实现该 URL 的设计

---

## Tools and usage / 工具与用法

### AI UI Generation workflow (`figma-generate-ui` v2 skill) / AI UI 生成工作流

**Supported file types / 支持文件类型:** Figma Design

| Input / 输入 | Example prompt / 示例提示词 |
|---|---|
| Natural language / 自然语言 | `"Create a fintech dashboard with balance card, transaction list, and quick-action bar"` |
| HTML file / HTML 文件 | `"Convert src/pages/landing.html to a Figma design using our design system"` |
| Wireframe image / 线框图 | `"Reproduce this wireframe in high-fidelity Figma using our component library"` |
| Figma prototype URL / 原型链接 | `"Upgrade this lo-fi prototype to high-fidelity: https://figma.com/design/..."` |
| Multiple variants / 多变体 | `"Generate a light mode and dark mode version of the pricing page side by side"` |

**Design quality guarantees (v2) / 设计质量保证（v2）:**
- UI/UX Pro Max design tokens applied (no generic defaults) / 应用 UI/UX Pro Max 设计 token（不使用通用默认值）
- HTML source of truth preserved in `figma-exports/` folder / HTML 事实来源保存在 `figma-exports/` 文件夹
- Real content on every component instance (no placeholder text) / 每个组件实例使用真实内容（无占位文本）
- Design system components preferred over hand-drawn primitives / 优先使用设计系统组件
- Variable bindings for colors and spacing / 颜色和间距使用变量绑定
- CSS→Figma auto-layout mapping throughout / 全程使用 CSS→Figma 自动布局映射
- Section-level screenshots validate each step / 区块级截图验证每个步骤

### `get_design_context`

**Supported file types / 支持文件类型:** Figma Design, Figma Make

Use this to get design context for your Figma selection. Default output is **React + Tailwind**, customizable via prompts:  
获取 Figma 选区的设计上下文。默认输出 **React + Tailwind**，可通过提示词自定义：

- "Generate my Figma selection in Vue." / "用 Vue 生成我的 Figma 选区。"
- "Generate my Figma selection in plain HTML + CSS." / "用原生 HTML + CSS 生成。"
- "Generate my Figma selection using components from src/components/ui" / "使用 src/components/ui 中的组件生成。"

### `generate_figma_design` *(specific clients only / 特定客户端)*

Captures a **running, locally-served web page** as pixel-perfect Figma design layers. Best used as a visual reference alongside the `figma-generate-ui` v2 skill.  
将**本地运行的网页**捕获为像素级 Figma 设计图层，最好与 `figma-generate-ui` v2 技能结合作为视觉参考。

### `use_figma`

The general-purpose tool for writing to Figma. Best invoked with the `figma-use` skill.  
写入 Figma 的通用工具，最好与 `figma-use` 技能结合使用。

### `search_design_system`

Searches across all connected design libraries for components, variables, and styles. Used automatically by `figma-generate-ui` v2 for component registry building.  
跨所有关联设计库搜索组件、变量和样式。`figma-generate-ui` v2 在构建组件注册表时自动调用。

### `get_variable_defs`

Returns variables and styles used in your selection — colors, spacing, typography.  
返回选区中使用的变量和样式——颜色、间距、字体排版。

### `get_code_connect_map` / `add_code_connect_map` / `get_code_connect_suggestions` / `send_code_connect_mappings`

Tools for connecting Figma design elements to their code implementations.  
用于将 Figma 设计元素与代码实现连接起来的工具集。

### `get_screenshot`

Takes a screenshot of your selection to preserve layout fidelity. Used after every section build in `figma-generate-ui` v2.  
截取选区截图以保存布局保真度，在 `figma-generate-ui` v2 每个区块构建后自动调用。

### `create_design_system_rules`

Generates rule files that give agents context to produce high-quality frontend code aligned with your design system.  
生成规则文件，让智能体获得与设计系统一致的高质量前端代码所需的上下文。

### `get_metadata`

Returns an XML representation of your selection with basic properties. Useful for very large designs.  
返回包含基本属性的选区 XML 表示，适用于非常大型的设计。

### `generate_diagram`

Generates FigJam diagrams from Mermaid syntax.  
从 Mermaid 语法生成 FigJam 图表。

### `create_new_file`

Creates a new blank Figma Design or FigJam file in your drafts.  
在草稿中创建新的空白 Figma 设计或 FigJam 文件。

---

## MCP best practices / MCP 最佳实践

### Structure your Figma file for better code / 优化 Figma 文件结构以获得更好的代码

- **Use components** for anything reused (buttons, cards, inputs, etc.) / **使用组件**处理任何复用元素
- **Link components to your codebase** via Code Connect / 通过 Code Connect **将组件链接到代码库**
- **Use variables** for spacing, color, radius, and typography / **使用变量**管理间距、颜色、圆角和字体
- **Name layers semantically** (e.g. `CardContainer`, not `Group 5`) / **语义化命名图层**（如 `CardContainer` 而非 `Group 5`）
- **Use Auto layout** to communicate responsive intent / **使用自动布局**传达响应式意图

### Write effective prompts / 编写有效提示词

**Generate UI in Figma (v2) / 在 Figma 中生成 UI（v2）:**
- "Create a SaaS landing page in Figma using our design system" / "用我们的设计系统在 Figma 中创建 SaaS 落地页"
- "Convert src/pages/dashboard.html to a Figma design, desktop 1440px" / "将 dashboard.html 转换为 Figma 设计，桌面 1440px"
- "Reproduce this wireframe [image] in our Figma design system" / "用我们的 Figma 设计系统重建这个线框图"
- "Build a mobile checkout flow (390px) in Figma for our e-commerce app" / "为电商应用在 Figma 中构建移动端结账流程（390px）"

**Useful constraints / 有效约束:**
- Screen size / 界面尺寸: "desktop 1440px", "tablet 768px", "mobile 390px"
- Design system / 设计系统: "use our Material design system", "use the tokens from [Figma URL]"
- Content / 内容: "use real copy from the HTML", "keep the wireframe's text labels"

**Implement Figma as code / 将 Figma 实现为代码:**
- "Generate iOS SwiftUI code from this frame" / "从这个框架生成 iOS SwiftUI 代码"
- "Use Chakra UI for this layout" / "用 Chakra UI 实现这个布局"
- "Add this to `src/components/marketing/PricingCard.tsx`" / "将其添加到 PricingCard.tsx"

### Break down large selections / 分解大型选区

Break screens into smaller parts for faster, more reliable results:  
将界面分解为较小部分以获得更快更可靠的结果：

1. Generate code for smaller sections or individual components / 为较小区块或独立组件生成代码
2. If it feels slow or stuck, reduce your selection size / 如果感觉缓慢或卡住，减小选区大小

### Add custom rules / 添加自定义规则

**Cursor:**
```yaml
---
description: Figma MCP server rules
globs:
alwaysApply: true
---
- The Figma MCP server provides an assets endpoint which can serve image and SVG assets
- IMPORTANT: If the Figma MCP server returns a localhost source for an image or an SVG, use that image or SVG source directly
- IMPORTANT: DO NOT import/add new icon packages, all the assets should be in the Figma payload
- IMPORTANT: do NOT use or create placeholders if a localhost source is provided
```

**General quality rules / 通用质量规则:**
```
- IMPORTANT: Always use components from /path_to_your_design_system when possible
- Prioritize Figma fidelity to match designs exactly
- Avoid hardcoded values, use design tokens from Figma where available
- Follow WCAG requirements for accessibility
- Place UI components in /path_to_your_design_system; avoid inline styles unless truly necessary
```

---

## Bringing Make context to your agent / 将 Make 上下文引入智能体

The Make + MCP integration makes it easier to take prototypes from **design to production**.  
Make + MCP 集成让原型从**设计到生产**变得更加容易。

1. Share your Make project link with your agent / 与智能体分享 Make 项目链接
2. Prompt: "I want to get the popup component behavior and styles from this Make file and implement it using my popup component." / "我想从这个 Make 文件获取弹窗组件的行为和样式，并用我的弹窗组件实现它。"

---

# Icon Guidelines / 图标使用指南

See the [Figma Brand Usage Guidelines](https://www.figma.com/using-the-figma-brand) for displaying any icons contained in this repo.  
关于本仓库中图标的展示，请参见 [Figma 品牌使用指南](https://www.figma.com/using-the-figma-brand)。

---

*figma-everyworkflow · authored by shiki · 2026-04-01*
