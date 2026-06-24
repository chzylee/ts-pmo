# Installing TS PMO

TS PMO has two halves — the **skills** (Claude Code) and a **Notion template** — plus a
one-time **repoint** that connects them. ~10 minutes.

## 1. Duplicate the Notion template
Open the **[TS PMO template](https://languid-stocking-b20.notion.site/TS-PMO-Template-38976356d6fe819789f6c1113a92e48a)** and click **Duplicate** to copy it into your
workspace. You now have a **🧰 TS PMO** container holding your 🎯 Efforts / 🧭 Work
Streams / ✅ Work Items databases, the 🎯 Efforts Board, the 📋 Todo boards, 🧠 Core
Context, 📓 Work Log, 📅 Daily Log, and the 📖 User Guide.

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
The skills ship with **placeholder IDs** like `{{EFFORTS_DS_ID}}`; they need your copy's
real IDs before they can read or write Notion. Let the setup skill do it:

> **Say "set up ts-pmo".** The **`ts-pmo-setup`** skill finds your duplicated template
> through the Notion connector, matches each database, shows you the IDs it resolved, and
> (on your OK) writes them into `_SHARED-PREAMBLE.md` and every skill's `Targets:` block.
> If it can't auto-detect, it walks you through a manual repoint — you can even paste the
> IDs and let it do the file edits.

### Manual fallback
If you'd rather do it by hand (or the connector isn't available): open each database (or
the Daily Log page) as a full page in Notion → **•••** → **Copy link**; the 32-char hex
string in the URL is that item's ID. Replace every placeholder below in
**`plugins/ts-pmo/skills/_SHARED-PREAMBLE.md`** *and* each skill's `Targets:` block:

| Placeholder | Your template item |
|---|---|
| `{{EFFORTS_DS_ID}}` | 🎯 Efforts (database) |
| `{{WORK_STREAMS_DS_ID}}` | 🧭 Work Streams (database) |
| `{{WORK_ITEMS_DS_ID}}` | ✅ Work Items (database) |
| `{{WORK_LOG_DS_ID}}` | 📓 Work Log (database) |
| `{{DAILY_LOG_PAGE_ID}}` | 📅 Daily Log — a **page**, not a DB (use its page ID) |
| `{{CORE_CONTEXT_DS_ID}}` | 🧠 Core Context (database) |

## 5. First run
- Say **"set up my direction"** → `set-direction` writes your Direction (the yardstick).
- Say **"create an effort"** → `create` stands up your first pursuit + its board.
- Then **"plan my day"**, work, and **"debrief this chat"** to log it.

That's the loop. See the **User Guide** inside your duplicated template for the daily +
weekly rhythm.
