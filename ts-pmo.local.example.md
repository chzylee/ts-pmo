# TS PMO — workspace IDs (local config) · EXAMPLE

Run `ts-pmo-setup` (say "set up ts-pmo") and it writes this file to
`~/.claude/ts-pmo.local.md` for you. Or copy this file there yourself and paste your own
IDs. The skills read it to resolve each logical store to its Notion data-source ID.
**Safe across updates** — the skills never overwrite it.

Find an ID: open the database (or the Daily Log page) in Notion → **•••** → **Copy link**;
the 32-char hex string in the URL is its ID.

| logical name | Notion store | id |
|---|---|---|
| efforts_ds | 🎯 Efforts | PASTE_EFFORTS_DATA_SOURCE_ID |
| streams_ds | 🧭 Work Streams | PASTE_WORK_STREAMS_DATA_SOURCE_ID |
| items_ds | ✅ Work Items | PASTE_WORK_ITEMS_DATA_SOURCE_ID |
| worklog_ds | 📓 Work Log | PASTE_WORK_LOG_DATA_SOURCE_ID |
| core_context | 🧠 Core Context | PASTE_CORE_CONTEXT_DATA_SOURCE_ID |
| daily_log | 📅 Daily Log (page, not a DB) | PASTE_DAILY_LOG_PAGE_ID |
