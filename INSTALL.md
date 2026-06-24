# Installing TS PMO

TS PMO has two halves — the **skills** (Claude Code) and a **Notion template** — plus a
one-time **repoint** that connects them. ~10 minutes.

## 1. Duplicate the Notion template
Open the **[TS PMO template](https://languid-stocking-b20.notion.site/TS-PMO-Template-38976356d6fe819789f6c1113a92e48a)** and click **Duplicate** to copy it into your
workspace. You now have a **🧰 TS PMO** container holding your 🎯 Efforts / 🧭 Work
Streams / ✅ Work Items databases, the 🎯 Efforts Board, the 📋 Todo boards, 🧠 Core
Context, 📓 Work Log, 📅 Daily Log, and the 📖 User Guide.

> Works on a **free Notion plan**. One caveat: the per-Effort boards `create` builds need a
> connector that can create views — if yours can't, board-building degrades gracefully and
> you add them by hand.

## 2. Connect Claude Code to Notion
Add the Notion connector / MCP so Claude can read and write your copy.

## 3. Install the skills
TS PMO is a set of **Agent Skills**, so it does **not** need the `/plugin` command —
which only works in the terminal CLI, not the Claude Code desktop app or web. Use
whichever path fits:

**Easiest — desktop app, web, or terminal; nothing to learn.** Paste this into Claude
Code and let it do the install:

> *Install the TS PMO skills: clone `https://github.com/chzylee/ts-pmo` (or download it)
> and copy everything inside its `plugins/ts-pmo/skills/` folder — the
> `_SHARED-PREAMBLE.md` file and every skill subfolder — into my `~/.claude/skills/`
> directory, creating it if it doesn't exist. Then list what you installed.*

Then **start a new chat** so the skills load. (Skills are read at the start of a
session.)

**Terminal (Claude Code CLI):**
```
claude plugin marketplace add chzylee/ts-pmo
claude plugin install ts-pmo@chzylee/ts-pmo
```
These run in any terminal, and the plugin then also appears in the desktop app (they
share `~/.claude`). Note: the **in-app `/plugin` slash command is CLI-only** — on the
desktop app or web, use the paste-in method above.

## 4. Wire the skills to YOUR template (one-time) — `ts-pmo-setup`
The skills read your workspace IDs from one config file, **`~/.claude/ts-pmo.local.md`**.
It doesn't exist yet — the setup skill writes it:

> **Say "set up ts-pmo".** The **`ts-pmo-setup`** skill finds your duplicated template
> through the Notion connector, matches each database, shows you the IDs it resolved, and
> (on your OK) writes them to `~/.claude/ts-pmo.local.md`. It **never edits the skill
> files**, so updating the skills later can't undo your wiring.

### Manual fallback
No connector, or prefer to do it by hand? Copy **`ts-pmo.local.example.md`** (in the repo)
to **`~/.claude/ts-pmo.local.md`** and fill in each ID. To find an ID: open the database
(or the Daily Log page) in Notion → **•••** → **Copy link**; the 32-char hex string in the
URL is its ID.

| logical name | Your template item |
|---|---|
| `efforts_ds` | 🎯 Efforts (database) |
| `streams_ds` | 🧭 Work Streams (database) |
| `items_ds` | ✅ Work Items (database) |
| `worklog_ds` | 📓 Work Log (database) |
| `core_context` | 🧠 Core Context (database) |
| `daily_log` | 📅 Daily Log — a **page**, not a DB (use its page ID) |

## 5. First run
- Say **"set up my direction"** → `set-direction` writes your Direction (the yardstick).
- Say **"create an effort"** → `create` stands up your first pursuit + its board.
- Then **"plan my day"**, work, and **"debrief this chat"** to log it.

That's the loop. See the **User Guide** inside your duplicated template for the daily +
weekly rhythm.
