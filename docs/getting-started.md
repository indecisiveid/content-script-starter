# Getting Started

After running `/content-script-setup` in Claude Code, here's how to use the system day-to-day.

## 1. Capture an idea

Drop any rough thought into `/capture-idea`:

```
/capture-idea the 5 minutes before your alarm
```

Claude infers funnel layer, awareness level, pillar, and format from the text, then writes a tagged idea file to `content-delivery/the-5-minutes-before-your-alarm.md`.

If you already have a rough draft, paste it whole — the entire message becomes a `## Pseudo Script` in the idea file, which the script generator will respect as your voice.

## 2. Script it

```
/script-from-idea the-5-minutes
```

Partial matches work. Claude fuzzy-matches against filenames and titles.

The generator produces `scripts/YYYY-MM-DD-the-5-minutes-before-your-alarm.md` with:
- 3 hook variations (for A/B testing)
- Anchor, numbered body sections, CTA + alt
- Filming notes (Location/Action blocks for physical, Visual blocks for laptop formats)
- Retention devices, pattern interrupts, A/B test suggestion
- A 30-second short version
- A 2-line caption

Open it in Obsidian. Edit anything that doesn't feel right.

## 3. Film and post

Nothing Claude-side for this step. You film, edit, upload.

## 4. Log performance

After the post has data (a few days later), open the idea file (now in `content-delivery/posted/` if you moved it) and add performance fields:

```yaml
views: 12400
likes: 340
saves: 88
comments: 12
shares: 21
watch_through_pct: 58
hook_variation_used: A       # which hook from the script you actually used
retrospective_notes: "hook landed, body dragged after sec 20"
```

Every field is optional. Log what you have. Skip what you don't.

## 5. Review every 10 posts

```
/review-script-performance
```

The command counts posts since the last review. If you have 10+ new posts with data, it:

- Sorts by performance_score (formula defined in `Script Voice Rules.md`)
- Compares top 10 vs bottom 10
- Extracts patterns (hook types, body structure, CTA style, voice patterns)
- Proposes updates to `Script Voice Rules.md` as a diff
- Waits for your approval before applying

After approval, the next `/script-from-idea` run picks up the updated rules automatically.

## The Bases view

Open `content-delivery/content-delivery.base` in Obsidian. You get:

- **Inbox** — ideas waiting to be scripted
- **Ready to film** — scripted but not yet filmed
- **In progress** — scripted / filmed status
- **Slipped** — scheduled date passed, not posted
- **Posted** — historical, sortable by performance score
- **By awareness / funnel / pillar** — grouped views for content balance
- **Trend content / Caveman trend** — filtered by tag

## Optional: your own pseudo-scripts

The secret weapon. Before running `/script-from-idea`, open the idea file and add a `## Pseudo Script` section with your rough draft — even 5 fragments of dialogue. The generator will preserve your word choices, metaphors, and rhythm, then structure them into the template.

Without a pseudo-script, Claude generates from frameworks. With one, it generates in your voice.

## Evolving the voice

`Script Voice Rules.md` is the canonical voice doc. Edit it anytime in Obsidian — the script generator reads it fresh on every run. Add new rules, example lines, anti-patterns. The changelog section captures what evolved when.
