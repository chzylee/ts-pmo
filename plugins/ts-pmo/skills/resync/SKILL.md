---
name: resync
description: Pick one Effort back up after time away. Gives a one-screen catch-up — what the Effort is, what you did recently, what's still open, and the single next action — so you can dive back in without digging through Notion. Use on "resync me on <Effort>", "where did I leave off on <Effort>", "catch me up on <Effort>".
---

# Resync → re-enter one Effort

> Inherits **[`_SHARED-PREAMBLE.md`](../_SHARED-PREAMBLE.md)** — User Sovereignty · workspace IDs · field semantics (priority cascade, impact locality, status ladders).

Targets:
- efforts_ds   (🎯 Efforts)
- streams_ds   (🧭 Work Streams)
- items_ds     (✅ Work Items)
- worklog_ds   (📓 Work Log)

Convention: **User Sovereignty** — read-only; offer to update Next action only on confirmation.

## Procedure
1. MATCH the named Effort in efforts_ds (ask if ambiguous).
2. READ: the Effort row (Priority, Status, Next action, body) + its open Work Items (Status != Done, with Priority/Impact/Commitment) + recent Work Log entries tagged to it.
3. OUTPUT one screen:
   - **WHAT** — one line on the Effort.
   - **STATE** — Status + effective priority (note if the Effort itself is parked).
   - **RECENTLY** — last few Work Log entries.
   - **OPEN** — top open Work Items by effective priority, with commitment.
   - **NEXT** — the single next action.
4. OFFER to update the Effort's Next action — only on confirmation.
