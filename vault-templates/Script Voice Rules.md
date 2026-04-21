---
tags:
  - {{brand}}
  - marketing
  - script
  - voice-rules
created: 2026-04-20
updated: 2026-04-20
last_review_date: null
last_review_post_count: 0
review_cadence: every 10 posts
---

# Script Voice Rules

This is the canonical voice/tonality reference for every {{BRAND}} script. `/script-from-idea` reads this file on every run and applies the rules below. Christian edits this doc directly in Obsidian as lessons accumulate — no code changes needed.

Updated automatically by `/review-script-performance` every 10 posts using top vs bottom performer analysis. Manual edits welcome anytime.

---

## Voice rules (v1)

### The core rule

**Scripts are not poetry.** Every line is concrete, literal, first-listen-clear. Christian's own writing is occasionally sharp and declarative — that's fine because he wrote it. When Claude is filling gaps, Claude stays literal.

### Do

- **Concrete > abstract.** Use specific months, numbers, times, actions, objects. "Start in May. By June it's too late." beats "Summer bod isn't a summer project."
- **Literal > metaphorical.** If the pseudo-script doesn't use a metaphor, don't invent one.
- **Direct instruction > reframe.** "You have to start Monday." beats "It's not about motivation, it's about starting."
- **Binary choices > soft exits.** "Start this week or wait until next spring." beats "Maybe next month is the right time."
- **Specific over universal.** "The people who have one now started in January." beats "People who are consistent succeed."
- **First-listen clarity.** If a viewer would need to rewind, the line is wrong.

### Don't

- Don't try to write the clever close. Land on a concrete binary or a specific instruction, not a metaphor payoff.
- Don't invent metaphors (doors, skips, bridges, chapters, seasons-as-verbs). Mirror the user's metaphors when they use them; don't add new ones.
- Don't write reframes for the sake of reframing. A reframe is only useful if it makes the next action clearer.
- Don't write lines that sound like LinkedIn quotes.

### When Christian's pseudo-script is abstract

Mirror the voice. If his draft uses a metaphor, his body should too. Don't overwrite his voice with this rules doc — the rules govern Claude's additions, not his own language.

---

## Format rules (v1)

### Hook structure

- 3 variations per script: typically contrarian / question / scenario, but adapt to awareness level
- Each hook is its own shot
- Hook verbal line is ≤ 15 words

### Body structure

- Numbered H3 sub-sections
- Each sub-section is one shot
- Body verbal per sub-section = 1–3 short sentences
- Each sub-section has a clear payoff line

### CTA structure

- Calibrated to funnel layer (Layer 1 = no call, Layer 5 = direct ask)
- End on a concrete instruction or binary choice, never a metaphor

### Shot block format — two variants

Each idea declares `shot_format:` in frontmatter. Default is `physical`. For laptop/screen-based formats (e.g. the caveman brain-rot trend), use `visual`.

**`shot_format: physical`** (default — Yap, Luxury, most formats)

````markdown
> [!example] Shot
> **Location:** <physical setting>
> **Action:** <what moves while the line is delivered>

"<spoken line>"

**On-screen:** <overlay text>
````

**`shot_format: visual`** (laptop explainer, caveman chain, any screen-based format)

````markdown
> [!example] Shot
> **Visual:** <simple slide / Figma frame / on-screen element you display while talking>

"<spoken line>"

**On-screen:** <overlay text — optional, can be same as visual>
````

Visual recommendations should be **simple and concrete**: a single word, a rough sketch, a basic shape, a crossed-out word, a checkmark, a single icon. The kind of thing you can mock up in Figma or PowerPoint in 60 seconds. Think "meme slides," not "infographic."

Examples of good Visual entries for a caveman-chain script:
- `**Visual:** Scale with "-20 lbs" written on it. Thumbs-up emoji.` (paired with "goal lose 20 pounds")
- `**Visual:** Calendar showing Monday with a question mark over it.` (paired with "Monday need motivation")
- `**Visual:** Cozy-bed illustration, zZz icon in the corner.` (paired with "bed warm")
- `**Visual:** Big checkmark next to a drawn routine. Word "SYSTEM" underneath.` (paired with "system always show up")
- `**Visual:** Two stacked words — "GOAL" with a red X, "SYSTEM" with a green check.` (paired with "goal bad, system good")

---

## Tags taxonomy

Every idea in `content-delivery/` can carry multiple `tags:` in frontmatter. Tags are freeform — add what's useful — but keep them consistent so Bases views can filter reliably.

Current tag vocabulary:

**Content type** (what kind of video this is):
- `Educational` — teaching or explaining something
- `My Story` — personal / founder / origin content
- `Promo` — direct promotional / announcement
- `Proof / BTS` — behind-the-scenes (though this is also a pillar — use the pillar field for that, use this tag for BTS-within-another-pillar)

**Series & trends** (format affiliations):
- `Hijinx Series` — the original Hijinx daily-challenge series (imported from Notion)
- `Trend` — copying a trending format (pair with a specific trend name tag)
- `Caveman` — specifically the brain-rot caveman-chain trend (always pairs with `Trend`)

**Project areas**:
- `Building` — 3D printer / hardware / making-of content

When creating a new trend-based idea, use BOTH `Trend` and the specific trend name as a sub-tag (e.g. `Trend` + `Caveman`, `Trend` + `GreenScreenReveal`, etc.). That way:
- "All trend content" filter works via `Trend`
- "Just the caveman ones" filter works via `Caveman`
- New trends can be added without breaking the structure

Add new tags as new formats or themes emerge. Document additions here so everyone knows which are canonical.

## Performance tracking

Performance data lives on `content-delivery/posted/<file>.md` frontmatter. Optional fields:

```yaml
views: 12400
likes: 340
saves: 88
comments: 12
shares: 21
watch_through_pct: 58
hook_variation_used: A      # which hook from the script was used
performance_score: null     # computed by Bases formula
retrospective_notes: "hook landed, body dragged after sec 20"
```

Christian fills these in manually as posts accumulate data. No field is required — add what's available.

Bases computes `performance_score` via formula (rough starting weight: `views * 0.2 + likes * 0.3 + saves * 0.5 + comments * 0.5 + shares * 0.8`). Tune the formula in `content-delivery.base` if the weighting stops matching intuition.

---

## Review cadence

Every 10 posts, run `/review-script-performance`. That command:
- Counts posts since `last_review_post_count`
- Compares top vs bottom performers
- Extracts common voice/structural patterns from the top
- Proposes edits to this file
- Updates `last_review_date` and `last_review_post_count` on approval

---

## Changelog

- **2026-04-20 (v1)** — Initial voice rules extracted from the "summer bod" feedback: concrete > abstract, literal > metaphorical, direct instruction > reframe, binary > soft, first-listen clarity. Format rules extracted from the template memory.
