# Automatic capture — the session-end hook

The problem: `debrief` can read the **current** chat, your **git** history, and the
**Notion Work Log** — but it **can't** read the content of *past* Claude Code sessions.
So work you did in a session you never debriefed can go missing.

The fix: a tiny **SessionEnd hook** that leaves a breadcrumb every time a session ends.
`debrief` then drains those breadcrumbs (plus git) into your Work Log and Daily Log, so
nothing slips through — even on days you forgot to log.

The hook writes **one local line per session** to a capture inbox. It never touches Notion
and never needs your IDs.

---

## The capture inbox

Default path: `~/.claude/ts-pmo-inbox.md` (override with the `TS_PMO_INBOX` env var).

Each session appends a line; `debrief` checks them off (`- [ ]` → `- [x]`) once logged:

```
- [ ] 2026-06-25 14:30 · /Users/you/repos/ts-pmo · git@694a7aa debrief: capture sources
- [x] 2026-06-25 09:12 · /Users/you/repos/site            (logged)
- [ ] 2026-06-25 16:40 · note: called the recruiter back, phone screen Thu 2pm
```

You can also add lines yourself for non-code work — anything starting `- [ ] ... · note:`
gets picked up. (The skills also accept **`log this: <thing>`** in chat, which appends a
note line for you.)

---

## Wiring it (one time)

Add a `SessionEnd` hook to your `~/.claude/settings.json`. Merge this into the existing
`hooks` block — don't overwrite other hooks you may have.

First copy the script for your OS to a stable spot next to your config —
`~/.claude/ts-pmo-capture.sh` (or `.ps1`). Then:

**macOS / Linux / Git Bash**
```json
{
  "hooks": {
    "SessionEnd": [
      { "hooks": [ { "type": "command", "command": "bash ~/.claude/ts-pmo-capture.sh" } ] }
    ]
  }
}
```

**Windows (PowerShell)**
```json
{
  "hooks": {
    "SessionEnd": [
      { "hooks": [ { "type": "command", "command": "powershell -NoProfile -File %USERPROFILE%\\.claude\\ts-pmo-capture.ps1" } ] }
    ]
  }
}
```

(The standard skill install copies `skills/`, not this `hooks/` folder — so copy the one
script you need to `~/.claude/` yourself, or just run `set up ts-pmo` and let it do both.)

**No-script alternative** — if you'd rather not manage a file, an inline command captures the
basics (timestamp + folder), just without the git line:

```json
{ "type": "command", "command": "printf -- '- [ ] %s · %s\\n' \"$(date '+%Y-%m-%d %H:%M')\" \"$(pwd)\" >> ~/.claude/ts-pmo-inbox.md" }
```

Running **`set up ts-pmo`** will offer to wire this for you.

---

## How `debrief` uses it

When you run `debrief` (a single chat or a whole window), it reads the inbox alongside the
current chat and your git log, expands each unchecked stub into a logged unit, writes the
Work Log + Daily Log, and marks the stub `- [x]`. It's idempotent: re-running never
double-logs, and a checked stub is skipped.

The durable habit this enables: **you don't have to remember to debrief every session** —
the breadcrumb is already there, and the next `debrief` sweeps it up.
