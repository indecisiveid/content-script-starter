# /capture-idea — Capture a {{BRAND}} Content Idea

Turns a raw thought, topic, or rough draft into a properly-tagged idea file in `{{VAULT_PATH}}/content-delivery/`. Infers funnel layer, awareness level, pillar, and format from the input text. Asks ONLY for what genuinely can't be inferred.

**Distinct from `/capture`** — `/capture` is the general task/idea inbox across all projects. This one is marketing-specific for {{BRAND}} content ideas.

## Usage

`/capture-idea [anything]`

Examples:
- `/capture-idea the 5 minutes before your alarm`
- `/capture-idea why you quit routines — it's because nobody notices`
- `/capture-idea you don't have a motivation problem. you have a starting problem. everyone talks about motivation. nobody teaches starting.`

## Steps

1. **Parse the input.**
   - **Title**: 5–10 word handle, derived from the dominant noun phrase or first sentence
   - **Topic blurb**: one-sentence angle description, written for the user's future self
   - **Pseudo-script candidate**: if the input has >2 sentences with specific phrasing, treat it as a pseudo-script. Preserve word choices. Put raw input into a `## Pseudo Script` body section.

2. **Infer metadata.** For each field, pick the value that best fits. Be confident — the user prefers inference over asking.

   **funnel_layer**:
   - `"1 — Face Familiarity"` — observational / relatable declarations, no product. "Everyone does X. Nobody talks about Y."
   - `"2 — Belief Alignment"` — sharp opinions. "Discipline isn't rare, systems are."
   - `"3 — Free Value"` — "here's what I did." Practical, specific. {{BRAND}} hinted ("the system I built"), not named.
   - `"4 — Demonstration"` — {{BRAND}} in use. POV, proof.
   - `"5 — Offer"` — direct CTA, link in bio.

   **awareness_level**:
   - `"A — Unaware"` — universal reframe. Viewer doesn't recognize the problem yet.
   - `"B — Problem-Aware"` — name the pain. Viewer knows the struggle, not the fix.
   - `"C — Solution-Aware"` — compare approaches, taxonomy. Viewer shopping for solution.
   - `"D — Product-Aware"` — viewer knows {{BRAND}}, needs proof.
   - `"E — Most Aware"` — direct offer / urgency.

   **pillar**: Use the pillars defined in `{{VAULT_PATH}}/Messaging.md` → "Pillars" section. If none defined yet, suggest 3–4 based on the brand voice.

   **format**: `Yap` (default) | `Middle Class` | `Luxury` | `LowLift Video` | `LowLift Carousel`

   **tags** (array): apply any that fit, from the canonical taxonomy in `{{VAULT_PATH}}/Script Voice Rules.md` → "Tags taxonomy". Common: `Educational`, `My Story`, `Promo`, `Trend` + specific trend name.

   If the input references a trending format, apply `Trend` + the trend name. If it's an origin story, apply `My Story`. If it's teaching something, apply `Educational`. Tags are liberal — add what fits, don't force.

   Inference rules:
   - If input doesn't hint at format, default to `Yap` (talking to camera, single take — most common).
   - Observational / universal / no problem framing → default Awareness A + Funnel 1.
   - Names a specific pain → lean B.
   - Compares multiple approaches or says "most X fails" → lean C.
   - {{BRAND}} mentioned explicitly → Funnel jumps to 4 or 5.
   - Trend reference in input → apply `Trend` tag + a specific format tag.

3. **Ask only for what genuinely couldn't be inferred.** Good follow-up: "Awareness — is this for people who haven't recognized the problem yet (A), or who already feel the pain (B)?"

   Never present a form. Never ask for metadata that can be inferred. If you can infer 4 of 5 fields, guess the fifth and flag it in the report for correction.

4. **Generate slug + filename.** Slug: lowercase, alphanumeric + hyphens, ≤60 chars. Path: `{{VAULT_PATH}}/content-delivery/<slug>.md`.

   Collision: if the slug exists AND it's the same idea, offer to append to `## Pseudo Script`. Otherwise suffix with `-2`, `-3`, etc.

5. **Write the file.**

   Frontmatter:
   ```yaml
   ---
   title: <Title>
   status: idea
   funnel_layer: "<verbose string>"
   awareness_level: "<verbose string>"
   pillar: <pillar>
   format: <format>
   tags:
     - <tag1>
     - <tag2>
   topic_blurb: <one-sentence angle>
   created: <YYYY-MM-DD today>
   ---
   ```

   Omit `tags:` entirely if no tags fit. Don't include an empty array.

   Body:
   ```markdown
   # <Title>

   <One-paragraph description of the idea and angle.>

   ## Pseudo Script

   <Raw input verbatim if it qualified as a pseudo-script. Omit this section if no draft.>
   ```

6. **Report back.** Short format:
   - `✓ Created {{VAULT_PATH}}/content-delivery/<slug>.md`
   - Inferred: Funnel / Awareness / Pillar / Format — with 3-word justifications
   - Flag any fields that were guesses
   - Next: `/script-from-idea <slug>` when ready

## Rules

- No form-filling. Infer aggressively. Ask one follow-up max.
- No script generation here — that's `/script-from-idea`.
- No `posted/` writes — inbox only.
- If no arguments provided: ask "What's the idea?"

$ARGUMENTS
