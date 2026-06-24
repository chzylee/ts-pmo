# TS PMO — Task Steward · Project Management Ops

**The operating layer for Claude-augmented work.** TS PMO is a project-management
**agent** for **Claude Code**, backed by a Notion template. It learns your goals,
keeps you accountable, and runs your work management — so your time goes to building
*with* Claude, not managing around it.

> *"this shit's pissing me off"* → **T**ask **S**teward · **P**roject **M**anagement **O**ps. The fix for task admin.

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
4. **Wire the skills to your copy** — say **"set up ts-pmo"**. The `ts-pmo-setup` skill
   auto-detects your template's databases and fills in the IDs for you (guided manual
   fallback in INSTALL.md). Then say **"set up my direction."**

## Usage

Talk to Claude Code in plain language — each skill triggers on what you say, asks what
it needs, and **confirms before it writes**.

**Set up (once)**
- `"set up my direction"` → **init-direction** writes your Direction — the yardstick all planning and review measure against.

**Create work (any tier)**
- `"create an effort"` · `"create a work item"` → **create** builds a fully-formed Effort / Work Stream / Work Item (priority, impact, commitment, acceptance criteria) and checks it against your goals.

**Run the day / week**
- `"plan my day"` · `"plan my week"` → **plan** builds a realistic plan by effective priority, makes you cut scope if over-committed, and stages it on the 📋 Todo boards.

**Log + stay honest**
- `"debrief this chat"` → **debrief** logs the session to the Work Log (by task) + Daily Log (by date) and moves the board.
- `"review my work"` · `"audit my work"` → **work-review** runs a quick hygiene scan or a full accountability audit (what's neglected vs. parked, where time went).
- `"resync me on <effort>"` → **resync** gives a one-screen re-entry on an effort.

**The rhythm** — daily: `plan my day` → work the Today board (To do → Doing → Done) → `debrief this chat`. Weekly: `plan my week`, then `work-review`.

The full walkthrough lives in the **User Guide** inside your duplicated Notion template.

## Status
Early / build-in-public. First-run wiring is handled by the **`ts-pmo-setup`** skill —
it auto-detects your duplicated template through the Notion connector and writes the IDs
in, falling back to a guided manual repoint. An **`npx ts-pmo init`** variant may follow.

## License
**MIT** — free and open. See [LICENSE](LICENSE).
