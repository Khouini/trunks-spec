#!/usr/bin/env bash
# Tests that /work picks the right track, with the kit installed in ~/.claude.
# Uses real Claude runs, so it costs tokens: run it by hand after changing a rule.
# Claude only gets read tools, so nothing is written.
set -uo pipefail
base="$(mktemp -d)"
trap 'rm -rf "$base"' EXIT

shop="$base/shop"
mkdir -p "$shop"
cat > "$shop/CLAUDE.md" <<'EOF'
# Shop

## Project rules

### Stack and commands
Shell scripts. Tests: `./test.sh`.

### Default branch
main
EOF
echo 'echo "$1"  # total = price x quantity (args: price quantity)' > "$shop/total.sh"
echo '[ "$1" -ge 100 ] && echo free || echo paid' > "$shop/shipping.sh"
echo '[ "$1" -ge 100 ] && echo "shipping: 0" || echo "shipping: 5"' > "$shop/invoice.sh"
echo '[ "$1" -ge 100 ] && echo "free shipping" || echo ""' > "$shop/receipt.sh"

empty="$base/empty"
mkdir -p "$empty"
echo 'console.log("hello")' > "$empty/app.js"

for d in "$shop" "$empty"; do git -C "$d" init -q; done

ask() { # folder, request
  (cd "$1" && claude -p "/work $2. Stop at your proposal, create nothing. End with one line: TRACK: <track name>." \
    --model sonnet --allowedTools Read,Grep,Glob --disallowedTools Write,Edit,Bash 2>&1)
}

fail=0
check() { # name, regex, answer
  if grep -qiE "$2" <<<"$3"; then
    echo "ok: $1"
  else
    echo "FAIL: $1. Wanted /$2/. Answer:"
    echo "$3" | tail -n 15
    fail=1
  fi
}

check "a bug goes to the bug track" '^\W*TRACK: \W*bug' \
  "$(ask "$shop" 'total.sh prints 10 for price 10 and quantity 2, it should print 20')"
check "a rule in 3 files goes to the change track" '^\W*TRACK: \W*change' \
  "$(ask "$shop" 'free shipping should start at 50 instead of 100')"
check "a repo with no rules is offered Project rules" 'project rules' \
  "$(ask "$empty" 'add a logout button')"

exit $fail
