# Step: impact (what it touches, what could break)

Read-only. Find everything the item touches in the codebase, the database, other repos and the docs, and who will see a difference.

## Depth per track
| Track | Writes | Depth |
|---|---|---|
| Bug | `bug.md` §4 blast radius (in `/investigate-bug`) | other callers, other repos, **all** affected rows, what was already sent wrong |
| Change | `change.md` §2 | the full list below, one short table per area |
| Small feature | `feature.md` §3 | the full list below, one short table per area |
| Big feature | `04-impact-analysis.md` (`/impact-analysis`) | the full list, per user story, with risks |

## What to look at
1. **Code**: every layer on the path (Project rules: Trace path). Quote `file:line`.
2. **Project checks**: everything listed in Project rules: Impact checks.
3. **Database**, if the project has one: tables, columns, indexes and any logic stored there. Always the **latest** version (Project rules: Database). Big tables make risky changes: note them.
4. **Consumers of everything that may change**: other callers in this repo, and what Project rules: Consumers to check lists.
5. **Who sees the difference**: Project rules: Who sees the difference.
6. **Public contract** (API, command line, file format, screen): does it change? Then whoever uses it needs a notice and its docs an update. Prefer additive (a new optional field) when possible; say when it isn't.
7. **Existing data**: does the new behavior apply to rows that already exist (backfill, repair), or only to new ones? Only when a backfill or repair is on the table and the count changes the decision: a read-only query in the item's `diagnostics.md` (copy `~/.claude/workflow/templates/bug/diagnostics.md`). I run it and paste IDs and counts. Otherwise no query.
8. **Docs**: which `docs/system/` files must be created or updated; runnable requests, if the project keeps them.
9. **Tests**: existing tests covering the area, and gaps (Project rules: Test rules says what the suite can reach).
10. **Decisions** in `docs/decisions/` that constrain the item.
11. **Reference**: an existing similar feature or code to copy.
12. **Risks**: what could break, for whom, how likely, how to mitigate.
13. **Size check**: count the files and the new things Project rules: Words for size names. If the item no longer fits its track (`~/.claude/workflow/WORKFLOW.md` §1), say so and follow `~/.claude/workflow/steps/intake.md`, "Moving an item".
