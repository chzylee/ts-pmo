---
name: debrief
description: Log your work into Notion and move the board — pulling from the current chat, your git commits, and a capture inbox; one session or a whole time window. Extract title/summary/key-decisions/next-actions, match to the Effort(s), upsert a Work Log row keyed by Source URL (set Kind + Effort relation), refresh a human-readable dated Daily Log page, propose flipping finished Work Items to Done, and surface new next-actions as Work Items (hand to create). Scopes to a time window — a day, yesterday, the past week, or a date range — backfills idempotently (re-running never duplicates), and is explicit about what work it can and can't see. "--close" mode adds an end-of-day board-hygiene pass. Use on "debrief this chat", "debrief today", "debrief yesterday", "debrief the past day", "debrief the past week", "close out my day", "log to Notion".
---

# Debrief → Notion (3-tier model)

> Inherits **[`_SHARED-PREAMBLE.md`](../_SHARED-PREAMBLE.md)** — User Sovereignty · workspace IDs · field semantics (priority cascade, impact locality, status ladders).

Targets:
- efforts_ds   (🎯 Efforts)
- streams_ds   (🧭 Work Streams)
- items_ds     (✅ Work Items)
- worklog_ds   (📓 Work Log)
- daily_log    (📅 Daily Log — a **page** with one dated child page per day, not a DB)

Model: **Effort → Work Stream (optional) → Work Item.** The Work Log relates to an **Effort** (and optionally a **Work Item**). There is no Map and no Todos database anymore.

Convention: **User Sovereignty** — recommend, then confirm before any write or status change. Always set **Kind** + the **Effort** relation on Work Log rows.

## Procedure
1. SCOPE — resolve the time window first:
   - **"this chat"** → the current conversation only.
   - **"today" / "close out my day"** → today.
   - **"yesterday" / "the past day"** → the previous day.
   - **"this week" / "the past week"** → the last 7 days (ask only if the user clearly means a calendar week).
   - **"the past N days" / a date or date range** → that exact window.
   **Your capture sources — read all that apply, and say which you used.** Work reaches Notion through several feeders; debrief is the one consolidator:
   - **The current chat** — always; debrief it fully.
   - **Git** — for the window, `git log` across the working repo(s). Commits are durable, timestamped evidence, so **build work gets captured even from sessions you never debriefed.** Group a day's commits by Effort (by repo / keyword).
   - **The capture inbox** — `~/.claude/ts-pmo-inbox.md`: session stubs the capture hook leaves automatically (plus any `log this:` notes). Drain the unchecked (`- [ ]`) stubs and mark each `- [x]` once logged.
   - **The Notion Work Log** — what's already logged, for rebuilding past days' Daily Log pages.
   - **`recent_chats`** — only in the Claude **chat app**, not Claude Code.
   You **cannot** read the *content* of past Claude Code conversations directly — **git and the inbox are how that work still gets captured.** **Tell the user which sources you actually used**, so coverage is clear. List the **days in scope**. Every write is idempotent (see Idempotency) — re-running a window backfills and refreshes in place, never duplicates.
2. EXTRACT the work, per source: for a **chat**, a short title + 2–3 sentence summary + key decisions + the single most concrete next action (+ any other discrete actions). For **git**, summarize each day's commits per repo/Effort (what shipped, the arc — not a raw commit dump). For an **inbox stub**, expand it into its work (follow its git/transcript pointer if present). Each becomes one logged unit.
3. MATCH to Effort(s) in efforts_ds (by name; a chat can touch more than one). If durable work has no Effort, propose creating one (hand to `create`).
4. WORK LOG upsert (idempotent on **Source URL**). **Source URL** = the conversation's canonical link in the Claude **chat app**; in **Claude Code** (no URL) use a stable session identifier, and if neither exists fall back to matching on **Title + Date** — never write a row with an empty key, which would collide and break dedup. Find the row with this key → update; else create with Title, Date=today, Summary, Key decisions, Next actions, Source URL, **Surface** (Claude Code vs Claude chat), **Kind**, the **Effort** relation, and the **Work Item** relation if the work maps to one.
5. DAILY LOG upsert (the human, date-organized view). **For each day in scope that has visible work** — the current chat's day, or any day with Work Log rows — **create its page if missing and refresh it**: fetch the 📅 Daily Log page, enumerate its child pages, find the `YYYY-MM-DD · Weekday` page **or create it**, and write/refresh a readable brief synthesizing that day's Work Log rows: **What I did · Where I left off · Pick up here · Decisions · Sources**. **Creating the missing day-page is the job — never just report that a day has no page.** Idempotent on the date — re-running a day updates its page, never duplicates. For a day in the window with **no visible work at all** (no current chat, no Work Log rows), don't fabricate a page — record it for the report (step 8) as uncaptured, with the reason. Same work the Work Log holds, organized by **date** instead of by **task**.
6. COMPLETE (the merge): if a Work Item was **explicitly finished** this session — the user said so, or the chat shows its acceptance criteria met (merely discussing an item is not completion) — propose flipping its Status (To do/Doing → **Done**). Apply on confirm; when unsure, ask rather than assume.
7. NEW ACTIONS: surface discrete next actions as candidate Work Items and hand them to `create` — do not create malformed rows here.
8. REPORT coverage clearly: the **days you captured** (Daily Log pages created/updated, with links) and any Work Items moved to Done. **Separately, name any day in the window with no visible work**, say why (you can't read past chats from Claude Code), and give the remedy — debrief from that chat while it's open, or tell me what you did and I'll log it. Frame uncaptured days as a **visibility limit you're disclosing**, not a silent gap. Nudge the habit: debrief at the end of each working session, while the chat is still readable.

## --close mode ("close out my day")
After the debrief, run a board-hygiene pass over Work Items: orphans (no Effort), items stuck in Doing, missing Priority/Acceptance criteria, `3h+` items that should be split. Surface them, then summarize the day. Read-mostly; ask before fixing.

## Idempotency
Source URL is the Work Log dedup key — re-running updates, never duplicates. Effort write-backs are single-field overwrites, safe to re-run. Works the same from chat or Claude Code (set Surface accordingly).

**Time-window debriefs are fully idempotent.** Each chat maps to one Work Log row (by Source URL) and each day to one Daily Log page (by date), so "debrief the past week" can be run repeatedly — daily *and* as an after-the-fact backfill — and only ever updates the existing rows/pages. Overlapping windows never create duplicates. **Git-derived entries key on date + repo** (a day's commits for a repo log once); **inbox stubs are marked `- [x]` when drained** — so re-running never double-logs git or inbox work either.
