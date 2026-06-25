# TS PMO — capture hook (Windows PowerShell).
# Appends a one-line session stub to the capture inbox when a Claude Code
# session ends. `debrief` later drains the inbox into your Work Log + Daily Log.
#
# Wire it as a SessionEnd hook — see this folder's README.md.
# Nothing here writes to Notion or needs your IDs; it's a local breadcrumb only.

$inbox = if ($env:TS_PMO_INBOX) { $env:TS_PMO_INBOX } else { Join-Path $HOME '.claude\ts-pmo-inbox.md' }
$dir = Split-Path $inbox
if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }

$cwd = (Get-Location).Path
$ts  = Get-Date -Format 'yyyy-MM-dd HH:mm'

$gitPart = ''
try {
  git -C $cwd rev-parse --is-inside-work-tree 2>$null | Out-Null
  if ($LASTEXITCODE -eq 0) {
    $head = git -C $cwd log -1 --format='%h %s' 2>$null
    if ($head) { $gitPart = " · git@$head" }
  }
} catch {}

Add-Content -Path $inbox -Value "- [ ] $ts · $cwd$gitPart" -Encoding utf8
