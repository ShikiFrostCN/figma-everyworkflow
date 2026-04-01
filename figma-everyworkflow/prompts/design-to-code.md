# 设计→代码 提示词模板 | Design to Code Prompt Templates

> 复制以下任意提示词，替换 `[...]` 中的内容，直接粘贴到 AI 聊天框即可。  
> Copy any prompt below, fill in `[...]` placeholders, paste into your AI chat.

---

## 基础实现 | Basic Implementation

```
帮我实现这个 Figma 设计：[Figma链接]
使用 React + Tailwind CSS，保持和设计的视觉一致性。

Implement this Figma design: [Figma URL]
Use React + Tailwind CSS, maintain visual consistency with the design.
```

---

## 指定框架 | Specify Framework

```
把这个 Figma 设计转换为 Vue 3 组件（使用 <script setup>）：[Figma链接]

Convert this Figma design to a Vue 3 component (using <script setup>): [Figma URL]
```

```
用 Next.js + shadcn/ui 实现这个 Figma 设计：[Figma链接]
组件放在 src/components/ui/ 目录下。

Implement this Figma design using Next.js + shadcn/ui: [Figma URL]
Place components in src/components/ui/ directory.
```

```
把这个设计实现为原生 HTML + CSS，不使用任何框架：[Figma链接]

Implement this design as vanilla HTML + CSS, no frameworks: [Figma URL]
```

```
用 SwiftUI 实现这个 Figma 设计（iOS）：[Figma链接]

Implement this Figma design in SwiftUI (iOS): [Figma URL]
```

---

## 复用现有组件 | Reuse Existing Components

```
实现这个 Figma 设计：[Figma链接]
请优先使用 src/components/ui 中已有的组件，避免重复造轮子。
颜色和间距使用项目已有的 design token。

Implement this Figma design: [Figma URL]
Prioritize reusing existing components from src/components/ui.
Use existing project design tokens for colors and spacing.
```

---

## 添加到现有文件 | Add to Existing File

```
把这个 Figma 设计添加到 [文件路径] 中，作为新的子组件：[Figma链接]

Add this Figma design as a new sub-component to [file path]: [Figma URL]
```

---

## 响应式实现 | Responsive Implementation

```
实现这个 Figma 设计，要求：[Figma链接]
- 移动端优先（Mobile First）
- 断点：sm(640px) / md(768px) / lg(1024px)
- 使用 CSS Grid / Flexbox 实现自适应布局

Implement this Figma design with: [Figma URL]
- Mobile-first approach
- Breakpoints: sm(640px) / md(768px) / lg(1024px)
- Use CSS Grid / Flexbox for adaptive layout
```

---

## 大型设计分块处理 | Large Design - Section by Section

```
这是一个大型页面设计，请先帮我列出所有主要区块（Section），
然后我们逐个区块实现。先从 Header 开始。
[Figma链接]

This is a large page design. Please first list all major sections,
then we'll implement them one by one. Start with the Header.
[Figma URL]
```

---

## 带视觉校验 | With Visual Validation

```
实现这个 Figma 设计：[Figma链接]
1. 先获取设计截图作为参考
2. 实现代码
3. 列出与设计相比可能存在的视觉差异点

Implement this Figma design: [Figma URL]
1. First get a screenshot for reference
2. Implement the code
3. List any visual differences compared to the design
```
