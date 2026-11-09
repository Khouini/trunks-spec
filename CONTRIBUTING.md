# Contributing

Thanks for helping. Keep it simple: short sentences, common words, one example per rule.

## What belongs where
- **Works for any project, in any technology:** the core (`CLAUDE.md`, `skills/`, `agents/`, `workflow/`).
- **One database, framework or platform:** a pack in `workflow/packs/<name>/`. See [its README](workflow/packs/README.md).
- **One project:** that project's `CLAUDE.md`, not here.

## How to send a change
1. Open an issue first for a new rule or step. Say what went wrong, with one example.
2. Make the change. A rule needs a real reason: something that happened, not something that might.
3. Run `./check.sh`. It fails if the core names one technology, a path is wrong, a skill lost its guard or the stop hook broke.
4. Changed a rule or a skill? Also run `tests/work.sh`. It checks that `/work` still picks the right track, using real Claude runs.
5. Add a line to `CHANGELOG.md`.
6. Open a pull request.

## Before you publish anything
Never put a real company, client, customer or person in the kit. Use fake data. To catch your own words, list them in `.check-words.local` (git-ignored, one pattern per line): `check.sh` fails if one gets in.
