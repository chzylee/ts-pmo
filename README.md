# TS PMO

**Task Steward · Project Management Ops** — a project manager for Claude Code that runs inside your Notion.

You decide what matters and do the work. TS PMO does the clerical part: it files well-formed
tasks, plans a realistic day, logs what you actually did, and tells you when your week is
drifting from what you said mattered. It asks before it writes anything, so you stay in
charge of your own workspace.

And yes, TS PMO is also *this shit's pissing me off*. That's task admin. This is the fix.

<!-- TODO: drop a screenshot or short GIF of an Effort board here before going public -->

## What you get
Two halves that work as one:

- **A Claude Code skill suite** — seven skills you drive in plain language.
- **A Notion template** — where the work actually lives. **[Duplicate it →](https://languid-stocking-b20.notion.site/TS-PMO-Template-38976356d6fe819789f6c1113a92e48a)**

The idea that holds it together: your **Notion fields are the task's properties** (priority,
status, effort, estimate), and the **page body is the documentation** — what the thing is,
why it matters, how you're approaching it. Over time that becomes a record TS PMO reads back
to understand how you work.

## Get started (~10 minutes)
You'll need a **Notion** account and **Claude Code** with the Notion connector enabled. Run
it from the desktop app or the terminal — web/cloud sessions don't keep your install around.

1. **Duplicate the template** → **[open it here](https://languid-stocking-b20.notion.site/TS-PMO-Template-38976356d6fe819789f6c1113a92e48a)** and hit Duplicate.
2. **Connect Notion to Claude Code** (the Notion connector / MCP), if you haven't.
3. **Install the skills.** They're Agent Skills, so you don't need the `/plugin` command
   (which only works in the terminal anyway). Paste this into Claude Code:
   > Install the TS PMO skills: clone https://github.com/chzylee/ts-pmo and copy its `plugins/ts-pmo/skills/` contents into my `~/.claude/skills/` folder.

   Then start a new chat so they load. *(On the terminal you can instead run
   `claude plugin marketplace add chzylee/ts-pmo` then `claude plugin install ts-pmo@chzylee/ts-pmo`.)*
4. **Point it at your copy** — say **"set up ts-pmo"**. It finds your duplicated template,
   shows you the IDs it resolved, and writes them to one small config file. You don't edit anything.
5. **First run** — say **"set up my direction"**, then **"create an effort"** for each thing
   you're working on.

Full detail, including a fully manual setup, is in **[INSTALL.md](INSTALL.md)**.

## How you use it
Talk to Claude Code like a person. Each skill triggers on what you say, and confirms before it writes.

| Say | What happens |
|---|---|
| `set up my direction` | **set-direction** interviews you and writes your Direction — the yardstick everything else is judged against. |
| `create an effort` · `create a task` | **create** builds a fully-formed item (priority, impact, estimate, acceptance criteria) plus a starter description in its body, checked against your goals. |
| `create a page for my Career effort` | **surface-effort** gives an Effort its own page — boards for its work items and streams — wherever you want it (top-level, say). |
| `plan my day` · `plan my week` | **plan** builds a realistic plan, makes you cut scope when you're over-committed, and stages your Todo board. |
| `debrief this chat` | **debrief** logs what happened to your Work Log and a dated Daily Log, and moves the board. |
| `review my work` | **work-review** runs a quick hygiene scan or a full audit: what's neglected vs. deliberately parked, and where your time actually went. |
| `resync me on Career` | **resync** catches you back up on an Effort after time away. |

**The rhythm:** plan your day → work the board → debrief. Once a week, plan the week and run a review.

## The model
🎯 **Effort** (a top-level pursuit, like a JIRA epic) → 🧭 **Work Stream** (optional grouping)
→ ✅ **Work Item** (a task).

A few opinions are baked in:
- **Effective priority cascades.** A task can't be more urgent than the Effort it sits under,
  so a shiny task on a parked project doesn't jump the queue.
- **Impact is local.** It's compared against siblings under the same parent, not across your
  whole workspace.
- A **Plan** tag (Today / This week) drives your Todo boards, and select labels are numbered
  so the boards always sort right.

## The one rule
**You're sovereign over your workspace.** Every skill reads first and confirms before it
writes. It recommends, shows you the trade-off, and asks. It never acts on its own, and it
never quietly "fixes" your Notion to match a stale plan. The thing AI is worst at is knowing
what matters to *you* — TS PMO hands that part back, every time.

## What it won't do
- **Act on its own.** Every write is proposed and confirmed.
- **Delete things.** The Notion API here can't archive pages or rows, so cleanup is on you.
- **Replace your calendar or your tools.** It's a work ledger and planner in Notion, not a
  do-everything assistant.

## Updating & uninstalling
- **Update:** re-install the skills to pull the latest. Your IDs live in
  `~/.claude/ts-pmo.local.md`, which updates never touch — so there's no re-setup, and your
  Notion data is never touched.
- **Uninstall:** delete the TS PMO skill folders and `_SHARED-PREAMBLE.md` from
  `~/.claude/skills/` (and `~/.claude/ts-pmo.local.md`). Your Notion stays yours.

## If something's off
- **"It can't find my databases" / a skill isn't wired** → run **`set up ts-pmo`** (your
  config got wiped or was never written).
- **`/plugin is not available`** → you're on the desktop app or web. Use the paste-in install
  above, then start a new chat.
- **Skills don't show up after installing** → start a new chat; they load when a session begins.
- **A board didn't build** → your Notion connector may not allow creating views; the skill
  prints the exact filter so you can add it by hand.

## Built in public
I built TS PMO to run my own work — a job hunt, a daily DSA grind, this repo itself — and I'm
building it in the open. It's early. It's **free and MIT-licensed**: use it, fork it, and tell
me where it breaks.

Repo + marketplace: `chzylee/ts-pmo`.

## License
[MIT](LICENSE).
