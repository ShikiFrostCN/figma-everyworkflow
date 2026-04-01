# 设计 Token 与变量 提示词模板 | Design Tokens & Variables Prompt Templates

<!--
  Author / 作者: shiki
  Updated / 更新: 2026-04-01
  Added: UI/UX Pro Max design token generation prompts
  新增：UI/UX Pro Max 设计 token 生成提示词
-->

> **作者 / Author:** shiki &nbsp;·&nbsp; **Updated / 更新:** 2026-04-01

---

## 🆕 UI/UX Pro Max 设计系统生成 | UI/UX Pro Max Design System Generation

> figma-generate-ui v2 在生成前自动运行，也可单独使用  
> figma-generate-ui v2 runs this automatically, but you can also use it standalone

```
用 UI/UX Pro Max 为我的 [产品类型] 项目生成完整的设计系统，
包括：推荐的 UI 样式、色彩方案、字体搭配、间距规范和反模式清单。
项目名称：[项目名称]

Use UI/UX Pro Max to generate a complete design system for my [product type] project,
including: recommended UI style, color palette, font pairing, spacing, and anti-patterns.
Project name: [project name]
```

```
分析这个 Figma 文件的设计风格，与 UI/UX Pro Max 数据库对比，
告诉我：当前样式是否合适？有哪些可以改进？

Analyze this Figma file's design style and compare with UI/UX Pro Max database.
Tell me: is the current style appropriate? What can be improved?
```

---

## 提取 Token | Extract Tokens

```
获取这个 Figma 选区中使用的所有设计变量（颜色、间距、字体）：[Figma链接]

Get all design variables (colors, spacing, typography) used in this Figma selection: [Figma URL]
```

```
列出这个组件用到的所有颜色变量和它们的实际值：[Figma链接]
我想把它们同步到我的代码 token 文件。

List all color variables and their actual values used in this component: [Figma URL]
I want to sync them to my code token file.
```

---

## 字体与排版 | Typography

```
获取这个 Figma 设计中用到的所有字体样式：
- 字体名称、大小、字重、行高
格式化为 CSS 变量。
[Figma链接]

Get all typography styles used in this Figma design:
- Font name, size, weight, line height
Format as CSS variables.
[Figma URL]
```

---

## 🆕 将 UI/UX Pro Max Token 同步到 Figma | Sync UI/UX Pro Max Tokens to Figma

```
根据 UI/UX Pro Max 为 [产品类型] 推荐的设计 token，
在我的 Figma 文件中创建对应的变量集合：
- 颜色变量（primary、secondary、background、surface、text、border）
- 间距变量（xs、sm、md、lg、xl、2xl）
- 圆角变量（sm、md、lg、xl）

Based on UI/UX Pro Max recommended design tokens for [product type],
create corresponding variable collections in my Figma file:
- Color variables (primary, secondary, background, surface, text, border)
- Spacing variables (xs, sm, md, lg, xl, 2xl)
- Radius variables (sm, md, lg, xl)
```

---

## Code Connect 映射 | Code Connect Mapping

```
分析我的 Figma 文件，找出哪些组件可以和我代码库（src/components）中的组件建立 Code Connect 映射。

Analyze my Figma file and suggest which components can be mapped to components
in my codebase (src/components) via Code Connect.
```

```
为 Figma 中的 Button 组件和 src/components/ui/Button.tsx 建立 Code Connect 映射。

Set up Code Connect mapping between Figma Button component and src/components/ui/Button.tsx.
```

---

## 设计系统规则生成 | Design System Rules

```
分析我的 Figma 文件和代码库，生成一份设计系统规则文件。
规则需要包含：
- 颜色 token 的使用约定
- 组件使用指南
- 间距和排版规范
技术栈：React + Tailwind CSS

Analyze my Figma file and codebase, generate a design system rules file.
Rules should include:
- Color token usage conventions
- Component usage guidelines
- Spacing and typography specs
Tech stack: React + Tailwind CSS
```

---

## 🆕 Design Token 映射文件 | Design Token Mapping File

> 将 figma-generate-ui v2 生成的 HTML CSS 变量映射到代码 token 系统  
> Map figma-generate-ui v2 HTML CSS variables to code token system

```
读取 figma-exports/[界面名称].html 中的 CSS 变量（:root 块），
将它们转换为 Tailwind CSS 的 theme.extend 配置，
放置在 tailwind.config.ts 中。

Read the CSS variables (:root block) in figma-exports/[screen-name].html,
convert them to Tailwind CSS theme.extend configuration,
place in tailwind.config.ts.
```

```
读取 figma-exports/[界面名称].html 中的 CSS 变量，
生成对应的 design-tokens.ts 文件（TypeScript 格式），
包含颜色、间距、圆角、字体的 token 对象。

Read CSS variables from figma-exports/[screen-name].html,
generate a corresponding design-tokens.ts file (TypeScript format)
with token objects for colors, spacing, radius, and typography.
```

---

*Design Tokens & Variables prompts · authored by shiki · 2026-04-01*
