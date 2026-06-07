---
name: agent-onboard
description: Onboard an existing repository to be agent-ready by creating AGENTS.md, seeding project memory, and generating project-specific skills. Use when user wants to prepare a repo for AI agents, make a codebase agent-ready, set up AGENTS.md for a new project, or onboard a repo.
---

# Agent Onboard

Make an existing repo agent-ready: a AGENTS.md that orients any agent in seconds, memory that persists context across sessions, and skills for recurring workflows.

## Phase 1: Discovery

Before writing anything, explore the repo to learn:

- **Stack** — languages, frameworks, build tools, test runner
- **Commands** — how to run, build, and test
- **Structure** — key directories and what lives in each
- **Conventions** — naming or patterns that deviate from defaults
- **Recurring workflows** — multi-step tasks a dev does repeatedly (deploy, migrate, seed, etc.)

Use the Explore subagent for broad sweeps. Read README, manifest files (package.json, pyproject.toml, Cargo.toml, etc.), CI config, and a sample of source files.

Present a one-paragraph summary of findings and confirm with the user before proceeding to Phase 2.

## Phase 2: Checklist

- [ ] Create or update **AGENTS.md** at repo root
- [ ] Create **CONTEXT.md / CONTEXT-MAP.md** — domain language for each area of the codebase
- [ ] Seed **project memory** with non-obvious context
- [ ] Create **project skills** for recurring workflows (if any found)

See [REFERENCE.md](REFERENCE.md) for templates and criteria.

## Output

After completing all phases, summarize:

```
## Agent Onboard Complete

### Created
- AGENTS.md
- memory/<file>.md
- .agents/skills/<name>/SKILL.md  (if applicable)

### Skipped
- <item> — <reason>

### Recommended next steps
- <anything the user should do manually>
```
