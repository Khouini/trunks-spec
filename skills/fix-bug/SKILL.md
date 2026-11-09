---
name: fix-bug
description: Apply an approved bug fix exactly as written in bug.md §6. Regression test first (it must fail), then database change + data repair, then the code, then tests, vet, build, self-review and a plan-vs-done hand-over for diff review, then commit. Use when the user approves a fix plan or says "apply the fix", even if they don't name this skill. Only in a repo whose CLAUDE.md has a Project rules section, or when the user types this command.
---

# Apply the fix

Follow `~/.claude/workflow/steps/apply.md` (track: bug) on `docs/bugs/<bug>/bug.md`:
- the plan is §6, and its status must be **"Approved"** (otherwise stop and run `/plan-fix`);
- the regression test must **fail** first, for the reason written in §6; if it passes, the test or the root cause is wrong: stop;
- a bug in database logic with a diagnostics query in §6: its "before" result is recorded in §2;
- deviations go in §7, "Plan vs done" in §8;
- self-review also checks: the root cause is fixed, not just the symptom; every "affected" row of §4 is handled or listed as a follow-up;
- hand-over status "Fixed", **STOP** for my diff review;
- after my approval: commit `fix(<scope>): <what was wrong>`, body with the root cause in one line and `Bug: docs/bugs/<folder>/`; fill `Commit:` in `bug.md` and the index; `Next: /ship-fix`.
