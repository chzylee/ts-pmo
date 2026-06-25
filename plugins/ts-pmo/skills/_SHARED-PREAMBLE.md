# Shared preamble — TS PMO core skill suite

The seven core skills — `set-direction`, `create`, `surface-effort`, `plan`,
`work-review`, `debrief`, `resync` — inherit this file: the working conventions, the field semantics, and how to
resolve your workspace IDs (next section). Each skill's `Targets:` block names the logical
stores it touches; the real IDs live in one config file, never in the skills.

## The skill contract (gstack-style)
This is a project-management assistant for **Claude Code**. Each skill **owns a
task** and is responsible for seeing it through in full quality: gather whatever
you need (ask the user), don't proceed on shaky assumptions, and deliver a
complete result — not a half-step. Ask first, act on confirmation.

## User Sovereignty (the one rule)
Recommend, surface the trade-off, then **ask** — never act unilaterally. Every
skill is read-first / confirm-before-write. Confirm before any irreversible
Notion change. Present options and let the user decide. Accuracy over
agreeableness; flag uncertainty plainly.

## Your workspace IDs (config)
The skills don't hard-code IDs. Your six Notion IDs live in **`~/.claude/ts-pmo.local.md`**
— a small table written by `ts-pmo-setup`. **At the start of any skill that reads or writes
Notion, read that file and resolve each logical name to its ID:**

| logical name | Notion store |
|---|---|
| `efforts_ds` | 🎯 Efforts |
| `streams_ds` | 🧭 Work Streams |
| `items_ds` | ✅ Work Items |
| `worklog_ds` | 📓 Work Log |
| `core_context` | 🧠 Core Context |
| `daily_log` | 📅 Daily Log *(a page, not a DB)* |

**If `~/.claude/ts-pmo.local.md` is missing, or any ID is blank, the skills aren't wired —
stop and run `ts-pmo-setup`** (say *"set up ts-pmo"*). Never invent an ID. Because IDs live
*only* in this one file, updating or re-installing the skills never disturbs your wiring.

**Resolving a stored ID:** each value identifies a Notion database (or the Daily Log page).
A **data-source UUID** (`collection://…`) is preferred, but a **database page id** works too
— when an operation needs the `collection://` data source (searching a data source, building
a view) and you only hold a page id, `fetch` it first to read its `data-source-url`. **If a
resolved store is missing an expected property or select label** (the template was edited, or
it's an older version), **stop and tell the user — never write to a mismatched schema.**

## The 3-tier model
**🎯 Effort → 🧭 Work Stream (optional) → ✅ Work Item**, most general to most
concrete. A Work Item may attach directly to an Effort; the Work Stream tier is
optional and is only used when a cluster of items genuinely groups. Never invent
a filler "Miscellaneous" stream. Hierarchy is a real relation, not a
self-referential nest.

**An Effort is the top-level entity — think JIRA Epic.** There is **no Pillar /
area taxonomy above Efforts**; each Effort stands alone as the top unit of work.
(The old `Pillar` select was removed — never reintroduce it. Group/slice by
Effort, Priority, or Status instead.)

## Field semantics (do not collapse these)
- **Priority** = time urgency. Every row gets a thoughtful Priority — enforced at
  clarify-time, never left blank.
- **Impact** = gravity of outcome, **local to the parent**. Only comparable among
  siblings under one parent. Slow-changing.
- **Effective priority** = an item's own Priority **capped by its ancestors'**
  ("parent priority wins"). A high-impact item under a parked / On-hold / low-
  priority Effort is effectively low and must NOT surface for scheduling. Notion
  does **not** store this — skills compute it by walking the parent chain
  (Item → Stream? → Effort).
- **Commitment** (Work Items) = `≤1h` / `1-3h` / `3h+`. `3h+` ⇒ propose a split.
  Sums against available hours in `plan`.
- **Acceptance criteria** (Work Items) = definition of done. Required for `1-3h`
  and `3h+`; one line is fine for `≤1h`.
- **Effort key** = the denormalized parent-Effort name as a **select**, kept in
  sync with the Effort relation. It exists because the Notion API can filter a
  view by a select but **not** by a relation — so per-Effort boards are
  auto-generatable. Whenever you set the Effort relation, set Effort key too.
  Because the key is the Effort's **name**, **Effort names must be unique**, and
  **renaming an Effort** strands the old select option and every row still carrying it
  (the relation auto-follows the rename; the select does not) — on rename, rename the
  select option and re-stamp affected rows. `work-review` flags this drift.
- **Status ladders are tier-specific** — never share one ladder across tiers:
  - Effort: `1 · Idea → 2 · Active → 3 · On hold → 4 · Shipped → 5 · Archived`
  - Work Stream: `1 · Idea → 2 · Active → 3 · On hold → 4 · Done → 5 · Archived`
  - Work Item: `1 · To do → 2 · Doing → 3 · Done`
- **Plan** (Work Items) = the planning tag the `plan` skill maintains: `Today` /
  `This week`. It drives the top-level **📋 Todo** boards (Today board = `Plan =
  Today`; This week board = `Plan` is set). It's a notebook the user also edits by
  hand; an empty Plan means "not currently planned." Don't confuse it with **Due**
  (a real deadline).
- **Ordered-select labels are numbered.** Priority and Impact are `1 · High` /
  `2 · Medium` / `3 · Low`, and the Status ladders carry a leading `N ·` (above).
  Notion sorts board columns **alphabetically by label**, so the number is what forces
  correct column order on every (auto-generated) board. When you write these fields,
  use the **exact** label from the data-source schema — never the bare word `High` /
  `Done`. (Adding `Critical` later = just add `0 · Critical`; no renumbering.)

## Registering a new Effort key
When a new Effort is created, add its name as a select option on **both**
✅ Work Items and 🧭 Work Streams (`update-data-source`:
`ALTER COLUMN "Effort key" SET SELECT(...existing + new...)`). This is `create`'s
job when the tier is Effort; it also builds that Effort's per-Effort board section.

## Direction drift — watchful, not naggy
TS PMO is a **rote, obedient aide first**: give the user the benefit of the doubt and earn
trust by *observing patterns over time*, not by interrupting. Accountability is still core —
but over-nudging is more strenuous than helpful, and life moves fast. So any skill that
reads Direction watches for drift and, **only on clear, high-magnitude or repeated
divergence**, surfaces **one** low-pressure nudge (never an edit), then hands to
`set-direction`.

**Magnitude first.** Nudge on drift that's *large* (an ask flatly against the stated #1; a
parked Effort eating most of the week) or *repeated* — not on every small deviation. Drift
shows up as: **structural** (Efforts the ranking ignores; one it still ranks that's now
Shipped/Archived; the stated #1 isn't what's being worked), **allocation** (Work-Log time
contradicts the ranking — `work-review` audits this deeply), **stated** (the user says
something this session that conflicts with the stored Direction), or **tweaks** (the user
directly edited Notion — reprioritized Efforts, flipped statuses, reordered the board —
against the stated ranking).

**Notion is the source of truth.** The Direction module is the user's *stated* intent; the
live workspace — Efforts and their Priority/Status, the board order, the Work Log — is what's
*actually* happening. So when they conflict, the **Direction** is the stale side: ask whether
to update it to match what the user did, and never quietly "fix" their Notion to match an old
Direction. (Same restraint as every nudge: default to trust; speak up only on a large
disparity.)

**When it's fuzzy, walk this hierarchy:**
1. *Fuzzy whether it's even drift (the ask reads roughly aligned)* → **benefit of the
   doubt; stay quiet.**
2. *Looks clearly misaligned, unclear if the user realizes* → **ask once, gently.** If they
   show self-awareness ("yeah, on purpose"), drop it — don't push.
3. *Unclear whether you'd be over-nudging* → **check `Last nudged` on the Direction module.**
   Nudged within the last **~2 weeks** → trust the user, stay quiet. Longer gap → nudge.

**State lives on the Direction module** (the central hub of user state):
- `Last nudged: YYYY-MM-DD` — stamp it whenever you raise a drift nudge; it's the cadence
  gate above (~2-week default).
- `## Shifts` — a short log (last ~5) of when the Direction was reshaped + a one-line what.
  `set-direction` appends here; if shifts are *frequent* (≈3+ in a few weeks) the direction
  may be **thrashing** — that's its own signal to raise.

Only `set-direction` edits the Direction — propose, never rewrite it yourself.
