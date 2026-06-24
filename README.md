# TS PMO — Task Scribe · Project Management Ops

**The operating layer for Claude-augmented work.** TS PMO is a project-management
**agent** for **Claude Code**, backed by a Notion template. It learns your goals,
keeps you accountable, and runs your work management — so your time goes to building
*with* Claude, not managing around it.

> *"this shit's pissing me off"* → **T**ask **S**cribe · **P**roject **M**anagement **O**ps. The fix for task admin.

## Two parts, one system
1. **The Claude skill suite (6 skills)** — the agent that runs your board.
2. **The Notion template** — the system of record. **[Duplicate it →](<TEMPLATE_DUPLICATE_LINK>)**

The skills live where you already work with Claude; `debrief` turns a Claude session
into tracked progress. Every skill **recommends and asks before it writes** — the
clerical work is the agent's, the judgment stays yours.

## The skills, by job
- **Learns your goals** → `init-direction` (writes your Direction — the yardstick).
- **Keeps you accountable** → `plan` (a feasible day or week), `work-review` (a quick hygiene scan or a full accountability audit).
- **Automates the busywork** → `create` (any tier → a fully-formed, goal-checked item), `debrief` (log a Claude session, move the board), `resync` (one-screen re-entry).

## The model
🎯 **Effort** (Epic) → 🧭 Work Stream (optional) → ✅ Work Item. Opinionated fields —
Priority, Impact (local to parent), Commitment, Acceptance criteria — an
**effective-priority cascade** (a child is capped by its parent), a **Plan** tag
(Today / This week) driving the Todo boards, and numbered select labels so boards
always sort correctly.

## Install
Full steps in **[INSTALL.md](INSTALL.md)**. In short:

1. **Duplicate the Notion template** → `<TEMPLATE_DUPLICATE_LINK>`
2. **Connect Claude Code to Notion** (the Notion connector / MCP).
3. **Install the skills:**
   ```
   /plugin marketplace add chzylee/ts-pmo
   /plugin install ts-pmo
   ```
   (Or drop `plugins/ts-pmo/skills/*` into `~/.claude/skills/`.)
4. **Repoint** the placeholder IDs to your template (INSTALL.md), then say
   **"set up my direction."**

## Status
Early / build-in-public. Today the skills are repointed to your Notion IDs by hand
(see INSTALL); an **`npx ts-pmo init`** wizard to automate that one-time repoint is on
the roadmap.

## License
TBD.
