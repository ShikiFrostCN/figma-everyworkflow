# Skill: 实现 Figma 设计 | Implement Figma Design

> **作者 / Author:** shiki  
> **来源 / Source:** figma-everyworkflow

---

## 触发场景 | When to Use

当用户说以下任意内容时，立即使用此技能：

- "实现这个 Figma 设计"
- "把 Figma 转换为代码"
- "根据这个 Figma 链接生成组件"
- "Implement this Figma design"
- "Generate code from Figma"
- "Convert Figma to code"

---

## 执行步骤 | Steps

### 第一步：获取设计上下文 | Step 1: Get Design Context

```
调用 get_design_context 工具，传入用户提供的 Figma 链接或节点 ID。
Call get_design_context with the Figma URL or node ID provided by the user.
```

- 如果响应过大或被截断，改用 `get_metadata` 获取层级结构，再对需要的节点单独调用 `get_design_context`。
- If response is too large, use `get_metadata` first, then `get_design_context` on specific nodes.

### 第二步：获取截图参考 | Step 2: Get Screenshot

```
调用 get_screenshot 获取视觉参考图，确保代码与设计视觉一致。
Call get_screenshot for visual reference to ensure code matches design.
```

### 第三步：提取设计变量 | Step 3: Extract Variables (Optional)

```
如果用户的项目有 design token，调用 get_variable_defs 获取变量名和值。
If the project has design tokens, call get_variable_defs to get variable names and values.
```

### 第四步：检查 Code Connect | Step 4: Check Code Connect

```
调用 get_code_connect_map 查看是否有已映射的代码组件，优先复用。
Call get_code_connect_map to check for existing code component mappings, prioritize reuse.
```

### 第五步：生成代码 | Step 5: Generate Code

根据以下规则生成代码 / Generate code following these rules:

1. **框架优先级**：遵循用户指定的框架，默认 React + Tailwind CSS
2. **Token 优先**：使用项目 design token，不硬编码颜色/间距值
3. **组件复用**：优先使用 Code Connect 映射的已有组件
4. **语义化 HTML**：使用正确的 HTML 语义标签
5. **响应式**：默认实现移动端兼容
6. **无障碍**：添加必要的 aria 属性

### 第六步：视觉校验 | Step 6: Visual Validation

对照截图检验代码实现，确保：
- 颜色、字体、间距与设计一致
- 布局结构正确
- 组件状态（hover、focus、disabled）完整

---

## 规则 | Rules

```
- Figma MCP 服务器提供 localhost 图片/SVG 资源时，直接使用该 URL，不要替换为占位符
- 不要引入新的图标库，所有资源应来自 Figma payload
- MCP 输出的 React + Tailwind 代码是设计意图的表达，需转换为项目实际使用的技术栈
- 始终以 1:1 视觉还原为目标

- When Figma MCP returns localhost image/SVG sources, use them directly
- Do NOT import new icon packages; all assets come from Figma payload
- MCP's React + Tailwind output represents design intent; translate to project's actual stack
- Always aim for 1:1 visual fidelity
```
