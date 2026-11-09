---
name: final-review
description: Review a complete feature before delivery against requirements, acceptance criteria, conventions, security, database changes and documentation. Use when all slices are done, or whenever the user asks for a final check, release readiness or a full feature review. Only in a repo whose CLAUDE.md has a Project rules section, or when the user types this command.
---

# Final review

## Steps
1. Confirm every slice in `progress.md` is committed, and every slice plan (`slices/slice-N.md`) has status "Committed", its "Plan vs done" filled, and every deviation recorded and approved.
2. Build the feature diff from the README `Branch:` field:
   - feature branch: `git diff <default branch>...HEAD` (Project rules: Default branch)
   - no feature branch: the slice commits recorded in `progress.md` (`git diff <first-slice-commit>^..<last-slice-commit>`)
3. Run the `code-reviewer` subagent on that diff.
4. Run the `test-engineer` subagent to check every acceptance criterion and example has a unit test or a `test-guide.md` scenario.
5. Run the full suite, format and vet on touched code, and the build (Project rules: Stack and commands; only the known failures listed there are allowed).
6. Check database changes, if any (`~/.claude/workflow/database.md`):
   - Every file has a header with an `UNDO:` line, and is idempotent
   - The README gives the apply order and whether it can go ahead of the code deploy
   - Ask me to confirm the whole set was applied in order on dev (you don't apply them)
   - No edits to already-applied changes; Project rules: Database followed
   - Project rules: Consumers to check checked for every change
   - Big-table risks noted with expected run time
7. Check docs: every affected `docs/system/` file updated, runnable requests added, feature README complete, the docs check passes if the project has one. Also every item of Project rules: Review points.
8. Check requirements traceability: each user story → slice plan → code → tests / scenarios.

## Output
Write `06-review.md`: results, issues found (blocking / non-blocking), fixes made, remaining risks, deployment notes (order of steps and services, database run time, undo plan). Update the README status to "Review".

## STOP
Ask me to confirm the feature is ready to deliver.
