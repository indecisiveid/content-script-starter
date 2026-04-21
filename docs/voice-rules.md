# How the Voice Rules Evolve

The voice rules doc (`Script Voice Rules.md` in your vault) is the single source of truth for how Claude writes scripts for your brand. It evolves in three ways.

## 1. You edit it directly

Whenever you notice a pattern that works — or one that doesn't — open the doc and add it. Concrete examples beat abstract rules. "Don't write lines that need rewinding" beats "keep it clear."

The script generator reads this file fresh on every run of `/script-from-idea`. No restart, no cache. Save the file, next generation inherits the change.

## 2. The review command proposes updates

After every 10 posts with logged performance, run `/review-script-performance`. The command:

- Reads `Script Voice Rules.md` frontmatter to see when the last review was
- Counts posts since then
- If >=10, compares top 10 vs bottom 10 performers
- Extracts structural and voice patterns (hook types, body structure, CTA style, specific word choices)
- Proposes diff-style edits to the doc
- Waits for your approval before applying

Approved changes get a changelog entry with the date, rationale, and post-count range analyzed.

## 3. Mid-session corrections become rules

When you push back on a generated script ("don't use metaphors," "no poetry," "this line needs rewind"), the fix is worth capturing in `Script Voice Rules.md` so future scripts inherit the lesson. The review command catches these indirectly (via performance data), but you can and should add them manually at the moment they occur.

## What's in the file by default

After `/content-script-setup` runs, the doc includes:

### Voice rules (v1)
- Concrete > abstract
- Literal > metaphorical
- Direct instruction > reframe
- Binary choices > soft exits
- First-listen clarity
- When user's pseudo-script is abstract, mirror it

### Format rules
- Hook structure (3 variations per script)
- Body structure (numbered H3 subsections, 1-3 short sentences each)
- CTA structure (calibrated to funnel layer)
- Shot block formats (physical vs visual)

### Tags taxonomy
Canonical list of content tags, expandable. When you run `/capture-idea`, it reads this section to know which tags are valid.

### Performance tracking
Schema for logging metrics on posted content, plus the formula for `performance_score`.

## The review cadence setting

Frontmatter on `Script Voice Rules.md`:

```yaml
last_review_date: null
last_review_post_count: 0
review_cadence: every 10 posts
```

Adjust `review_cadence` if every 10 feels wrong. "Every 5 posts" catches trends faster but may act on noise. "Every 20" is more conservative but slower to learn.

## When NOT to update the rules

- Single-post anomalies (one viral outlier doesn't mean the pattern generalizes)
- Format experiments you haven't committed to (caveman trend test still running)
- Lessons from other creators' videos that don't match your voice (copying their style over yours loses what makes your videos yours)

## Changelog discipline

Every update gets a changelog entry. Format:

```markdown
- **YYYY-MM-DD (vN)** — [One-sentence summary of the change].
  Evidence: [top 3 performers cited; what pattern showed up].
  Posts analyzed: N through M.
```

This makes it possible to revert a rule that stops working, and to see how your voice has evolved over time.
