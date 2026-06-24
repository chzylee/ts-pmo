---
name: resync
description: One-screen re-entry on a single Effort — what it is, recent work, open items, next action. Use on "resync me on <effort>", "where did I leave off on <effort>", "step back into <effort>".
---

# Resync → re-enter one Effort

> Inherits **[`_SHARED-PREAMBLE.md`](../_SHARED-PREAMBLE.md)** — User Sovereignty · canonical IDs · field semantics (priority cascade, impact locality, status ladders).

Targets:
- efforts_ds   {{EFFORTS_DS_ID}}   (🎯 Efforts)
- items_ds     {{WORK_ITEMS_DS_ID}}   (✅ Work Items)
- worklog_ds   {{WORK_LOG_DS_ID}}   (📓 Work Log)

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
