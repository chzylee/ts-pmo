---
name: init-direction
description: Interview the user about their priorities and what productive use of time means to them, then write the Direction module to Core Context. The foundational yardstick every accountability skill reads. Run first when setting up; re-run to refresh. Use on "set up my direction", "define my priorities", "refresh my direction".
---

# Init Direction → the yardstick

> Inherits **[`_SHARED-PREAMBLE.md`](../_SHARED-PREAMBLE.md)** — User Sovereignty · canonical IDs · field semantics (priority cascade, impact locality, status ladders).

Targets:
- efforts_ds   {{EFFORTS_DS_ID}}   (🎯 Efforts)
- items_ds     {{WORK_ITEMS_DS_ID}}   (✅ Work Items — for the Todo boards)
- core_context {{CORE_CONTEXT_DS_ID}}   (🧠 Core Context)

Convention: **User Sovereignty** — draft, show, edit until approved, then write. This is the analog of an injected builder profile: short, high-signal, read on every skill run.

## Procedure
1. CONTEXT. Check Core Context for an existing Direction module (refresh, don't duplicate). Read current Efforts (the top-level entities — JIRA-style Epics) for grounding.
2. FORCING INTERVIEW (walk every question, one at a time):
   1. **Efforts** — your current top-level pursuits (each one an Effort/Epic)? List and confirm them.
   2. **Ranking** — rank your Efforts by priority now. The clear #1? Which are deliberately parked?
   3. **North star** — one sentence: what are you moving toward this season?
   4. **Definition of productive** — what counts as productive time *for you*; what doesn't?
   5. **Trade-offs** — what are you intentionally saying no to right now? (This is what lets the audit tell parked from neglected.)
   6. **Capacity** — typical focused hours/day for this work? (Feeds `plan`.)
   7. **Accountability style** — where to push, where to leave you alone?
3. DRAFT + CONFIRM. Draft the module; present; edit until approved.
4. WRITE. Upsert a Core Context page (Category = Direction) with sections: `## Efforts & ranking`, `## North star`, `## What productive means`, `## Deliberate trade-offs (parked)`, `## Capacity`, `## How to push me`. Keep it short.
5. PLACEMENT (first-time setup only). Ask where the user wants their TS PMO views to live — a single **🧰 container page** (recommended: they can drag it anywhere and the whole system moves with it) or directly top-level. Then ensure the overall boards exist there, creating them with `create-view` if missing:
   - **🎯 Efforts Board** — board of efforts_ds, GROUP BY Priority (drag an Effort between columns to reprioritize).
   - **📋 Todo** — items_ds: a *Today* board (FILTER Plan = "Today") and a *This week* board (FILTER Plan is not empty), the home `plan` populates.
   This location is also the **default home for per-Effort boards** that `create` builds. Skip if the user already has these (e.g. from the duplicated template).
