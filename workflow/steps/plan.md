# Step: plan (the code before it exists) ⛔

**Nothing is applied here.** No code, database or test file is created or changed; the plan is written in the item's doc so I approve it first. Keep it short: I read the real code in the diff.

**Only what I decided.** Every name and every implementation choice in the plan comes from the decisions (`decide.md`). If the plan needs a name or a choice that isn't decided yet, stop before writing it and ask: 2-3 options, each with an example and your recommendation.

**Mechanical change, nothing to decide** (a generator command, a rename, a one-line wiring): the plan is 2-3 lines in the doc (what runs, which files), applied at once. One stop, at the diff. Example: "Run `newsupplier acme 260`; it writes `src/acme/` and 2 config lines."

| Track | Writes | Form |
|---|---|---|
| Trivial | in chat | A |
| Bug | `bug.md` §6 (`/plan-fix`) | B + A for risky code |
| Change | `change.md` §4 | B + A for risky code |
| Small feature | `feature.md` §5 | B + A for risky code |
| Big feature | `slices/slice-N.md` from `~/.claude/workflow/templates/feature/slices/slice-N.md` (`/build-slice`) | B + A for risky code |

## Form A: exact code (only for risky code)
Risky code is where a small slip does real harm: **database changes, permission and access checks, public contracts**. Everything else is form B. A trivial item is form A in chat, because it is that small.

**One "Change" block per function or fragment**: file, function, why, the **Current** code copied with `file:line`, and the **New** code exactly as it will be written: the complete function or block, no `...`, no "similar to".

## Form B: short plan (all other code)
No function bodies. Example: "`checkCutoff(order, shop) error`, new, in `orders/rules`: refuses an order under 4h before closing. Called from `createOrder`. Reuses `shop.ClosingTime` (`shop.go:40`)."
- **Code:** for each function, new or edited: file, signature (current → new), what changes in one line, code reused (`file:line`), side effects. Types with their tags, validation rules and the entry point when new. Add what Project rules: Plan details lists.
- **Database:** the exact change (schema, stored logic, data), as form A. For new logic in the database: inputs, outputs, errors and steps. Add what the project's pack asks, if it uses one.
- **Public contract:** the exact input and output (for an API, request and response JSON), error table (status, code or message, when).

## Both forms
- **Logic in the database:** the changed fragment as Current / New. The full version and how to undo it go in the change file (`~/.claude/workflow/database.md`).
- **Consumers checked** when a query, schema or contract changes: Project rules: Consumers to check.
- **Schema:** the exact change. Schema and data changes in separate files. Big tables: add first, backfill in batches, constrain last, with the expected run time.
- **Data change** (if decided): the full script, the row condition, the preview count (diagnostics Qn → N rows), how the old values are kept and how to restore them. Always its own file, applied after the change that stops new bad rows.
- **Tests:** for each: name, input, expected, why it fails before the code.
  - Logic the suite can reach: following a similar existing test and Project rules: Test rules. Case names start with the ID they protect: `"BUG: …"`, `"CHANGE: …"`, `"BR-03: …"`. No test code in the plan.
  - Logic the suite can't reach (logic in the database, a live external system): a `test-guide.md` scenario (request, preconditions, expected) and the runnable request. A diagnostics query (bad rows before, none after) only if stored data is wrong. **Never a test that fakes that logic from guesses.**
- **Files** table (file, create/change, what), laid out as the project's conventions say, **Not changed (on purpose)**, the `docs/system/` files to update, and the **deploy order** (can the database change go ahead of the code deploy, or must they go together?).
- **Size line** (an estimate): `+40/-5, 2 files. Simpler option rejected: one check per path (+90), because it repeats the rule 5 times.` Nothing simpler exists? Say so: `Simpler option: none.`
- **Size check:** past ~10 files, or a new thing from Project rules: Words for size on a bug or change → say so and follow `~/.claude/workflow/steps/intake.md`, "Moving an item".

## Review before the gate
A plan whose correctness rests on claims about the code or the docs (new or rewritten docs, a checklist, a design, a plan citing many `file:line`): run the `code-reviewer` subagent on the plan **before** the STOP and fix what it finds.

## STOP
Status "Plan", `Next:` approval of the plan. I review each change and may rewrite any line. Update the plan until I say **approved**, then status "Approved", `Next:` apply.

Assumptions and open questions: only if there are some.
