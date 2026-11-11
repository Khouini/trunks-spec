# Changelog

What changed, newest first. Versions: a new step, track or rule that changes how you work adds to the middle number; a small fix adds to the last.

## 0.3.0 (2026-11-11)

Less to read, fewer stops.

### Changed
- `CLAUDE.md` keeps only what is needed every time (118 → 54 lines). Tracks and phases live in `WORKFLOW.md` only.
- Templates are one line per field: bug, change, small feature and slice (497 → 194 lines). Section numbers are the same.
- 4 client-email commands become 2: `/read-client-emails` (clean copy + analysis), `/email-client` (questions or validation).
- A mechanical change with nothing to decide has one stop, at the diff.
- `learn.md`: one line per note. An applied note changes a line, it doesn't add one.
- Saving to git: list the files first, stage only your own. Saying a doc lacks something: name the pages read.

### Removed
- The status table in `WORKFLOW.md`: each item's `Next:` line says the next step.

## 0.2.1 (2026-11-11)

### Changed
- How Claude talks: every reply is `Done` / `Not done` / `Question`, in plain words (Simplified Technical English: one idea per sentence, 15 words or fewer, a tiny example for each technical word).

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
