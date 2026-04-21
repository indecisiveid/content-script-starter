# /script-from-idea — Generate a Script from a {{BRAND}} Content Idea

Runs the Layer 1 script generator against an idea in the content-delivery database and produces a ready-to-film script following the established template. Handles optional pseudo-script drafts.

## Usage

`/script-from-idea [slug-or-title-fragment]`

Examples:
- `/script-from-idea morning-routine-reframe`
- `/script-from-idea` (no args — shows the Inbox and asks which idea to script)

## Steps

1. **Locate the idea file.**
   - Try exact: `{{VAULT_PATH}}/content-delivery/<arg>.md`
   - Then try slugified argument
   - Then fuzzy-match `$ARGUMENTS` against filenames and `title:` frontmatter in that folder (skip `posted/`)
   - If multiple candidates, list them and ask
   - If none, fail with a list of `status: idea` files

2. **Read the idea file.** Extract frontmatter: `title`, `topic_blurb`, `funnel_layer` (required, verbose string), `awareness_level` (required, verbose string), `pillar`, `format`, `shot_format` (optional — defaults to `physical`; set to `visual` for laptop/screen-based formats like the caveman chain), `target_length_seconds`, `tags`, `callback_to`, `notion_source`, `trend_reference` (optional free-text pointer to a trend format being copied), `script` (if already set — confirm before regenerating). Also extract any `## Pseudo Script` body section.

3. **Read reference docs (read-only, in this order).**
   - `{{VAULT_PATH}}/Script Voice Rules.md` — **canonical voice rules. Read this FIRST, every run. Apply these rules to every line Claude generates.** Takes precedence over inline rules in this command file.
   - `{{VAULT_PATH}}/Marketing AI System.md` — Layer 1 spec, calibration tables
   - `{{VAULT_PATH}}/Content Guide.md` — tone, format rules
   - `{{VAULT_PATH}}/Messaging.md` — voice, pain points, positioning
   - `{{VAULT_PATH}}/pattern-library/` — if non-empty, scan for matching funnel + awareness
   - If `callback_to` is set, read the predecessor script for voice continuity

4. **Identify gaps.** Confirm awareness_level, funnel_layer, and the body payload (what are the actual examples / points / categories?). Look for the body payload in order: `## Pseudo Script` → `topic_blurb` → the idea's body. Only ask the user if genuinely unknowable. Do not re-ask for frontmatter fields that are already set.

5. **Generate the script** per the script template memory:
   - H1 title + intro paragraph
   - `## HOOK (0–3 sec) — 3 variations` (A/B/C, each calibrated to awareness level)
   - `## ANCHOR (3–6 sec)`
   - `## BODY` — numbered H3 sub-sections, one per example/category/point
   - `## CTA` + `### CTA alt` (calibrated to funnel layer)
   - `## Format / filming notes`
   - `## Retention devices`
   - `## Pattern interrupts (timestamps)`
   - `## A/B test suggestion`
   - `## Short version (~30 sec / ~75 words)`
   - `## Caption`

   Each scripted line uses a shot block. The block format depends on `shot_format` from the idea frontmatter:

   **If `shot_format: physical` (default):**

   ````
   ### <Section name>

   > [!example] Shot
   > **Location:** <where you are physically>
   > **Action:** <what moves while the line is delivered>

   "<spoken line — multi-line dialogue allowed in one quoted string>"

   **On-screen:** <uppercase overlay text>
   ````

   **If `shot_format: visual` (laptop / screen-based — e.g. caveman chain trend):**

   ````
   ### <Section name>

   > [!example] Shot
   > **Visual:** <simple slide / Figma frame / on-screen element to display while talking — one concrete item>

   "<spoken line>"

   **On-screen:** <optional overlay text — can match the visual or be omitted if the visual is the overlay>
   ````

   For `visual` blocks, suggest concrete simple visuals: a single word with a red X, a rough sketch, a basic shape, a meme-style slide, a calendar with a mark, a checkbox, an icon. Think "memes in PowerPoint," not "designed infographic." The user will build them in Figma or slides.

   Do NOT add a `## Metadata` section — frontmatter covers it.

6. **Pseudo-script handling.** If the idea has a `## Pseudo Script` section, treat it as authoritative raw material: preserve the user's language, metaphors, and specific phrasings. Restructure into Hook/Anchor/Body/CTA. Tighten filler but don't substitute vocabulary. Flag any additions made beyond the pseudo-script in the final report.

7. **Write the script file** to `{{VAULT_PATH}}/scripts/YYYY-MM-DD-<slug>.md` (today's date, slugified title). Frontmatter follows the template exactly, including `content_delivery_link: "[[<idea-slug>]]"` backref. `funnel_layer` and `awareness_level` are verbose single strings (`"3 — Free Value"`, `"A — Unaware"`).

8. **Update the idea file:** set `status: scripted`, add `script: "[[<script-slug-without-md>]]"`. Preserve all other frontmatter and body content.

9. **Optional Notion push.** If `notion_source` is set and the Notion MCP is configured, ask the user: "Push this script to the Notion page's 'Actual Script' toggle?" Default yes. Skip this step entirely if the Notion MCP isn't installed.

10. **Report back** with: script file path, word count, runtime estimate, any gaps that required user input, any additions beyond the pseudo-script, Notion sync status, and a suggested next step.

## Rules

- Awareness calibration: A = pattern interrupt; B = name the pain; C = compare approaches; D = proof/demo; E = direct offer
- Funnel calibration for CTA: Layer 1 none; Layer 2 soft; Layer 3 "the system I built"; Layer 4 show {{BRAND}}; Layer 5 direct ask
- Never touch `posted/` files
- Never regenerate an already-scripted idea without explicit confirmation

## Voice rules

**Source of truth:** `{{VAULT_PATH}}/Script Voice Rules.md`

Always read that file at step 3 before generating. If it conflicts with anything in this command file, the vault doc wins — the user edits it directly as the rules evolve.

Short version of the current rules (mirrored here for context, authoritative copy is in the vault):
- Concrete > abstract. Specific months, numbers, actions.
- Literal > metaphorical. Don't invent metaphors.
- Direct instruction > reframe.
- Binary choices > soft exits.
- First-listen clarity.
- When the user's pseudo-script is abstract, mirror their voice. The rules govern Claude's additions, not their own language.

$ARGUMENTS
