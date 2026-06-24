---
name: ts-pmo-setup
description: First-run setup for TS PMO — point the skills at YOUR duplicated Notion template by filling the {{...}} placeholder IDs. Detects the template automatically through the Notion connector and rewrites the IDs for you, with a guided manual fallback (including a paste-the-IDs hybrid) if anything is missing. Run once, right after installing. Use on "set up ts-pmo", "ts-pmo setup", "finish ts-pmo install", "connect ts-pmo to notion", "repoint ts-pmo".
---

# TS PMO setup → point the skills at your Notion

The one-time bridge between the installed skills and **your** duplicated template. The
core skills ship with placeholder IDs (`{{EFFORTS_DS_ID}}`, …); until those are replaced
with your copy's real data-source IDs, the skills can't read or write your workspace.
This skill finds those IDs and writes them in — and if it can't, it hands you an exact
manual checklist.

**Goal: the user does as little as possible.** Prefer auto-detection; ask for at most
one URL; fall back to manual only when auto truly can't proceed. **Confirm before
writing** (User Sovereignty — recommend, show, then ask).

## What gets filled (the placeholder map)
`_SHARED-PREAMBLE.md`'s ID table is the canonical list. It is:

| Placeholder | Template child to match (ignore emoji + case) | Value to write |
|---|---|---|
| `{{EFFORTS_DS_ID}}` | **Efforts** (database) | its data-source UUID |
| `{{WORK_STREAMS_DS_ID}}` | **Work Streams** (database) | its data-source UUID |
| `{{WORK_ITEMS_DS_ID}}` | **Work Items** (database) | its data-source UUID |
| `{{WORK_LOG_DS_ID}}` | **Work Log** (database) | its data-source UUID |
| `{{CORE_CONTEXT_DS_ID}}` | **Core Context** (database) | its data-source UUID |
| `{{DAILY_LOG_PAGE_ID}}` | **Daily Log** (page, not a DB) | the page UUID |

A database's **data-source UUID** is the part after `collection://` in its
`data-source-url`. The Daily Log value is the plain page UUID.

## Procedure

### 0. Locate the skill files
Find every file under the TS PMO skills folder that still contains `{{` — that's
`_SHARED-PREAMBLE.md` plus the core skills (`init-direction`, `create`, `plan`,
`work-review`, `debrief`, `resync`). Those are what you'll rewrite. **Never rewrite
this file (`ts-pmo-setup`)** — its placeholders are reference, not config. If no file
contains `{{`, setup has already run — say so and stop unless the user asks to redo it.

### 1. Check the Notion connector
Confirm the Notion MCP is connected (a trivial search/fetch succeeds). If it isn't, go
to **Manual fallback → M1**, telling the user to add the Notion connector first.

### 2. Find the template automatically (no URL yet)
Search Notion for the duplicated container — try `TS PMO`, then child names like
`Efforts`, `Work Items`. The match is a **page** whose children include databases named
Efforts / Work Items / Work Log. If one strong candidate appears, show it (title + link)
and ask the user to confirm it's their copy. If search is empty or ambiguous, go to 3.

### 3. Ask for one URL (only if step 2 didn't land it)
Ask for the link to their **🧰 TS PMO container page** — the page that holds all the
databases. How to get it: open that page in Notion → top-right **•••** (or **Share**) →
**Copy link**. If they paste a sub-page or single-database link by mistake, fetch it and
walk up its `ancestor-path` to the container — don't make them redo it.

### 4. Resolve the IDs
Fetch the container. From its child `<database>` / `<page>` blocks, match each row of the
placeholder map by name (ignore emoji/case). For databases, take the UUID from
`data-source-url` (`collection://<UUID>`); for Daily Log, take the page `url` UUID. If a
required child can't be matched (renamed/missing), mark it **unresolved** — never guess.

### 5. Confirm before writing
Show a table: placeholder → matched name → resolved ID, plus any unresolved rows. Ask for
a go-ahead. If some rows are unresolved, offer to write the resolved ones now and send
the rest to the manual checklist, or pause so they can fix names first.

### 6. Write the IDs
For each resolved placeholder, replace **every** occurrence with its real ID across the
located files (preamble + core skills) — replace-all, exact token match. Do not touch
this setup skill's file.

### 7. Verify
Re-scan those files: confirm no `{{` placeholders remain (except any intentionally
deferred). Smoke-test by fetching one written ID (e.g. Efforts) and confirming it
resolves to the expected database. Report what changed.

### 8. Hand off
Setup is done. Next: say **"set up my direction"** (`init-direction`), then **"create an
effort."** Point the user to the **User Guide → Quick Start** inside their template.

## Manual fallback
Use when: no connector, fetch/search fails, the user prefers by hand, or some IDs stayed
unresolved.

- **M1 — connector missing.** Tell them to add the Notion connector to Claude Code, then
  re-run `ts-pmo-setup`. If they'd rather not connect it, continue — you can still write
  IDs they paste.
- **M2 — copy-the-ID recipe.** Open each database (or the Daily Log page) as a full page
  in Notion → **•••** → **Copy link**; the 32-char hex string in the URL is that item's
  ID. Map each to its placeholder using the table above.
- **M3 — hybrid (preferred manual path).** Have them paste the IDs into the chat and
  **you** do the find-and-replace across the files — so even "manual" needs no file
  editing from them.
- **M4 — fully manual.** They open `_SHARED-PREAMBLE.md` and each skill's `Targets:`
  block and replace each `{{…}}` themselves. Point them at `INSTALL.md` for the same map.

Always end by confirming the result and the next step (`init-direction`).
