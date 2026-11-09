---
name: impact-analysis
description: Find everything in the existing codebase, database, other repos and docs that a feature will touch or could break, before design. Use after requirements are validated, or whenever the user asks what a change affects, what could break, or where a feature fits in the existing system. Only in a repo whose CLAUDE.md has a Project rules section, or when the user types this command.
---

# Impact analysis

## Inputs
- `02-requirements.md`, `03-client-validation.md`
- The codebase, `docs/system/README.md` and the sources it lists, `docs/decisions/`, existing database changes

## Steps
Follow `~/.claude/workflow/steps/impact.md` at big-feature depth: go through its list **for each user story**, then the risks, the reference feature and the size check.

Asked outside a feature ("what does this change affect?"): the same list, answered in chat, no file.

## Output
Write `04-impact-analysis.md`: code affected, database affected (with table sizes when known), APIs and integrations affected, docs affected, existing tests and gaps, constraining decisions, risks, reference feature. Assumptions and open questions: only if there are some. `Next: /design-feature`.
