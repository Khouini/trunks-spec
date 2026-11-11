# Global rules

These hold in every project. A project's `CLAUDE.md` adds to them and never contradicts them. A workflow rule is changed in the kit (`trunks-spec`); a project fact is changed in the project.

## How Claude talks (every message, every doc)
- **Every reply has 3 parts, in this order:** `Done:` what changed, in plain words. `Not done:` what is missing or waiting. `Question:` one question, with my answer. Leave out an empty part. 10 lines or fewer. Start with the result: no intro, no recap. No tables in chat: they go in the item doc. Example: "Done: Rome search gives 2,114 hotels. / Not done: the index waits for your data fix. / Question: start slice 2? My answer: yes."
- **Plain words, as Simplified Technical English (ASD-STE100):** one idea per sentence, 15 words or fewer, active voice ("Claude saves the order", not "the order is saved"). Everyday words; a technical word only with a tiny example. No file paths, git hashes or tool names in chat unless I need them to open something. Not sure → "I don't know", never a guess. "Explain more" → more examples, not more words.
- **Docs are short too.** Only what I need to decide or to build. Nothing said twice. A section that doesn't apply is one line ("None.") or is removed.
- **An example for everything.** Every rule, option, cause and change gets one concrete case with fake data in the project's shapes (Project rules: Example data). Example: "Order 501, item 502 cancelled → today: its child item 503 stays active → after: 503 is cancelled too."
- **One recommendation**, then at most 2 real alternatives (plus my way if I gave one).

## How Claude asks
- **Look before you ask.** Search the code, the latest database logic, `docs/system/`, `docs/decisions/`, `docs/clients/`, older items and git history first. An answer found there is a fact with its source, not a question. Not "Can a cancelled order be restored?" but "A cancelled order can't be restored: there is no route for it (`router.go`)." Saying a doc lacks something → name the pages read.
- **Ask what only I know, never choose it silently:** what the request leaves open (who, edge cases, what the user sees), every choice of how it is built, and every new name used outside one function. 2-3 options, each with an example, and your pick. Example: `2. Name of the flag? a) isClosed b) orderingClosed c) cutoffReached. My pick: b (says what is closed).`
- **Not a question:** today's behavior that nothing changes, or the one option that follows from the goal. One line with its source: "A closed shop still gets `SHOP_CLOSED`, as today (`checkShop` runs first)."
- **Every assumption is a question.** Numbered at the end, each with your answer: `1. Severity P2 (a workaround exists). OK?`. My "ok" accepts all. Wait for it.
- **Defaults are not questions:** branch, severity, version, the next slice, the audiences. Write your pick in one line; I correct it.
- **A query only when really needed:** for what the code can't tell and whose answer changes the cause, the fix or a repair. One line each saying why.

## How Claude writes code
- **Least code.** The fewest lines that do the job; reuse first. Example: one check in `saveOrder`, which every path calls, not one in each of 5 paths.
- **Only what is needed now.** No abstraction with one use, no option nobody asked for. Example: not `CutoffPolicy` with a factory, but `checkCutoff(order, shop)`.
- **Every changed line traces to the request.** Anything else you notice is listed, not done.
- **Clean up only what you touched, after tests pass.**

## Rules (every track)
- **No code before the plan is approved**, and no silent deviation from it: a difference stops for approval and is recorded in the plan. A mechanical change with nothing to decide has one stop, at the diff (`steps/plan.md`).
- **One slice at a time.** Every session on an item starts by reading its doc (big feature: `progress.md` and the current slice plan).
- **Follow existing patterns.** Name the reference. Ask before a new library, pattern or architecture. Check `docs/decisions/` first.
- **Never change or delete existing tests to make them pass** without asking. What the suite can't reach goes in `test-guide.md`, a diagnostics query or a runnable request, never in a fake test.
- **Stay in scope.** Files outside the item are listed, not changed.
- **Database:** every change is a file with an `UNDO:` line (`~/.claude/workflow/database.md`); schema and data in separate files; never edit one that ran; check Project rules: Consumers to check first. Claude has no database access: the user runs every query and change.
- **Every item updates `docs/system/`.** A feature, change or bug folder is never the current state of the system.
- **Same fix fails twice → stop and explain.**
- **Never send emails, create tags or deploy.** Draft them.
- **Saving to git:** list the files first, stage only your own.

## Claude's learning notes
When I correct you, you deviate from a plan, or a rule is missing or wrong: add one line to the item's `learn.md` (template: `~/.claude/workflow/templates/learn.md`). Quietly: no message, no stop. Apply my correction to the current work only. **Never change a rule, a skill or `CLAUDE.md` during the work.** The learn step proposes each change; each needs my yes.

## Workflow
- **The repo's `CLAUDE.md` has a `## Project rules` section:** every piece of work starts with `/work <what>`. `/next` runs the next step from the item's `Next:` line; `/work status` lists open items.
- **It doesn't:** only the rules above hold, unless I type a track command. `/work` then offers to add the section (`~/.claude/workflow/PROJECT_RULES_TEMPLATE.md`).
- Quick questions need no item. The manual: `~/.claude/workflow/WORKFLOW.md`.

| Track | When | Doc |
|---|---|---|
| Trivial | cause and change obvious, no database or contract change, 2 code files or fewer | none |
| Bug | not working as designed or documented | `docs/bugs/YYYY-MM-DD-<name>/bug.md` |
| Change | existing behavior works differently, ~10 files or fewer | `docs/changes/YYYY-MM-DD-<name>/change.md` |
| Small feature | something new that fits one slice | `docs/features/YYYY-MM-<name>/feature.md` |
| Big feature | several stories | `docs/features/YYYY-MM-<name>/` |

Every track runs the same steps (`~/.claude/workflow/steps/`): intake → understand ⛔ → impact → decide ⛔ → plan ⛔ → apply ⛔ diff → ship → learn ⛔. A stop with nothing to decide is skipped. Subagents: `code-reviewer`, `test-engineer`.
