# 安装与配置指南 | Setup Guide

> **作者 / Author:** shiki

---

## 前置要求 | Prerequisites

- Figma 账户（免费或付费）/ Figma account (free or paid)
- 支持的编辑器：Cursor、VS Code、Claude Code / Supported editor: Cursor, VS Code, Claude Code
- macOS / Linux / Windows

---

## 方式一：一键安装（推荐）| Method 1: One-Click Install (Recommended)

```bash
# macOS / Linux
curl -fsSL https://raw.githubusercontent.com/shiki/figma-everyworkflow/main/install.sh | bash

# Windows PowerShell
irm https://raw.githubusercontent.com/shiki/figma-everyworkflow/main/install.ps1 | iex
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

---

## 验证安装 | Verify Installation

安装完成后，在编辑器聊天框中输入：

```
#get_design_context
```

如果能看到 Figma MCP 工具列表，即安装成功。

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
