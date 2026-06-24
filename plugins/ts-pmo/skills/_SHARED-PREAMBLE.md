# Shared preamble — TS PMO core skill suite

The six core skills — `set-direction`, `create`, `plan`, `work-review`, `debrief`,
`resync` — inherit this. Each SKILL.md restates the IDs it needs in its own
`Targets:` block so it stays self-contained at runtime; this file is the single
source of truth for the IDs, the working conventions, and the field semantics.
When a skill and this file disagree, this file wins — update both.

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

## Canonical data-source IDs
> **⚠️ First-run setup:** these are placeholders. Run the **`ts-pmo-setup`** skill once
> (say *"set up ts-pmo"*) to fill them with **your** template's real IDs automatically —
> or repoint by hand via `INSTALL.md`. The skills can't read or write your workspace
> until this is done.

| Store | data-source ID |
|---|---|
| 🎯 Efforts | `{{EFFORTS_DS_ID}}` |
| 🧭 Work Streams | `{{WORK_STREAMS_DS_ID}}` |
| ✅ Work Items | `{{WORK_ITEMS_DS_ID}}` |
| 📓 Work Log | `{{WORK_LOG_DS_ID}}` |
| 📅 Daily Log *(a page, not a DB)* | `{{DAILY_LOG_PAGE_ID}}` |
| 🧠 Core Context | `{{CORE_CONTEXT_DS_ID}}` |

The same IDs appear in each skill's `Targets:` block — repoint them there too.

## Before you run — IDs must be wired
Every skill's `Targets:` must hold real IDs. **If any Target still contains `{{…}}`, the
skills aren't pointed at a workspace yet — stop and route the user to `ts-pmo-setup`**
(say *"set up ts-pmo"*). Never use a `{{…}}` placeholder as a Notion ID. (`ts-pmo-setup`
is the one skill that intentionally runs with placeholders present — it's what fills
them.)

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
contradicts the ranking — `work-review` audits this deeply), or **stated** (the user says
something this session that conflicts with the stored Direction).

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
