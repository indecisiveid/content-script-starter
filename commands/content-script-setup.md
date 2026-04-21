# /content-script-setup — Interactive Content Script Agent Setup Wizard

You are guiding a new user through setting up a content-marketing script generation system powered by Claude Code + Obsidian. This is a ~5 minute conversation across 7 turns. The user talks, you build.

Be warm, decisive, low-friction. Do not make them fill out forms. Do not dump walls of text.

---

## How the Wizard Works

Ask ONE turn at a time. Wait for their answer. Do NOT ask all questions at once.

Between turns, silently update an in-memory scratch pad. At the end, show a summary and build everything in one shot.

If the user skips or says "I don't know," pick a reasonable default, note it, and move on. Never block.

**Repo base URL for downloads:**
```
https://raw.githubusercontent.com/indecisiveid/content-script-starter/main
```

---

## Turn 0 — Orientation

Open with exactly this (or close to it):

> Hey — I'm going to set up a content script generator for you. Here's what that means:
>
> - **An Obsidian folder** — `<brand>/marketing/` with your messaging, voice rules, and a content-delivery database (Bases view)
> - **Slash commands** — `/capture-idea` (drop in a raw thought, get a tagged idea) and `/script-from-idea` (generate a ready-to-film script following your voice)
> - **A performance loop** — every 10 posts, `/review-script-performance` updates your voice rules based on what actually worked
>
> I'll ask you ~7 short questions, then build everything. Ready?

Wait for confirmation.

---

## Turn 1 — Vault Path

> First: where's your Obsidian vault? Full path (e.g. `~/Projects/vault` or `~/Documents/Obsidian/MyVault`).

Expand `~`. Verify with `ls`. If not found, offer to create it. Store as `VAULT_ROOT`.

Also detect if Bases plugin is enabled by checking `{VAULT_ROOT}/.obsidian/core-plugins.json` for `"bases": true`. If not, tell them to enable it in Obsidian Settings → Core plugins → Bases, and offer to wait.

---

## Turn 2 — Brand + Folder Location

> What's the brand/project name? (Short, lowercase — this becomes the folder slug, like `pokito` or `myproduct`.)

Store as `BRAND_SLUG`. Also capture a Title-case version `BRAND` (e.g. "Pokito", "MyProduct").

Then detect whether they've run `second-brain-starter` already — check for `{VAULT_ROOT}/context/_about-me.md`, `{VAULT_ROOT}/projects/`, or `{VAULT_ROOT}/templates/Daily Note.md`. If any exist, assume they have the second-brain convention installed.

Then ask:

> And where should the marketing folder live inside your vault?

**If second-brain-starter detected:** Recommend option 1 as the default:

> I see you've got the second-brain-starter setup — I'll put the marketing folder at `projects/{BRAND_SLUG}/marketing/` to match that convention. Sound right? (Y/n)

If they confirm, use that path. If they decline, show them:
> 1. `projects/{BRAND_SLUG}/marketing/` (second-brain-starter convention)
> 2. `marketing/` at vault root
> 3. Custom path

**If second-brain-starter NOT detected:** Offer the full choice with option 2 as the default:

> Two common choices:
> 1. `projects/{BRAND_SLUG}/marketing/` — use this if you plan to install the second-brain-starter later (recommended if your vault will hold more than just marketing)
> 2. `marketing/` at vault root — simplest if you only use this vault for marketing
> 3. Custom path

Store as `VAULT_PATH` (absolute) and `VAULT_INFOLDER_PATH` (relative-to-vault — this goes in the Bases file's `file.inFolder()` predicate).

---

## Turn 3 — Messaging (the product questions)

One message, 4 questions:

> Now the product. Answer in 1-2 sentences each, skip if unsure:
>
> 1. **What is it?** (The product in a sentence.)
> 2. **Who is it for?** (Your target viewer / customer.)
> 3. **What pain does it solve?** (What does your audience struggle with that this fixes?)
> 4. **Why does it work?** (The mechanism — what makes it actually effective.)

Store answers as `PRODUCT_WHAT`, `PRODUCT_WHO`, `PRODUCT_VALUE` (combined from pain + mechanism), `PRODUCT_HOW`.

---

## Turn 4 — Voice + Pillars

> Two more:
>
> 5. **How do you talk?** Describe the voice in 5-10 words. Examples: "deadpan, declarative, short sentences"; "warm, educational, specific"; "sharp, contrarian, sarcastic."
>
> 6. **What are your content pillars?** 3-4 recurring themes your videos live under. Examples: `Consistency / Systems`, `Motivation / Friction`, `Proof / BTS`, `Hot Takes`.
>
> If you don't know pillars yet, I'll suggest 3-4 based on your product answers.

Store as `VOICE_NOTES` and `PILLARS` (as a markdown list).

If they skip pillars, propose 3-4 based on pain/mechanism, confirm, and continue.

---

## Turn 5 — Example Messages

> Give me 3-5 example sentences — how you'd describe the product in a tweet, or a tagline you've used. These seed the voice for every script the system generates.

Store as `EXAMPLE_MESSAGES` (markdown list of quoted strings).

Also extract / ask for:
- `CONVERSATION_SENTENCE` — one sentence, how they'd pitch to a friend at a party
- `MARKETING_SENTENCE` — one sentence, how it'd appear on the landing page
- `BENEFITS` — 3-5 short benefit phrases

If they only give partials, derive missing ones from what they gave and confirm.

---

## Turn 6 — Optional Integrations

> Two optional hookups, skip either:
>
> 7a. **Notion sync** — if you keep content ideas in a Notion database and want scripts pushed back there, I can wire the Notion MCP. Need your workspace connected to Notion MCP already. Skip if no Notion.
>
> 7b. **Full Calendar plugin** — shows your scheduled/posted content on an Obsidian calendar. Requires installing the Full Calendar community plugin.

Store flags `USE_NOTION`, `USE_FULL_CALENDAR`.

---

## Turn 7 — Confirm + Build

Show a summary:

> Got it. Here's what I'll build:
>
> - Vault folder: `{VAULT_PATH}`
> - Brand: {BRAND} (slug: `{BRAND_SLUG}`)
> - Pillars: [list]
> - 3 slash commands: `/capture-idea`, `/script-from-idea`, `/review-script-performance`
> - 4 vault docs: Messaging.md, Marketing AI System.md, Script Voice Rules.md, Content Guide.md
> - 1 Bases view: content-delivery.base
> - 2 memory files for persistence
> - 1 "Hello World" idea so you can immediately try `/script-from-idea`
>
> Build it?

On yes:

### Build step A — Download command files

Download into `~/.claude/commands/`, replacing placeholders inline:

```bash
BASE="https://raw.githubusercontent.com/indecisiveid/content-script-starter/main"
mkdir -p ~/.claude/commands

for cmd in capture-idea script-from-idea review-script-performance; do
  curl -sSL "$BASE/commands/$cmd.md" | \
    sed -e "s|{{BRAND}}|{BRAND}|g" \
        -e "s|{{BRAND_SLUG}}|{BRAND_SLUG}|g" \
        -e "s|{{VAULT_PATH}}|{VAULT_PATH}|g" \
        -e "s|{{VAULT_INFOLDER_PATH}}|{VAULT_INFOLDER_PATH}|g" \
    > ~/.claude/commands/$cmd.md
done
```

### Build step B — Create vault folder structure

```bash
mkdir -p "{VAULT_PATH}/content-delivery/posted"
mkdir -p "{VAULT_PATH}/scripts"
```

### Build step C — Download + template vault docs

Download and substitute:
- `Marketing AI System.md`
- `Script Voice Rules.md`
- `Content Guide.md`
- `content-delivery/content-delivery.base`

Placeholder substitutions:
- `{{BRAND}}` → `{BRAND}`
- `{{brand}}` → `{BRAND_SLUG}` (lowercase form)
- `{{VAULT_PATH}}` → `{VAULT_PATH}`
- `{{VAULT_INFOLDER_PATH}}` → `{VAULT_INFOLDER_PATH}`
- `{{TODAY}}` → today's ISO date

### Build step D — Build Messaging.md from user answers

Fetch the skeleton `vault-templates/Messaging.md` and substitute:
- `{{BRAND_SLUG}}`, `{{TODAY}}`, `{{PRODUCT_WHAT}}`, `{{PRODUCT_HOW}}`, `{{PRODUCT_WHO}}`, `{{PRODUCT_VALUE}}`
- `{{EXAMPLE_MESSAGES}}` — formatted as a markdown list
- `{{CONVERSATION_SENTENCE}}`, `{{MARKETING_SENTENCE}}`
- `{{BENEFITS}}` — formatted as a numbered list
- `{{PILLARS}}` — formatted as a markdown list
- `{{VOICE_NOTES}}` — the user's tone description

Write to `{VAULT_PATH}/Messaging.md`.

### Build step E — Install memory files

```bash
mkdir -p "$HOME/.claude/projects/<project-key>/memory"
# <project-key> is the Claude Code project directory corresponding to the user's vault
# Determine via the `claude` project convention
```

Download from `memory-templates/`, substitute placeholders, write to memory dir. Update the `MEMORY.md` index.

### Build step F — Seed a "Hello World" idea

Write `{VAULT_PATH}/content-delivery/hello-world.md`:

```markdown
---
title: Hello world — your first idea
status: idea
funnel_layer: "1 — Face Familiarity"
awareness_level: "A — Unaware"
pillar: <first pillar from their list>
format: Yap
tags:
  - Example
topic_blurb: Delete this after you've run /script-from-idea once to see the pipeline work end-to-end.
created: <today>
---

# Hello world

This is a seed idea to let you test the pipeline. Run `/script-from-idea hello-world` and watch it generate a full script in `scripts/`. Then delete this and replace with your real ideas.

## Pseudo Script

nobody tell you this

you build content before you have audience

no audience yet

you keep building anyway

one day people notice
```

### Build step G — Optional integrations

If `USE_NOTION`: add a `notion_source:` field to the hello-world idea pointing nowhere, and note in the final report that they'll need to add Notion page URLs manually as they capture ideas.

If `USE_FULL_CALENDAR`: tell them to install Full Calendar plugin and add two local calendar sources pointing to `{VAULT_INFOLDER_PATH}` and `{VAULT_INFOLDER_PATH}/content-delivery/posted`, with date fields `scheduled_date` and `posted_date` respectively.

### Build step H — Final report

```
✓ Setup complete.

Installed commands (in ~/.claude/commands/):
- /capture-idea
- /script-from-idea
- /review-script-performance

Vault docs (in {VAULT_PATH}):
- Marketing AI System.md
- Script Voice Rules.md
- Content Guide.md
- Messaging.md  ← your answers
- content-delivery/content-delivery.base  ← Bases view
- content-delivery/hello-world.md  ← seed idea

Next steps:
1. Open Obsidian. Navigate to {VAULT_INFOLDER_PATH}/content-delivery/content-delivery.base — the Bases view should show your Hello World idea.
2. In Claude Code, run /script-from-idea hello-world to generate your first script.
3. Open the script in Obsidian and confirm voice/format feel right.
4. Edit {VAULT_PATH}/Script Voice Rules.md anytime — the script generator reads it fresh on every run.
5. After 10 posts with performance data, run /review-script-performance.

Start capturing with: /capture-idea <your thought>
```

---

## Rules

- Never write to `~/.claude/commands/` or the vault before Turn 7 confirmation.
- If ANY curl fails, stop and report. Don't proceed with partial state.
- If the Bases plugin isn't enabled, warn but don't block the rest.
- If the user has an existing `{VAULT_PATH}/Messaging.md`, ask before overwriting.
- Keep the tone warm and decisive throughout — no form-filling feel.

$ARGUMENTS
