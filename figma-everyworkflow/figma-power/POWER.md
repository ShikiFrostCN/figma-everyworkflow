---
name: "figma"
displayName: "Figma"
description: "Comprehensive Figma integration for: (1) generating UI designs in Figma from natural language, HTML files, or wireframes — like UX Pilot but directly in Figma, with UI/UX Pro Max design intelligence and HTML-first pipeline, (2) implementing Figma designs as production-ready code, (3) connecting Figma components to code via Code Connect, and (4) generating project-specific design system rules. Use when implementing UI from Figma files, generating new Figma designs, connecting components to code, creating design system rules, or when user provides Figma URLs."
keywords: ["figma", "design", "implement", "component", "ui", "code generation", "design system", "code connect", "mapping", "design to code", "rules", "guidelines", "implement design", "implement component", "generate code", "connect component", "design rules", "build design", "generate ui", "create design", "generate figma", "html to figma", "wireframe to figma", "design from description", "ux pilot", "ai design generation", "create screen", "build page figma", "ui ux pro max", "html first", "component registry"]
author: "shiki"
version: "2.0"
updated: "2026-04-01"
---

<!--
  Author / 作者: shiki
  Version / 版本: 2.0
  Updated / 更新: 2026-04-01
-->

# Figma Power / Figma 功能集

## Overview / 概述

This Power provides four core capabilities for working with Figma:  
本 Power 提供四项核心 Figma 工作能力：

1. **Generate UI Design (v2) / 生成 UI 设计（v2）** — AI-powered UI generation in Figma from natural language, HTML files, or wireframe images, powered by the **three-engine pipeline**: UI/UX Pro Max design intelligence, Figma component registry, and HTML-first generation.  
   由**三引擎流水线**驱动：UI/UX Pro Max 设计智能、Figma 组件注册表、HTML 优先生成。

2. **Implement Design / 实现设计** — Translate Figma designs into production-ready code with pixel-perfect accuracy.  
   将 Figma 设计以像素级精度转为生产就绪代码。

3. **Code Connect Components / Code Connect 组件连接** — Connect Figma design components to their code implementations using Code Connect.  
   通过 Code Connect 将 Figma 设计组件与代码实现连接。

4. **Create Design System Rules / 创建设计系统规则** — Generate project-specific design system rules that guide consistent Figma-to-code workflows.  
   生成项目专属的设计系统规则，指导一致的 Figma→代码工作流。

---

## When to Use This Power / 何时使用本 Power

Activate this Power when the user / 在以下情况激活本 Power：

- Wants to **generate** a Figma design from a description, HTML, or wireframe / 想要从描述、HTML 或线框图**生成** Figma 设计
- Mentions: generate UI in Figma, create a design for, build this screen, convert HTML to Figma, design from description, create screen, make a Figma design / 提及：在 Figma 中生成 UI、创建设计、构建界面、将 HTML 转为 Figma
- Provides a Figma URL and wants to implement the design as code / 提供 Figma URL 并想将设计实现为代码
- Mentions: implement design, generate code, implement component, build Figma design / 提及：实现设计、生成代码、实现组件
- Mentions: code connect, connect this component to code, map this component / 提及：code connect、将组件连接到代码、映射组件
- Mentions: create design system rules, generate rules for my project / 提及：创建设计系统规则、为项目生成规则

---

## Available MCP Tools / 可用 MCP 工具

| Tool / 工具 | Description / 描述 |
|------|-------------|
| `get_design_context` | Fetches structured design data (layout, typography, colors, spacing) / 获取结构化设计数据（布局、字体、颜色、间距） |
| `get_metadata` | Returns sparse XML with basic layer properties / 返回包含基本图层属性的稀疏 XML |
| `get_screenshot` | Captures a visual screenshot of a Figma selection / 捕获 Figma 选区的视觉截图 |
| `get_variable_defs` | Retrieves variables and styles from selections / 从选区获取变量和样式 |
| `get_code_connect_suggestions` | Detects and suggests Code Connect mappings / 检测并建议 Code Connect 映射 |
| `send_code_connect_mappings` | Confirms Code Connect mappings / 确认 Code Connect 映射 |
| `get_code_connect_map` | Maps Figma node IDs to code components / 将 Figma 节点 ID 映射到代码组件 |
| `add_code_connect_map` | Establishes new Figma-to-code mappings / 建立新的 Figma→代码映射 |
| `create_design_system_rules` | Generates rule files for design system guidance / 生成设计系统指导规则文件 |
| `generate_figma_design` | Converts running web page into Figma design layers / 将运行中的网页转为 Figma 设计图层 |
| `search_design_system` | Searches design libraries for components, variables, styles / 在设计库中搜索组件、变量、样式 |
| `use_figma` | General-purpose Figma write tool / 通用 Figma 写入工具 |
| `create_new_file` | Creates a new Figma Design or FigJam file / 创建新 Figma 设计或 FigJam 文件 |
| `get_figjam` | Converts FigJam diagrams to XML / 将 FigJam 图表转为 XML |
| `generate_diagram` | Creates FigJam diagrams from Mermaid syntax / 从 Mermaid 语法创建 FigJam 图表 |
| `whoami` | Returns authenticated user identity / 返回已认证用户信息 |

---

## Steering / 工作流路由

Load the appropriate workflow based on the user's intent / 根据用户意图加载相应工作流：

- **Generating a new Figma UI design** (from text, HTML, or wireframe) / **生成新 Figma UI 设计**（文字、HTML 或线框图）  
  → `readPowerSteering("figma", "generate-ui.md")`
- **Implementing a Figma design as code** / **将 Figma 设计实现为代码**  
  → `readPowerSteering("figma", "implement-design.md")`
- **Connecting Figma components to code via Code Connect** / **通过 Code Connect 连接组件**  
  → `readPowerSteering("figma", "code-connect-components.md")`
- **Creating design system rules** / **创建设计系统规则**  
  → `readPowerSteering("figma", "create-design-system-rules.md")`

---

## Prerequisites / 前置条件

- Figma MCP server must be connected and accessible / Figma MCP 服务器必须已连接且可访问
- For **Generate UI (v2)** / 对于**生成 UI（v2）**: A Figma file must be open, or the user accepts creating a new one. `ui-ux-pro-max` scripts preferred at `~/.codex/skills/ui-ux-pro-max/scripts/search.py` / 需要打开 Figma 文件或接受新建。建议安装 `ui-ux-pro-max` 脚本
- For **Implement Design** / 对于**实现设计**: User must provide a Figma URL in the format `https://figma.com/design/:fileKey/:fileName?node-id=1-2`
- For **Code Connect / Design System Rules**: Project should have an established design system or component library / 项目应有已建立的设计系统或组件库

---

## Quick Usage Examples / 快速使用示例

### Generate a UI Design in Figma (v2) / 在 Figma 中生成 UI 设计（v2）

User: "Create a SaaS pricing page in Figma using our design system"  
用户："在 Figma 中用我们的设计系统创建一个 SaaS 定价页"

→ Load `generate-ui.md` steering.  
→ **v2 pipeline**: Run UI/UX Pro Max design system generator → scan Figma component registry → generate semantic HTML with design tokens → present HTML for approval → convert to Figma component instances section-by-section.  
→ **v2 流程**：运行 UI/UX Pro Max 设计系统生成器 → 扫描 Figma 组件注册表 → 生成含设计 token 的语义化 HTML → 展示 HTML 供审阅 → 逐区块转换为 Figma 组件实例。

User: "Convert src/pages/landing.html to a Figma design"  
用户："将 src/pages/landing.html 转换为 Figma 设计"

→ Load `generate-ui.md` → Mode: HTML-to-Figma. Read HTML → enhance with design tokens → add `data-figma-*` attributes → convert to Figma.  
→ 加载 `generate-ui.md` → HTML→Figma 模式。读取 HTML → 增强设计 token → 添加 `data-figma-*` 属性 → 转换为 Figma。

### Implement a Design / 实现设计

User: "Implement this Figma button: https://figma.com/design/..."  
用户："实现这个 Figma 按钮：https://figma.com/design/..."

→ Load `implement-design.md` steering, follow the 7-step workflow.  
→ 加载 `implement-design.md`，遵循 7 步工作流。

### Connect Components via Code Connect / 通过 Code Connect 连接组件

User: "Connect this Figma button to my code"  
用户："将这个 Figma 按钮连接到我的代码"

→ Load `code-connect-components.md` steering.  
→ 加载 `code-connect-components.md`。

### Create Design System Rules / 创建设计系统规则

User: "Create design system rules for my React project"  
用户："为我的 React 项目创建设计系统规则"

→ Load `create-design-system-rules.md` steering.  
→ 加载 `create-design-system-rules.md`。

---

## Troubleshooting / 故障排查

### Generate UI: No design system found / 生成 UI：未找到设计系统

If `search_design_system` returns nothing and the file has no existing screens:  
如果 `search_design_system` 无返回且文件无现有界面：
- Ask the user if they want to provide a Figma library URL / 询问用户是否要提供 Figma 库 URL
- UI/UX Pro Max design tokens will still provide a complete style foundation / UI/UX Pro Max 设计 token 仍会提供完整的样式基础
- Fall back to building manually with consistent visual language (Inter font, 4px grid, neutral palette) / 退而使用一致的视觉语言手动构建
- Consider using [figma-generate-library](../../skills/figma-generate-library/SKILL.md) to scaffold a design system first / 考虑先用 `figma-generate-library` 搭建设计系统

### Generate UI: Generated screen looks wrong visually / 生成 UI：生成的界面视觉效果有误

Take a section-level screenshot to pinpoint the issue. Check for: clipped text (line height too small), wrong component variant, missing variable binding. Fix with a targeted `use_figma` call — do NOT rebuild the whole screen.  
截取区块级截图以定位问题。检查：文字被裁剪（行高太小）、错误的组件变体、缺少变量绑定。用精准的 `use_figma` 调用修复——不要重建整个界面。

### Generate UI: HTML file has complex nested structures / 生成 UI：HTML 文件嵌套结构复杂

Focus on major semantic sections only (header, main, section, footer). Skip deeply nested tables or mega-menus. Ask the user which sections to prioritize.  
只关注主要语义区块（header、main、section、footer）。跳过深层嵌套表格或超级菜单。询问用户优先处理哪些区块。

### Figma output is truncated (Implement Design) / Figma 输出被截断（实现设计）

Use `get_metadata` to get the node structure, then fetch specific nodes individually with `get_design_context`.  
使用 `get_metadata` 获取节点结构，然后用 `get_design_context` 单独获取特定节点。

### Assets not loading / 资产无法加载

Verify the Figma MCP server's assets endpoint is accessible. The server serves assets at `localhost` URLs — use these directly without modification.  
验证 Figma MCP 服务器资产端点是否可访问。服务器在 `localhost` URL 提供资产——直接使用，不要修改。

### Design token values differ from Figma / 设计 token 值与 Figma 不一致

When project tokens differ from Figma values, prefer project tokens for consistency but adjust spacing/sizing to maintain visual fidelity.  
当项目 token 与 Figma 值不同时，为保持一致性优先使用项目 token，但调整间距/尺寸以保持视觉保真度。

---

*Figma Power v2.0 · authored by shiki · 2026-04-01*
