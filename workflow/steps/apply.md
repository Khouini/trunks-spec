# Step: apply (write exactly the plan) ⛔ diff

| Track | Plan | Deviations | Plan vs done | Hand-over status | Commit |
|---|---|---|---|---|---|
| Trivial | the code shown in chat | ask, in chat | in chat | — | `fix` / `chore` / `refactor(<scope>): …` |
| Bug | `bug.md` §6 | §7 | §8 | Fixed | `fix(<scope>): <what was wrong>`, body: root cause in one line + `Bug: docs/bugs/<folder>/` |
| Change | `change.md` §4 | §5 | §6 | Built | `feat(<scope>): <new behavior>` (`refactor` if nobody sees it), body: why + `Change: docs/changes/<folder>/` |
| Small feature | `feature.md` §5 | §6 | §7 | Built | `feat(<scope>): <what it adds>`, body: `Feature: docs/features/<folder>/` |
| Big feature | `slices/slice-N.md` | §8 | §9 | Built | `feat(<scope>): <slice goal>` |

`<scope>`: the area changed (Project rules: Words for size).

## 0. Load
- Read the item doc (big feature: `progress.md`, the slice plan). The plan's status must be **"Approved"**; otherwise stop and go back to the plan step.
- Check the branch: `git branch --show-current` against `Branch:`. If different, stop and ask.

## 1. Tests first
- Write the tests exactly as planned. Run them (Project rules: Stack and commands).
- They must **fail**, for the reason the plan gives. A test passing before the code exists is a bad test (or, for a bug, a wrong root cause): stop and say so.
- A new fixture needed: follow Project rules: Test rules.
- Logic the suite can't reach: `test-guide.md` scenarios written; runnable request added or updated. If the plan has a diagnostics query, its "before" result is in the doc.

## 2. Database change (if any)
- Write exactly the planned change files, as `~/.claude/workflow/database.md` and Project rules: Database say.
- The set's `README.md`: apply order, ahead of or with the code deploy, consumers checked.
- Never edit a change already applied anywhere. Project rules: Database names what else not to touch.
- **You don't apply database changes** (unless Project rules: Database allows it on a local database). STOP and give me the files to apply on dev, in order, once, then the runnable request (or the plan's diagnostics query, if any) with its expected result. A data repair runs on dev only if the bad data exists there; otherwise I review it by reading. Wait for my confirmation.

## 3. Code: exactly the plan
- Write the planned code, nothing more. Allowed without asking: the formatter and import ordering. A generated-code step in Project rules: Plan details runs with the change.
- **Deviation rule:** anything else (another file, a different line or signature, an extra helper, a different approach, a missing parameter) → STOP, explain what and why, ask. Once I approve, record it in the Deviations section, then continue. Never deviate silently.
- Stay in scope. Something else needs changing or looks wrong? List it (open questions, or the Backlog of `docs/bugs/README.md`); don't do it.

## 4. Verify
- The new tests pass.
- Project rules: Stack and commands: the full suite (known failures allowed, report anything else), format and vet on touched code, the build.
- The docs check, if the project has one, passes. A problem in a doc this item touched, or one its code change broke (a renamed file, a changed constant), is fixed in this item.
- NEVER change or delete existing tests to make them pass without asking me. If the same fix fails twice, stop and explain.

## 5. Self-review
- The diff against the plan, line by line: everything planned is done, nothing done that isn't planned or recorded as a deviation.
- Edge cases, errors, nulls, permissions, concurrency, transactions, and Project rules: Review points. Security: no query built as a string from input, authorization, no sensitive data in logs. Cross-repo: no consumer broken (Project rules: Consumers to check).
- Bug: the root cause is fixed, not only the symptom; every affected row of §4 is handled or listed as a follow-up.
- Anything beyond a one-function change: run the `code-reviewer` subagent with the item doc (and the slice plan) and fix its blocking findings; tell me the others.

## 6. Docs
- Create or update the `docs/system/` file of the affected area (its modules, API or database docs); add a new one to `docs/system/README.md`.
- `CLAUDE.md` only if cross-cutting behavior changed (request path, data layer, startup, deploy).
- A runnable request for every new or changed route, if the project keeps them.
- List the docs and database files in the item doc (big feature: the feature README).

## 7. Hand over
- Fill "Plan vs done": each plan item → where it is implemented → done / deviated / not done (why).
- Give me, short (15 lines or fewer): what was done in 2-3 lines, `git diff --stat`, the tests (failed before, pass now), the database files to apply in order, deviations (or "none"), what to check on dev. The rest is in the doc.
- Status as in the table, `Next:` diff review. **STOP** for my review of the diff.

## 8. After my approval
- Commit on the recorded branch, message as in the table (repo style, attribution lines as the session says).
- Fill `Commit:` in the doc and the index row (big feature: the slice plan and `progress.md`). Status "Committed" (bug: stays "Fixed"), `Next:` ship (big feature: the next slice, or `/final-review`).
- If I gave a preference that applies beyond this item ("always do X like this"), add it to the item's `learn.md`. The learn step proposes it.
- Big feature: tell me to `/clear` before the next slice.

## Definition of done
- [ ] Plan approved before any code; code matches it; every deviation approved and recorded
- [ ] New tests failed first and pass now; what the suite can't reach has a scenario, runnable requests updated
- [ ] Full suite: no new failure; format and vet clean on touched code; the build passes
- [ ] Database change applied on dev by me (if any)
- [ ] Self-review done (+ `code-reviewer` beyond a one-function change)
- [ ] `docs/system/` updated and listed in the item doc
- [ ] Plan vs done filled, diff reviewed by me, committed, doc and index updated
