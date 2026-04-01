# 工作流指南 | Workflow Guide

> **作者 / Author:** shiki

---

## 工作流一：Figma 设计 → 代码 | Workflow 1: Figma Design to Code

```
1. 在 Figma 中设计好组件/页面
2. 右键帧 → Copy link（获取链接）
3. 打开 AI 聊天框，粘贴以下提示词：
   "帮我实现这个 Figma 设计：[链接]，使用 React + Tailwind"
4. AI 自动调用 get_design_context + get_screenshot
5. 生成代码，你来审查和调整
```

---

## 工作流二：代码 / 网页 → Figma 设计 | Workflow 2: Code / Web to Figma

```
1. 运行你的本地开发服务器
2. 在 AI 聊天中说：
   "截取我当前运行的应用首页，导入到 Figma 文件 [链接]"
3. AI 调用 generate_figma_design 完成截图和导入
```

---

## 工作流三：提取设计 Token | Workflow 3: Extract Design Tokens

```
1. 在 Figma 中选择目标帧
2. 告诉 AI："列出这个选区中所有颜色和间距变量"
3. AI 调用 get_variable_defs，返回完整 token 列表
4. 将 token 同步到你的代码 token 文件
```

---

## 工作流四：建立 Code Connect | Workflow 4: Set Up Code Connect

```
1. 告诉 AI："分析我的 Figma 文件，找出可以和 src/components 建立映射的组件"
2. AI 调用 get_code_connect_suggestions
3. 确认建议后，AI 调用 send_code_connect_mappings 和 add_code_connect_map
4. 之后再生成代码时，AI 会自动复用你的实际组件
```

---

## 工作流五：生成设计系统规则 | Workflow 5: Generate Design System Rules

```
1. 告诉 AI："分析我的 Figma 文件和代码库，生成设计系统规则"
2. AI 调用 create_design_system_rules
3. 将生成的规则保存为 .cursor/rules/figma-design-system.mdc
4. 之后所有 Figma → 代码任务都会自动遵循这些规则
```

---

## 工作流六：在 FigJam 生成流程图 | Workflow 6: Generate FigJam Diagrams

```
1. 描述你想要的流程图："生成用户注册流程图，包括邮箱验证步骤"
2. AI 调用 generate_diagram，使用 Mermaid 语法生成
3. 流程图自动出现在你的 FigJam 文件中
支持：流程图、甘特图、状态图、时序图
```
