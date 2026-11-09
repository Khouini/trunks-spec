# Changelog

What changed, newest first. Versions: a new step, track or rule that changes how you work adds to the middle number; a small fix adds to the last.

## 0.2.0 (2026-11-09)

Simpler code, shorter docs, less talk.

### Added
- "How Claude writes code": least code, only what is needed now, every changed line traces to the request.
- A size line in every plan: `+40/-5, 2 files. Simpler option rejected: …`. `code-reviewer` blocks complexity with no reason.
- A clean-up after tests pass, only in the code the item touched.
- Stop check: a hook that tells Claude when tests fail. Each project turns it on with its own test command.
- Self-tests: `tests/hook.sh` (run by `check.sh`) and `tests/work.sh` (real Claude runs).

### Changed
- Plans are short: signatures, files and tests. Exact code only for database changes, permission checks and public contracts. The rest is reviewed in the real diff.
- A decide stop with nothing to decide is skipped.
- The hand-over is 5 lines or fewer.

## 0.1.0 (2026-11-09)

First public version.

### Added
- Tracks for questions, trivial fixes, bugs, changes, small and big features, with approvals before any code.
- `/work`, `/next` and `/work status`, plus a command for each phase.
- `code-reviewer` and `test-engineer` helpers.
- Project rules: each project keeps its facts in its own `CLAUDE.md`.
- Learn step: Claude notes its remarks in `learn.md` during the work and proposes them at the end. Nothing is added without your yes.
- Packs for one technology. First one: SQL Server.
- `install.sh` and `check.sh`.
