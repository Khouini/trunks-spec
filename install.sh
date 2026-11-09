#!/usr/bin/env bash
# Links this kit into ~/.claude. "--uninstall" removes exactly what it added.
# Stops before changing anything if a target exists and is not its own link.
set -euo pipefail

KIT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_CLAUDE="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
IMPORT_LINE="@$KIT/CLAUDE.md"
SETTINGS="$HOME_CLAUDE/settings.json"
# An allow rule must match both the requested path and the file it resolves to, and
# "//" is what makes a path absolute. So the link and the kit each get a rule.
ALLOW_RULES=("Read(/$KIT/**)" "Read(/$HOME_CLAUDE/workflow/**)")

targets() { # prints "link<TAB>source"
  local d
  for d in "$KIT"/skills/*/; do
    printf '%s\t%s\n' "$HOME_CLAUDE/skills/$(basename "$d")" "${d%/}"
  done
  for d in "$KIT"/agents/*.md; do
    printf '%s\t%s\n' "$HOME_CLAUDE/agents/$(basename "$d")" "$d"
  done
  printf '%s\t%s\n' "$HOME_CLAUDE/workflow" "$KIT/workflow"
}

edit_allow() { # add|remove
  python3 - "$SETTINGS" "$1" "${ALLOW_RULES[@]}" <<'PY'
import json, os, sys
path, mode, *rules = sys.argv[1:]
data = json.load(open(path)) if os.path.exists(path) else {}
allow = data.setdefault("permissions", {}).setdefault("allow", [])
for rule in rules:
    if mode == "add" and rule not in allow:
        allow.append(rule)
    if mode == "remove" and rule in allow:
        allow.remove(rule)
with open(path, "w") as f:
    json.dump(data, f, indent=2)
    f.write("\n")
PY
}

if [[ "${1:-}" == "--uninstall" ]]; then
  while IFS=$'\t' read -r link src; do
    if [[ -L "$link" && "$(readlink "$link")" == "$src" ]]; then rm "$link"; fi
  done < <(targets)
  if [[ -f "$HOME_CLAUDE/CLAUDE.md" ]]; then
    grep -vxF "$IMPORT_LINE" "$HOME_CLAUDE/CLAUDE.md" > "$HOME_CLAUDE/CLAUDE.md.tmp" || true
    if [[ -s "$HOME_CLAUDE/CLAUDE.md.tmp" ]]; then
      mv "$HOME_CLAUDE/CLAUDE.md.tmp" "$HOME_CLAUDE/CLAUDE.md"
    else
      rm "$HOME_CLAUDE/CLAUDE.md.tmp" "$HOME_CLAUDE/CLAUDE.md"
    fi
  fi
  if [[ -f "$SETTINGS" ]]; then edit_allow remove; fi
  echo "Kit removed from $HOME_CLAUDE"
  exit 0
fi

# Check everything first: nothing changes if one target is in the way.
while IFS=$'\t' read -r link src; do
  if [[ -e "$link" || -L "$link" ]] && [[ "$(readlink "$link" || true)" != "$src" ]]; then
    echo "STOP: $link exists and is not this kit's link. Nothing changed." >&2
    exit 1
  fi
done < <(targets)

mkdir -p "$HOME_CLAUDE/skills" "$HOME_CLAUDE/agents"
while IFS=$'\t' read -r link src; do
  ln -sfn "$src" "$link"
done < <(targets)

touch "$HOME_CLAUDE/CLAUDE.md"
grep -qxF "$IMPORT_LINE" "$HOME_CLAUDE/CLAUDE.md" || echo "$IMPORT_LINE" >> "$HOME_CLAUDE/CLAUDE.md"

if [[ -f "$SETTINGS" ]]; then cp "$SETTINGS" "$SETTINGS.bak-claude-kit"; fi
edit_allow add
echo "Kit linked into $HOME_CLAUDE"
