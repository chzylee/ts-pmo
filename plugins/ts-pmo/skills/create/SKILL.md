---
name: create
description: Create a fully-formed Effort, Work Stream, or Work Item — the one creation flow for every tier. Reads your Direction (north star), populates every field, asks for whatever it needs to make the item both complete and sensible against your current goals, and ends by asking what's next. Triggers on "create an effort", "create a work stream", "create a work item", "add a task", "new effort", "track this", "file this".
---

# Create → a fully-formed item, every tier

> Inherits **[`_SHARED-PREAMBLE.md`](../_SHARED-PREAMBLE.md)** — User Sovereignty · workspace IDs · field semantics (priority cascade, impact locality, status ladders).

**Your task:** turn a rough intent into one well-formed Effort, Work Stream, or Work
Item — fully populated and coherent with the user's goals — then hand control back
with a clear next step. This is the clerical aide and the accountability gate in one.
Gather whatever you need to deliver it in full quality: never write a half-formed
item, never guess past your confidence, and never write without confirmation.

Targets:
- efforts_ds   (🎯 Efforts)
- streams_ds   (🧭 Work Streams)
- items_ds     (✅ Work Items)
- core_context (🧠 Core Context → Direction)

## Procedure
1. **Load the north star.** Read the **Direction** module in Core Context — it's the
   basis for judging priority, impact, and fit. **If there is no Direction module,
   stop and route the user to `set-direction` first** — you can't populate well
   without the yardstick. Also load existing Efforts (names + Effort-key options) for
   parent-matching and dedupe.
2. **Determine the tier.** From the request: a long-term pursuit → **Effort**; a
   coherent cluster of items under an Effort → **Work Stream**; a single completable
   action → **Work Item**. State your read; ask only if genuinely ambiguous. One item
   per run unless the user clearly hands you several.
3. **Resolve the parent** (streams/items). Match to an existing Effort (and Stream, if
   any). No confident parent? Ask — or create the parent Effort first in the same
   flow. Surface near-duplicates before creating anything.
4. **Populate every field — ask for what you need.** Fill all fields for the tier;
   never leave a blank you could have asked about.
   - **Effort:** Name · Priority · Status (default Active; Idea if there's no first
     action yet) · Next action · Links/Notes if relevant.
   - **Work Stream:** Name · Effort (+ Effort key) · Priority · Impact (local to the
     Effort) · Status · Next action.
   - **Work Item:** Name · Effort (+ Effort key) · Work Stream (if any) · Priority ·
     Impact (local to parent) · Commitment (`≤1h`/`1-3h`/`3h+`; `3h+` ⇒ propose a
     split) · Acceptance criteria (required for `1-3h`/`3h+`) · Due if known · Source.
5. **Accountability check** (what makes this more than data entry). Before showing the
   draft, test it against the Direction:
   - Does it fit the user's stated priorities, or is it off-direction? Say so plainly
     if it looks like a detour.
   - Is the Priority honest given the **cascade** (a child can't be effectively more
     urgent than its parent Effort)? Is Impact right relative to its siblings?
   - Is it a duplicate or near-duplicate of existing work?
   Raise anything that doesn't add up and propose a fix — don't just record what you
   were told.
6. **Show + confirm.** Present the complete draft (every field). The user approves /
   edits / drops. **Do not write until confirmed.**
7. **Write.**
   - Item / Stream → create in items_ds / streams_ds with the **Effort relation AND
     the Effort-key select set together**.
   - **Effort →** create in efforts_ds; **register its Effort key** (`update-data-source`:
     `ALTER COLUMN "Effort key" SET SELECT(...existing + new...)` on items_ds AND
     streams_ds). Then **offer to give it a viewable home** — hand to **`surface-effort`**,
     which builds the Effort's own page (linked Work-Stream + Work-Item views + board
     sub-pages, Impact surfaced) at a location the user picks.
   - **Best-effort, not all-or-nothing:** if `ALTER COLUMN` isn't available on the user's
     Notion plan, **don't fail the create** — the Effort row still stands; report the
     Effort-key select option the user should add by hand.
8. **Deliver + ask next.** Report the created item with its link, then ask what's next
   — add Work Items under this Effort, plan it into your day/week (`plan`), or create
   the next thing. Leave the user with a clear handle, not a dead end.
