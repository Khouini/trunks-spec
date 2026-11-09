# Step: plan (the code before it exists) ⛔

**Nothing is applied here.** No code, database or test file is created or changed; the plan is written in the item's doc so I see the exact code first.

**Only what I decided.** Every name and every implementation choice in the plan comes from the decisions (`decide.md`). If the plan needs a name or a choice that isn't decided yet, stop before writing it and ask: 2-3 options, each with an example and your recommendation.

| Track | Writes | Form |
|---|---|---|
| Trivial | in chat | A |
| Bug | `bug.md` §6 (`/plan-fix`) | A |
| Change | `change.md` §4 | A |
| Small feature | `feature.md` §5 | B (+ A for edits to existing code) |
| Big feature | `slices/slice-N.md` from `~/.claude/workflow/templates/feature/slices/slice-N.md` (`/build-slice`) | B (+ A for edits to existing code) |

## Form A: exact code (edits to existing code)
**One "Change" block per function or fragment**: file, function, why, the **Current** code copied with `file:line`, and the **New** code exactly as it will be written: the complete function or block, no `...`, no "similar to". Follow the project's code conventions (`AGENTS.md`, if it has one).

## Form B: code-level plan (new code)
- **Database:** the exact change (schema, stored logic, data). For logic in the database: inputs, outputs, errors and steps. Add what the project's pack asks, if it uses one.
- **Code:** request and response types with their tags, validation rules, the route with its middleware, handler and service signatures, code reused (`file:line`), side effects. Add what Project rules: Plan details lists.
- **Public contract:** the exact input and output (for an API, request and response JSON), error table (status, code or message, when).

## Both forms
- **Logic in the database:** the changed fragment as Current / New. The full version and how to undo it go in the change file (`~/.claude/workflow/database.md`).
- **Consumers checked** when a query, schema or contract changes: Project rules: Consumers to check.
- **Schema:** the exact change. Schema and data changes in separate files. Big tables: add first, backfill in batches, constrain last, with the expected run time.
- **Data change** (if decided): the full script, the row condition, the preview count (diagnostics Qn → N rows), how the old values are kept and how to restore them. Always its own file, applied after the change that stops new bad rows.
- **Tests:** for each: name, input, expected, why it fails before the code.
  - Logic the suite can reach: following a similar existing test and Project rules: Test rules. Case names start with the ID they protect: `"BUG: …"`, `"CHANGE: …"`, `"BR-03: …"`. Form A: the full test code. Form B: the test names and what each covers.
  - Logic the suite can't reach (logic in the database, a live external system): a `test-guide.md` scenario (request, preconditions, expected) and the runnable request. A diagnostics query (bad rows before, none after) only if stored data is wrong. **Never a test that fakes that logic from guesses.**
- **Files** table (file, create/change, what), laid out as the project's conventions say, **Not changed (on purpose)**, the `docs/system/` files to update, and the **deploy order** (can the database change go ahead of the code deploy, or must they go together?).
- **Size check:** past ~10 files, or a new thing from Project rules: Words for size on a bug or change → say so and follow `~/.claude/workflow/steps/intake.md`, "Moving an item".

## Review before the gate
A plan whose correctness rests on claims about the code or the docs (new or rewritten docs, a checklist, a design, a plan citing many `file:line`): run the `code-reviewer` subagent on the plan **before** the STOP and fix what it finds.

## STOP
Status "Plan", `Next:` approval of the plan. I review each change and may rewrite any line. Update the plan until I say **approved**, then status "Approved", `Next:` apply.

Assumptions and open questions: only if there are some.
