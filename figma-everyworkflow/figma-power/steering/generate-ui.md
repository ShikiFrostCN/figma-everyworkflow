# Generate UI Design in Figma (v2) / 在 Figma 中生成 UI 设计（v2）

<!--
  Author / 作者: shiki
  Version / 版本: 2.0
  Updated / 更新: 2026-04-01
  Upgraded: Three-engine pipeline — UI/UX Pro Max + Figma Component Registry + HTML-First
  升级：三引擎流水线 —— UI/UX Pro Max + Figma 组件注册表 + HTML 优先
-->

> **Author / 作者**: shiki &nbsp;·&nbsp; **v2.0** &nbsp;·&nbsp; 2026-04-01

## Overview / 概述

This workflow enables AI-powered UI generation directly inside Figma files using the **three-engine pipeline**:  
本工作流通过**三引擎流水线**直接在 Figma 文件内部实现 AI 驱动的 UI 生成：

```
Engine 1 / 引擎 1: UI/UX Pro Max Design Intelligence
  ↓ Generates: style, colors, typography, effects, anti-patterns
  ↓ 生成：样式、色彩、字体排版、效果、反模式

Engine 2 / 引擎 2: Figma Component Registry
  ↓ Scans: existing components, frames, variables, styles in the file
  ↓ 扫描：文件中现有组件、框架、变量、样式

Engine 3 / 引擎 3: HTML-First Generation
  ↓ Generates HTML → presents for approval → converts to Figma
  ↓ 生成 HTML → 展示供审阅 → 转换为 Figma
```

**Golden rule / 黄金法则:** All UI generation and modification starts with HTML. The HTML is the single source of truth. Figma output is derived from it.  
所有 UI 创建和修改都从 HTML 开始。HTML 是唯一事实来源，Figma 输出从 HTML 派生。

---

## When to Use This Workflow / 何时使用本工作流

Activate when the user / 在以下情况激活：

- Describes a UI they want built in Figma using natural language / 用自然语言描述想在 Figma 中构建的 UI
  - "Create a SaaS pricing page in Figma" / "在 Figma 中创建 SaaS 定价页"
  - "Design a dashboard for a fintech app" / "为金融科技应用设计仪表盘"
  - "Build a login screen in Figma" / "在 Figma 中构建登录界面"
- Wants to convert an HTML/code file into a Figma design / 想将 HTML/代码文件转换为 Figma 设计
  - "Convert this HTML to a Figma design" / "将这个 HTML 转换为 Figma 设计"
  - "Turn this React component into a Figma screen" / "将这个 React 组件转为 Figma 界面"
- Wants to reproduce a wireframe in a real design system / 想用真实设计系统重建线框图
  - "Recreate this wireframe using our design system" / "用我们的设计系统重建这个线框图"
  - "Convert this lo-fi prototype to high-fidelity in Figma" / "将这个低保真原型转为高保真 Figma 设计"
- Wants multiple design directions / 想要多种设计方向
  - "Generate 2 design options for this screen" / "为这个界面生成两个设计方案"
  - "Show me a light and dark version" / "展示亮色和深色两个版本"

**Do NOT use this workflow when / 以下情况不使用本工作流：**
- The user wants to generate *code* from a Figma design → use `implement-design.md` / 用户想从 Figma 设计生成代码
- The user wants to connect components to code → use `code-connect-components.md` / 用户想连接组件到代码
- The user wants to create design tokens/variables only → use `figma-use` skill directly / 用户只想创建设计 token/变量

---

## Required Workflow / 必须遵循的工作流

**Load [figma-generate-ui](../../skills/figma-generate-ui/SKILL.md) immediately and follow its full 8-step workflow.**  
**立即加载 [figma-generate-ui](../../skills/figma-generate-ui/SKILL.md) 并遵循其完整的 8 步工作流。**

The skill covers the complete end-to-end v2 process:  
该技能涵盖完整的端到端 v2 流程：

| Step / 步骤 | Action / 操作 | Engine / 引擎 |
|---|---|---|
| 0 | Determine input source / 确定输入来源 | — |
| 1 | Generate Design Intelligence / 生成设计智能 | UI/UX Pro Max |
| 2 | Scan Figma file — build component registry / 扫描 Figma 文件—构建组件注册表 | Figma Registry |
| 3 | Synthesize screen specification / 整合界面规格 | — |
| 4 | Resolve target Figma file / 确定目标 Figma 文件 | — |
| 5 | Generate HTML (source of truth) / 生成 HTML（唯一事实来源） | HTML-First |
| 6 | Convert HTML to Figma / 将 HTML 转换为 Figma | HTML-First + Plugin API |
| 7 | Validate the full screen / 验证完整界面 | — |
| 8 | Post-generation handoff / 生成后交接 | — |

---

## Quick Reference / 快速参考

### Input Source Handling / 输入来源处理

| Input / 输入 | Action / 操作 |
|---|---|
| Text description / 文字描述 | Run UI/UX Pro Max → scan registry → generate HTML → build Figma / 运行 UI/UX Pro Max → 扫描注册表 → 生成 HTML → 构建 Figma |
| HTML file path / HTML 文件路径 | Read file → enhance with design tokens → add `data-figma-*` attrs → convert to Figma / 读取文件 → 增强设计 token → 添加属性 → 转 Figma |
| Wireframe image / 线框图 | Analyze layout → run UI/UX Pro Max → generate HTML reproducing structure → convert to Figma / 分析布局 → 运行 UI/UX Pro Max → 生成 HTML → 转 Figma |
| Figma prototype URL / Figma 原型链接 | `get_design_context` → extract structure → run UI/UX Pro Max → generate HTML → convert to Figma / 提取结构 → 运行 UI/UX Pro Max → 生成 HTML → 转 Figma |

### Design System Priority / 设计系统优先级

1. **UI/UX Pro Max design tokens** — always generated first (even without a Figma library) / 始终首先生成（即使没有 Figma 库）
2. **Figma component registry** — components found by scanning current file / 通过扫描当前文件找到的组件
3. **User-specified system** — provided via URL, name, or file key / 通过 URL、名称或文件键提供的系统
4. **Fallback** — build manually using UI/UX Pro Max token values / 使用 UI/UX Pro Max token 值手动构建

### Screen Size Defaults / 默认界面尺寸

| Target / 目标 | Frame Width / 框架宽度 |
|---|---|
| Desktop / 桌面 | 1440px |
| Tablet / 平板 | 768px |
| Mobile / 移动端 | 390px |

---

## Examples / 示例

### Example 1: Natural Language → HTML → Figma / 示例 1：自然语言 → HTML → Figma

User: "Generate a SaaS landing page in Figma for a project management tool."  
用户："在 Figma 中为项目管理工具生成一个 SaaS 落地页。"

**Actions / 操作:**
1. Load `figma-generate-ui` v2 skill / 加载 `figma-generate-ui` v2 技能
2. Run UI/UX Pro Max: `search.py "SaaS project management tool landing" --design-system` / 运行 UI/UX Pro Max
3. Scan Figma file for components and variables / 扫描 Figma 文件的组件和变量
4. Spec: Navbar → Hero → Features Grid → Testimonials → Pricing → Footer / 规格：导航栏 → 英雄区 → 功能网格 → 证言 → 定价 → 页脚
5. Generate HTML with design tokens from UI/UX Pro Max, `data-figma-*` attrs from registry / 生成带设计 token 和注册表属性的 HTML
6. Present HTML to user for approval / 向用户展示 HTML 供审阅
7. Convert to Figma section-by-section, validate with `get_screenshot` / 逐区块转换为 Figma，用截图验证

### Example 2: HTML File → Figma / 示例 2：HTML 文件 → Figma

User: "Convert src/pages/pricing.html to a Figma design."  
用户："将 src/pages/pricing.html 转换为 Figma 设计。"

**Actions / 操作:**
1. Load `figma-generate-ui` v2 → Mode: HTML-to-Figma / 加载技能 → HTML→Figma 模式
2. Read `src/pages/pricing.html` / 读取文件
3. Run UI/UX Pro Max on product type / 根据产品类型运行 UI/UX Pro Max
4. **Enhance the HTML** with design tokens (inject CSS variables) / **增强 HTML**（注入 CSS 变量）
5. Add `data-figma-section` and `data-figma-component` attributes / 添加 `data-figma-*` 属性
6. Build Figma from enhanced HTML structure / 从增强的 HTML 结构构建 Figma
7. Use exact text from the HTML (headings, CTAs, pricing values) / 使用 HTML 中的确切文字

### Example 3: Wireframe → HTML → Figma / 示例 3：线框图 → HTML → Figma

User: "Here's a wireframe — reproduce it in high-fidelity using our design system."  
用户："这是一个线框图——用我们的设计系统高保真重建它。"

**Actions / 操作:**
1. Load `figma-generate-ui` v2 → Mode: Wireframe-to-Figma / 加载技能 → 线框图→Figma 模式
2. Analyze wireframe: identify sections, component positions, text labels / 分析线框图
3. Run UI/UX Pro Max to get design system / 运行 UI/UX Pro Max 获取设计系统
4. Generate HTML that reproduces wireframe structure + applies design system / 生成重现线框结构并应用设计系统的 HTML
5. Convert HTML to Figma, using wireframe as layout reference / 将 HTML 转换为 Figma，以线框图作为布局参考

### Example 4: Multiple Design Directions / 示例 4：多种设计方向

User: "Generate 2 design options for a dashboard: light mode and dark mode."  
用户："为仪表盘生成两个设计方案：亮色模式和深色模式。"

**Actions / 操作:**
1. Load `figma-generate-ui` v2 → Mode: Multi-Style Variants / 加载技能 → 多样式变体模式
2. Run UI/UX Pro Max **twice** with different style keywords / 用不同样式关键词**两次**运行 UI/UX Pro Max
3. Generate 2 HTML files — one per variant / 生成两个 HTML 文件，各对应一个变体
4. Build 2 Figma wrapper frames side by side / 并排构建两个 Figma 包装框架
5. Label each variant frame clearly / 清晰标记每个变体框架

---

## Modification Workflow / 修改工作流

When modifying an existing Figma screen / 修改现有 Figma 界面时：

1. Locate HTML source in `figma-exports/` / 在 `figma-exports/` 中找到 HTML 源文件
2. Edit the HTML / 编辑 HTML
3. Re-run UI/UX Pro Max if style/colors are changing / 如果样式/色彩发生变化，重新运行 UI/UX Pro Max
4. Identify which sections changed (by `data-figma-section`) / 确定哪些区块变化了
5. Update only changed sections in Figma — do NOT rebuild all / 只更新 Figma 中变化的区块——不要全部重建
6. Validate with `get_screenshot` / 用截图验证

---

## Design Quality Bar / 设计质量标准

Generated designs should meet these quality standards / 生成的设计应满足以下质量标准：

- **UI/UX Pro Max design tokens applied** — no generic defaults / **应用 UI/UX Pro Max 设计 token**——不使用通用默认值
- **HTML source of truth** — saved in `figma-exports/` folder / **HTML 事实来源**——保存在 `figma-exports/` 文件夹
- **No placeholder text** — all instances have real content / **无占位文字**——所有实例有真实内容
- **Design system components used** — from Figma component registry / **使用设计系统组件**——来自 Figma 组件注册表
- **Variable bindings** — colors and spacing from design tokens, not hardcoded / **变量绑定**——颜色和间距使用设计 token，不硬编码
- **Auto-layout throughout** — no absolute positioning / **全程自动布局**——不使用绝对定位
- **Section padding** — ≥ 64px top/bottom, consistent left/right gutter / **区块内边距** ≥ 64px 上下，左右一致
- **Validated with screenshots** — each section confirmed before proceeding / **截图验证**——继续前确认每个区块

---

## Troubleshooting / 故障排查

### No design system found / 未找到设计系统

If `search_design_system` returns nothing and there are no existing screens with instances:  
如果 `search_design_system` 无返回且无现有带实例的界面：
- UI/UX Pro Max will still provide complete color, typography, and spacing tokens as fallback / UI/UX Pro Max 仍会提供完整的颜色、字体、间距 token 作为回退
- Ask the user if they want to use a specific Figma library URL / 询问用户是否要使用特定 Figma 库 URL
- Consider [figma-generate-library](../../skills/figma-generate-library/SKILL.md) to create a design system first / 考虑先用 `figma-generate-library` 创建设计系统

### HTML file is complex / too large / HTML 文件复杂/太大

- Focus on main content sections only / 只关注主要内容区块
- Skip navigation mega-menus or highly nested tables / 跳过超级菜单或高度嵌套的表格
- Ask the user which sections to prioritize / 询问用户优先处理哪些区块

### Wireframe is ambiguous / 线框图不明确

- Ask the user to clarify any ambiguous sections before building / 构建前询问用户澄清不明确的区块
- Use your best judgment for common patterns (grid of boxes → card grid) / 对常见模式使用最佳判断（方框网格 → 卡片网格）

### Generated screen looks wrong / 生成的界面看起来有问题

1. Take a section-level screenshot to pinpoint the issue / 截取区块级截图以定位问题
2. Check for: clipped text, wrong variant, missing variable bindings / 检查：文字裁剪、错误变体、缺少变量绑定
3. Edit the HTML source first, then re-sync only the affected section / 先编辑 HTML 源文件，再只重新同步受影响的区块
4. Fix with a targeted `use_figma` call — do NOT rebuild the whole screen / 用精准的 `use_figma` 调用修复——不要重建整个界面

---

*Generate UI v2.0 · authored by shiki · 2026-04-01*
