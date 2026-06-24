---
name: work-review
description: Review your work — from a quick task-set hygiene scan to a full accountability audit. Asks the depth up front, then checks whether your active work is clean (high-impact/priority items surfaced, nothing stale or orphaned) and, at depth, what's neglected vs. deliberately parked, where time actually went, and whether it matches your Direction. Triggers on "review my work", "review my week", "work review", "audit my work", "what am I neglecting", "is my task list clean".
---

# Work-review → is your work clean and on-target

> Inherits **[`_SHARED-PREAMBLE.md`](../_SHARED-PREAMBLE.md)** — User Sovereignty · canonical IDs · field semantics (priority cascade, impact locality, status ladders).

**Your task:** give the user an honest read on the state of their work at the depth
they ask for — surface what needs attention, tie every claim to evidence, separate
observation from interpretation, and let them rule on any change. Read-only unless the
user confirms a fix.

Targets:
- efforts_ds   {{EFFORTS_DS_ID}}   (🎯 Efforts)
- streams_ds   {{WORK_STREAMS_DS_ID}}   (🧭 Work Streams)
- items_ds     {{WORK_ITEMS_DS_ID}}   (✅ Work Items)
- worklog_ds   {{WORK_LOG_DS_ID}}   (📓 Work Log)
- core_context {{CORE_CONTEXT_DS_ID}}   (🧠 Core Context → Direction)

## Step 0 — Ask the depth (always, first)
- **Quick** — a hygiene scan of the *current* task set (fast, no history).
- **Full** — the quick scan **plus** the accountability audit and a time-distribution
  review over a window (default last 7 days; accept "month").
Default to **Quick** if the user just says "review."

## Quick — task-set hygiene (focus: high impact / priority)
Read open Work Items + their Efforts; apply the cascade. Flag:
- **Buried priorities** — high effective-priority / high-Impact items still in To do
  under an Active Effort.
- **Stale Doing** — items stuck in Doing.
- **Orphans + malformed** — no Effort; missing Priority / Acceptance criteria; `3h+`
  not split.
- **Effort-key drift** — Effort relation set but Effort key blank or mismatched (e.g. after an Effort was **renamed**: the relation follows, the key select does not). Offer to re-stamp the key and rename the stale select option.
Present the shortlist; offer to fix on confirm. Nothing else.

## Full — adds the audit + distribution
1. **Parked vs neglected.** For every high-Impact item/stream untouched too long, check
   its parent: parent parked/On-hold → **parked** (intended; at most a low-frequency
   "still parked?"). Parent Active/high-priority yet child untouched → **neglected**
   (raise it).
2. **Direction drift.** Compare the Work Log's recent distribution (by Effort) to the
   Direction ranking. Name mismatches with evidence — a #1 Effort getting little time
   (starved), a parked Effort quietly eating time (shadow). Give two honest resolutions
   each: change the work, or change the claim (update Direction).
3. **Distribution.** Over the window: Kind mix (Build/Write/Plan/Stream/Event/Admin),
   Effort distribution, cadence (active days, longest streak, gaps), vs. the previous
   window. Lead with counts/dates; mark interpretation as separate from data.
4. **Ball in their court.** For each flag, the user rules: fix now / re-park (record
   it) / re-prioritize. Respect a snoozed state so the same item isn't re-litigated
   next run.

## Write rule
Apply only confirmed changes (item Priority/Status/Plan, or the Direction module).
Optionally log the review (Kind = Admin).
