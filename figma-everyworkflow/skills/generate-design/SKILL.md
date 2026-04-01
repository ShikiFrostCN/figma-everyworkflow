# Skill: 生成 Figma 设计 | Generate Figma Design

> **作者 / Author:** shiki  
> **来源 / Source:** figma-everyworkflow

---

## 触发场景 | When to Use

当用户说以下任意内容时，立即使用此技能：

- "在 Figma 中创建..."
- "把这个页面/组件写入 Figma"
- "从代码生成 Figma 设计"
- "把我的网页导入到 Figma"
- "Write to Figma"
- "Create in Figma"
- "Push to Figma"
- "Build this design in Figma"

---

## 执行步骤 | Steps

### 第一步：搜索设计系统 | Step 1: Search Design System

```
先调用 search_design_system 搜索相关组件和变量，避免重复创建。
First call search_design_system to find existing components and variables.
```

### 第二步：理解目标 | Step 2: Understand Goal

明确以下信息：
- 目标 Figma 文件（已有或新建？）
- 要创建的内容类型（组件/页面/流程图）
- 是否需要遵循现有设计系统

### 第三步：分区块创建 | Step 3: Build Section by Section

对于复杂页面，按区块逐步构建：

1. 整体布局帧（Frame）
2. Header / Navigation
3. 主内容区域
4. Footer
5. 各个组件细节

每个区块完成后确认再继续下一个。

### 第四步：使用设计系统变量 | Step 4: Use Design System Variables

```
- 颜色：使用变量而非硬编码 HEX 值
- 间距：使用间距 token
- 字体：使用文字样式
Colors: use variables, not hardcoded HEX values
Spacing: use spacing tokens
Typography: use text styles
```

### 第五步：设置 Auto Layout | Step 5: Configure Auto Layout

所有帧和组件应使用 Auto Layout，正确设置：
- 主轴方向（Horizontal / Vertical）
- 对齐方式
- 间距
- 内边距

---

## 规则 | Rules

- 优先复用现有设计系统组件，不重复造轮子
- 所有元素语义化命名（`ButtonPrimary` 而非 `Rectangle 5`）
- 始终使用 Auto Layout 而非固定定位
- Reuse existing design system components whenever possible
- Name all elements semantically
- Always use Auto Layout over fixed positioning
