# 写入 Figma 提示词模板 | Write to Figma Prompt Templates

> 以下提示词用于让 AI 直接在你的 Figma 文件中创建或修改内容。  
> Use these prompts to have AI create or modify content directly in your Figma file.

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

```
把这个 React 组件的 UI 转换为 Figma 设计：[粘贴组件代码或路径]
在 Figma 中重建相应的帧和组件结构。

Convert this React component's UI to a Figma design: [paste component code or path]
Recreate the corresponding frame and component structure in Figma.
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
