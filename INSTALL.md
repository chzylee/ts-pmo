# Installing TS PMO

TS PMO has two halves — the **skills** (Claude Code) and a **Notion template** — plus a
one-time **repoint** that connects them. ~10 minutes.

## 1. Duplicate the Notion template
Open **`<TEMPLATE_DUPLICATE_LINK>`** and click **Duplicate** to copy it into your
workspace. You now have a **🧰 TS PMO** container holding your 🎯 Efforts / 🧭 Work
Streams / ✅ Work Items databases, the 🎯 Efforts Board, the 📋 Todo boards, 🧠 Core
Context, 📓 Work Log, 📅 Daily Log, ⚡ Leverage Board, and the 📖 User Guide.

## 2. Connect Claude Code to Notion
Add the Notion connector / MCP so Claude can read and write your copy.

## 3. Install the skills
```
/plugin marketplace add chzylee/ts-pmo
/plugin install ts-pmo
```
Or, drop-in: copy `plugins/ts-pmo/skills/*` into `~/.claude/skills/` (this also brings
`_SHARED-PREAMBLE.md`, which the skills read).

## 4. Repoint the skills to YOUR template (one-time)
The skills ship with **placeholder IDs** like `{{EFFORTS_DS_ID}}`. Replace each with the
real data-source ID from your duplicated template.

**Find an ID:** open a database as a full page in Notion → **•••** → **Copy link**. The
32-character hex string in the URL is the database ID — use it for that database's
placeholder. (These are single-source databases, so the database ID is what the skills
need.)

Replace every placeholder below in **`plugins/ts-pmo/skills/_SHARED-PREAMBLE.md`** *and*
in each skill's `Targets:` block (a find-and-replace across `plugins/ts-pmo/skills/` does
it):

| Placeholder | Your database |
|---|---|
| `{{EFFORTS_DS_ID}}` | 🎯 Efforts |
| `{{WORK_STREAMS_DS_ID}}` | 🧭 Work Streams |
| `{{WORK_ITEMS_DS_ID}}` | ✅ Work Items |
| `{{WORK_LOG_DS_ID}}` | 📓 Work Log |
| `{{DAILY_LOG_PAGE_ID}}` | 📅 Daily Log — a **page**, not a DB (use its page ID) |
| `{{CORE_CONTEXT_DS_ID}}` | 🧠 Core Context |
| `{{LEVERAGE_BOARD_DS_ID}}` | ⚡ Leverage Board |

> Roadmap: an **`npx ts-pmo init`** wizard will do this repoint for you (paste your
> template's IDs once, it rewrites the files).

## 5. First run
- Say **"set up my direction"** → `init-direction` writes your Direction (the yardstick).
- Say **"create an effort"** → `create` stands up your first pursuit + its board.
- Then **"plan my day"**, work, and **"debrief this chat"** to log it.

That's the loop. See the **User Guide** inside your duplicated template for the daily +
weekly rhythm.
