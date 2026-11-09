---
name: build-slice
description: Build ONE vertical slice of an approved feature design. First agree the code-level implementation choices with the user, then write and get approval for a code-level slice plan (slices/slice-N.md), then build test-first, following the plan exactly, with verification, self-review, doc updates and a plan-vs-done hand-over. Use whenever the user asks to implement, code, build or continue a feature that has a docs/features folder with a 05-design.md, or says "next slice", even if they don't name this skill. Only in a repo whose CLAUDE.md has a Project rules section, or when the user types this command.
---

# Build one slice

Work on exactly ONE slice per session. **No code (app code, database changes, tests) is written before the slice plan is approved.**

## 0. Load context
- Read `docs/features/<feature>/progress.md` first, then `05-design.md` (architecture decisions, the slice's scope), `02-requirements.md`, the README (`Branch:` field) and the plans of earlier slices (`slices/`).
- Check you are on the recorded branch (`git branch --show-current`). If not, stop and ask.
- Identify the slice (the one I name, or the next one not committed) and name it in one line; no separate confirmation.

## 1. Implementation choices ⛔
Follow `~/.claude/workflow/steps/decide.md` with the **Code** questions, after reading the reference feature, every file the slice will change and the latest version of any database logic it touches. Architecture choices were made in `05-design.md`; don't reopen them unless the code shows a problem. **STOP** until every choice has a decision; if I describe how I want something implemented, that is the decision.

## 2. Slice plan ⛔
Create `slices/slice-<n>.md` from `~/.claude/workflow/templates/feature/slices/slice-N.md` and fill it with `~/.claude/workflow/steps/plan.md`, **form B + form A for risky code**, with the size line: §1 the choices and my decisions, §2 database, §3 code, §4 API contract, §5 files, §6 tests (unit test names starting with the rule ID, `"BR-03: …"`; `test-guide.md` scenarios for what the suite can't reach), §7 not in this slice. Status "Plan", update `progress.md`. **STOP** until I say approved; then status "Approved".

## 3. Build ⛔ diff
Follow `~/.claude/workflow/steps/apply.md` (track: big feature):
- tests first (they must fail), scenarios in `docs/features/<feature>/test-guide.md`, runnable requests updated;
- database change (`~/.claude/workflow/database.md`), then **STOP** for me to apply it on dev, once;
- code as the plan; deviations in §8 after my approval; verify; self-review (the `code-reviewer` subagent for larger slices, with the slice plan);
- docs: `docs/system/`, runnable requests, listed in the feature README;
- hand-over: §9 "Plan vs done", status "Built", **STOP** for my diff review.

## 4. After my approval
- Commit `feat(<scope>): <slice goal>` (or `fix(<scope>): ...`) on the recorded branch.
- Slice plan status "Committed" with the hash; `progress.md` updated (commit, decisions, open issues); README `Next:` the next slice, or `/final-review` after the last one.
- A preference I gave that applies beyond this feature → one line in `learn.md`.
- Tell me to start a fresh session (`/clear`) for the next slice.
