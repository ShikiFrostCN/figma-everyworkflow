---
name: "figma"
displayName: "Figma"
description: "Comprehensive Figma integration for: (1) generating UI designs in Figma from natural language, HTML files, or wireframes — like UX Pilot but directly in Figma, (2) implementing Figma designs as production-ready code, (3) connecting Figma components to code via Code Connect, and (4) generating project-specific design system rules. Use when implementing UI from Figma files, generating new Figma designs, connecting components to code, creating design system rules, or when user provides Figma URLs."
keywords: ["figma", "design", "implement", "component", "ui", "code generation", "design system", "code connect", "mapping", "design to code", "rules", "guidelines", "implement design", "implement component", "generate code", "connect component", "design rules", "build design", "generate ui", "create design", "generate figma", "html to figma", "wireframe to figma", "design from description", "ux pilot", "ai design generation", "create screen", "build page figma"]
author: "Figma"
---

# Figma

## Overview

This Power provides four core capabilities for working with Figma:

1. **Generate UI Design** — AI-powered UI generation in Figma from natural language, HTML files, or wireframe images (equivalent to UX Pilot's design generation)
2. **Implement Design** — Translate Figma designs into production-ready code with pixel-perfect accuracy
3. **Code Connect Components** — Connect Figma design components to their code implementations using Code Connect
4. **Create Design System Rules** — Generate project-specific design system rules that guide consistent Figma-to-code workflows

## When to Use This Power

Activate this Power when the user:

- Wants to **generate** a Figma design from a description, HTML, or wireframe
- Mentions: generate UI in Figma, create a design for, build this screen, convert HTML to Figma, design from description, create screen, make a Figma design
- Provides a Figma URL and wants to implement the design as code
- Mentions: implement design, generate code, implement component, build Figma design, build components matching Figma specs
- Mentions: code connect, connect this component to code, map this component, link component to code, create code connect mapping
- Mentions: create design system rules, generate rules for my project, set up design rules, customize design system guidelines
- Wants to establish mappings between Figma designs and code implementations
- Wants to establish project-specific conventions for Figma-to-code workflows

## Available MCP Tools

The Figma MCP server provides these tools:

| Tool | Description |
|------|-------------|
| `get_design_context` | Fetches structured design data (layout, typography, colors, spacing, component structure) for a layer or selection |
| `get_metadata` | Returns a sparse XML representation with basic layer properties like IDs, names, and dimensions |
| `get_screenshot` | Captures a visual screenshot of a Figma selection to preserve layout fidelity |
| `get_variable_defs` | Retrieves variables and styles (colors, spacing, typography) from selections |
| `get_code_connect_suggestions` | Detects and suggests Code Connect mappings between Figma and code components |
| `send_code_connect_mappings` | Confirms Code Connect mappings after suggestions are generated |
| `get_code_connect_map` | Maps Figma node IDs to corresponding code components in your codebase |
| `add_code_connect_map` | Establishes new mappings between Figma elements and code implementations |
| `create_design_system_rules` | Generates rule files that guide agents in translating designs to frontend code |
| `generate_figma_design` | Converts a running web page into design layers in Figma files (pixel-perfect capture) |
| `search_design_system` | Searches across all connected design libraries to find components, variables, and styles |
| `use_figma` | General-purpose tool for writing to Figma: create/edit/delete nodes, components, variables, styles |
| `create_new_file` | Creates a new blank Figma Design or FigJam file in the user's drafts |
| `get_figjam` | Converts FigJam diagrams to XML format including metadata and node screenshots |
| `generate_diagram` | Creates FigJam diagrams from Mermaid syntax (flowcharts, Gantt charts, etc.) |
| `whoami` | Returns authenticated user identity and plan information |

## Steering

Load the appropriate workflow based on the user's intent:

- **Generating a new Figma UI design** (from text, HTML, or wireframe) → `readPowerSteering("figma", "generate-ui.md")`
- **Implementing a Figma design as code** → `readPowerSteering("figma", "implement-design.md")`
- **Connecting Figma components to code via Code Connect** → `readPowerSteering("figma", "code-connect-components.md")`
- **Creating design system rules for a project** → `readPowerSteering("figma", "create-design-system-rules.md")`

## Prerequisites

- Figma MCP server must be connected and accessible
- For **Generate UI**: A Figma file must be open, or the user accepts creating a new one. A design system library is preferred but not required.
- For **Implement Design**: User must provide a Figma URL in the format `https://figma.com/design/:fileKey/:fileName?node-id=1-2`
- For **Code Connect / Design System Rules**: Project should have an established design system or component library (preferred but not required)

## Quick Usage Examples

### Generate a UI Design in Figma

User: "Create a SaaS pricing page in Figma using our design system"

→ Load `generate-ui.md` steering, then follow the 9-step workflow: parse the requirement, discover the design system, present a generation plan, and build section-by-section with `use_figma`.

User: "Convert src/pages/landing.html to a Figma design"

→ Load `generate-ui.md` steering → Mode: HTML-to-Figma. Read the HTML file, extract sections and content, map to design system components, build in Figma.

User: "Recreate this wireframe in Figma with high-fidelity using our component library" (with an image attached)

→ Load `generate-ui.md` steering → Mode: Wireframe-to-Figma. Analyze the wireframe, identify sections, upgrade to real design system components.

### Implement a Design

User: "Implement this Figma button: https://figma.com/design/kL9xQn2VwM8pYrTb4ZcHjF/DesignSystem?node-id=42-15"

→ Load `implement-design.md` steering, then follow the 7-step workflow to fetch context, capture screenshot, download assets, translate to project conventions, and validate.

### Connect Components via Code Connect

User: "Connect this Figma button to my code: https://figma.com/design/kL9xQn2VwM8pYrTb4ZcHjF/DesignSystem?node-id=42-15"

→ Load `code-connect-components.md` steering, then follow the 4-step workflow to get suggestions, scan codebase, present matches, and create mappings.

### Create Design System Rules

User: "Create design system rules for my React project"

→ Load `create-design-system-rules.md` steering, then follow the 5-step workflow to run the tool, analyze codebase, generate rules, save to CLAUDE.md, and validate.

## Troubleshooting

### Generate UI: No design system found

If `search_design_system` returns nothing and the file has no existing screens with component instances:
- Ask the user if they want to provide a Figma library URL.
- Fall back to building manually with a consistent visual language (Inter font, 4px grid, neutral palette).
- Consider using [figma-generate-library](../../skills/figma-generate-library/SKILL.md) to scaffold a design system first.

### Generate UI: Generated screen looks wrong visually

Take a section-level screenshot to pinpoint the issue. Check for: clipped text (line height too small), wrong component variant, missing variable binding. Fix with a targeted `use_figma` call — do NOT rebuild the whole screen.

### Generate UI: HTML file has complex nested structures

Focus on major semantic sections only (header, main, section, footer). Skip deeply nested tables or mega-menus. Ask the user which sections to prioritize if the file is very large.

### Figma output is truncated (Implement Design)

The design is too complex for a single response. Use `get_metadata` to get the node structure, then fetch specific nodes individually with `get_design_context`.

### Assets not loading

Verify the Figma MCP server's assets endpoint is accessible. The server serves assets at `localhost` URLs — use these directly without modification. Do not import new icon packages or create placeholders.

### No published components found (Code Connect)

Code Connect only works with published components. The user needs to publish the component to a team library in Figma first. Code Connect is only available on Organization and Enterprise plans.

### Design token values differ from Figma

When project tokens differ from Figma values, prefer project tokens for consistency but adjust spacing/sizing to maintain visual fidelity.

### Claude isn't following design system rules

Make rules more specific and actionable. Add "IMPORTANT:" prefix to critical rules. Verify rules are saved in the correct configuration file and restart the IDE or MCP client to reload.
