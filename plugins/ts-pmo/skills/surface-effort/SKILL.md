---
name: surface-effort
description: Give one Effort a viewable home — a dedicated Notion page (at a location you choose, e.g. top-level) holding linked views of its Work Streams + Work Items, plus board sub-pages (active items by priority, streams by priority, items by status — with Impact surfaced on the cards). Works on Efforts created earlier, or hand-off from `create` for a new one. Use on "create a page for my <Effort> effort", "surface my <Effort>", "build the board/page for <Effort>", "give <Effort> its own page", "make <Effort> viewable".
---

# Surface Effort → a viewable home for one Effort

> Inherits **[`_SHARED-PREAMBLE.md`](../_SHARED-PREAMBLE.md)** — User Sovereignty · workspace IDs (config) · field semantics (priority cascade, impact locality, status ladders).

Targets:
- efforts_ds   (🎯 Efforts)
- streams_ds   (🧭 Work Streams)
- items_ds     (✅ Work Items)

**Your task:** stand up a clean, navigable page for one existing Effort so the user can see
its work at a glance, **wherever they want it to live**. These are *linked views* — the data
stays in the core stores, filtered to this Effort by its **Effort key** (the select whose
value is the Effort's name). No new databases.

## Procedure
1. **Identify the Effort.** Match the named Effort in `efforts_ds` (ask if ambiguous). Note
   its exact **Effort key** value — every view filters on it. Ensure that key is registered
   as a select option on `items_ds` *and* `streams_ds` (`create` normally does this; if it's
   missing, add it via `ALTER COLUMN "Effort key" SET SELECT(...)` first, else the filters
   match nothing).
2. **Ask where it should live.** The user's call — **top-level** (adjacent to the 🧰 TS PMO
   container), inside the container, or under another page they name. Ask; don't assume.
3. **Create the Effort's page** at that location: a page titled after the Effort (carry its
   icon if it has one). This is a dashboard, not the Effort's database row — link to the row
   in the page body so they can jump to the Effort itself.
4. **At-a-glance views on the page body** (linked views via `create-view`, filtered by
   `"Effort key" = <Effort>`):
   - **Work Streams** — this Effort's streams (a table/list).
   - **Work Items** — this Effort's items (a table/list, all statuses).
5. **Board sub-pages** (each a child page of the Effort page, holding one board view):
   - **Active items · by Priority** — board of `items_ds`, GROUP BY Priority, FILTER
     `"Effort key" = <Effort>` AND Status ≠ the **Done** label (read from the schema, never
     hardcoded); surface **Impact** on the cards.
   - **Work Streams · by Priority** — board of `streams_ds`, GROUP BY Priority, FILTER
     `"Effort key" = <Effort>`; surface **Impact** on the cards.
   - **Items · by Status** — board of `items_ds`, GROUP BY Status, FILTER
     `"Effort key" = <Effort>`; surface **Priority + Impact** on the cards.
   Use the **exact numbered labels** from the schema for any status/priority filter or group.
6. **Surface properties on cards.** Set the named properties (Impact, and Priority where
   noted) as visible card properties if `create-view` supports it. If it can't set card
   properties, build the boards anyway and tell the user the one toggle: open the board →
   **•••** → **Properties** → show Impact (and Priority).
7. **Best-effort, not all-or-nothing.** If `create-view` isn't available on the user's Notion
   plan, don't fail — create the page, add whatever you can, and hand the user the exact
   specs for the rest (each view's group + filter + card properties) to add by hand.
8. **Report** the new page with its link and what it contains, then offer to do the same for
   the user's other Efforts.

## Notes
- **Don't duplicate.** If the Effort already has a page at that location, offer to **refresh**
  its views rather than create a second one. Ask before replacing anything.
- This is the richer companion to `create`'s Effort step: `create` registers the Effort key
  and hands new Efforts here for their full home; `surface-effort` also works standalone on
  Efforts you made earlier.
