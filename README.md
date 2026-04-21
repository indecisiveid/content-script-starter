# content-script-starter

A Claude Code + Obsidian system for generating short-form video scripts for any product, calibrated to your voice and improving itself from real performance data.

Sibling to [`second-brain-starter`](https://github.com/indecisiveid/second-brain-starter).

## Recommended setup path

**If you don't already have a second brain:** install [`second-brain-starter`](https://github.com/indecisiveid/second-brain-starter) **first**. That gives you the base vault (daily notes, project structure, `/morning`, `/wrap`, `/capture`, etc.). Then install this repo on top — it adds the marketing/script layer into `projects/<your-brand>/marketing/` without touching the rest of the vault.

**If you only want script generation and nothing else:** install this repo alone. The wizard will create a minimal vault with just the marketing folder. You can always add the second brain later.

**If you already have an Obsidian vault from some other setup:** install this repo alone. The wizard asks where to put the marketing folder so it drops in alongside your existing structure.

---

## What you get

**Three slash commands:**

- **`/capture-idea`** — drop in any rough thought; it infers funnel layer, awareness level, pillar, and format, then writes a tagged idea file to your vault
- **`/script-from-idea`** — takes an idea (with or without a pseudo-script draft) and generates a full ready-to-film script following your voice rules
- **`/review-script-performance`** — every 10 posts, compares top vs bottom performers and proposes updates to your voice rules

**Four vault docs** (templated from your answers during setup):

- `Marketing AI System.md` — the architecture: funnel layers (1-5), awareness levels (A-E, Schwartz), how they combine
- `Script Voice Rules.md` — voice rules, tag taxonomy, shot block formats, performance tracking schema
- `Content Guide.md` — funnel layer definitions, Hook/Value/CTA frameworks, posting tips
- `Messaging.md` — your product positioning, voice, pillars, example messages

**One Obsidian Bases view** for the content-delivery database with filterable inbox, scripted, slipped, posted, and tag views.

**Two Claude Code memory files** that persist the two-axis model and script template across sessions.

---

## Prerequisites

- **Claude Code** — [install](https://claude.ai/code)
- **Obsidian** — [install](https://obsidian.md); enable the **Bases** core plugin (Settings → Core plugins)

Optional but recommended:
- **Templater** community plugin — for Notion-style prompt-driven idea creation
- **Full Calendar** community plugin — visualize scheduled and posted content on a calendar

Optional Claude skills that enhance `/script-from-idea` (install via Claude Code settings):
- `marketing-skills:marketing-psychology`
- `marketing-skills:customer-research`
- `marketing-skills:social-content`
- `marketing-skills:copywriting`
- `marketing-skills:content-strategy`

The system works without the marketing skills — they just add psychological and copywriting depth to generated scripts.

---

## Install

One line:

```bash
curl -sL https://raw.githubusercontent.com/indecisiveid/content-script-starter/main/install.sh | bash
```

This downloads the `/content-script-setup` wizard into `~/.claude/commands/`. Then, in any Claude Code session:

```
/content-script-setup
```

The wizard asks ~7 short questions (vault path, brand name, product, voice, pillars, examples) and builds everything in ~5 minutes.

---

## How it works (30-second tour)

```
you: /capture-idea the 5 minutes before your alarm
      ↓
  Claude infers Layer 1, Awareness A, Motivation/Friction, Yap
  writes content-delivery/the-5-minutes-before-your-alarm.md
      ↓
you: /script-from-idea the-5-minutes
      ↓
  Claude reads Script Voice Rules.md, Messaging.md, Marketing AI System.md
  generates scripts/YYYY-MM-DD-the-5-minutes-before-your-alarm.md
  with 3 hook variations, body, CTA, filming notes, short version, caption
      ↓
you: film it, post it, log views/likes/saves in frontmatter
      ↓
  after 10 posts: /review-script-performance
      ↓
  Claude compares top vs bottom performers
  proposes updates to Script Voice Rules.md
  you approve → rules evolve → next generation is sharper
```

---

## The two-axis model (core idea)

Every script calibrates on two orthogonal dimensions:

- **Funnel Layer (1–5)** — how much of this do I post (Face Familiarity → Offer)
- **Awareness Level (A–E, Schwartz)** — who is this written for (Unaware → Most Aware)

A Layer 3 + Awareness B video sounds different than a Layer 3 + Awareness C video. The system calibrates hook, body, and CTA based on both.

Full explanation in `Marketing AI System.md` → "Awareness level calibration" after install.

---

## What the wizard asks

1. **Vault path** — where's your Obsidian vault
2. **Brand name + folder location** — what to call your product folder and where in the vault
3. **Product** — what is it, who is it for, what pain, what mechanism
4. **Voice** — how do you talk; what are your content pillars (3–4)
5. **Examples** — 3–5 tagline-style sentences that seed voice for every script
6. **Integrations** — optional Notion MCP sync, Full Calendar plugin

No forms. Natural conversation. Skip anything you don't know — the wizard picks sensible defaults.

---

## What ships vs. what you build

**Ships in the box:**
- All three workflow commands (with placeholders for your brand)
- The three framework docs (funnel layers, awareness levels, voice rules — all generic, based on established marketing frameworks)
- The Bases view
- A Hello World seed idea so you can immediately test `/script-from-idea`

**You fill in:**
- `Messaging.md` — your product positioning (wizard walks you through)
- Content ideas as you have them (via `/capture-idea`)
- Performance data as you post (update frontmatter after each post)
- Voice rules evolve automatically via `/review-script-performance`

---

## License

MIT. See [LICENSE](LICENSE).

---

## Credits

Built for the Pokito marketing workflow, open-sourced for anyone building in public. Sibling repo: [second-brain-starter](https://github.com/indecisiveid/second-brain-starter).

Issues and PRs welcome — see [CONTRIBUTING.md](CONTRIBUTING.md).
