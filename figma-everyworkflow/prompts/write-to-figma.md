# 写入 Figma 提示词模板 | Write to Figma Prompt Templates

<!--
  Author / 作者: shiki
  Updated / 更新: 2026-04-01
  Added: figma-generate-ui v2 HTML-first generation prompts
  新增：figma-generate-ui v2 HTML 优先生成提示词
-->

> **作者 / Author:** shiki &nbsp;·&nbsp; **Updated / 更新:** 2026-04-01  
> 以下提示词用于让 AI 直接在你的 Figma 文件中创建或修改内容。  
> Use these prompts to have AI create or modify content directly in your Figma file.

---

## 🆕 AI 生成 UI（v2 HTML 优先）| AI Generate UI (v2 HTML-First)

> 以下提示词触发 figma-generate-ui v2 三引擎流水线：UI/UX Pro Max 设计智能 → Figma 组件注册表 → HTML → Figma  
> These prompts trigger the figma-generate-ui v2 three-engine pipeline.

```
在 Figma 中为 [产品名称/描述] 创建 [界面类型] 界面，使用我们的设计系统。

Create a [screen type] screen in Figma for [product name/description], using our design system.
```

```
在 Figma 中生成一个 SaaS 落地页，包含：导航栏、英雄区、功能特性、定价和页脚。
桌面端，1440px 宽。

Generate a SaaS landing page in Figma with: navbar, hero, features, pricing, and footer.
Desktop, 1440px wide.
```

```
为 [产品类型] 应用设计一个移动端首页（390px），深色模式。

Design a mobile home screen (390px) for a [product type] app, dark mode.
```

```
生成两个 [界面名称] 设计方案：亮色模式和深色模式，并排展示。

Generate 2 design options for [screen name]: light mode and dark mode, side by side.
```

---

## 🆕 HTML 转 Figma | HTML to Figma

```
将 [HTML文件路径] 转换为 Figma 设计，使用我们的设计系统。
先分析 HTML 结构，再用 UI/UX Pro Max 增强设计 token，最后构建 Figma。

Convert [HTML file path] to a Figma design using our design system.
Analyze the HTML structure, enhance with UI/UX Pro Max design tokens, then build in Figma.
```

```
把这个 React 组件的 UI 转换为 Figma 设计：[粘贴组件代码或路径]
保留原始内容，但应用我们的设计系统样式。

Convert this React component's UI to a Figma design: [paste component code or path]
Keep the original content but apply our design system styles.
```

---

## 🆕 线框图转高保真 Figma | Wireframe to High-Fidelity Figma

```
这是一个线框图截图，请用我们的 Figma 组件库将它重建为高保真设计。
[附加线框图图片]

This is a wireframe screenshot. Please rebuild it as a high-fidelity design using our Figma component library.
[Attach wireframe image]
```

```
把这个低保真原型升级为使用我们设计系统的高保真 Figma 设计：[Figma原型链接]

Upgrade this lo-fi prototype to high-fidelity Figma design using our design system: [Figma prototype URL]
```

---

## 🆕 修改现有 Figma 界面 | Modify Existing Figma Screen (v2)

> v2 修改工作流：先编辑 HTML 源文件，再同步到 Figma  
> v2 modification workflow: edit HTML source first, then sync to Figma

```
在 figma-exports/[界面名称].html 中，将英雄区的标题文案改为 "[新文案]"，
然后只更新 Figma 中的英雄区，不要重建整个页面。

In figma-exports/[screen-name].html, change the hero headline to "[new copy]",
then update only the hero section in Figma without rebuilding the whole page.
```

```
将 [界面名称] 的配色从亮色模式改为深色模式。
先更新 HTML 中的 CSS 变量，再同步到 Figma。

Change [screen name] color scheme from light to dark mode.
First update CSS variables in the HTML, then sync to Figma.
```

---

## 创建组件 | Create Components

```
在我当前打开的 Figma 文件中新建一个 Button 组件。
要求：Primary / Secondary / Ghost 三种变体，
使用我设计系统中的颜色变量。

Create a Button component in my current Figma file.
Requirements: Primary / Secondary / Ghost variants,
use color variables from my design system.
```

```
在 Figma 中创建一个 Card 组件，包含：
- 顶部图片区域
- 标题、副标题
- 操作按钮（使用已有 Button 组件）
- 使用 Auto Layout

Create a Card component in Figma with:
- Top image area
- Title and subtitle text
- Action button (reuse existing Button component)
- Using Auto Layout
```

---

## 修改现有设计 | Modify Existing Design

```
将我 Figma 文件中 [组件名称] 组件的颜色改为使用设计系统的 primary-500 变量，
不要硬编码颜色值。

Update the [component name] component in my Figma file to use the primary-500 
design system variable instead of hardcoded color values.
```

```
修复 [帧名称] 中 Auto Layout 的间距问题，
垂直间距改为 16px，水平内边距改为 24px。

Fix the Auto Layout spacing in [frame name]:
set vertical gap to 16px, horizontal padding to 24px.
```

---

## 从代码生成 Figma 设计 | Code to Figma

```
把我当前运行的 Web 应用截图并导入到 Figma 中，
保存到 [Figma文件链接] 这个文件的 "Captures" 页面。

Capture my currently running web app and import it to Figma,
save to the "Captures" page in [Figma file URL].
```

---

## 设计 Token 管理 | Design Token Management

```
在我的 Figma 文件中创建颜色变量集合，
基于以下 token 文件的内容：[粘贴token文件路径或内容]

Create a color variable collection in my Figma file
based on the following token file: [paste token file path or content]
```

```
同步我的代码 token（src/tokens/colors.ts）到 Figma 变量，
保持两者一致。

Sync my code tokens (src/tokens/colors.ts) to Figma variables,
keep them in sync.
```

---

## 新建文件 | Create New File

```
在我的 Figma 草稿中新建一个设计文件，命名为 "[项目名称] - UI Kit"

Create a new Figma design file in my drafts named "[project name] - UI Kit"
```

```
帮我新建一个 FigJam 文件，用于 [项目名称] 的用户旅程规划。

Create a new FigJam file for [project name] user journey planning.
```

---

## 流程图 | Diagrams (FigJam)

```
在 FigJam 中生成用户注册流程图：
1. 访问注册页
2. 填写邮箱/密码
3. 邮箱验证
4. 完善资料
5. 进入应用

Generate a user registration flowchart in FigJam:
1. Visit signup page
2. Enter email/password
3. Email verification
4. Complete profile
5. Enter app
```

```
画一个 [系统名称] 的微服务架构图，
包括：API Gateway、用户服务、订单服务、支付服务、消息队列。

Create a microservices architecture diagram for [system name] including:
API Gateway, User Service, Order Service, Payment Service, Message Queue.
```

---

*Write to Figma prompts · authored by shiki · 2026-04-01*
