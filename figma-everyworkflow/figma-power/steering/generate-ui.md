# Generate UI Design in Figma

## Overview

This workflow enables AI-powered UI generation directly inside Figma files — equivalent to what design tools like UX Pilot provide. It accepts multiple input types (natural language, HTML files, wireframe images) and produces polished, design-system-consistent Figma screens.

## When to Use This Workflow

Activate when the user:

- Describes a UI they want built in Figma using natural language
  - "Create a SaaS pricing page in Figma"
  - "Design a dashboard for a fintech app"
  - "Build a login screen in Figma"
- Wants to convert an HTML/code file into a Figma design
  - "Convert this HTML to a Figma design"
  - "Turn this React component into a Figma screen"
  - "Import this HTML file into Figma"
- Wants to reproduce a wireframe or prototype in a real design system
  - "Recreate this wireframe using our design system"
  - "Convert this lo-fi prototype to high-fidelity in Figma"
  - "Take this mockup and apply our components"
- Wants multiple design directions to compare
  - "Generate 2 design options for this screen"
  - "Show me a light and dark version"

**Do NOT use this workflow when:**
- The user wants to generate *code* from a Figma design → use `implement-design.md`
- The user wants to connect components to code → use `code-connect-components.md`
- The user wants to create design tokens/variables only → use `figma-use` skill directly

## Required Workflow

**Load [figma-generate-ui](../../skills/figma-generate-ui/SKILL.md) immediately and follow its full workflow.**

The skill covers the complete end-to-end process:

1. **Determine input source** — natural language, HTML file, wireframe, or Figma URL
2. **Understand the design requirement** — synthesize inputs into a screen specification
3. **Resolve the target Figma file** — open file or create a new one
4. **Discover the design system** — find components, variables, and styles
5. **Present a generation plan** — confirm with user before building
6. **Create the page wrapper frame** — establish the top-level container
7. **Build each section** — one section per `use_figma` call, validate after each
8. **Validate the full screen** — screenshot and fix issues
9. **Handoff report** — summarize what was built and suggest next steps

## Quick Reference

### Input Source Handling

| Input | Action |
|---|---|
| Text description | Parse into screen spec → discover design system → build |
| HTML file path | Read file → extract sections/content → map to design system → build |
| Wireframe image | Analyze layout → identify sections/components → reproduce with design system |
| Figma prototype URL | `get_design_context` → extract structure → reproduce with design system |

### Design System Priority

1. **User-specified system** (provided via URL, name, or file key) — always preferred
2. **Auto-discovered from current file** — inspect existing screens for component instances
3. **Search across linked libraries** — use `search_design_system` with broad terms
4. **Fallback** — build manually with consistent visual language if no design system found

### Screen Size Defaults

| Target | Frame Width |
|---|---|
| Desktop | 1440px |
| Tablet | 768px |
| Mobile | 390px |

## Examples

### Example 1: Natural Language → Figma Screen

User: "Generate a SaaS landing page in Figma for a project management tool. Use our design system."

**Actions:**
1. Load `figma-generate-ui` skill.
2. Parse requirement: SaaS landing page, project management tool.
3. Discover design system via `search_design_system` and existing file inspection.
4. Build spec: Navbar → Hero → Features Grid → Testimonials → Pricing → Footer.
5. Present plan and confirm.
6. Build section by section with `use_figma`, validating each.
7. Report completion with frame link.

### Example 2: HTML File → Figma Screen

User: "Convert src/pages/pricing.html to a Figma design."

**Actions:**
1. Load `figma-generate-ui` skill.
2. Read `src/pages/pricing.html` using the Read tool.
3. Parse HTML: extract sections (nav, .hero, .pricing-grid, .faq, footer), text content, button labels.
4. Discover design system.
5. Map HTML structure to design system components.
6. Build the Figma screen section by section.
7. Use exact text from the HTML (headings, CTAs, pricing values).

### Example 3: Wireframe Image → High-Fidelity Figma Design

User: "Here's a wireframe screenshot — reproduce it in high-fidelity using our design system."

**Actions:**
1. Load `figma-generate-ui` skill.
2. Analyze the wireframe: identify sections, component positions, text labels.
3. Discover design system.
4. "Upgrade" wireframe: map wireframe boxes → design system components.
5. Preserve layout intent from the wireframe.
6. Build section by section with real components.

### Example 4: Multiple Design Directions

User: "Generate 2 design options for a dashboard: light mode and dark mode."

**Actions:**
1. Load `figma-generate-ui` skill → Mode: Multi-Style Generation.
2. Create two wrapper frames side by side.
3. Build Variant A (light) and Variant B (dark) using design system theme variants.
4. Label each frame clearly.
5. Present both screenshots for user comparison.

## Design Quality Bar

Generated designs should meet these quality standards:

- **No placeholder text** — all instances have real content
- **Design system components used** — buttons, cards, inputs from the library (not hand-drawn)
- **Variable bindings** — colors and spacing from design tokens, not hardcoded
- **Auto-layout throughout** — no absolute positioning
- **Section padding** — ≥ 64px top/bottom, consistent left/right gutter
- **Validated with screenshots** — each section confirmed visually before proceeding

## Troubleshooting

### No design system found

If `search_design_system` returns nothing and there are no existing screens with instances:
- Ask the user if they want to use a specific Figma library URL.
- Fall back to building manually with a consistent visual language.
- Consider using [figma-generate-library](../../skills/figma-generate-library/SKILL.md) to create a design system first.

### HTML file is complex / too large

- Focus on the main content sections only.
- Skip navigation mega-menus or highly nested tables.
- Ask the user which sections to prioritize.

### Wireframe is ambiguous

- Ask the user to clarify any ambiguous sections before building.
- Use your best judgment for common patterns (e.g., a grid of boxes → card grid).

### Generated screen looks wrong

1. Take a section-level screenshot to pinpoint the issue.
2. Check for: clipped text, wrong variant, missing variable bindings.
3. Fix with a targeted `use_figma` call. Do NOT rebuild the whole screen.
