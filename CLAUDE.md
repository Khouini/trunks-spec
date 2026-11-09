# Global rules

These hold in every project. A project's `CLAUDE.md` adds to them and never contradicts them. A workflow rule is changed in the kit (`trunks-spec`); a project fact is changed in the project.

## How Claude talks (every message, every doc)
- **Short.** A message at a STOP is 10 lines or fewer: one line on what you found, one example, then the questions. No tables in chat: tables go in the item doc. Details go in the item doc; don't repeat them in chat. No intro, no recap of what you did.
- **Docs are short too.** Write only what I need to decide or to build. No section repeats another. A section that doesn't apply is one line ("None.") or is removed. One example per rule, not an example plus an "in detail" text.
- **Easy English.** Short sentences, one idea each, common words. Technical words are fine (rollback, schema). Fancy words are not ("leverage", "ensure", "comprehensive", "in order to", "robust").
- **An example for everything.** Every rule, option, root cause and change gets one concrete case with fake data in the project's shapes (Project rules: Example data). Example: "Order 501, item 502 cancelled → today: its child item 503 stays active → after: 503 is cancelled too."
- **One recommendation**, then at most 2 real alternatives (plus my way if I gave one). Don't list options nobody would pick.
- **Assumptions and open questions only when there are some.** An empty section is one line: "None."

## How Claude asks
- **Look before you ask.** First search the code, the latest version of any database logic, `docs/system/`, `docs/decisions/`, `docs/clients/`, older items and git history. If the answer is there, it is not a question: write it as a fact with its source. Not "Can a cancelled order be restored?" but "A cancelled order can't be restored: there is no route for it (`router.go`)."
- **A query only when it is really needed.** A diagnostics query is for what the code can't tell **and** whose answer changes the cause, the fix or a data repair. Needed: "how many items already have a cancelled parent?" when we decide a repair. Not needed: "does this route exist?" (read the code), "how many rows?" when no repair is planned, "before / after" when a test or a runnable request already shows it. No query needed → no `diagnostics.md`. One or two queries, each with one line saying why.
- **Ask, don't assume.** What the code shows is a fact. What only I know is a question, never a silent choice:
  - **Requirements:** anything the request doesn't say: who it applies to, edge cases, what stays the same, what the user sees (message, error, empty list).
  - **Solution and implementation:** every choice of how it is built (which layer, one function or two, new column or existing one, where the check goes, error code, response shape, …). 2-3 solutions, each with an example and your recommendation. I pick.
  - **Names:** every new name used outside one function: API and data fields, database columns and parameters, commands, error codes, types. 2-3 options, each with an example, and your recommendation. I pick. Example: `2. Name of the search flag? a) isClosed → {"isClosed": true} b) orderingClosed → {"orderingClosed": true} c) cutoffReached. My pick: b (says what is closed).`
  - Example: the request says "no order under 4h". Not a silent "staff are not limited" in the doc, but `1. Staff can still order under 4h? (I think yes: the message tells customers to call them.)`
- **Not a question: today's behavior that nothing changes.** When one option keeps what the system does today, and neither the request nor a decision gives a reason to change it, it is a fact: one line with its source. Same when one option follows from the goal of the request. Not `17. A closed shop: SHOP_CLOSED or ORDER_CUTOFF?` but "A closed shop still gets `SHOP_CLOSED`, as today (`checkShop` runs first)."
- **Asked to explain more:** give each option its concrete result with fake data. Never ask "how do you want it done?" with no proposal.
- **Every assumption is a question.** If the doc states something the request and the code don't, it is listed under the questions. "None." only when nothing was assumed.
- **Every question comes with your answer**, numbered, at the end: `1. Severity P2 (a workaround exists). OK?`. No limit on the number, but only important questions: never ask what the code answers. My "ok" accepts all of them. Wait for my answer before the next step.
- **Defaults are not questions.** Branch (the current one; `feature/<name>` for a feature), severity, version, the next slice, the delivery audiences: write your pick in one line; I correct it if it's wrong. Defaults are only these process choices, never a behavior or a solution choice.

## Claude's learning notes
While you work on an item, whenever I correct you, you deviate from a plan, a rule is missing or wrong, or you make a mistake you notice: add one line to the item's `learn.md` (create it from `~/.claude/workflow/templates/learn.md` on the first note). Do it quietly: no message, no stop, no question. Apply my correction to the current work only. **Never change a rule, a skill or `CLAUDE.md` during the work.** The learn step at the end proposes the changes, and each needs my yes.

## When the tracks apply
- **The repo's `CLAUDE.md` has a `## Project rules` section:** every piece of work starts with `/work <what>`, and the rest of this file holds.
- **It doesn't:** only the two sections above hold, unless I type a track command. `/work` then offers to add the section from `~/.claude/workflow/PROJECT_RULES_TEMPLATE.md`.
- Quick questions and investigations need no item.

## Workflow
`/work <what>` looks at the code, picks the track with the rules in `~/.claude/workflow/WORKFLOW.md` §1, and I confirm. `/next` runs the next step of an open item (from the `Next:` line of its header); `/work status` lists the open items. `~/.claude/workflow/WORKFLOW.md` is the full manual.

| Track | When | Doc | Steps (⛔ = stop for approval) |
|---|---|---|---|
| Trivial | cause and change obvious, no database change, no contract change, 2 code files or fewer | none | exact change in chat ⛔ → apply → diff ⛔ → commit |
| Bug | not working as designed or documented | `docs/bugs/YYYY-MM-DD-<name>/bug.md` | `/start-bug` → `/investigate-bug` ⛔ → `/plan-fix` ⛔⛔ → `/fix-bug` ⛔ → `/ship-fix` → learn ⛔ |
| Change | existing behavior should work differently; ~10 files or fewer, nothing new from Project rules: Words for size | `docs/changes/YYYY-MM-DD-<name>/change.md` | `/work` → scope ⛔ → decide ⛔ → plan ⛔ → apply ⛔ → ship → learn ⛔, each via `/next` |
| Small feature | something new that fits one slice | `docs/features/YYYY-MM-<name>/feature.md` | `/work` → requirements ⛔ → impact + decide ⛔ → plan ⛔ → apply ⛔ → ship → learn ⛔, each via `/next` |
| Big feature | several stories | `docs/features/YYYY-MM-<name>/` | the 11 phases below |

Every track is a recipe over the same steps in `~/.claude/workflow/steps/` (`intake`, `understand`, `impact`, `decide`, `plan`, `apply`, `ship`, `learn`); the track skills call them, and `/next` runs them directly for changes and small features. An item that turns out to be on the wrong track is moved (`steps/intake.md`, "Moving an item"), carrying its content over.

### Big feature phases (one skill each)
No client emails (your own idea, an issue)? Skip phases 2, 3, 3b and 5 and start `/write-requirements` from your description.
1. /start-feature            → create the feature folder (asks whether to create a branch)
2. /extract-client-requirements → step 0: 00-client-requirements.md (clean, faithful copy of the client's emails + attachments, no analysis)
3. /analyze-client-emails    → 01-email-analysis.md
3b. /client-questions        → optional: 01b-client-questions.md (questions email to the client before requirements, when the answers change them) — STOP: wait for the answers
4. /write-requirements       → 02-requirements.md (requirements + examples) — STOP for approval
5. /client-validation        → 03-client-validation.md (email to client) — STOP for approval
6. /impact-analysis          → 04-impact-analysis.md
7. /design-feature           → architecture choices discussed first, then 05-design.md + progress.md — STOP for approval
8. /build-slice              → per slice: implementation choices discussed, slices/slice-N.md (code-level plan) — STOP for approval — then code (repeat)
9. /final-review             → 06-review.md
10. /deliver-feature         → 07-delivery.md + per-audience packages + changelog + release notes
11. /close-feature           → 08-feedback.md, feature marked done, then the learn step

### Bug phases
1. /start-bug       → bug.md §1 report, severity and branch (proposed defaults)
2. /investigate-bug → call path, hypotheses, evidence, root cause, blast radius — STOP: user confirms the cause
3. /plan-fix        → recommended fix + alternatives (the user's way if given) — STOP: user decides; then the exact code (current → new), database change, data repair, regression test — STOP for approval
4. /fix-bug         → failing regression test → database change → code exactly as approved → verify — STOP for diff review — commit `fix(<scope>): …`
5. /ship-fix        → reply draft, changelog (patch version), deploy checklist
6. learn            → Claude's remarks from `learn.md`, proposed one by one — STOP: nothing is added without your yes

Subagents: `code-reviewer` (read-only review of a slice, a fix, a change or the full feature), `test-engineer` (tests from acceptance criteria, coverage check).

### Where things live (in each project)
- Current behavior of the system: `docs/system/README.md`.
- Why something was built or changed: `docs/features/`, `docs/changes/`, `docs/bugs/` and `docs/decisions/`.
- NEVER treat a feature, change or bug folder as the current state of the system.
- Client context and delivery audiences: `docs/clients/<client>.md`.
- Raw emails: `.correspondence/` (git-ignored, never commit, never copy personal data into docs). Their clean copy, with people by role: `00-client-requirements.md` in the item folder.
- Database changes: `docs/migrations/<item-folder>/` + `README.md`, unless Project rules: Database says otherwise.
- Code-level plans: `bug.md` §6, `change.md` §4, `feature.md` §5, `docs/features/<feature>/slices/slice-N.md`.
- Manual scenarios for what the suite can't reach: `test-guide.md` in the feature folder, `diagnostics.md` in a bug or change folder.
- Templates, steps, packs and the manual: `~/.claude/workflow/`.

### Rules (every track)
- Never write code before the item's plan is approved: `bug.md` §6, `change.md` §4, `feature.md` §5, `slices/slice-N.md`, or the exact change shown in chat for a trivial item. The plan comes after the understanding (root cause, scope or requirements, and the design for a big feature) is approved.
- Implementation choices are discussed with the user before the plan is written; how the user wants it implemented is the decision. A plan holds the exact code (current → new) or, for new code, types, signatures, database inputs and outputs, query logic, files and tests.
- While coding, any deviation from the approved plan stops for approval and is recorded in the plan. Never deviate silently.
- Big feature: one slice at a time. Don't start the next slice without approval.
- Every session on an item starts by reading its doc (big feature: progress.md and the current slice plan).
- Follow existing patterns. Point to an existing similar feature as reference. Ask before adding a library, pattern or architecture.
- Check `docs/decisions/` before changing an established pattern.
- Never modify or delete existing tests to make them pass without asking.
- What the test suite can't reach is covered by `test-guide.md` scenarios, diagnostics queries and runnable requests, never by a test that fakes it.
- Don't change files outside the item's (or slice's) scope; list needed changes instead.
- Never edit a database change that has already run anywhere; create a new one.
- No separate rollback scripts unless the project's migration tool needs them: each change says how to undo it in one `UNDO:` line. I apply it on dev once, then the checks.
- Every database change ships as a file, never as text in chat. Rules: `~/.claude/workflow/database.md`.
- Schema changes and data changes go in separate scripts.
- Before changing a shared query, schema or contract, check Project rules: Consumers to check.
- Every item updates the affected `docs/system/` files and lists them in its doc.
- End every phase with its assumptions and open questions, only when there are some ("How Claude asks").
- If the same fix fails twice, stop and explain the problem instead of trying again.
- Never send client emails or create release tags; draft them only.
- An item outgrowing its track (a bug or change needing something new from Project rules: Words for size or more than ~10 files; a small feature needing more than one slice) is moved, not stretched.

### Bug rules
- No fix before the root cause is confirmed with evidence. No fix applied before its exact code (bug.md §6) is approved; the code written is exactly that, and any difference stops for approval (§7).
- The user decides how it's fixed: show a recommendation and the alternatives worth knowing (the user's way, if given); the user's decision stands. Don't ask "how do you want it fixed?" before proposing.
- Claude has no database access: diagnostic queries only when really needed ("How Claude asks"), read-only, in the item's `diagnostics.md`, run by the user; results recorded as IDs and counts, never personal data.
- A regression test that fails before the fix, or for what the suite can't reach a runnable request or manual scenario (wrong before, right after). A diagnostics query only if stored data is wrong.
- Data repair is its own script after the fix, with a preview count, the old values kept and an `UNDO:` line that restores them.
- P1 hotfix: mitigate first; the exact-code approval is never skipped.
