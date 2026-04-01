# figma-everyworkflow

> **作者 / Author:** [shiki](https://github.com/shiki)  
> **基于 / Based on:** [figma/mcp-server-guide](https://github.com/figma/mcp-server-guide)  
> **协议 / License:** MIT

---

## 简介 | Introduction

**figma-everyworkflow** 是 Figma 官方 MCP Server 指南的增强版本，专为希望将 Figma 设计无缝融入任何开发工作流的团队和个人打造。  
支持自然语言驱动、一键安装、中英双语文档，让 AI 辅助设计→代码的工作流变得极简高效。

**figma-everyworkflow** is an enhanced fork of the official Figma MCP Server Guide, built for teams and individuals who want to seamlessly integrate Figma into any development workflow.  
Features natural language prompts, one-click installation, and bilingual documentation.

---

## 快速开始 | Quick Start

### 一键安装 | One-Click Install

**macOS / Linux:**
```bash
curl -fsSL https://raw.githubusercontent.com/shiki/figma-everyworkflow/main/install.sh | bash
```

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/shiki/figma-everyworkflow/main/install.ps1 | iex
```

**本地安装 | Local Install:**
```bash
git clone https://github.com/shiki/figma-everyworkflow.git
cd figma-everyworkflow
bash install.sh
```

---

## 功能特性 | Features

| 功能 Feature | 描述 Description |
|---|---|
| 写入 Figma 画布 | 直接在 Figma 中创建/修改帧、组件、变量 |
| Write to Canvas | Create/modify frames, components, variables in Figma |
| 从选区生成代码 | 选中 Figma 帧，自动生成前端代码 |
| Code from Selection | Select a Figma frame and generate frontend code |
| 提取设计上下文 | 获取变量、组件、布局信息 |
| Extract Design Context | Pull variables, components, layout data |
| Code Connect | 将 Figma 组件与代码库精准对应 |
| Code Connect | Map Figma components to your codebase |
| 设计系统规则生成 | 自动生成符合你项目的设计系统规则文件 |
| Design System Rules | Auto-generate rules tailored to your project |
| 自然语言驱动 | 用自然语言描述需求，无需记忆复杂命令 |
| Natural Language | Describe what you want in plain language |

---

## 安装说明 | Installation Guide

### Cursor（推荐 / Recommended）

在 Cursor 聊天框中输入：

```
/add-plugin figma
```

或手动添加配置 `Cursor → Settings → MCP`：

```json
{
  "mcpServers": {
    "figma": {
      "url": "https://mcp.figma.com/mcp"
    }
  }
}
```

### VS Code

1. `⌘ Shift P` → 搜索 `MCP:Add Server`
2. 选择 `HTTP`，粘贴 `https://mcp.figma.com/mcp`
3. Server ID 填写 `figma`
4. 在 Agent 模式下输入 `#get_design_context` 验证

### Claude Code

```bash
claude mcp add --transport http figma https://mcp.figma.com/mcp
```

---

## 自然语言使用指南 | Natural Language Usage Guide

> 无需记忆命令，用你最自然的语言描述需求即可。  
> No need to memorize commands — just describe what you want naturally.

### 设计→代码 | Design to Code

```
帮我把这个 Figma 链接的设计用 React + Tailwind 实现：[figma链接]

Implement this Figma design as React + Tailwind: [figma url]
```

```
把这个 Figma 选区转换为 Vue 组件

Convert my Figma selection into a Vue component
```

```
用我的项目组件库来实现这个 Figma 设计，组件路径在 src/components/ui

Implement this Figma design using my components at src/components/ui
```

### 写入 Figma | Write to Figma

```
在我的 Figma 文件中新建一个按钮组件，使用我设计系统的颜色变量

Create a button component in my Figma file using my design system color variables
```

```
把我的网页 UI 截图并导入到 Figma

Capture my web UI and import it into Figma
```

### 设计 Token | Design Tokens

```
列出这个 Figma 选区用到的所有颜色和间距变量

List all color and spacing variables used in my Figma selection
```

```
获取我的设计系统所有字体和颜色 token

Get all typography and color tokens from my design system
```

### 组件映射 | Code Connect

```
帮我把 Figma 的 Button 组件和我代码库的 Button 组件建立 Code Connect 映射

Set up Code Connect between my Figma Button component and my codebase Button
```

```
给我建议哪些 Figma 组件可以和我的代码组件建立映射

Suggest Code Connect mappings between Figma components and my code components
```

### 图表与流程图 | Diagrams

```
在 FigJam 中生成用户登录流程的流程图

Generate a user login flowchart in FigJam
```

```
画一个支付系统的时序图

Create a sequence diagram for the payment system
```

---

## MCP 工具速查 | MCP Tools Reference

| 工具 Tool | 用途 Usage | 场景 When to Use |
|---|---|---|
| `get_design_context` | 获取设计上下文 / Get design context | 生成代码时 / Code generation |
| `get_variable_defs` | 获取变量定义 / Get variables | 提取 token 时 / Token extraction |
| `get_screenshot` | 截图参考 / Screenshot reference | 视觉校验时 / Visual validation |
| `get_code_connect_map` | 获取 Code Connect 映射 / Get CC map | 组件复用时 / Component reuse |
| `use_figma` | 写入 Figma / Write to Figma | 创建/修改设计时 / Create/edit designs |
| `search_design_system` | 搜索设计系统 / Search design system | 复用组件时 / Reuse components |
| `generate_diagram` | 生成流程图 / Generate diagrams | 画图时 / Diagrams |
| `get_metadata` | 获取层级结构 / Get layer metadata | 大型设计时 / Large selections |
| `create_design_system_rules` | 生成设计系统规则 / Create DS rules | 初始化项目时 / Project setup |
| `create_new_file` | 新建 Figma 文件 / Create new file | 新项目时 / New project |

---

## 最佳实践 | Best Practices

### 结构化你的 Figma 文件 | Structure Your Figma File

- **使用组件** 封装所有可复用的元素（按钮、卡片、输入框等）  
  Use **Components** for all reusable elements
- **绑定 Code Connect** 将 Figma 组件与代码精准对应  
  Link components via **Code Connect** for precise mapping
- **使用变量** 管理颜色、间距、圆角、字体  
  Use **Variables** for colors, spacing, radius, typography
- **语义化命名** 图层用 `CardContainer` 而非 `Group 5`  
  Use **semantic layer names** like `CardContainer` not `Group 5`
- **启用 Auto Layout** 传达响应式意图  
  Enable **Auto Layout** to express responsive intent

### 提示词技巧 | Prompting Tips

- 先提供框架偏好：「用 Vue + Tailwind 实现」  
  Specify your framework: "Implement using Vue + Tailwind"
- 指定组件路径：「使用 src/components/ui 中的组件」  
  Specify component paths: "Use components from src/components/ui"
- 分块处理大设计：先生成各个子组件，再组合  
  Break large designs into sections, generate components individually

---

## 费率限制 | Rate Limits

| 计划 Plan | 限制 Limit |
|---|---|
| Starter / View / Collab | 每月最多 6 次工具调用 / Up to 6 calls/month |
| Dev / Full (Professional+) | 遵循 Figma REST API Tier 1 限制 / Tier 1 API rate limits |

> 写入画布（`use_figma`）当前处于免费 Beta 阶段，后续将成为付费功能。  
> Write-to-canvas is currently free during Beta and will become a paid feature.

---

## 项目结构 | Project Structure

```
figma-everyworkflow/
├── README.md              # 本文档 / This file
├── install.sh             # macOS/Linux 一键安装脚本
├── install.ps1            # Windows 一键安装脚本
├── .mcp.json              # MCP 配置文件 / MCP config
├── skills/                # AI Agent 技能文件 / Agent skills
│   ├── implement-design/  # 设计实现技能
│   ├── generate-design/   # 设计生成技能
│   ├── code-connect/      # Code Connect 技能
│   └── design-system/     # 设计系统规则技能
├── prompts/               # 自然语言提示词模板 / Prompt templates
│   ├── design-to-code.md
│   ├── write-to-figma.md
│   └── tokens-and-variables.md
└── docs/                  # 详细文档 / Detailed docs
    ├── setup.md
    ├── workflows.md
    └── troubleshooting.md
```

---

## 贡献 | Contributing

欢迎提交 Issue 和 PR！  
Issues and PRs are welcome!

---

## 致谢 | Credits

- [Figma MCP Server Guide](https://github.com/figma/mcp-server-guide) — 原始项目 / Original project
- [Figma Developer Documentation](https://help.figma.com/hc/en-us/articles/32132100833559) — 官方文档 / Official docs

---

*由 [shiki](https://github.com/shiki) 维护 | Maintained by [shiki](https://github.com/shiki)*
