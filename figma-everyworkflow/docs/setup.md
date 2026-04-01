# 安装与配置指南 | Setup Guide

<!--
  Author / 作者: shiki
  Updated / 更新: 2026-04-01
  Updated for figma-generate-ui v2: added UI/UX Pro Max prerequisites
  针对 figma-generate-ui v2 更新：添加 UI/UX Pro Max 前置要求
-->

> **作者 / Author:** shiki &nbsp;·&nbsp; **Updated / 更新:** 2026-04-01

---

## 前置要求 | Prerequisites

- Figma 账户（免费或付费）/ Figma account (free or paid)
- 支持的编辑器：Cursor、VS Code、Claude Code / Supported editor: Cursor, VS Code, Claude Code
- macOS / Linux / Windows
- Python 3.x（用于 figma-generate-ui v2 的 UI/UX Pro Max 设计智能引擎）/ Python 3.x (for UI/UX Pro Max design intelligence in figma-generate-ui v2)

```bash
# 检查 Python / Check Python
python3 --version

# macOS 安装 / macOS install
brew install python3
```

---

## 方式一：一键安装（推荐）| Method 1: One-Click Install (Recommended)

```bash
# macOS / Linux
curl -fsSL https://raw.githubusercontent.com/ShikiFrostCN/figma-everyworkflow/main/install.sh | bash

# Windows PowerShell
irm https://raw.githubusercontent.com/ShikiFrostCN/figma-everyworkflow/main/install.ps1 | iex
```

---

## 方式二：手动安装 | Method 2: Manual Setup

### Cursor

1. 打开 `Cursor → Settings → MCP`
2. 点击 `+ Add new global MCP server`
3. 粘贴以下配置：

```json
{
  "mcpServers": {
    "figma": {
      "url": "https://mcp.figma.com/mcp"
    }
  }
}
```

4. 重启 Cursor
5. 在聊天框中输入 `#get_design_context` 验证

### VS Code

1. `⌘ Shift P` → `MCP: Add Server` → `HTTP`
2. 粘贴 `https://mcp.figma.com/mcp`，Server ID: `figma`
3. 切换到 Agent 模式（`⌥⌘B`）
4. 输入 `#get_design_context` 验证

### Claude Code

```bash
claude mcp add --transport http figma https://mcp.figma.com/mcp
claude mcp list  # 验证
```

---

## 方式三：插件安装 | Method 3: Plugin Install

在 Cursor 聊天框中运行：

```
/add-plugin figma
```

在 Claude Code 中运行：

```bash
claude plugin install figma@claude-plugins-official
```

---

## figma-generate-ui v2 附加设置 | Additional Setup for figma-generate-ui v2

figma-generate-ui v2 使用 UI/UX Pro Max 设计智能引擎。建议安装以获得最佳效果：  
figma-generate-ui v2 uses the UI/UX Pro Max design intelligence engine. Install for best results:

```bash
# 使用 npm CLI 安装（全局）/ Install via npm CLI (global)
npm install -g uipro-cli
uipro init --ai cursor --global   # 安装到 ~/.cursor/skills/
uipro init --ai codex --global    # 安装到 ~/.codex/skills/

# 或克隆仓库 / Or clone the repo
git clone https://github.com/nextlevelbuilder/ui-ux-pro-max-skill.git ~/.codex/skills/ui-ux-pro-max
```

验证安装 / Verify installation:

```bash
python3 ~/.codex/skills/ui-ux-pro-max/scripts/search.py "SaaS dashboard" --design-system
```

如果看到设计系统输出（包含样式、色彩、字体推荐），即安装成功。  
If you see design system output (style, colors, typography recommendations), installation is successful.

---

## 验证安装 | Verify Installation

安装完成后，在编辑器聊天框中输入：

```
#get_design_context
```

如果能看到 Figma MCP 工具列表，即安装成功。  
If you can see the Figma MCP tools list, installation is successful.

---

## 常见问题 | FAQ

**Q: 提示 rate limit 怎么办？ / Getting rate limit errors?**

A: Starter 计划每月限 6 次工具调用。升级到 Dev/Full 席位可获得更高限额。  
Starter plan is limited to 6 calls/month. Upgrade to Dev/Full seat for higher limits.

**Q: 工具不显示怎么办？ / Tools not showing?**

A: 重启编辑器，确认配置文件格式正确（有效的 JSON）。  
Restart your editor and verify the config file is valid JSON.

**Q: 如何查看 Figma 节点 ID？ / How to find Figma node ID?**

A: 在 Figma 中右键选中元素 → `Copy link`，链接中的 `node-id` 参数即为节点 ID。  
Right-click an element in Figma → `Copy link`. The `node-id` param in the URL is the node ID.

**Q: figma-generate-ui v2 和 v1 有什么区别？ / What's different in figma-generate-ui v2?**

A: v2 新增三项核心功能：(1) UI/UX Pro Max 设计智能，在生成前自动推荐样式/色彩/字体；(2) Figma 组件注册表扫描，发现并复用现有文件组件；(3) HTML 优先流程，所有生成工作先产出 HTML，再转换为 Figma。  
v2 adds three core capabilities: (1) UI/UX Pro Max design intelligence auto-recommends style/colors/typography before generating; (2) Figma component registry scanning discovers and reuses existing file components; (3) HTML-first pipeline — all generation produces HTML first, then converts to Figma.

---

*figma-everyworkflow setup guide · authored by shiki · 2026-04-01*
