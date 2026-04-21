# Contributing

This repo is currently maintained by one person ([@indecisiveid](https://github.com/indecisiveid)) as a personal template that he dogfoods daily. Improvements flow one way for now: from the maintainer's live vault → sanitized → into this repo → out to everyone else via `git pull`.

That may change over time. If you want to contribute, read this first.

---

## Current state

- **Maintainer-driven.** The maintainer's own use of the system is the main source of improvements. The `/publish-improvements` workflow handles the sync.
- **External PRs are welcome** but must pass a higher bar than a typical project: they have to generalize, not just work for one person's setup.
- **No issue-driven roadmap.** The roadmap is whatever the maintainer finds friction with in his own use.

---

## Before opening a PR

### 1. Is your change *universal*, *engineering-extras*, or *personal*?

The template has three tiers:

| Tier | Goes into | Example |
|---|---|---|
| **Universal** | `commands/`, `docs/`, `examples/` | A better morning-planning prompt, a new priority-marker convention, a clearer time-block pattern |
| **Engineering-extras** | `engineering-extras/` | Patterns that are useful if you're primarily a developer (TDD integration, repo-level CLAUDE.md templates, git-log summaries in wrap-ups) — not installed by default, users opt in |
| **Personal** | Not published at all | Your own project names, partner's name, specific calendars, financial details, domain-specific content |

If your PR doesn't fit in one of the first two, don't open it.

### 2. Run the sanitization grep

```bash
grep -riE "(your own names/projects/partners here)" .
```

Better: grep for known maintainer-specific tokens that should never appear:

```bash
grep -riE "Pokito|bitty-city|NightSync|Angie|Dimitri|Ling|Bryant|christianiosif"
```

Both commands must return nothing. See [`docs/sanitization-rules.md`](docs/sanitization-rules.md) for the full placeholder convention.

### 3. PR description must answer

See the pull request template — it asks you to classify your change (universal / engineering-extras), confirm sanitization, and describe the user problem your change solves.

---

## The `/publish-improvements` workflow (maintainer-only, for now)

The maintainer uses a slash command (`/publish-improvements`) that:

1. Diffs his live vault against this repo's corresponding files
2. Sanitizes the diff (replaces project names, strips personal details)
3. Classifies each change as universal / engineering-extras / personal
4. Presents each to him for approval
5. Commits approved changes with a structured commit message and pushes

Each sync becomes one commit. The commit message enumerates what changed and why. This is the project's history of improvements — you can read `git log --oneline` to see how the template has evolved.

If a given sync skipped a change as "engineering-extras" but you think it should have been universal (or vice versa), open an issue.

---

## Future

When external contributions start flowing regularly, this section will expand. Likely additions:

- Pre-commit hook in this repo that fails on known maintainer-specific tokens (defence in depth)
- GitHub Action that runs the same grep on PRs
- Versioned releases tied to substantive improvements

Not building these until they're needed.

---

## Code of conduct

Be decent. The maintainer runs this solo with limited bandwidth and will close PRs that make him more miserable to merge than the improvement is worth. A well-scoped, sanitized, clearly-described PR will get merged fast.
