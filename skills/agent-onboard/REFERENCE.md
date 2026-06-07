# Agent Onboard — Reference

## AGENTS.md template

Keep under 80 lines. Omit sections that aren't relevant — don't document what a skilled developer could infer from the file tree.

```markdown
# <Repo Name>

<One sentence: what this project does and who it's for.>

## Stack

- Language/runtime: ...
- Framework: ...
- DB / infra: ...

## Commands

```bash
# Run dev server
<command>

# Run tests
<command>

# Build
<command>
```

## Structure

| Path | Purpose |
|------|---------|
| src/ | ... |

## Conventions

- <Non-obvious convention 1>
- <Non-obvious convention 2>

## Avoid

- <Footgun or "don't do this" rule>
```

---

## CONTEXT.md / CONTEXT-MAP.md

Domain glossaries that give agents (and developers) a shared vocabulary for each area of the codebase. These are the primary source of truth for project-specific terms — AGENTS.md and memory files should reference them, not duplicate them.

**Single context (most repos):** one `CONTEXT.md` at the repo root.

**Multiple contexts:** a `CONTEXT-MAP.md` at the repo root listing each context file and how they relate, with individual `CONTEXT.md` files co-located with their bounded area (e.g. `src/billing/CONTEXT.md`).

**How to decide which structure to use:**
- One coherent domain → single `CONTEXT.md`
- Distinct sub-domains with different vocabularies (e.g. ordering vs. billing vs. fulfillment) → `CONTEXT-MAP.md` + per-area files

**CONTEXT.md format** (follow [grill-with-docs CONTEXT-FORMAT.md](../grill-with-docs/CONTEXT-FORMAT.md) exactly):
- `## Language` section with one term per bold heading
- Definition: 1–2 sentences on what the term IS
- `_Avoid_:` line listing synonyms to reject
- Only include terms specific to this project — not general programming concepts
- Group under subheadings when natural clusters emerge

**CONTEXT-MAP.md format:**
```markdown
# Context Map

## Contexts

- [Ordering](./src/ordering/CONTEXT.md) — receives and tracks customer orders
- [Billing](./src/billing/CONTEXT.md) — generates invoices and processes payments

## Relationships

- **Ordering → Billing**: Ordering emits `OrderPlaced` events; Billing consumes them
```

During discovery, identify the domain terms and bounded areas first. Then write the context file(s) — use terms from the codebase itself (class names, variable names, comments, README) as raw material.

---

## Memory files

Memory location: `~/.agents/projects/<project-slug>/memory/` (global) or `.agents/memory/` (repo-local).

Write a memory file only for facts that:
- Cannot be derived by reading the code
- Would cost an agent significant time to rediscover
- Are stable (not in-progress task state)

**Typical candidates:**
- Why a non-obvious architectural decision was made
- External services or APIs the project depends on
- Manual environment setup steps not in README
- Team/ownership context

**Format:**
```markdown
---
name: <slug>
description: <one-line summary used to decide relevance>
metadata:
  type: project
---

<Fact or decision.>

**Why:** <reason>
**How to apply:** <what an agent should do with this>
```

---

## Project skills — when to create one

**Create a skill if the workflow:**
- Has 3+ non-obvious steps
- An agent would likely get it wrong without guidance
- Will be triggered repeatedly in this repo

**Skip if:**
- A single command covers it (document in AGENTS.md instead)
- It's a one-time setup step

Place skills in `.agents/skills/<skill-name>/SKILL.md` in the repo root. Follow the `/write-a-skill` process for each.
