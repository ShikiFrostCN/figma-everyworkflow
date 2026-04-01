# Skill: 设计系统规则 | Design System Rules

> **作者 / Author:** shiki  
> **来源 / Source:** figma-everyworkflow

---

## 触发场景 | When to Use

当用户说以下任意内容时：

- "生成设计系统规则"
- "帮我建立 Code Connect"
- "创建组件映射"
- "同步 Figma 和代码"
- "Generate design system rules"
- "Set up Code Connect"
- "Create component mapping"
- "Sync Figma with code"

---

## 执行步骤 | Steps

### Code Connect 建立

1. 调用 `get_code_connect_suggestions` 获取建议映射
2. 与用户确认每个建议映射
3. 调用 `send_code_connect_mappings` 确认映射
4. 调用 `add_code_connect_map` 写入映射

### 设计系统规则生成

1. 分析 Figma 文件的变量、组件和样式
2. 扫描代码库中的组件和 token 文件
3. 调用 `create_design_system_rules` 生成规则
4. 将规则保存到项目的 `.cursor/rules/` 或 `AGENTS.md`

---

## 规则文件模板 | Rules Template

```markdown
## Figma 设计系统规则 | Figma Design System Rules

### 颜色 Colors
- 使用 Figma 变量中的颜色名，不硬编码 HEX
- Use Figma variable names for colors, never hardcode HEX

### 间距 Spacing
- 使用 4px 基础单位的倍数
- Use multiples of 4px base unit

### 组件 Components
- 按钮：使用 src/components/ui/Button
- 输入框：使用 src/components/ui/Input
- Button: use src/components/ui/Button
- Input: use src/components/ui/Input

### 禁止 Forbidden
- 不使用内联样式 No inline styles
- 不硬编码颜色值 No hardcoded color values
- 不重复创建已有组件 No duplicate components
```
