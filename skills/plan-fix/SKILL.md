---
name: plan-fix
description: Decide with the user how a bug will be fixed, then show the exact implementation before anything is applied. First show a recommended fix and at most 2 alternatives (the user's way included if given) and let the user decide, then write in bug.md the exact code (current vs new for every change), database change, data repair and regression test, for approval line by line. Use after the root cause of a bug is confirmed, or whenever the user wants to discuss or decide how to fix a bug, even if they don't name this skill. Only in a repo whose CLAUDE.md has a Project rules section, or when the user types this command.
---

# Plan the fix

**Nothing is applied in this skill.** No code, database or test file is created or changed; everything is written in `bug.md` §5 and §6.

## 0. Load context
Read `docs/bugs/<bug>/bug.md`. §3 must be confirmed; if not, stop and run `/investigate-bug`. Check the branch.

## 1. Solution ⛔
Follow `~/.claude/workflow/steps/decide.md` with the **Bug** questions, writing §5 ("What you want", options, recommendation, decisions). The fix must address the root cause in §3; if an option only guards the symptom, say so. **STOP** until every question has a decision. Status "Solution".

## 2. Exact implementation ⛔
Follow `~/.claude/workflow/steps/plan.md`, **form A**, writing §6:
- a "Change" block per function or fragment (Current with `file:line` → New, complete);
- the database files (each with its `UNDO:` line), consumers checked;
- the data repair (if decided) in full, with its preview count and how old values are kept;
- the **regression test**: logic the suite can reach → the full test code, case names starting with `"BUG: "`; otherwise a manual scenario and the runnable request (wrong before, right after); a diagnostics query only if stored data is wrong;
- files, not changed (on purpose), deploy order, size check (something new from Project rules: Words for size, or past ~10 files → propose the move to a feature).

Status "Plan". **STOP.** I review each change and may rewrite any line. Update §6 until I say **approved**, then status "Approved", `Next: /fix-bug`.

Assumptions and open questions: only if there are some.
