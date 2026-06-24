---
name: debrief
description: Log Claude work into Notion and move the board — one chat, or a whole time window. Extract title/summary/key-decisions/next-actions, match to the Effort(s), upsert a Work Log row keyed by Source URL (set Kind + Effort relation), refresh a human-readable dated Daily Log page, propose flipping finished Work Items to Done, and surface new next-actions as Work Items (hand to create). Scopes to a time window — a day, yesterday, the past week, or a date range — and backfills idempotently: re-running never duplicates. "--close" mode adds an end-of-day board-hygiene pass. Use on "debrief this chat", "debrief today", "debrief yesterday", "debrief the past day", "debrief the past week", "close out my day", "log to Notion".
---

# Debrief → Notion (3-tier model)

> Inherits **[`_SHARED-PREAMBLE.md`](../_SHARED-PREAMBLE.md)** — User Sovereignty · canonical IDs · field semantics (priority cascade, impact locality, status ladders).

Targets:
- efforts_ds   {{EFFORTS_DS_ID}}   (🎯 Efforts)
- streams_ds   {{WORK_STREAMS_DS_ID}}   (🧭 Work Streams)
- items_ds     {{WORK_ITEMS_DS_ID}}   (✅ Work Items)
- worklog_ds   {{WORK_LOG_DS_ID}}   (📓 Work Log)
- daily_log    {{DAILY_LOG_PAGE_ID}}   (📅 Daily Log — a **page** with one dated child page per day, not a DB)

Model: **Effort → Work Stream (optional) → Work Item.** The Work Log relates to an **Effort** (and optionally a **Work Item**). There is no Map and no Todos database anymore.

Convention: **User Sovereignty** — recommend, then confirm before any write or status change. Always set **Kind** + the **Effort** relation on Work Log rows.

## Procedure
1. SCOPE — resolve the time window first:
   - **"this chat"** → the current conversation only.
   - **"today" / "close out my day"** → today.
   - **"yesterday" / "the past day"** → the previous day.
   - **"this week" / "the past week"** → the last 7 days (ask only if the user clearly means a calendar week).
   - **"the past N days" / a date or date range** → that exact window.
   Beyond the current chat, use `recent_chats` (or whatever conversation history is available) to gather every Claude conversation with work in the window, and run the steps below on each. List the **days in scope** — you'll refresh one Daily Log page per day. Every write is idempotent (see Idempotency), so re-running an overlapping or repeated window is always safe: it backfills and refreshes in place, never duplicates.
2. EXTRACT, per chat: short title, 2–3 sentence summary, key decisions, the single most concrete next action (+ any other discrete actions).
3. MATCH to Effort(s) in efforts_ds (by name; a chat can touch more than one). If durable work has no Effort, propose creating one (hand to `create`).
4. WORK LOG upsert (idempotent on **Source URL**): find a row with this Source URL → update; else create with Title, Date=today, Summary, Key decisions, Next actions, Source URL, **Surface** (Claude Code vs Claude chat), **Kind**, the **Effort** relation, and the **Work Item** relation if the work maps to one.
5. DAILY LOG upsert (the human, date-organized view). For each day in scope, find or create a page under the 📅 **Daily Log** titled `YYYY-MM-DD · Weekday`, and write/refresh a readable brief synthesizing that day's work: **What I did · Where I left off · Pick up here · Decisions · Sources**. Idempotent on the date — re-running a day updates its page, never duplicates. When backfilling a past window, rebuild each day's brief from that day's Work Log rows so the by-date view stays complete even for days with no fresh chat. Same work the Work Log holds, organized by **date** instead of by **task**.
6. COMPLETE (the merge): if a Work Item was finished this session, propose flipping its Status (To do/Doing → **Done**). Apply on confirm.
7. NEW ACTIONS: surface discrete next actions as candidate Work Items and hand them to `create` — do not create malformed rows here.
8. REPORT what was created/updated, with links; call out any Work Items moved to Done.

## --close mode ("close out my day")
After the debrief, run a board-hygiene pass over Work Items: orphans (no Effort), items stuck in Doing, missing Priority/Acceptance criteria, `3h+` items that should be split. Surface them, then summarize the day. Read-mostly; ask before fixing.

## Idempotency
Source URL is the Work Log dedup key — re-running updates, never duplicates. Effort write-backs are single-field overwrites, safe to re-run. Works the same from chat or Claude Code (set Surface accordingly).

**Time-window debriefs are fully idempotent.** Each chat maps to one Work Log row (by Source URL) and each day to one Daily Log page (by date), so "debrief the past week" can be run repeatedly — daily *and* as an after-the-fact backfill — and only ever updates the existing rows/pages. Overlapping windows never create duplicates.
