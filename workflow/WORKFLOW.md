# Workflow

One entry point for everything: **`/work <what you want>`**. Claude looks at the code, picks the track with the rules below, and you confirm. Then **`/next`** runs the next step of that track. **`/work status`** lists the open items and the next step of each.

You do the steps marked 👤: approve, apply database changes, send emails, deploy. Claude never applies a database change, never sends an email, never creates a tag. Project rules may add more.

## 1. Choose the track

First match wins. Claude proposes, your choice stands.

| # | If | Track | Doc |
|---|---|---|---|
| 1 | You ask or want to understand something | **Question** | none |
| 2 | The cause and the change are obvious, no database change, no contract change, 2 code files or fewer (tests not counted) | **Trivial** | none, a commit |
| 3 | Something does not work as designed or documented: wrong result, error, crash, wrong data | **Bug** | `docs/bugs/YYYY-MM-DD-<name>/bug.md` |
| 4 | Needs something new from Project rules: Words for size (an endpoint, a table) or a screen, or the client must sign off on new rules | **Small feature** if one slice (about 10 files or fewer, one or two stories), else **Big feature** | `docs/features/YYYY-MM-<name>/feature.md`, or the full feature folder |
| 5 | Existing behavior should work differently | **Change** (about 10 files or fewer, nothing new from Project rules: Words for size) | `docs/changes/YYYY-MM-DD-<name>/change.md` |

**Moving an item.** Any step can show the item is on the wrong track: a bug that works as designed (→ change), a bug fix or change that needs something new from Project rules: Words for size or grows past ~10 files (→ feature), a small feature that needs more than one slice (→ big feature), a change that is really a one-liner (→ trivial). Claude says so and proposes the move. On your yes, the new item carries over what is already written and the old one is marked "Moved to …" with a link. Nothing is redone or deleted.

## 2. Tracks at a glance

Every track is a recipe over the same eight steps (`~/.claude/workflow/steps/`), at a depth that fits its size.

| Step | Trivial | Bug | Change | Small feature | Big feature |
|---|---|---|---|---|---|
| **intake**: record the request | | `/start-bug` | `/work` | `/work` | `/start-feature`, `/extract-client-requirements` |
| **understand** ⛔ | | `/investigate-bug`: root cause | current vs wanted | light requirements (+ `/client-validation` if needed) | `/analyze-client-emails`, (`/client-questions`), `/write-requirements`, `/client-validation` |
| **impact** | | blast radius, in `/investigate-bug` | with understand | with decide | `/impact-analysis` |
| **decide** ⛔ | | `/plan-fix` | ✓ | ✓ (architecture + code) | `/design-feature`, then `/build-slice` per slice |
| **plan** ⛔ | exact code, in chat | `/plan-fix`: short plan | short plan | short plan | `/build-slice`: slice plan |
| **apply** ⛔ diff | ✓ | `/fix-bug` | ✓ | ✓ | `/build-slice` per slice, then `/final-review` |
| **ship** | changelog line if visible | `/ship-fix` | ✓ | ✓ | `/deliver-feature` |
| **learn** ⛔ | | ✓ | ✓ | ✓ | `/close-feature`, then ✓ |

✓ = run by `/next`. You never need the command names: `/next` reads the item's `Next:` line and runs the right step or skill. A Question gets an answer, nothing else.

### The same four approvals everywhere
1. ⛔ **Understand**: the root cause (bug), the scope (change), the requirements (feature).
2. ⛔ **Decide**: how it's done. Claude shows its recommendation and at most 2 alternatives (your way included, if you gave one). You pick, or say "ok". Your decision stands.
3. ⛔ **Plan**: the code before it exists, short: signatures, files, tests and a size line. Exact code (current → new) only for database changes, permission checks and public contracts.
4. ⛔ **Diff**: the real code, which follows the plan. Any difference stopped for your approval and is recorded in the doc.

Nothing is written in the code or the database files before approval 3. A trivial item has only 3 and 4, in chat. With nothing to decide, approval 2 is skipped: the facts are recorded and the plan comes next.

---

## Question
Ask normally, or `/work <question>`. Claude reads the code and docs and answers. No doc, no gate. If the answer is durable knowledge missing from `docs/system/`, Claude offers to add it.

## Trivial
- [ ] `/work <what>`: Claude shows the exact change (current → new, and a test if logic changes) ⛔
- [ ] Claude applies it, runs tests, vet, build, shows the diff ⛔
- [ ] Your OK → commit (`fix` / `chore` / `refactor(<scope>)`). A CHANGELOG line if someone outside the team will notice.

## Bug
Everything for one bug is in **one file**: `docs/bugs/YYYY-MM-DD-<name>/bug.md` (+ `diagnostics.md` only when a query is really needed).

| # | You type | Claude writes | Your job | Gate |
|---|---|---|---|---|
| 1 | `/start-bug <what's wrong>` | `bug.md` §1 + index row | Correct the severity or branch if wrong, answer **TO ASK** | |
| 2 | `/investigate-bug` | §2 call path, hypotheses, evidence · §3 root cause · §4 blast radius | 👤 Run the queries / log commands, if any, paste results | ⛔ cause |
| 3 | `/plan-fix` | §5 recommendation + options (your way if given) · §6 short plan, size line, database change, data repair, regression test | Pick an option or give your way, review the plan | ⛔ solution (if there is something to decide), ⛔ plan |
| 4 | `/fix-bug` | test (fails) → database change → code as §6 → verify → §8 | 👤 Apply the database change on dev, review the diff | ⛔ diff |
| 5 | `/ship-fix` | §9 reply draft + deploy checklist · changelog | 👤 Send the reply, apply the database change in prod, deploy, verify | |
| 6 | `/next` | learn: Claude's remarks from `learn.md`, each with the exact text to add | Say yes or no to each | ⛔ each remark |

- **Severity:** **P1** production blocked or data getting corrupted now · **P2** wrong, with a workaround · **P3** minor.
- **Root cause:** it must explain **every** symptom, with evidence (`file:line`, query result, log). A diagnostic query only when the code can't prove it and the answer changes the fix; read-only; you paste IDs and counts, never personal data.
- **Blast radius:** other callers, other repos, how many rows are already wrong, what was already sent wrong.
- **P1 hotfix:** mitigate first if possible (redeploy the previous commit, undo the last set (the `UNDO:` line of each file), a manual workaround, Project rules: Deploy). Root cause and solution can come in one message. **The plan approval is never skipped.** Deploy, then finish §8-§10.
- **Data repair:** its own script, after the fix (so no new bad rows appear): preview count first, old values kept, and its `UNDO:` line restores them. Rules: `~/.claude/workflow/database.md`.
- Found something else while fixing? It goes to the **Backlog** of `docs/bugs/README.md`, not into this fix.

## Change
Existing behavior should work differently. Everything in **one file**: `docs/changes/YYYY-MM-DD-<name>/change.md`.

**Docs-only change** (no code, no database change): steps 1 and 2 below are one stop, and the plan is the draft text (`~/.claude/workflow/steps/understand.md`).

| # | You type | Claude writes | Your job | Gate |
|---|---|---|---|---|
| 1 | `/work <what should change>` | §1 request, current vs wanted with before/after examples · §2 impact: who sees the difference, data and consumers, existing data, API contract, size | Check the examples and who is affected | ⛔ scope |
| 2 | `/next` | §3 recommendation + options, decisions | Decide | ⛔ if there is something to decide |
| 3 | `/next` | §4 short plan, size line, database change, data change, tests, docs | Review the plan | ⛔ |
| 4 | `/next` | tests → database change → code as §4 → verify → §6 plan vs done | 👤 Apply the database change on dev, review the diff | ⛔ diff |
| 5 | `/next` | §7 changelog ("Changed"), notice to whoever sees the difference, deploy checklist | 👤 Send the notice, apply the database change in prod, deploy | |
| 6 | `/next` | learn: Claude's remarks from `learn.md`, each with the exact text to add | Say yes or no to each | ⛔ each remark |

The difference from a bug: nothing is broken, so there is no root cause to prove. What matters is **who depends on today's behavior** (Project rules: Who sees the difference) and whether existing data follows the new rule.

## Small feature
Something new that fits one slice. Everything in **one file**: `docs/features/YYYY-MM-<name>/feature.md` (+ `00-client-requirements.md` if the request came with long emails or attachments, + `test-guide.md` if the suite can't reach the behavior).

| # | You type | Claude writes | Your job | Gate |
|---|---|---|---|---|
| 1 | `/work <the new need>` | §1 request · §2 stories, rules, examples (normal, edge, failure), out of scope | Review the examples: they become the tests. Client must confirm? `/client-validation` drafts the email | ⛔ requirements |
| 2 | `/next` | §3 impact · §4 options for architecture and code, decisions | Decide | ⛔ if there is something to decide |
| 3 | `/next` | §5 short plan: size line, the database change, types, signatures, entry point, public contract, files, tests | Review the plan | ⛔ |
| 4 | `/next` | tests → database change → code as §5 → verify → docs, runnable requests → §7 plan vs done | 👤 Apply the database change on dev, review the diff | ⛔ diff |
| 5 | `/next` | §8 changelog ("Added"), short delivery note per audience, deploy checklist | 👤 Send, apply the database change in prod, deploy | |
| 6 | `/next` | learn: Claude's remarks from `learn.md`, each with the exact text to add | Say yes or no to each | ⛔ each remark |

## Big feature
Something with several stories. One folder `docs/features/YYYY-MM-<name>/` with one file per phase. No client emails (your own idea, an issue)? Skip phases 2, 3, 3b and 5, and start `/write-requirements` from your description.

| # | You type | Claude writes | Your job | Gate |
|---|---|---|---|---|
| 1 | `/start-feature <name> for <client>` | the folder + index row | Correct the branch if wrong. 👤 Drop the emails in `.correspondence/` | |
| 2 | `/extract-client-requirements` | `00-client-requirements.md` (step 0) | Check nothing the client sent is missing | |
| 3 | `/analyze-client-emails` | `01-email-analysis.md` | Check the open questions | |
| 3b | `/client-questions` (optional) | `01b-client-questions.md` (email draft) | 👤 Send it, paste the answers back | ⛔ client answers |
| 4 | `/write-requirements` | `02-requirements.md` | Review stories, rules, examples | ⛔ |
| 5 | `/client-validation` | `03-client-validation.md` (email draft) | 👤 Send it, paste the answers back | ⛔ client confirms |
| 6 | `/impact-analysis` | `04-impact-analysis.md` | Check the risks | |
| 7 | `/design-feature` | architecture choices → `05-design.md` + `progress.md` | Decide the choices, review DB design and slices | ⛔ choices, ⛔ design |
| 8 | `/build-slice` (repeat) | implementation choices → `slices/slice-N.md` → code, tests, database change, docs | Decide how it's coded, approve the plan, 👤 apply the database change on dev, review the diff | ⛔ choices, ⛔ plan, ⛔ diff |
| 9 | `/final-review` | `06-review.md` | Confirm database changes were tested | ⛔ |
| 10 | `/deliver-feature` | `07-delivery.md` + one package per audience | 👤 Send, apply the database change in prod, deploy | |
| 11 | `/close-feature` | `08-feedback.md`, then the learn step | Say yes or no to each remark | ⛔ each remark |

- **A slice** is one part of the feature built end to end (database, code, tests, docs), small enough to really review, leaving the system working. Example for a discount feature: slice 1 = create and list discounts, slice 2 = apply them to orders, slice 3 = reports.
- **Three levels of validation before code:** the feature design (`05-design.md`: architecture, data model, public surface, slices), the slice choices (in chat: reuse vs new, where validation lives, error codes), the slice plan (`slices/slice-N.md`: exact types, signatures, database inputs and outputs, query logic, files, tests).
- **One slice per session.** `/clear` between slices; every session starts from `progress.md` and the current slice plan.
- **Client questions (optional):** when the answers to the open questions of `01-email-analysis.md` change the requirements, ask them first: `/client-questions` drafts the email in `01b-client-questions.md`; 👤 you send it and paste the answers back; Claude records them in `00` and `01`, then `/write-requirements`. Questions that don't change the requirements go out later, with the requirements, in `/client-validation`.
- **Client validation:** Claude drafts the email in `03-client-validation.md`; 👤 you put the names in and send it; when the client answers, paste it: *"client answered: …"*. Claude updates the requirements.

---

## Applying a database change (every track)
👤 On dev, in the set README's order: once, then tell Claude. Each file's `UNDO:` line says how to undo it in production if something breaks. In production at delivery: backup → change → deploy → verify → whatever Project rules: Deploy says must be regenerated. Rules: `~/.claude/workflow/database.md`.

## Deploying (every track)
👤 The steps of Project rules: Deploy. Other repos if touched. Smoke test with the runnable requests.

## Rules to remember
- **Never skip a ⛔.** If Claude moves on without approval, say: *"follow the STOP steps"*.
- **Same fix fails twice:** stop, `/clear`, restart with the exact error.
- **Quality drops in a long session:** let Claude update the item doc, `/clear`, `/next`.
- The rest is in `CLAUDE.md` (talk, ask, code, rules).

## Where things are

| What | Where |
|---|---|
| How the system works now | `docs/system/README.md` |
| Project facts and rules | the project's `CLAUDE.md`, `## Project rules` |
| Bugs / changes / features (index + one folder each) | `docs/bugs/`, `docs/changes/`, `docs/features/` |
| Database changes of an item | `docs/migrations/<item-folder>/` + `README.md`, or as Project rules: Database says |
| Claude's remarks on an item | `learn.md` in the item's folder |
| Support for one technology | `~/.claude/workflow/packs/` |
| Why a pattern was chosen | `docs/decisions/` |
| Client context (languages, audiences) | `docs/clients/<client>.md` |
| How to write a handover for other developers | `~/.claude/workflow/handover-package.md` |
| Raw emails (never committed) | `.correspondence/<client>/<item-folder>/` |
| Changelog | `docs/releases/CHANGELOG.md` |
| Steps (how Claude runs each step) | `~/.claude/workflow/steps/` |
| Skills / agents | the kit, linked into `~/.claude/`; a project's own skills in its `.claude/skills/` |
