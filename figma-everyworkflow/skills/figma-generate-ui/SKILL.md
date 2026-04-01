---
name: figma-generate-ui
description: "AI-powered UI generation directly in Figma — equivalent to UX Pilot's design generation. Use when the user wants to generate Figma UI from: (1) natural language descriptions ('create a SaaS dashboard', 'design a login page'), (2) HTML files or source code, (3) wireframe/prototype images or screenshots. Supports using a specified design system to keep generated designs consistent. Triggers: 'generate UI in Figma', 'create a design for', 'build this screen in Figma', 'convert this HTML to Figma', 'generate from wireframe', 'design this page', 'create UI from description', 'make a Figma design for'."
disable-model-invocation: false
---

# figma-generate-ui — AI UI Generation in Figma

Generate polished, design-system-consistent Figma screens from natural language, HTML files, or wireframe images — directly inside Figma. This skill replicates the AI design generation workflow of tools like UX Pilot, powered by the Figma Plugin API and MCP.

**MANDATORY**: You MUST also load [figma-use](../figma-use/SKILL.md) before any `use_figma` call. That skill contains critical rules (color ranges, font loading, etc.) that apply to every script you write.

**MANDATORY**: You MUST also load [figma-generate-design](../figma-generate-design/SKILL.md) as the core screen-building workflow reference.

**Always pass `skillNames: "figma-generate-ui"` when calling `use_figma` as part of this skill.**

---

## Supported Input Modes

| Input Mode | Description | Example Trigger |
|---|---|---|
| **Natural Language** | Describe the UI in plain text | "Create a SaaS pricing page with 3 tiers" |
| **HTML / Source File** | Read an HTML or component file and convert it to a Figma screen | "Convert this HTML file to Figma" |
| **Wireframe / Image** | Analyze a wireframe screenshot or prototype image and reproduce it in Figma | "Recreate this wireframe in Figma using our design system" |
| **Combined** | Mix inputs: e.g. wireframe + text refinements, or HTML + design system override | "Take this HTML but use our dark theme design system" |

---

## Required Workflow

**Follow these steps in order. Do not skip steps.**

### Step 0: Determine Input Source

Before doing anything, identify the input source(s):

1. **Natural language only** → proceed to Step 1 directly.
2. **HTML file provided** → read the file to extract layout structure, sections, components, and content. Map these to UI components and screen sections.
3. **Image / wireframe provided** → use `get_screenshot` or analyze the provided image to extract layout structure: identify sections (header, hero, content, sidebar, footer), component types (buttons, cards, inputs, nav), text content, and visual hierarchy.
4. **Figma URL of existing prototype** → use `get_design_context` to extract the layout, then treat it like a wireframe to reproduce in the design system.

For HTML files, extract:
- Page title / heading hierarchy (h1, h2, h3)
- Major sections by semantic tags (header, nav, main, section, aside, footer)
- Form elements (inputs, buttons, labels)
- Repeated elements (card grids, list items, table rows)
- Class names that hint at intent (e.g., `.hero`, `.pricing-card`, `.cta-button`)

### Step 1: Understand the Design Requirement

Synthesize all inputs into a clear screen specification:

1. **Screen name** — what is this screen? (e.g., "Pricing Page", "Dashboard", "Login")
2. **Target device** — Desktop (1440px), Tablet (768px), or Mobile (390px)? Default: Desktop (1440px).
3. **Sections list** — list every major section in order from top to bottom.
4. **Components per section** — for each section, list the component types needed.
5. **Content** — key text, labels, CTA copy, placeholder counts.

**Example specification output:**

```
Screen: SaaS Pricing Page (Desktop 1440px)
Sections:
  1. Navbar — Logo + nav links + CTA button
  2. Hero — Headline + subtitle + 2 CTAs + trust badges
  3. Pricing Grid — 3 cards (Starter, Pro, Enterprise) with feature lists
  4. FAQ Accordion — 6 questions
  5. Footer — Links + social icons + copyright
```

### Step 2: Resolve the Target Figma File

The user must have a Figma file open or provide a URL. If neither:

1. Ask the user if they want to create a new Figma file or target an existing one.
2. If creating new: load [figma-create-new-file](../figma-create-new-file/SKILL.md) to create a file, then use its `file_key` for `use_figma`.
3. If targeting existing: extract the `file_key` from the Figma URL they provide.

### Step 3: Discover the Design System

> This is the most important step for design consistency. A strong design system produces polished, professional results.

Follow the **full design system discovery workflow** from [figma-generate-design](../figma-generate-design/SKILL.md) Steps 2a–2c:

#### 3a. Check for a user-specified design system

If the user specified a design system (e.g., "use our Material Design system", "use the tokens from file X"):
- If they provided a Figma library URL, use `get_design_context` on that file to discover its components and variables.
- If they provided a name/description, use `search_design_system` with those terms.

If **no design system is specified**, proceed to auto-discovery:

#### 3b. Auto-discover components

Inspect existing screens in the current file first (most authoritative). Fall back to `search_design_system` with broad terms:

```js
// Priority 1: inspect existing screens in the current file
const frame = figma.currentPage.findOne(n => n.type === "FRAME" && n.children.length > 3);
if (frame) {
  const uniqueSets = new Map();
  frame.findAll(n => n.type === "INSTANCE").forEach(inst => {
    const mc = inst.mainComponent;
    const cs = mc?.parent?.type === "COMPONENT_SET" ? mc.parent : null;
    const key = cs ? cs.key : mc?.key;
    const name = cs ? cs.name : mc?.name;
    if (key && !uniqueSets.has(key)) {
      uniqueSets.set(key, { name, key, isSet: !!cs, sampleVariant: mc.name });
    }
  });
  return [...uniqueSets.values()];
}
return [];
```

Search terms to try with `search_design_system` (run in parallel):
- `"button"`, `"input"`, `"card"`, `"nav"`, `"header"`, `"footer"`, `"badge"`, `"avatar"`, `"icon"`, `"accordion"`

#### 3c. Auto-discover variables and styles

Run `search_design_system` with `includeVariables: true` using terms:
- `"background"`, `"text"`, `"border"`, `"primary"`, `"gray"`, `"surface"`
- `"space"`, `"radius"`, `"gap"`, `"padding"`

Run `search_design_system` with `includeStyles: true` using terms:
- `"heading"`, `"body"`, `"caption"`, `"shadow"`, `"elevation"`

#### 3d. Build the component map

Create a mapping of needed components to their design system keys:

```
Component Map for This Screen:
- Button (Primary/CTA) → key: "abc123", COMPONENT_SET
- NavBar → key: "def456", COMPONENT
- PricingCard → key: "ghi789", COMPONENT_SET
- Accordion → key: "jkl012", COMPONENT_SET
- Footer → key: "mno345", COMPONENT
Variables:
- bg-primary → key: "var-bg-001"
- text-primary → key: "var-text-001"
- space-lg → key: "var-space-004"
```

**If the design system has no matching components:** Fall back to building manually with hardcoded values, matching the visual language of any existing components in the file. Note this in your response.

### Step 4: Plan the Generation

Before writing to Figma, output a brief generation plan to the user:

```
Generation Plan: Pricing Page
---
Target: Desktop (1440 × auto)
Design System: [found X components, Y variables]

Sections to build:
1. Navbar — using NavBar component (key: def456)
2. Hero — custom frame + Button (key: abc123) + Typography styles
3. Pricing Grid — 3× PricingCard (key: ghi789) in HORIZONTAL auto-layout
4. FAQ — 6× Accordion (key: jkl012) in VERTICAL auto-layout
5. Footer — using Footer component (key: mno345)

Proceed? (Yes to start building)
```

Wait for user confirmation before proceeding, unless the user already said "go ahead" or similar.

### Step 5: Create the Page Wrapper Frame

Create the wrapper frame first, following the pattern from [figma-generate-design](../figma-generate-design/SKILL.md) Step 3:

```js
let maxX = 0;
for (const child of figma.currentPage.children) {
  maxX = Math.max(maxX, child.x + child.width);
}

const wrapper = figma.createFrame();
wrapper.name = "AI Generated — [Screen Name]";
wrapper.layoutMode = "VERTICAL";
wrapper.primaryAxisAlignItems = "MIN";
wrapper.counterAxisAlignItems = "CENTER";
wrapper.resize(1440, 100);  // width fixed, height will hug
wrapper.layoutSizingHorizontal = "FIXED";
wrapper.layoutSizingVertical = "HUG";
wrapper.x = maxX + 200;
wrapper.y = 0;

// Apply background color from design system if available
// const bgVar = await figma.variables.importVariableByKeyAsync("BG_VAR_KEY");
// const bgPaint = figma.variables.setBoundVariableForPaint(
//   { type: 'SOLID', color: { r: 1, g: 1, b: 1 } }, 'color', bgVar
// );
// wrapper.fills = [bgPaint];

return { success: true, wrapperId: wrapper.id, wrapperName: wrapper.name };
```

### Step 6: Build Each Section

Build one section per `use_figma` call. At the start of each call, fetch the wrapper by its ID from Step 5.

For each section:

1. Import required components by key from the design system.
2. Create the section frame with auto-layout.
3. Create component instances and set their text/variant properties.
4. Apply design system variable bindings (colors, spacing, radii).
5. Apply text and effect styles.
6. Append the section to the wrapper. Set `FILL` sizing AFTER appending.
7. Return all created node IDs.

**Content guidelines:**
- Use real, meaningful content from the input (not "Lorem ipsum" or "Button").
- For natural language inputs: generate plausible placeholder content that fits the UI purpose.
- For HTML inputs: copy content from the HTML structure exactly.
- For wireframe inputs: follow the text labels from the wireframe, refine if needed.

**Example section build:**

```js
const wrapper = await figma.getNodeByIdAsync("WRAPPER_ID");

// Import from design system
const btnSet = await figma.importComponentSetByKeyAsync("BUTTON_SET_KEY");
const primaryBtn = btnSet.defaultVariant || btnSet.children.find(c => c.name.includes("primary"));

// Import variables
const bgVar = await figma.variables.importVariableByKeyAsync("BG_PRIMARY_KEY");
const spaceVar = await figma.variables.importVariableByKeyAsync("SPACE_XL_KEY");

// Load fonts
await figma.loadFontAsync({ family: "Inter", style: "Bold" });
await figma.loadFontAsync({ family: "Inter", style: "Regular" });

// Build hero section
const hero = figma.createFrame();
hero.name = "Hero";
hero.layoutMode = "VERTICAL";
hero.primaryAxisAlignItems = "CENTER";
hero.counterAxisAlignItems = "CENTER";
hero.itemSpacing = 32;
hero.paddingTop = 96;
hero.paddingBottom = 96;
const bgPaint = figma.variables.setBoundVariableForPaint(
  { type: 'SOLID', color: { r: 1, g: 1, b: 1 } }, 'color', bgVar
);
hero.fills = [bgPaint];

// Headline
await figma.loadFontAsync({ family: "Inter", style: "Bold" });
const headline = figma.createText();
headline.fontName = { family: "Inter", style: "Bold" };
headline.fontSize = 56;
headline.characters = "The Design Platform for Modern Teams";
headline.fills = [{ type: 'SOLID', color: { r: 0.07, g: 0.07, b: 0.07 } }];
hero.appendChild(headline);

// CTA button
const ctaBtn = primaryBtn.createInstance();
ctaBtn.setProperties({ "Label#1:0": "Start for free" });
hero.appendChild(ctaBtn);

wrapper.appendChild(hero);
hero.layoutSizingHorizontal = "FILL";

return { success: true, createdNodeIds: [hero.id, headline.id, ctaBtn.id] };
```

After each section, call `get_screenshot` on the section node ID to validate visuals before moving on.

### Step 7: Validate the Full Screen

After all sections are built:

1. Call `get_screenshot` on the wrapper frame ID for a full-page visual.
2. Compare against the input (wireframe/HTML/description).
3. Fix any issues with targeted `use_figma` calls — do NOT rebuild.
4. Check for:
   - Placeholder text still showing ("Title", "Button", "Label")
   - Clipped/cropped text (line heights too small)
   - Overlapping elements
   - Wrong component variants
   - Missing sections

### Step 8: Post-Generation Handoff

After validation, report to the user:

```
✅ Generation complete: [Screen Name]

Built sections:
- Navbar ✓
- Hero ✓
- Pricing Grid ✓
- FAQ Accordion ✓
- Footer ✓

Design system components used: X instances
Variables bound: Y properties
File: [Figma URL if available]

Next steps:
- Select the "AI Generated — [Screen Name]" frame in Figma to review
- Use /figma-implement-design to convert this screen to code
- Use /figma-generate-library to extract a reusable component library
```

---

## Special Modes

### Mode: HTML-to-Figma

When a HTML file path is provided:

1. Read the HTML file using the Read tool.
2. Parse the DOM structure into a section/component map.
3. Extract all text content, headings, button labels, input placeholders.
4. Identify the layout grid (flexbox/grid → maps to Figma auto-layout).
5. Map CSS class names to design system components where possible.
6. Follow Steps 3–8 using the extracted structure.

**HTML section mapping heuristic:**

| HTML Element / Class | Figma Section Type |
|---|---|
| `<header>`, `.navbar`, `.nav` | Navbar section |
| `.hero`, `.banner`, `h1` + first `<section>` | Hero section |
| `.card-grid`, `.features`, `.grid` | Card grid section |
| `.pricing`, `.plans` | Pricing section |
| `.faq`, `.accordion` | FAQ section |
| `<footer>`, `.footer` | Footer section |
| `<form>` | Form section |
| `<table>` | Data table section |

### Mode: Wireframe-to-Figma

When a wireframe image or Figma prototype URL is provided:

1. If it's a Figma URL: use `get_design_context` to extract structure, and `get_screenshot` for visual reference.
2. If it's an image file: analyze it visually — identify regions, labels, rough layout.
3. Extract the section structure and component positions.
4. Use the design system to "upgrade" the wireframe: replace wireframe boxes with real component instances.
5. Preserve the layout intent from the wireframe.

### Mode: Multi-Style Generation

When the user wants to see multiple design directions (like UX Pilot's "Explore 4 looks at once"):

1. Ask the user for the number of variants (default: 2).
2. Create a wrapper frame for each variant, placed side by side.
3. For each variant, apply a different design system theme or visual style:
   - Variant A: Light mode, rounded corners, soft shadows
   - Variant B: Dark mode, sharp corners, strong contrast
4. Label each variant frame clearly.
5. Return all variant node IDs so the user can compare.

---

## Design Quality Guidelines

These guidelines ensure AI-generated designs match the quality bar of professional tools like UX Pilot:

### Layout
- Use proper auto-layout for every container (not absolute positioning).
- Sections span full width (`layoutSizingHorizontal = "FILL"` inside the wrapper).
- Consistent padding: section padding ≥ 64px top/bottom, content max-width ≤ 1200px for desktop.
- Card grids: use `HORIZONTAL` auto-layout with `WRAP` for responsive feel.

### Typography
- Maximum 3 font sizes per section (heading, body, caption).
- Use imported text styles from the design system whenever available.
- Heading sizes: H1 = 48–64px, H2 = 32–40px, H3 = 24–28px, Body = 16px, Caption = 12–14px.

### Color
- Never hardcode colors when design system variables exist.
- Use semantic color names (background, surface, text-primary, border) over primitives (gray-100).
- Ensure sufficient contrast for text on backgrounds (WCAG AA minimum).

### Spacing
- Use design system spacing tokens. If none: 4px grid (8, 16, 24, 32, 48, 64, 96px).
- Consistent internal padding: card padding = 24px, section padding = 64–96px.

### Components
- Always prefer imported design system components over manual recreation.
- Set real text content on every component instance (no placeholder text).
- Use correct component variants (primary/secondary, size, state).

---

## Error Recovery

Follow the error recovery process from [figma-use](../figma-use/SKILL.md#6-error-recovery--self-correction):

1. **STOP** on error — do not retry immediately.
2. Read the error message to understand what failed.
3. If unclear, call `get_metadata` or `get_screenshot` to inspect the file.
4. Fix the script. Since each section is a separate call, failures are isolated.
5. Retry the corrected script.

---

## Reference Docs

Load these as needed:

- [figma-generate-design](../figma-generate-design/SKILL.md) — Core screen-building workflow
- [figma-use](../figma-use/SKILL.md) — Plugin API rules and critical gotchas
- [figma-create-new-file](../figma-create-new-file/SKILL.md) — Creating a new Figma file
- [component-patterns.md](../figma-use/references/component-patterns.md) — Importing components, setProperties, text overrides
- [variable-patterns.md](../figma-use/references/variable-patterns.md) — Binding variables, importing library variables
- [text-style-patterns.md](../figma-use/references/text-style-patterns.md) — Applying text styles
- [gotchas.md](../figma-use/references/gotchas.md) — Critical layout pitfalls
