# 工作流指南 | Workflow Guide

<!--
  Author / 作者: shiki
  Updated / 更新: 2026-04-01
  Added Workflow 7: figma-generate-ui v2 HTML-First Pipeline
  新增工作流 7：figma-generate-ui v2 HTML 优先流程
-->

> **作者 / Author:** shiki &nbsp;·&nbsp; **Updated / 更新:** 2026-04-01

---

## 工作流一：Figma 设计 → 代码 | Workflow 1: Figma Design to Code

```
1. 在 Figma 中设计好组件/页面
2. 右键帧 → Copy link（获取链接）
3. 打开 AI 聊天框，粘贴以下提示词：
   "帮我实现这个 Figma 设计：[链接]，使用 React + Tailwind"
4. AI 自动调用 get_design_context + get_screenshot
5. 生成代码，你来审查和调整

1. Design your component/page in Figma
2. Right-click frame → Copy link
3. Open AI chat, paste:
   "Implement this Figma design: [URL], use React + Tailwind"
4. AI auto-calls get_design_context + get_screenshot
5. Review and adjust generated code
```

---

## 工作流二：代码 / 网页 → Figma 设计 | Workflow 2: Code / Web to Figma

```
1. 运行你的本地开发服务器
2. 在 AI 聊天中说：
   "截取我当前运行的应用首页，导入到 Figma 文件 [链接]"
3. AI 调用 generate_figma_design 完成截图和导入

1. Run your local dev server
2. In AI chat say:
   "Capture my running app homepage and import to Figma file [URL]"
3. AI calls generate_figma_design to capture and import
```

---

## 工作流三：提取设计 Token | Workflow 3: Extract Design Tokens

```
1. 在 Figma 中选择目标帧
2. 告诉 AI："列出这个选区中所有颜色和间距变量"
3. AI 调用 get_variable_defs，返回完整 token 列表
4. 将 token 同步到你的代码 token 文件

1. Select target frame in Figma
2. Tell AI: "List all color and spacing variables in this selection"
3. AI calls get_variable_defs, returns full token list
4. Sync tokens to your code token file
```

---

## 工作流四：建立 Code Connect | Workflow 4: Set Up Code Connect

```
1. 告诉 AI："分析我的 Figma 文件，找出可以和 src/components 建立映射的组件"
2. AI 调用 get_code_connect_suggestions
3. 确认建议后，AI 调用 send_code_connect_mappings 和 add_code_connect_map
4. 之后再生成代码时，AI 会自动复用你的实际组件

1. Tell AI: "Analyze my Figma file, find components to map to src/components"
2. AI calls get_code_connect_suggestions
3. After confirming, AI calls send_code_connect_mappings and add_code_connect_map
4. Future code generation will automatically reuse your actual components
```

---

## 工作流五：生成设计系统规则 | Workflow 5: Generate Design System Rules

```
1. 告诉 AI："分析我的 Figma 文件和代码库，生成设计系统规则"
2. AI 调用 create_design_system_rules
3. 将生成的规则保存为 .cursor/rules/figma-design-system.mdc
4. 之后所有 Figma → 代码任务都会自动遵循这些规则

1. Tell AI: "Analyze my Figma file and codebase, generate design system rules"
2. AI calls create_design_system_rules
3. Save generated rules as .cursor/rules/figma-design-system.mdc
4. All future Figma → code tasks will automatically follow these rules
```

---

## 工作流六：在 FigJam 生成流程图 | Workflow 6: Generate FigJam Diagrams

```
1. 描述你想要的流程图："生成用户注册流程图，包括邮箱验证步骤"
2. AI 调用 generate_diagram，使用 Mermaid 语法生成
3. 流程图自动出现在你的 FigJam 文件中
支持：流程图、甘特图、状态图、时序图

1. Describe your diagram: "Generate a user registration flowchart with email verification"
2. AI calls generate_diagram using Mermaid syntax
3. Diagram appears automatically in your FigJam file
Supports: flowcharts, Gantt charts, state diagrams, sequence diagrams
```

---

## 工作流七（新）：AI 生成 Figma UI — HTML 优先流程 | Workflow 7 (NEW): AI Generate Figma UI — HTML-First Pipeline

> **figma-generate-ui v2 三引擎流水线**  
> **figma-generate-ui v2 Three-Engine Pipeline**

这是 v2 的核心新工作流。所有 AI 生成 UI 的工作，无论输入是自然语言、HTML 文件还是线框图，都遵循以下完整流程：  
This is the core new workflow in v2. All AI-generated UI work — whether input is natural language, HTML file, or wireframe — follows this complete pipeline:

```
步骤 1 / Step 1: 设计智能 / Design Intelligence
────────────────────────────────────────────────────
告诉 AI："在 Figma 中为一个 SaaS 项目管理工具创建落地页"
Tell AI: "Create a landing page in Figma for a SaaS project management tool"

AI 自动运行 UI/UX Pro Max 设计系统生成器：
AI automatically runs UI/UX Pro Max design system generator:
  python3 ~/.codex/skills/ui-ux-pro-max/scripts/search.py \
    "SaaS project management tool landing" --design-system -p "ProjectPro"

输出：样式推荐（如 Glassmorphism）、色彩方案、字体搭配、反模式
Output: Style (e.g. Glassmorphism), color palette, font pairing, anti-patterns


步骤 2 / Step 2: 组件注册表 / Component Registry
────────────────────────────────────────────────────
AI 扫描当前 Figma 文件，发现：
AI scans the current Figma file and discovers:
  - 本地组件（Button、Card、NavBar 等）/ Local components
  - 设计系统库中已有的组件实例 / Design system component instances
  - 已绑定的颜色/间距变量 / Bound color/spacing variables
  - 已有的文字样式和效果样式 / Existing text and effect styles


步骤 3 / Step 3: 生成 HTML / Generate HTML
────────────────────────────────────────────────────
AI 生成完整的语义化 HTML 文件，包含：
AI generates a complete semantic HTML file including:
  - CSS 自定义属性（映射到 UI/UX Pro Max 设计 token）
    CSS custom properties (mapped to UI/UX Pro Max design tokens)
  - data-figma-section 属性标记区块 / data-figma-section attrs for sections
  - data-figma-component 属性映射到注册表组件 / data-figma-component attrs
  - 真实内容（无占位文字）/ Real content (no Lorem ipsum)

文件保存到：figma-exports/landing-page-[timestamp].html
File saved to: figma-exports/landing-page-[timestamp].html
AI 展示 HTML 供你审阅。
AI presents HTML for your review.


步骤 4 / Step 4: 转换为 Figma / Convert to Figma
────────────────────────────────────────────────────
你批准 HTML 后，AI 逐区块构建 Figma：
After you approve the HTML, AI builds Figma section by section:
  - CSS 属性 → Figma 自动布局属性 / CSS properties → Figma auto-layout
  - data-figma-component 匹配注册表 → importComponentSetByKeyAsync + createInstance()
  - 无注册表匹配 → 用设计 token 值手动构建 / No registry match → build manually
  - 每个区块后截图验证 / Screenshot validation after each section


步骤 5 / Step 5: 修改工作流 / Modification Workflow
────────────────────────────────────────────────────
需要修改时：先编辑 HTML，再同步到 Figma
When modifications needed: edit HTML first, then sync to Figma
  1. 打开 figma-exports/[screen-name].html / Open the HTML file
  2. 编辑需要修改的区块 / Edit the sections that need changes
  3. 只重新构建变更的区块 / Rebuild only the changed sections in Figma
  4. 截图验证 / Screenshot validation
```

**快速触发示例 / Quick trigger examples:**

```
"在 Figma 中创建一个金融科技应用仪表盘"
"Create a fintech app dashboard in Figma"

"将 src/pages/pricing.html 转换为 Figma 设计，使用我们的设计系统"
"Convert src/pages/pricing.html to a Figma design using our design system"

"用我们的组件库将这个线框图高保真重建为 Figma 设计"
"Reproduce this wireframe in high-fidelity Figma using our component library"

"生成两个仪表盘设计方案：亮色模式和深色模式，并排展示"
"Generate 2 dashboard designs: light mode and dark mode side by side"
```

---

*figma-everyworkflow workflow guide · authored by shiki · 2026-04-01*
