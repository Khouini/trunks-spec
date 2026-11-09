#!/usr/bin/env bash
# Tests the stop hook in a throwaway repo. Free and fast: check.sh runs it.
set -uo pipefail
hook="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/workflow/hooks/stop-check.sh"
repo="$(mktemp -d)"
trap 'rm -rf "$repo"' EXIT
export CLAUDE_PROJECT_DIR="$repo"
git -C "$repo" init -q
git -C "$repo" -c user.name=t -c user.email=t@example.com commit -q --allow-empty -m start

fail=0
expect() { # name, wanted exit, wanted runs of the check, command
  : > "$repo/.git/runs"
  "$hook" "echo run >> .git/runs; $4" >/dev/null 2>&1
  local code=$? runs
  runs=$(wc -l < "$repo/.git/runs" | tr -d ' ')
  if [[ $code == "$2" && $runs == "$3" ]]; then
    echo "ok: $1"
  else
    echo "FAIL: $1 (exit $code, wanted $2; ran $runs, wanted $3)"
    fail=1
  fi
}

expect "no changes: the check doesn't run" 0 0 false
echo a > "$repo/code.txt"
expect "new code, check fails: Claude is told" 2 1 false
expect "same code: not told twice" 0 0 false
echo b > "$repo/code.txt"
expect "code changed, check fails: told again" 2 1 false
echo c > "$repo/code.txt"
expect "code changed, check passes" 0 1 true
rm "$repo/code.txt"
echo notes > "$repo/notes.md"
expect "docs only: the check doesn't run" 0 0 false

exit $fail
