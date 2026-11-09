# Step: understand (what is really asked) ⛔

No fix and no design here. The output is an understanding I approve.

| Track | How | Writes | Gate |
|---|---|---|---|
| Bug | `/investigate-bug` (call path, hypotheses, evidence, root cause) | `bug.md` §2-§3 | I confirm the cause |
| Change | "Change" below, then `~/.claude/workflow/steps/impact.md` | `change.md` §1-§2 | I confirm the scope |
| Small feature | "Small feature" below | `feature.md` §2 | I approve the requirements |
| Big feature | `/analyze-client-emails`, `/client-questions` (optional), `/write-requirements`, `/client-validation` | `01`, `01b`, `02`, `03` | I approve, the client answers and confirms |

## Change: current vs wanted
1. **Trace today's behavior** from the entry point to the data, with `file:line` (Project rules: Trace path). For logic in the database, read its **latest version** (Project rules: Database).
2. **Write §1:**
   - **Current behavior**: what the system does today, in plain words, with `file:line` and one concrete example.
   - **Wanted behavior**: the request in testable terms.
   - **Before / after examples**: normal, edge, failure. Input → today → after the change. Realistic fake data (Project rules: Example data). These become the tests. One table, no extra "in detail" text.
   - **TO ASK**: every point of the wanted behavior the request doesn't say (who it applies to, edge cases, what stays the same, what the user sees). Not written as a fact: a numbered question with your answer (`CLAUDE.md`, "How Claude asks").
3. **Check `docs/decisions/`** and the project's module docs: is today's behavior a recorded decision? Say so; changing it may need an ADR update.
4. **Right track?** Today's behavior is not what was designed or documented → bug. It needs something new from Project rules: Words for size, or a screen → feature. Then `~/.claude/workflow/steps/intake.md`, "Moving an item".
5. Run `~/.claude/workflow/steps/impact.md` (change depth) into §2.
6. Status "Scope". **STOP**: in chat, the TO ASK questions and one line asking me to confirm the examples. Wait for my answers. After my OK: status "Scoped", `Next:` decide.
   **Docs-only change** (no code, no database change, no contract change): write §3 (options, recommendation, decisions) in the same pass and stop **once** for scope and solution together. Its plan (§4) holds new docs in full in the item's `draft/` folder and edits as current → new; apply copies them and deletes `draft/`.

## Small feature: light requirements
Same rules as `/write-requirements`, shorter, in `feature.md` §2:
1. **Stories** US-01… ("As a <role>, I want <action> so that <benefit>"; roles: Project rules: Example data) and **rules** BR-01…, each linked to its stories.
2. **Examples** for each rule: normal, edge, failure, as a table (input → expected), realistic fake data. They become the tests.
3. **Acceptance criteria**: Given / When / Then, one or two per story.
4. **Out of scope**, explicit. Name the surfaces (Project rules: Example data).
5. **Non-functional** only if relevant: permissions, audit, timeouts, languages (Project rules: Example data).
6. **Contradictions** with how the system works today (read the code, the docs and the latest database logic). **Questions:** every rule, story or out-of-scope line that the request doesn't state is a numbered question with your answer, not a fact (`CLAUDE.md`, "How Claude asks").
7. **Client validation:** if the client must confirm a rule or an ambiguity, say so; `/client-validation` drafts the email into §2 "Client validation" and status becomes "Validation" until the answer is recorded. Otherwise write "No client validation: <why>".
8. **Right track?** More than one slice of work (several stories, ~10+ files) → big feature (`~/.claude/workflow/steps/intake.md`, "Moving an item").
9. Status "Requirements". **STOP**: in chat, the questions and one line asking me to approve. Wait for my answers. After my approval (and the client's, if needed): status "Scoped", `Next:` impact + decide.

Assumptions and open questions: only if there are some.
