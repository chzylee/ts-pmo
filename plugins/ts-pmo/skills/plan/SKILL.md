---
name: plan
description: Plan a realistic day or week from your open work. Computes effective priority via the parent cascade, fits the load to your available time, makes you cut scope when over-committed, and tags the chosen Work Items so the Today / This week boards populate — a starting point you refactor, not an autopilot. Triggers on "plan my day", "plan my week", "what should I do today", "plan".
---

# Plan → a realistic day or week

> Inherits **[`_SHARED-PREAMBLE.md`](../_SHARED-PREAMBLE.md)** — User Sovereignty · canonical IDs · field semantics (priority cascade, impact locality, status ladders).

**Your task:** produce a feasible, priority-aligned plan for the requested horizon and
stage it on the boards so the user can start working — and refactor it — immediately.
Gather what you need (chiefly: available time for a day) to make it realistic. The plan
is a *starting point*, not a verdict; the user owns the final shape.

Targets:
- efforts_ds   {{EFFORTS_DS_ID}}   (🎯 Efforts)
- streams_ds   {{WORK_STREAMS_DS_ID}}   (🧭 Work Streams)
- items_ds     {{WORK_ITEMS_DS_ID}}   (✅ Work Items) — uses the **Plan** select (Today / This week)
- worklog_ds   {{WORK_LOG_DS_ID}}   (📓 Work Log)
- core_context {{CORE_CONTEXT_DS_ID}}   (🧠 Core Context → Direction)

## Horizon
"plan my day" → **Day** (Plan tag = `Today`). "plan my week" → **Week** (Plan tag =
`This week`). Ask which only if unclear. (2-week sprints are a later extension.)

## Procedure
1. **Context.** Read Direction (priorities, parked Efforts, capacity, push-style);
   Efforts (Priority + Status — for the cascade); open Work Items (Status To do/Doing)
   with Priority, Impact, Commitment, Due, Effort key, and current Plan tag.
2. **Effective priority.** For each open item, walk the parent chain (Item → Stream? →
   Effort) and cap its priority by its ancestors'. An item under a parked / On-hold /
   low-priority Effort is effectively low — don't surface it, even if its own
   Priority/Impact is high.
3. **Size the horizon.**
   - **Day:** ask *"How many focused hours today?"* (default to the Direction capacity
     if the user defers). Sum Commitment (`≤1h`≈1, `1-3h`≈2, `3h+`≈3) against it.
   - **Week:** infer a realistic week's load from the Direction capacity × workdays and
     the open backlog (calendar integration is a later extension). Don't pack it full —
     leave slack.
4. **Select.** Rank candidates by effective priority, then Due proximity, then Impact.
   Pull a set that fits the horizon. If the must-do set exceeds the time, **STOP and
   make the user cut scope** — show the over-commit and the trade-off. Never silently
   trim.
5. **Show the plan.** List the chosen items with Effort, Commitment, running total vs.
   capacity, and what you deferred and why. The user edits freely — this is their
   starting point.
6. **Stage it** (on confirm). **First list every item whose Plan tag this run would
   clear** — previously tagged for this horizon but not in the new plan — in the confirm
   step; some may be hand-set, so never empty a tag silently. On confirmation, clear
   those, then set the **Plan** tag on the chosen items (`Today` for a day, `This week`
   for a week) so the **📋 Todo** boards populate. Optionally flip chosen items to **Doing**.
7. **Log** (optional). Offer one Work Log row (Kind = Plan, Effort relation set)
   capturing the plan.

## Note
If the user keeps overriding the plan, the weak input is the Direction module or the
Priority/Impact/Commitment data — fix those, not this skill. The boards are a notebook,
not an autopilot: the user re-arranges Plan tags by hand any time.
