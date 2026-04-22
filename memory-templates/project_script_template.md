---
name: {{BRAND}} script template — frontmatter + shot-callout format
description: Standard file format for {{BRAND}} video scripts. Frontmatter carries all metadata (no duplicate body section). Each scripted line is preceded by a [!example] callout with Location + Action fields.
type: project
originSessionId: 6bec0754-610b-46c5-8c5d-86741605b625
---
{{BRAND}} video scripts live in `{{VAULT_PATH}}/scripts/` with filename `YYYY-MM-DD-<slug>.md` and follow a fixed template.

**Why:** Established 2026-04-19 (and refined 2026-04-20). The previous template had a `## Metadata` section duplicating frontmatter, and filming notes appeared as bullet points AFTER the spoken line, making them visually indistinguishable from `On-screen:` overlays. Christian wanted cleaner separation and richer labels.

**How to apply:** When generating or editing a script file, use this structure.

### Frontmatter

```yaml
---
tags:
  - {{brand}}
  - marketing
  - script
status: scripted           # idea → in-progress → scripted → filmed → posted
topic: <title>
funnel_layer: "3 — Free Value"       # single verbose string, not a separate label field
awareness_level: "A — Unaware"       # Schwartz verbose, single field
pillar: Consistency / Systems
format: Yap
target_length_seconds: 55-65
callback_to: "..."
callback_phrases:
  - "quit quietly"
notion_source: <url>
content_delivery_link: "[[slug-in-content-delivery]]"
variant_of: "[[primary-variant-file]]"   # only for variants
created: "YYYY-MM-DD"
---
```

Key rules:
- `funnel_layer` holds the verbose string (`"3 — Free Value"`), not a bare integer. Don't split into `funnel_layer` + `funnel_label` — redundant.
- Same for `awareness_level` — single verbose string (`"A — Unaware"`), not split.
- Valid funnel values: `"1 — Face Familiarity"`, `"2 — Belief Alignment"`, `"3 — Free Value"`, `"4 — Demonstration"`, `"5 — Offer"`.
- Valid awareness values: `"A — Unaware"`, `"B — Problem-Aware"`, `"C — Solution-Aware"`, `"D — Product-Aware"`, `"E — Most Aware"`.
- Do NOT add a `## Metadata` section in the body — it duplicates frontmatter. Obsidian renders frontmatter as the Properties panel.

### Body sections (in order)

1. H1 title
2. One-paragraph intro describing the video's angle
3. `---`
4. `## HOOK (0–3 sec) — N variations` with H3 sub-sections (A, B, C)
5. `## ANCHOR (3–6 sec)`
6. `## BODY (6–Xs)` with H3 numbered sub-sections
7. `## CTA (Xs–Ys)` with optional `### CTA alt`
8. `---`
9. `## Format / filming notes` (prose bullets, not per-shot)
10. `## Retention devices`
11. `## Pattern interrupts (timestamps)`
12. `## A/B test suggestion`
13. `---`
14. `## Short version (~30 sec / ~Nwords)`
15. `---`
16. `## Title (on-screen overlay)` — 3-4 word ALL CAPS overlay at top of video
17. `---`
18. `## Caption` (Line 1, Line 2)

### Per-line shot format

Two variants, driven by `shot_format:` on the idea file. Canonical spec is in `{{VAULT_PATH}}/Script Voice Rules.md` → "Shot block format — two variants." Short form:

**`shot_format: physical`** (default — Yap, Luxury, most formats):

````markdown
### <Section name>

> [!example] Shot
> **Location:** <where you are physically>
> **Action:** <what moves while the line is delivered>

"<spoken line>"

**On-screen:** <overlay text>
````

**`shot_format: visual`** (laptop / screen-based — e.g. caveman brain-rot trend):

````markdown
### <Section name>

> [!example] Shot
> **Visual:** <simple slide / Figma frame / on-screen element to display>

"<spoken line>"

**On-screen:** <optional overlay>
````

Rules:
- `[!example]` callout (purple in Obsidian) goes BEFORE the spoken line, not after. This matches film-crew convention (set up the shot, then deliver).
- **Location** = the physical setting (room, spot, framing). Concrete. "Kitchen entrance, pre-dawn" not "Somewhere at home."
- **Action** = what moves — body, hands, camera, props — and timing cues tied to specific words in the line.
- Spoken line is a plain quoted string (no blockquote wrapping the dialogue). Multi-line dialogue stays in one quoted block with literal line breaks.
- **On-screen** is a bold-prefixed plain line AFTER the dialogue. Uppercase overlay text.

### Voice rules

**Canonical source:** `{{VAULT_PATH}}/Script Voice Rules.md`

Always read that file before generating or editing any script. The rules there evolve over time via `/review-script-performance` (runs every 10 posts, analyzes top vs bottom performers, proposes rule updates). This memory file is intentionally light on rule content — the vault doc is the truth.

Short version (mirrored for context only — authoritative copy in vault):
- Concrete > abstract
- Literal > metaphorical
- Direct instruction > reframe
- Binary choices > soft exits
- First-listen clarity
- When the user's pseudo-script is abstract, mirror his voice — the rules govern Claude's additions only

### Anti-patterns (do not do these)

- Don't put filming direction AFTER the spoken line as a bullet (`- **Filming:** ...`). That was the old format.
- Don't merge Location and Action into one field. They're different axes — Location is static, Action is dynamic.
- Don't re-list metadata in the body. Use frontmatter.
- Don't use `>` blockquotes for spoken lines — reserve blockquotes for the Short version's multi-line script block and for the `[!example]` callouts.
- Don't write lines that require re-reading to understand. If a viewer would have to rewind to catch the meaning, the line is wrong. Keep it on first-listen.
- Don't try to write the "clever close." Land on a concrete binary or a specific instruction, not a metaphor payoff.
