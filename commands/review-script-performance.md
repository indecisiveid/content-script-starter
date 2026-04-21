# /review-script-performance — Review Script Performance and Update Voice Rules

Runs a performance review across posted Pokito scripts. Compares top vs bottom performers, extracts voice and structural patterns, and proposes updates to `Script Voice Rules.md`. Intended cadence: every 10 posts.

## Usage

`/review-script-performance [force]`

- No arg: check if enough new posts have accumulated since the last review (10+). If yes, run. If no, report progress.
- `force`: run the review regardless of post count. Useful for ad-hoc analysis after a single surprising performer.

## Steps

1. **Read `vault/projects/pokito/marketing/Script Voice Rules.md` frontmatter** to get:
   - `last_review_date`
   - `last_review_post_count`
   - `review_cadence`

2. **Count posted files.** Glob `vault/projects/pokito/marketing/content-delivery/posted/*.md`. Record the current count as `current_post_count`.

3. **Gate the review.**
   - `delta = current_post_count - last_review_post_count`
   - If `delta < 10` AND no `force` arg: report `"X/10 posts since last review"`. Exit.
   - Else: proceed.

4. **Pull performance data.** For each posted file, extract:
   - `title`
   - `funnel_layer`, `awareness_level`, `pillar`, `format`
   - `posted_date`
   - Performance fields: `views`, `likes`, `saves`, `comments`, `shares`, `watch_through_pct`
   - `hook_variation_used` (A/B/C if logged)
   - `script` link (to the full script file)
   - `retrospective_notes` if present

   Compute a `performance_score` per file using the formula defined in `Script Voice Rules.md` (current baseline: `views * 0.2 + likes * 0.3 + saves * 0.5 + comments * 0.5 + shares * 0.8`). Skip files missing all performance fields — they're untracked and won't contribute.

5. **Sort + partition.** Sort files by `performance_score` descending.
   - Top 10 = `top_set`
   - Bottom 10 = `bottom_set`
   - If fewer than 20 files have data, adjust splits (top 1/3, bottom 1/3, middle ignored).

6. **For each set, pull the corresponding script files** (via `script: [[...]]` on the posted file). Read the full script content.

7. **Pattern extraction.** Compare `top_set` vs `bottom_set` across these axes:
   - **Hook variation used** — is a particular hook type (contrarian / question / scenario) dominating the top?
   - **Body structure** — are list-based bodies beating taxonomy bodies (or vice versa)? How many examples/categories?
   - **CTA style** — concrete instruction? Binary? Soft close? None?
   - **Voice** — concrete vs abstract lines. Count metaphors. Count specific numbers/months/times.
   - **Length** — is one range outperforming (30–45s vs 45–60s)?
   - **Funnel + awareness pairing** — which combos appear most in top vs bottom?
   - **Pillar** — which pillars dominate top vs bottom?

   For each pattern you find, note:
   - The observation ("top performers use a binary close; 7/10 bottom performers end on a reframe")
   - Sample size / confidence ("based on 10 top vs 10 bottom, single reviewer, manual data")
   - Proposed rule change (add / edit / remove an existing rule)

8. **Generate the proposed update.** Show the user a diff-style proposal against `Script Voice Rules.md`:
   - New rules to add under Do / Don't / Format
   - Existing rules to edit (with before/after)
   - Rules to retire (if a rule is contradicted by data)
   - A one-paragraph summary of the data supporting each change

9. **Ask for approval.** The user responds:
   - `approve all` → apply everything
   - `approve <list of numbers>` → apply specified changes
   - `reject` → no changes, just log the review
   - Free-form comments → incorporate + re-propose

10. **Apply approved changes.**
    - Update the Do / Don't / Format sections in `Script Voice Rules.md`
    - Append a new entry to `## Changelog` with today's date, a summary of changes, and the post count range analyzed
    - Update frontmatter: `last_review_date: <today>`, `last_review_post_count: <current_post_count>`

11. **Report.** One-line summary: "Review complete. N rules added, M edited, K retired. Next review at post count X."

## Rules

- Never auto-apply rule changes without user approval.
- Always show the supporting data when proposing a rule. "We changed the rule because the top 3 used binary closes" beats "changed the rule."
- Prefer additive rules over overwrites. If a new rule contradicts an old one, flag the contradiction rather than silently erasing the old rule.
- Respect the changelog — every applied change gets an entry with date, rationale, and the post count range.
- If performance data is thin (< 5 top + 5 bottom), say so and don't force patterns out of noise.

## Non-goals

- Don't modify script files themselves — only the voice rules doc.
- Don't generate new scripts — that's `/script-from-idea`.
- Don't touch `content-delivery/posted/` files' data — read-only.

$ARGUMENTS
