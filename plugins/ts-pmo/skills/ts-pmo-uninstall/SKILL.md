---
name: ts-pmo-uninstall
description: Cleanly remove TS PMO from this machine — deletes the skill folders, the shared preamble, your config, the capture script, and the inbox, and removes the TS PMO session-end hook from settings.json (leaving any other hooks intact). Inventories and confirms first, and never touches your Notion (the template and your data are yours to keep or delete). Use on "uninstall ts-pmo", "remove ts-pmo", "delete ts-pmo", "tear down ts-pmo".
---

# TS PMO uninstall → remove the local footprint, leave Notion alone

> Inherits **User Sovereignty** — show exactly what will be removed and confirm before
> deleting anything. This is the one place the tooling deletes its own files, so be precise.

**Removes (local only):** the TS PMO skills, the shared preamble, your config, the capture
script, the inbox, and the session-end hook. **Never touches:** your Notion workspace — the
template and every Effort / Work Stream / Work Item / log stays yours. (The Notion connector
can't delete pages anyway.) If you want the template gone too, you move it to Trash in Notion
yourself — this skill will remind you, not do it.

## Procedure

1. **Inventory first — don't delete yet.** Check which of these exist and list them back to
   the user, so they see the exact footprint:
   - `~/.claude/skills/` folders: `set-direction`, `create`, `surface-effort`, `plan`,
     `work-review`, `debrief`, `resync`, `ts-pmo-setup`, `ts-pmo-uninstall` — and the file
     `_SHARED-PREAMBLE.md`.
   - `~/.claude/ts-pmo.local.md` — your workspace config.
   - `~/.claude/ts-pmo-capture.ps1` / `ts-pmo-capture.sh` — the capture script.
   - `~/.claude/ts-pmo-inbox.md` — the capture inbox.
   - the **TS PMO `SessionEnd` hook** in `~/.claude/settings.json` (the entry whose command
     references `ts-pmo-capture`).
   - the marketplace entry `extraKnownMarketplaces.ts-pmo` and the plugin, if installed that
     way.

2. **Offer a last debrief.** If `ts-pmo-inbox.md` has unchecked `- [ ]` stubs, or there's
   unlogged work in this chat, point it out and offer to run `debrief` first — once these
   files are gone, those breadcrumbs are gone. Skip if the user just wants it removed.

3. **Confirm.** Show the full list and ask for a go-ahead. **Nothing is deleted until
   confirmed.** Let the user keep any piece (e.g. keep the inbox, keep the marketplace entry).

4. **Remove the files.** Delete the skill folders + `_SHARED-PREAMBLE.md`, `ts-pmo.local.md`,
   `ts-pmo-capture.*`, and — if the user agreed — `ts-pmo-inbox.md`.

5. **Remove the hook surgically.** Read `~/.claude/settings.json`. Remove **only** the
   `SessionEnd` hook whose command references `ts-pmo-capture`; leave every other hook
   exactly as is. If that empties the `SessionEnd` array (or the whole `hooks` object), drop
   the empty container. Re-read afterward to confirm the file is still valid JSON. **Never
   rewrite settings wholesale — edit the one entry.**

6. **Marketplace (ask, don't assume).** Offer to remove `extraKnownMarketplaces.ts-pmo` and
   disable the plugin in settings.json. Leave them if the user might reinstall.

7. **Report + the Notion note.** List what was removed. Then state plainly: **your Notion
   template and data are untouched and yours** — to remove them, move the TS PMO page to Trash
   in Notion. Suggest starting a fresh chat so the now-deleted skills clear from the session.
