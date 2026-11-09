#!/usr/bin/env bash
# Fails if the core is tied to one technology, a kit path named in a file doesn't exist,
# a skill lost its guard, or a word from the private list got in.
#
# Private list: .check-words.local (git-ignored), one extended regex per line, for words
# that must never be published, like your company and client names.
set -uo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")" || exit 2
fail=0

# The core: everything except packs, which exist to be specific.
core=$(find CLAUDE.md skills agents workflow -type f \( -name '*.md' -o -name '*.sql' \) -not -path 'workflow/packs/*')
tech='\bGo\b|gofmt|go test|go vet|APP_ENV|\bPython\b|Node\.?js|PHP|Bruno|Postman|Redis|Mongo|journalctl|systemd|SQL Server|T-SQL|Postgres|MySQL|\bprocs?\b|[Pp]rocedure|dbo\.|RAISERROR|XACT_ABORT|CREATE OR ALTER|\bDDL\b|\bEXEC\b|```go|```sql|\bSQL\b'
hits=$(grep -nE "$tech" $core | grep -vE 'extract_correspondence\.py|\bpython3\b' || true)
if [[ -n "$hits" ]]; then
  echo "Technology words in the core (they belong in a pack or in Project rules):"
  echo "$hits" | cut -c1-160
  fail=1
fi

# Every ~/.claude/... path named in the kit must exist in the kit.
all=$(find CLAUDE.md README.md CONTRIBUTING.md skills agents workflow -type f \( -name '*.md' -o -name '*.sql' \))
missing=$(grep -ohE '~/\.claude/(workflow|skills|agents)/[A-Za-z0-9_./-]+' $all | sed 's/\.$//' | sort -u | while read -r p; do
  rel="${p#\~/.claude/}"
  [[ -e "$rel" ]] || echo "$p"
done)
if [[ -n "$missing" ]]; then
  echo "Paths that don't exist in the kit:"
  echo "$missing"
  fail=1
fi

for s in skills/*/SKILL.md; do
  head -4 "$s" | grep -q 'Only in a repo whose CLAUDE.md has a Project rules section' || {
    echo "No guard: $s"
    fail=1
  }
done

# Private words: every file, packs and history notes included. LICENSE names its holder.
if [[ -f .check-words.local ]]; then
  private=$(find . -type f -not -path './.git/*' -not -name '.check-words.local' -not -name 'LICENSE' -exec grep -nIHiE -f .check-words.local {} + || true)
  if [[ -n "$private" ]]; then
    echo "Private words:"
    echo "$private" | cut -c1-160
    fail=1
  fi
fi

[[ $fail == 0 ]] && echo "check.sh: OK"
exit $fail
