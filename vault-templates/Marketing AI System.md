---
tags:
  - {{brand}}
  - marketing
created: "2026-02-13"
updated: "2026-04-14"
---

# Marketing AI System

A two-layer system that analyzes what's working in the niche and generates ready-to-film ~60 second scripts for {{BRAND}} content.

## Architecture Overview

```
LAYER 2: Analyze                          LAYER 1: Generate
(what's working in the niche)             (write scripts for {{BRAND}})
─────────────────────────────             ─────────────────────────
Apify scrapers                            Input (from Notion: Content Delivery):
  ↓                                         - Topic / pillar
Discover → Enrich → Filter                  - Funnel layer (1-5)
  ↓                                         - Awareness level (A-E)
Transcribe top videos                       - Format
  ↓                                         - Target length (~60 sec)
Structure into patterns                     ↓
  ↓                                       Pull from:
Store in pattern library ────────────────→  - Pattern library (Layer 2)
                                            - Content Guide frameworks
Manual Creator Search Insights ──────────→  - {{BRAND}} messaging + tone
  (2x/week sweep)                           - Marketing psychology
                                            - Creator Insights trends
                                            ↓
                                          Full script output
```

**Layer 2 feeds Layer 1.** The pattern library is training data for the generator, not the end product.

## TODO

- [ ] Sign up for Apify and test one TikTok search actor manually
- [ ] Run one manual end-to-end: keyword → Apify → pick creator → transcript → structure → generate script
- [ ] Build a hook library for my niche (100 hooks grouped by angle + JTBD situation)
- [ ] Build the automated pipeline script once the manual run proves the flow works
- [ ] Create the first batch of scripts using Layer 1

---

## Layer 2: Pattern Analyzer (Apify + Claude)

### Purpose

Find creators in the {{BRAND}} niche who are outperforming their audience, pull their best-performing video transcripts, and deconstruct them into reusable patterns. This replaces the original "Zapier / Make" scraper plan from Feb 2026.

### Pipeline

#### Step 1 — Seed keywords

Source: `Affiliate Marketing.md` Phase 2 search terms + Creator Insights sweep trends.

Current keywords:
- "morning routine", "gym before work", "I hate waking up"
- "ADHD routines", "habit building", "alarm didn't work"
- Add rising keywords from `creator-insights-sweeps/` as they emerge

#### Step 2 — Discover videos (Apify)

Actors: `clockworks/tiktok-scraper`, `apify/instagram-hashtag-scraper`

For each seed keyword, pull ~100 recent videos with:
- Video URL, play count, like count, comment count
- Creator handle

#### Step 3 — Enrich creators (Apify)

Actors: `clockworks/tiktok-profile-scraper`, `apify/instagram-profile-scraper`

For each unique creator handle from Step 2:
- Follower count
- Last 10 posts with view counts
- Bio

#### Step 4 — Filter by viewer/follower ratio (local code)

Compute: `median(views over last 10 posts) / follower_count`

Keep creators where:
- Ratio >= 0.5 (outperforming audience; >= 1.0 = algorithm-favored; >= 2.0 = borderline viral consistency)
- Followers in 5k–100k range (per Affiliate Marketing filters)
- Posted in last 14 days
- Talks to camera, personal pain points (manual spot-check for quality)

Heuristic: **relatable > big** (from `Affiliate Marketing.md`)

#### Step 5 — Transcribe top videos (Apify)

Actor: `scrape-creators/tiktok-transcript` or similar

For each filtered creator, pull transcripts of their top 5 performing posts.

#### Step 6 — Deconstruct into patterns (Claude)

For each transcript, output a structured pattern entry:

```yaml
source:
  creator: "@handle"
  platform: tiktok
  views: 240000
  ratio: 1.8
  url: "https://..."
  scraped: 2026-04-14

pattern:
  hook: "The problem isn't that you can't wake up."
  hook_type: contrarian_statement  # or: question, statistic, scenario, cliffhanger, call_out
  hook_technique: "Negates the obvious assumption, creates curiosity gap"
  body_structure: problem_agitate_reframe  # or: story_arc, list, comparison, before_after
  body_pacing: "Short declarative sentences, builds tension, lands on insight"
  retention_devices:
    - "Pause before reveal at ~25 sec"
    - "Cut to b-roll mid-sentence"
    - "Callback to opener in closing"
  cta_style: soft_positioning  # or: direct_ask, no_cta, social_proof, curiosity
  cta_text: null  # or the actual CTA if present
  psychological_hooks:
    - loss_aversion
    - identity_framing
  funnel_layer: 2  # which Content Guide layer this maps to (1-5)
  {{brand}}_adaptability: 4  # 1-5, how naturally this maps to {{BRAND}}'s pain
  {{brand}}_angle: "The gap between waking up and starting — exactly what checkpoints solve"
  estimated_length_seconds: 55
  word_count: 148
```

#### Step 7 — Store in pattern library

Location: `{{VAULT_PATH}}/pattern-library/`

One file per scrape batch (e.g., `2026-04-14-batch.md`) or one running file per creator. Over time this becomes the knowledge base Layer 1 draws from.

### Manual complement: Creator Search Insights

TikTok's Creator Search Insights (in-app only, no API) provides the one signal Apify can't: **content gaps** (searches where demand is high but supply is low).

Template: `creator-insights-sweeps/TEMPLATE.md`
Cadence: 2x/week, ~10 min per sweep (screenshot in-app → Claude transcribes into template)

How it feeds the pipeline:
- **Content gaps** → highest-priority topics for Layer 1 script generation
- **Rising searches** → added to seed keyword list for Layer 2
- **Trending topics** → Layer 1–2 funnel content (ride the wave for reach)
- **Hooks to try** → direct filming prompts or inputs to Layer 1

### Cost estimate (Apify)

For 6 keywords x 100 videos per scrape, weekly cadence:
- Discovery + profile enrichment: ~$10-30/month
- Transcripts: ~$0.01-0.10 per video (filter aggressively before transcribing)
- Total: ~$20-50/month at moderate volume

### Tools considered and rejected

| Tool | Why rejected |
|---|---|
| Zapier / Make | Too limited for TikTok scraping, no residential proxy support, expensive for the data volume |
| Custom scraper (DIY) | Anti-bot arms race: TikTok uses X-Bogus signed headers, device fingerprinting, TLS fingerprinting. A working scraper is a maintenance project, not a one-time script. |
| OpusClip / VidIQ | YouTube-focused, weak on TikTok. Good supplement but not primary. |
| TrendTok / Tokboard / Pentos | Good for trend signals, but don't provide transcripts or per-creator ratio data. Worth adding later as a second automated signal if the manual Creator Insights sweep feels insufficient. |
| Jasper / Copy.ai / Flick / Predis.ai | Content generation tools, not analysis tools. Claude + marketing skills replaces these for Layer 1. |

---

## Layer 1: Script Generator (Claude + Marketing Skills)

### Purpose

Generate ready-to-film ~60 second scripts for {{BRAND}} content, powered by patterns from Layer 2 and frameworks from the Content Guide.

### Inputs

| Input | Source |
|---|---|
| Topic / pillar | Notion: Content Delivery DB (primary), Content Guide pillars, or Creator Insights sweep gaps |
| Funnel layer (1-5) | Notion metadata or Content Guide funnel distribution targets |
| Awareness level (A-E) | Notion metadata — Schwartz's 5 levels (Unaware → Most Aware). See calibration table below. |
| Format | Notion metadata (Yap / B-roll heavy / Skit / POV / Day X / Luxury) |
| Target length | ~60 seconds (~150 words spoken) |
| Pattern library | Layer 2 output in `pattern-library/` |
| Content frameworks | `social-media/Content Guide.md` (Hook/Value/CTA/Format, funnel layers, awareness levels, hook tips, posting tips) |
| {{BRAND}} messaging | `Messaging.md`, `Affiliate Marketing.md` (tone, pain points, positioning) |
| Psychological hooks | `marketing-psychology` skill |
| Trend context | Latest `creator-insights-sweeps/` entries |

### Claude skills used

| Skill | Role |
|---|---|
| `customer-research` | Mine pattern library for relevant hooks and structures |
| `social-content` | Write platform-native scripts (TikTok/IG conventions) |
| `copywriting` | Polish and tighten language |
| `marketing-psychology` | Tag and leverage psychological triggers |
| `content-strategy` | Pick topics aligned with funnel distribution |

### Script output format

Every generated script follows this structure:

```
TOPIC: [topic]
FUNNEL LAYER: [1-5] ([layer name from Content Guide])
TARGET: 55-65 seconds (~150 words)
INSPIRED BY: @[creator] — "[video title/hook]" (ratio: [X], [N]k views)

---

HOOK (0-3 sec):
"[Verbal hook — the words you say]"
[Visual: what the viewer sees]
[Written hook on screen: what text appears]

ANCHOR (3-6 sec):
"[Curiosity gap / stakes / social proof]"
[Visual direction]

BODY (6-45 sec):
"[Full script text, broken into natural speech chunks]
[Each chunk ~2-3 sentences]
[Paced for ~150 wpm spoken delivery]"
[Visual/b-roll directions inline]

CTA (45-55 sec):
[Calibrated to funnel layer:]
  Layer 1-2: No product mention. End on insight or emotion.
  Layer 3: "Here's what I built for myself" framing.
  Layer 4: Show {{BRAND}} in use, no hard sell.
  Layer 5: "Link in bio" / direct ask. Use sparingly (<5% of content).
[Visual direction]

FORMAT: [Yap / B-roll heavy / Skit / POV / Day X / Luxury]
FILMING: [Location, lighting, energy level]
RETENTION DEVICES: [List: contrarian open, callback, pattern interrupt, etc.]
PATTERN INTERRUPT: [Where to add a visual cut, sound, or shift — with timestamp]
```

### Funnel layer calibration (from Content Guide)

| Layer | % of content | CTA behavior | {{BRAND}} mention |
|---|---|---|---|
| 1 — Face Familiarity | 40-50% | None. No CTA. | Never. |
| 2 — Belief Alignment | 25-30% | Soft positioning only. | Never. |
| 3 — Free Value | 15-20% | "Here's what I did" framing. | Indirect — "the system I built." |
| 4 — Demonstration | 10-15% | Show {{BRAND}} in use. | Yes — show the app. |
| 5 — Offer / Conversion | <5% | Direct ask: "Link in bio." | Yes — name it. |

### Awareness level calibration (Schwartz)

Awareness level is a **second axis, orthogonal to Funnel Layer**. Funnel Layer decides *what % of the content mix this is*. Awareness Level decides *who the viewer is and what mental state they're in*.

A single video is tagged with both. Example: Funnel Layer 1 + Awareness A is a typical face-familiarity post for a cold audience. Funnel Layer 3 + Awareness C is a "here's what I did" post aimed at solution-aware viewers comparing approaches.

| Level | Audience state | Hook technique | Body | CTA / product |
|---|---|---|---|---|
| A — Unaware | Doesn't know they have a problem | Pattern interrupt, observational reframe: "Everyone does X. Nobody notices Y." | Plant a seed. Viewer self-discovers the gap by ~sec 40. No problem language. | None. End on insight or emotion. |
| B — Problem-Aware | Knows the pain, no solution | Name the pain sharply and specifically: "The reason alarms stop working is not what you think." | Agitate the problem, reveal why common fixes fail. | None or soft positioning only. |
| C — Solution-Aware | Knows solutions exist, hasn't picked | Compare approaches: "Every routine method fails at the same point." | Frame why category X works vs category Y. Don't pitch product. | "Here's what I built for myself" framing works here. |
| D — Product-Aware | Knows {{BRAND}}, not convinced | Proof / demo hook: "I've been using this for 90 days." | Show specifics — checkpoints, prints, streaks, real moments. | Show {{BRAND}} in use. No hard sell. |
| E — Most Aware | Ready to buy, needs trigger | Urgency, offer, testimonial, social proof | Direct: reason to act now. | Direct ask. Link in bio. |

**How the two axes combine in practice:**
- Most Layer 1 content is Awareness A or B (reach new people, surface universal pains)
- Most Layer 2 content is Awareness B or C (deepen belief among problem-aware viewers)
- Most Layer 3–4 content is Awareness C or D (convert solution-aware and product-aware)
- Layer 5 is Awareness D or E (direct conversion plays)

When an idea in the Notion Content Delivery DB is tagged with both funnel layer and awareness level, Layer 1 reads both and calibrates hook, body, and CTA accordingly. If awareness level is missing, Layer 1 infers it from the funnel layer using the default mapping above.

### Variations per script

Each generation should produce:
- **3 hook variations** (different hook types: contrarian, question, scenario)
- **1 full body** (the main script)
- **2 CTA options** (calibrated to funnel layer)
- **1 short version** (~30 sec / ~75 words) for when the full version is too long
- **Format notes** (how to film, what energy, what location)
- **A/B test suggestion** (which element to test first: hook, body structure, or CTA)

### Output destination

Scripts are stored in: `{{VAULT_PATH}}/scripts/`

One file per script or per batch. Filename: `YYYY-MM-DD-[topic-slug].md`

### Rules from Content Guide learnings

These are non-negotiable for every generated script:
- Don't make a video longer than 30 seconds unless necessary (60 sec is the upper bound)
- Remove all filler words (um, uh, like, so)
- Keep a strong cadence — short punchy sentences
- Start sentences with the result, then explain
- Don't add sentences that don't add value
- Title and beginning of video should be different
- First 3 seconds grabs attention — start with what matters to the viewer
- State the outcome before the explanation
- Talk less about yourself and more about the emotion/event the viewer relates to

---

## Implementation path

### Phase 1: Manual validation (do this first)

1. Sign up for Apify (free tier)
2. Run a TikTok search actor manually in the Apify console for 2-3 seed keywords
3. Manually compute viewer/follower ratio on a few creators
4. Pick the best creator, grab a transcript
5. Paste into Claude session: "Structure this into a pattern entry per the Marketing AI System spec"
6. Use that pattern to generate one full script via Layer 1
7. Film it. Post it. See if the output is useful.

If the end-to-end produces usable scripts, move to Phase 2.

### Phase 2: Automation

Build a standalone project at `/Projects/Main/MarketingPipeline/` (or keep it as scripts in this vault — decide after Phase 1). The pipeline:

1. TypeScript or Python script that calls Apify SDK
2. Runs Steps 1-5 of Layer 2 automatically
3. Sends transcripts to Claude API for Step 6 (pattern extraction)
4. Stores patterns in `pattern-library/`
5. Separate script (or Claude Code session) runs Layer 1: picks a topic + funnel layer + patterns → generates a full script
6. Stores scripts in `scripts/`

Cadence: Layer 2 runs weekly. Layer 1 runs on demand or as part of the weekly content assembly (60 min block from Content Guide).

### Phase 3: Feedback loop

Track which scripts actually get filmed, posted, and how they perform. Over time:
- Tag pattern entries with `used: true/false` and `performance: views/likes/saves`
- Weight the pattern library toward patterns that actually produced good videos
- The generator gets better as the library grows and gets annotated with real performance data
