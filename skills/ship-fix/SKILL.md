---
name: ship-fix
description: Ship a committed bug fix and close it - draft the reply to whoever reported it, the patch-version changelog entry, the hotfix deployment checklist (database change, data repair, deploy, verification query, undo plan), then hand over to the learn step. Use when a fix is committed and ready for production, or whenever the user asks for the bug reply, the hotfix checklist or to close a bug. Only in a repo whose CLAUDE.md has a Project rules section, or when the user types this command.
---

# Ship and close the fix

`docs/bugs/<bug>/bug.md` must have status "Fixed" and `Commit:` filled.

1. **Ship** with `~/.claude/workflow/steps/ship.md` (track: bug), writing §9: the patch version (your proposal from the latest tag; I correct it), the "Fixed" changelog line linking `../bugs/<folder>/`, the reply to the reporter (draft), the deployment checklist with the verification query and the backup table cleanup. P1: the essentials only, deploy first.
2. When I confirm production: status "Shipped", `Version:` filled, index row updated (fixed in, status), `Next:` learn.

Nothing sent, nothing tagged.
