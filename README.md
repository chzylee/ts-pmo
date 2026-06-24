# TS PMO — Task Steward · Project Management Ops

**The operating layer for Claude-augmented work.** TS PMO is a project-management
**agent** for **Claude Code**, backed by a Notion template. It learns your goals,
keeps you accountable, and runs your work management — so your time goes to building
*with* Claude, not managing around it.

> *"this shit's pissing me off"* → **T**ask **S**teward · **P**roject **M**anagement **O**ps. The fix for task admin.

## Two parts, one system
1. **The Claude skill suite (6 core skills + a one-time setup)** — the agent that runs your board.
2. **The Notion template** — the system of record. **[Duplicate it →](https://languid-stocking-b20.notion.site/TS-PMO-Template-38976356d6fe819789f6c1113a92e48a)**

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

1. **Duplicate the Notion template** → **[open it here](https://languid-stocking-b20.notion.site/TS-PMO-Template-38976356d6fe819789f6c1113a92e48a)**
2. **Connect Claude Code to Notion** (the Notion connector / MCP).
3. **Install the skills** (they're Agent Skills — no `/plugin` needed):
   - **Easiest (desktop app / web / terminal):** paste into Claude Code — *"Install the
     TS PMO skills: clone https://github.com/chzylee/ts-pmo and copy its
     `plugins/ts-pmo/skills/` contents into my `~/.claude/skills/` folder, then list what
     you installed"* — then start a new chat.
   - **Terminal CLI:** `claude plugin marketplace add chzylee/ts-pmo` → `claude plugin
     install ts-pmo@chzylee/ts-pmo`.

   The in-app `/plugin` command works **only in the terminal CLI**, not the desktop app
   or web — use the paste-in method there.
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
- `"resync me on <Effort>"` → **resync** catches you up on an Effort after time away — recent work, what's open, the next action.

**The rhythm** — daily: `plan my day` → work the Today board (To do → Doing → Done) → `debrief this chat`. Weekly: `plan my week`, then `work-review`.

The full walkthrough lives in the **User Guide** inside your duplicated Notion template.

## Requirements
- A **Notion** account with this template duplicated into it, and the **Notion connector / MCP** enabled in Claude Code so the skills can read and write your workspace.
- **Claude Code** — terminal, desktop app, or web. The in-app `/plugin` command is **terminal-only**; on desktop or web use the paste-in install above. Web/cloud sessions don't persist `~/.claude`, so install and run from the desktop app or terminal for a setup that sticks.
- A Notion connector that can **create database views and edit a database's select options** — `create` builds per-Effort boards and registers Effort-key options as you add Efforts. If your plan/connector blocks that, board-building degrades gracefully (you get an "add it manually" note) rather than failing silently.

## What it doesn't do
- **Not autonomous** — every write is proposed and confirmed; it never acts on its own.
- **Doesn't delete** — the Notion API here can't archive pages or rows, so cleanup is manual.
- **No calendars, reminders, or external tools** — it's a Notion-backed work ledger + planner, not a do-everything assistant.
- **One workspace per install** — pointing it at a different Notion workspace means re-running `ts-pmo-setup`.

## Updating
Re-install the skills (paste-in, or `/plugin install` / `claude plugin install`) to pull the latest. Re-run `ts-pmo-setup` only if the placeholder set changed. Updates never touch your Notion data.

## Uninstalling
- **Plugin install:** `/plugin uninstall ts-pmo` (terminal) or remove it from the desktop **+ → Plugins → Manage**.
- **Drop-in install:** delete the TS PMO skill folders and `_SHARED-PREAMBLE.md` from `~/.claude/skills/`.

Your Notion workspace is yours — uninstalling the skills leaves it untouched.

## Troubleshooting
- **A skill can't find your databases, or uses a literal `{{…}}` ID** → you haven't wired it yet. Say **"set up ts-pmo"** (it falls back to a guided manual repoint if it can't auto-detect).
- **`/plugin is not available in this environment`** → you're on the desktop app or web. Use the paste-in install, then start a new chat.
- **Skills don't show up after installing** → start a **new chat**; skills load at the start of a session.
- **`set up ts-pmo` can't find your template** → when asked, paste your duplicated **TS PMO** container page's link (Notion → ••• → Copy link).
- **A per-Effort board didn't get built** → your Notion connector may not allow programmatic views; add the board by hand using the filter the skill prints.

## Status
**Canonical repo + marketplace:** `chzylee/ts-pmo` (MIT-licensed). Early / build-in-public. First-run wiring is handled by the **`ts-pmo-setup`** skill —
it auto-detects your duplicated template through the Notion connector and writes the IDs
in, falling back to a guided manual repoint. An **`npx ts-pmo init`** variant may follow.

## License
**MIT** — free and open. See [LICENSE](LICENSE).
