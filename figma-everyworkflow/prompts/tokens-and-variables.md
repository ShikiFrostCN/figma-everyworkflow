# 设计 Token 与变量 提示词模板 | Design Tokens & Variables Prompt Templates

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
