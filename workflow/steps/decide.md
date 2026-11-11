# Step: decide (how it will be done) ⛔

**Nothing is written in the code or the database files here.** The output is a set of decisions I made.

| Track | Writes decisions in | Questions |
|---|---|---|
| Bug | `bug.md` §5 (`/plan-fix`) | Bug |
| Change | `change.md` §3 | Change + Code |
| Small feature | `feature.md` §4 | Architecture + Code, in one discussion |
| Big feature | `05-design.md` (`/design-feature`), then `slices/slice-N.md` §1 (`/build-slice`) | Architecture, then Code per slice |

## Steps
1. **Read first**: every file and the latest version of any database logic the item may touch, the docs of the area, and the code around them (helpers, types, validation functions, other callers) that could be reused. Note it as `file:line`.
2. **My way:** if I already said how I want it, it is one of the options (the decision, if it's the only sensible one). If I didn't, propose your recommendation as a question, not as a decision.
3. **Options:** your recommendation first, then at most 2 real alternatives (+ my way if I gave one). One line each: what changes and an example of the result. If my way has a problem (doesn't solve it, breaks a consumer, risks data), say so plainly with the evidence. After that, **my decision stands**.
4. **Checklist to find the questions.** Walk through the list below. It is for you, not for the doc: don't write a line per item. Each item that applies is a numbered question in this form, in the doc and in chat: **Problem** in one plain line; **Example** with fake data, today → after each option; **Options** (2-3); **Recommended** with a one-line why. I pick (`CLAUDE.md`, "How Claude asks"). **Every new name** the plan will need (API and data fields, database columns and parameters, commands, error codes, types) is a question too, asked here, never chosen in the plan. Not a question: an item where one option keeps today's behavior and nothing gives a reason to change it; write it as a fact with its source.
   Project rules: Extra rules can add questions and things to read first.
   - **Bug:** fix at the root or guard at the symptom; in which layer; minimal now or the proper fix (the other as a follow-up); repair existing data or not, which rows (all, since a date, only the reported ones); for everyone or only the affected part; a guard so the bad data can't come back.
   - **Change:** in which layer; existing data follows the new rule (backfill) or only new rows; for everyone or behind a setting; keep the old behavior reachable or not; contract change or additive (new optional field); can the database change go ahead of the code deploy.
   - **Architecture:** which layer or service owns the logic; a new table/column or an existing one; a new package or extend one; synchronous or background; which store; which existing feature to copy.
   - **Code:** extend an existing function or type, or add one; where validation goes; one function with a flag or two; response shape; type shapes and naming; error codes and statuses; what to reuse. Your recommendation is the option with the least code that does the job.
5. **Nothing to decide:** no new name and no real choice, because every answer follows from my words, the code or an earlier decision. Record them as facts with their source, skip the STOP and go straight to the plan. Same for one sensible option when I already said how.
6. Decisions made at an earlier level (`05-design.md` for a slice) are not reopened unless the code shows a problem; then say so.
7. **STOP.** In chat (no table): every numbered question in the step 4 form, the same text as the doc. Clear beats short here: the 10-line limit does not apply to these questions. My "ok" accepts them all. Discuss until every question has a decision. Record in the doc my words ("What you want"), the options and the decisions (one line each). Status "Solution" (big feature: as its skill says), `Next:` plan.

Assumptions and open questions: only if there are some.
