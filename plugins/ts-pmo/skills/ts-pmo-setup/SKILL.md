---
name: ts-pmo-setup
description: First-run setup for TS PMO — point the skills at YOUR duplicated Notion template by writing your six workspace IDs to ~/.claude/ts-pmo.local.md (the config the skills read). Detects the template automatically through the Notion connector and writes the config for you, with a guided manual fallback if anything is missing. Run once after installing; re-run to repoint. Use on "set up ts-pmo", "ts-pmo setup", "finish ts-pmo install", "connect ts-pmo to notion", "repoint ts-pmo".
---

# TS PMO setup → write your workspace config

The one-time bridge between the installed skills and **your** duplicated template. The
skills don't hard-code IDs — they read them from **`~/.claude/ts-pmo.local.md`**. Until
that file exists with your six real IDs, the skills can't read or write your workspace.
This skill finds those IDs and writes that one file — and if it can't, it hands you an
exact manual checklist. It touches **only** the config file; it never edits the skills, so
updating or re-installing them can't clobber your wiring.

**Goal: the user does as little as possible.** Prefer auto-detection; ask for at most one
URL; fall back to manual only when auto truly can't proceed. **Confirm before writing**
(User Sovereignty — recommend, show, then ask).

## What gets written (the config)
One file, `~/.claude/ts-pmo.local.md` — a small markdown table mapping each logical store
to its Notion ID:

| logical name | Notion store to match (ignore emoji + case) | value |
|---|---|---|
| `efforts_ds` | **Efforts** (database) | its data-source UUID |
| `streams_ds` | **Work Streams** (database) | its data-source UUID |
| `items_ds` | **Work Items** (database) | its data-source UUID |
| `worklog_ds` | **Work Log** (database) | its data-source UUID |
| `core_context` | **Core Context** (database) | its data-source UUID |
| `daily_log` | **Daily Log** (page, not a DB) | the page UUID |

A database's **data-source UUID** is the part after `collection://` in its
`data-source-url` — **not** the database page id. The Daily Log value is the plain page
UUID. A model file ships as `ts-pmo.local.example.md` in the repo.

## Procedure

### 0. Check current config
Read `~/.claude/ts-pmo.local.md`. If it already has all six IDs filled, setup has run —
say so and stop, unless the user wants to **re-point** (re-duplicated template / new
workspace), in which case continue and overwrite it.

### 1. Check the Notion connector
Confirm the Notion MCP is connected (a trivial search/fetch succeeds). If it isn't, go to
**Manual fallback → M1**, telling the user to add the Notion connector first.

### 2. Find the template automatically (no URL yet)
Search Notion for the duplicated container — try `TS PMO`, then child names like `Efforts`,
`Work Items`. The match is a **page** whose children include databases named Efforts /
Work Items / Work Log. If one strong candidate appears, show it (title + link) and ask the
user to confirm it's their copy. If search is empty or ambiguous, go to 3.

### 3. Ask for one URL (only if step 2 didn't land it)
Ask for the link to their **🧰 TS PMO container page** — the page that holds all the
databases. How to get it: open it in Notion → top-right **•••** (or **Share**) → **Copy
link**. If they paste a sub-page or single-database link by mistake, fetch it and walk up
its `ancestor-path` to the container — don't make them redo it.

### 4. Resolve the IDs
Fetch the container. From its child `<database>` / `<page>` blocks, match each row of the
config table by name (ignore emoji/case). For databases, take the UUID from
`data-source-url` (`collection://<UUID>`) — **not** the database page id. If a database
exposes **more than one `data-source-url`** (multi-source), don't guess: list them and ask
which is the real store. For Daily Log, take the page `url` UUID. If a required child can't
be matched (renamed/missing), mark it **unresolved** — never guess. If **two** different
pages match the same store name (e.g. two "Efforts"), ask which container is right.

### 5. Confirm before writing
Show a table: logical name → matched name → resolved ID, plus any unresolved rows. Ask for
a go-ahead. If some rows are unresolved, offer to write the resolved ones now (leaving the
rest blank for a later pass) or pause so they can fix names first.

### 6. Write the config
Write `~/.claude/ts-pmo.local.md` with the resolved IDs, in the shape of
`ts-pmo.local.example.md` (header note + the six-row table). This is the **only** file you
write — never edit the skill files or the preamble.

### 7. Verify
Re-read `~/.claude/ts-pmo.local.md`; confirm all six rows are filled (or note any
deferred). Smoke-test: fetch `efforts_ds` (confirm it resolves to the Efforts database) and
`daily_log` (confirm it's a **page**, not a data source — the one structurally different
entry, and the easiest to mis-copy). Report what you wrote.

### 8. Offer automatic capture (optional)
TS PMO logs work from the current chat, your **git** history, and a **capture inbox**
(`~/.claude/ts-pmo-inbox.md`). The inbox fills itself if you wire a one-line **SessionEnd
hook**, so even sessions you forget to debrief leave a breadcrumb for the next `debrief` to
sweep up. Offer to set it up (User Sovereignty — explain, then ask; it's optional, since git
capture already works without it):
   - **If yes:** copy the script for their OS from `plugins/ts-pmo/hooks/`
     (`ts-pmo-capture.sh` for macOS/Linux/Git Bash, `ts-pmo-capture.ps1` for Windows) to
     `~/.claude/`, then **merge** a `SessionEnd` hook into `~/.claude/settings.json` pointing
     at it. **Read settings.json first and add to any existing `hooks` — never overwrite
     other hooks.** Show the change before writing.
   - **If they'd rather not manage a file:** offer the inline one-liner from
     `plugins/ts-pmo/hooks/README.md` (timestamp + folder only, no git line).
   - Full detail and both snippets live in **`plugins/ts-pmo/hooks/README.md`**.

### 9. Hand off
Setup is done. Next: say **"set up my direction"** (`set-direction`), then **"create an
effort."** Point the user to the **User Guide → Quick Start** inside their template.

## Manual fallback
Use when: no connector, fetch/search fails, the user prefers by hand, or some IDs stayed
unresolved.

- **M1 — connector missing.** Tell them to add the Notion connector to Claude Code, then
  re-run `ts-pmo-setup`. If they'd rather not connect it, continue — you can still write
  the IDs they paste.
- **M2 — copy-the-ID recipe.** Open each database (or the Daily Log page) as a full page in
  Notion → **•••** → **Copy link**; the 32-char hex string in the URL is that item's ID.
  Map each to its logical name using the table above.
- **M3 — hybrid (preferred manual path).** Have them paste the IDs into the chat and **you**
  write `~/.claude/ts-pmo.local.md` — so even "manual" needs no file editing from them.
- **M4 — fully manual.** They copy `ts-pmo.local.example.md` to `~/.claude/ts-pmo.local.md`
  and paste each ID into the table themselves.

Always end by confirming the result and the next step (`set-direction`).
