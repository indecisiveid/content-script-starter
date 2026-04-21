# Performance Tracking

The system learns what works by reading performance data you log against posted content. This doc covers the schema and the manual logging workflow.

## The schema

After a post goes up, open the corresponding idea file in `content-delivery/posted/` and add any of these frontmatter fields:

```yaml
views: 12400
likes: 340
saves: 88
comments: 12
shares: 21
watch_through_pct: 58
hook_variation_used: A       # which hook from the script you filmed
performance_score: null      # computed by Bases formula, don't set manually
retrospective_notes: "hook landed, body dragged after sec 20. comments mostly agreed with the premise."
```

**Every field is optional.** Log what you have, skip what you don't. Missing fields aren't penalized — the review command skips posts with no data entirely.

## The performance formula

Default, defined in `Script Voice Rules.md` → "Performance tracking":

```
performance_score = views * 0.2 + likes * 0.3 + saves * 0.5 + comments * 0.5 + shares * 0.8
```

Tune the weights in the Bases formula (`content-delivery/content-delivery.base`) if your intuition diverges from the ranking. Common adjustments:

- **Weight saves and shares higher** if you're optimizing for audience quality over reach
- **Weight views lower** if you have one-off viral posts that skew comparisons
- **Add watch_through_pct** to the formula if retention matters more than raw views

## Where the data lives

- **Raw metrics** — in each posted file's frontmatter (manual entry for now)
- **Bases computation** — `performance_score` shown as a sortable column in the Posted view
- **Review reads** — `/review-script-performance` loads all posted files, computes scores, and ranks

## Manual logging workflow

After each post:

1. Find the idea in Obsidian — it'll be in `content-delivery/` (or `content-delivery/posted/` if you moved it)
2. Set `status: posted`
3. Add `posted_date: YYYY-MM-DD`
4. Add `hook_variation_used: A` (or B, C — matches the script's hook options)
5. Come back in 3-7 days once the post has data, add `views` / `likes` / `saves` / `comments` / `shares`
6. Optional: add `retrospective_notes` — your qualitative read of what landed or didn't

## Why manual (for now)

The plan is to start manual and automate later if useful. Automation options:

- **TikTok API** — official creator API gives post-level metrics but requires app approval
- **Instagram Graph API** — similar, needs business account setup
- **YouTube Data API** — straightforward, works with personal accounts

None of these are in the box. If you want one, scope it as a separate task.

For now: log when you look at your analytics anyway (weekly review, post-mortems, whatever). It doesn't need to be instant.

## Minimum data needed for `/review-script-performance`

The command can run with as few as 5 top + 5 bottom posts tracked, but works best with 10+. If you have under 5 with data, the command will tell you and skip.

When logging, prioritize:

- **hook_variation_used** — which A/B/C hook you actually filmed. This is the single most useful data point for the review.
- **views** or **watch_through_pct** — baseline reach signal
- **saves** — intent signal (audience wants to reference this again)

The rest are nice-to-have.

## Where insights go

Approved rule changes from `/review-script-performance` land in `Script Voice Rules.md` → Changelog section. Every change includes the evidence: "Top 3 performers used a binary close; 7/10 bottom performers ended on a reframe. Updated rule: prefer binary close for Layer 1 content."

This is how the system gets sharper over time.
