#!/usr/bin/env bash
# Stop hook: runs the project's check when code changed since the last run.
# A failure goes back to Claude (exit 2), once per state of the code, so it can't loop.
# Docs alone (*.md) don't trigger it. Set up per project: PROJECT_RULES_TEMPLATE.md.
set -uo pipefail

cmd="${1:?usage: stop-check.sh '<check command>'}"
cd "${CLAUDE_PROJECT_DIR:-.}" || exit 0
cd "$(git rev-parse --show-toplevel 2>/dev/null)" || exit 0
last="$(git rev-parse --absolute-git-dir)/trunks-stop-check"

untracked() { git ls-files --others --exclude-standard -- . ':(exclude)*.md'; }
changes="$(git diff HEAD -- . ':(exclude)*.md' 2>/dev/null; untracked)"
[[ -n "$changes" ]] || exit 0

state="$( { printf '%s\n' "$changes"; untracked | git hash-object --stdin-paths; } | git hash-object --stdin)"
[[ "$(cat "$last" 2>/dev/null)" != "$state" ]] || exit 0
printf '%s\n' "$state" > "$last"

output="$(bash -c "$cmd" </dev/null 2>&1)" && exit 0
{
  echo "The check failed: $cmd"
  tail -n 40 <<<"$output"
  echo
  echo "Fix it. If the failure is expected (a test written first, or it failed before your change), say so in one line and stop. This check runs again only when the code changes."
} >&2
exit 2
