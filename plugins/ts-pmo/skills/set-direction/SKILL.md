---
name: set-direction
description: Interview the user about their priorities and what productive use of time means to them, then write the Direction module to Core Context — the foundational yardstick every accountability skill reads. Run first when setting up; re-run to **refresh** — on a refresh it diffs the stored Direction against your current Efforts and recent work and asks only about what's drifted. Use on "set up my direction", "define my priorities", "refresh my direction", "re-sync my direction", "is my direction still right".
---

# Set Direction → the yardstick

> Inherits **[`_SHARED-PREAMBLE.md`](../_SHARED-PREAMBLE.md)** — User Sovereignty · workspace IDs · field semantics (priority cascade, impact locality, status ladders).

Targets:
- efforts_ds   (🎯 Efforts)
- items_ds     (✅ Work Items — for the Todo boards)
- core_context (🧠 Core Context)

Convention: **User Sovereignty** — draft, show, edit until approved, then write. This is the analog of an injected builder profile: short, high-signal, read on every skill run.

## Procedure
1. CONTEXT + MODE. Check Core Context for an existing Direction module, and read the current Efforts (names, Priority, Status) plus the recent Work Log distribution by Effort for grounding.
   - **No Direction yet → FIRST RUN:** do the full forcing interview (step 2).
   - **Direction exists → REFRESH (diff mode):** don't re-interview from scratch. Compute where the stored Direction has **drifted** from reality — Efforts added / removed / re-ranked, the stated #1 vs. where time actually went, Shipped/Archived Efforts it still treats as live, and anything the user said this session that conflicts with it. Show that diff, then ask targeted questions **only on the drifted parts** and propose the updates.
2. FORCING INTERVIEW (first run — walk every question; for a refresh, ask only the drifted questions from step 1):
   1. **Efforts** — your current top-level pursuits (each one an Effort/Epic)? List and confirm them.
   2. **Ranking** — rank your Efforts by priority now. The clear #1? Which are deliberately parked?
   3. **North star** — one sentence: what are you moving toward this season?
   4. **Definition of productive** — what counts as productive time *for you*; what doesn't?
   5. **Trade-offs** — what are you intentionally saying no to right now? (This is what lets the audit tell parked from neglected.)
   6. **Capacity** — typical focused hours/day for this work? (Feeds `plan`.)
   7. **Accountability style** — where to push, where to leave you alone?
3. DRAFT + CONFIRM. Draft the module; present; edit until approved.
4. WRITE. Upsert the Core Context Direction page (Category = Direction) with sections: `## Efforts & ranking`, `## North star`, `## What productive means`, `## Deliberate trade-offs (parked)`, `## Capacity`, `## How to push me`. Keep it short. Also maintain the **drift-watch state** the preamble relies on: a `Last nudged:` line (the accountability skills stamp it — leave it intact) and a `## Shifts` log. On any refresh that actually changes the Direction, append one dated line summarizing what changed and keep the last ~5. **If that log shows frequent reshaping (≈3+ in a few weeks), reflect it back before writing** — is the direction settling, or churning? — rather than silently recording another flip.
5. PLACEMENT (first-time setup only). Ask where the user wants their TS PMO views to live — a single **🧰 container page** (recommended: they can drag it anywhere and the whole system moves with it) or directly top-level. Then ensure the overall boards exist there, creating them with `create-view` if missing:
   - **🎯 Efforts Board** — board of efforts_ds, GROUP BY Priority (drag an Effort between columns to reprioritize).
   - **📋 Todo** — items_ds: a *Today* board (FILTER Plan = "Today") and a *This week* board (FILTER Plan is not empty), the home `plan` populates.
   This location is also the **default home for per-Effort boards** that `create` builds. Skip if the user already has these (e.g. from the duplicated template).
