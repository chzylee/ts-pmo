#!/usr/bin/env bash
# TS PMO - capture hook (macOS / Linux / Git Bash).
# Appends a one-line session stub to the capture inbox when a Claude Code
# session ends. `debrief` later drains the inbox into your Work Log + Daily Log.
#
# Wire it as a SessionEnd hook - see this folder's README.md.
# Nothing here writes to Notion or needs your IDs; it's a local breadcrumb only.

set -euo pipefail

inbox="${TS_PMO_INBOX:-$HOME/.claude/ts-pmo-inbox.md}"
mkdir -p "$(dirname "$inbox")"

cwd="$(pwd)"
ts="$(date '+%Y-%m-%d %H:%M')"

git_part=""
if git -C "$cwd" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  head="$(git -C "$cwd" log -1 --format='%h %s' 2>/dev/null || true)"
  [ -n "$head" ] && git_part=" | git@${head}"
fi

printf -- '- [ ] %s | %s%s\n' "$ts" "$cwd" "$git_part" >> "$inbox"
