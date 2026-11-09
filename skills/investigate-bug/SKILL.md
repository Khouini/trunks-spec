---
name: investigate-bug
description: Find and prove the root cause of a reported bug, with evidence (code file:line, query results, read-only diagnostic queries the user runs, logs, stores, git history), and measure its blast radius (other callers, other repos, data already wrong). Writes bug.md §2-§4 and stops for the user to confirm the cause. Use after /start-bug, or whenever the user asks why something is broken, to debug, or to find the cause of an error, even if they don't name this skill. Only in a repo whose CLAUDE.md has a Project rules section, or when the user types this command.
---

# Investigate a bug

**No fix in this step, not even a "quick" one.** The output is a proven cause, not a change.

## 0. Load context
- Read `docs/bugs/<bug>/bug.md`. Check the branch recorded in `Branch:` (`git branch --show-current`); if different, stop and ask.
- If §1 has **TO ASK** items, first answer what you can from the code, docs and git. Ask me what is left: what the code can't tell and only I know (expected behavior, which users or flows).
- Set the status "Investigating" (bug file and index).

## 1. Call path
Trace from the symptom to the code and write it in §2 with `file:line` (Project rules: Trace path). For logic in the database, read its **latest version** (Project rules: Database).

## 2. Hypotheses
List 2 to 4 possible causes in §2, ranked, each with how to check it. Don't stop at the first plausible one. An external system "sending something odd" is a hypothesis to prove with its payload, not a conclusion.

## 3. Evidence
Check the hypotheses, cheapest first, and record each finding in §2 "Evidence":
- **Code:** read it; quote `file:line`.
- **Database (you have no DB access), only when really needed** (`CLAUDE.md`, "How Claude asks"): the code can't prove the hypothesis and the answer changes the cause or the fix. Then write one or two read-only queries in `docs/bugs/<bug>/diagnostics.md` (Q1, Q2), each saying what it checks, where to run it (dev or production) and the expected result if the hypothesis is right. **STOP** and ask me to run them and paste the results. Record IDs and counts only, never personal data.
- **Logs and stores:** give me the exact command or query to run (Project rules: Evidence).
- **History:** when did it break? `git log -S '<snippet>'`, `git log -L :<func>:<file>`, past database changes, and the history sources Project rules: Evidence names.
- **Reproduction test:** if the suite can reach the suspect logic, a unit test can prove it. Ask me before adding the test file; it becomes the regression test in `/plan-fix`.
- Remember the non-production limits (Project rules: Evidence).

If two rounds of evidence don't confirm any hypothesis, stop and say what is known and unknown instead of guessing.

## 4. Root cause
Fill §3: type, cause ("X happens because Y"), where, since when, why it wasn't caught. It must explain **every** symptom; if one is unexplained, say so.
- Works as designed, or really a new need: say so and propose the move (`~/.claude/workflow/steps/intake.md`, "Moving an item": to a change if existing behavior should differ, to a feature if it is new), or "Not a bug" with a reply to the reporter. Stop there.

## 5. Blast radius
Fill §4 with `~/.claude/workflow/steps/impact.md` at bug depth:
- other callers of the same function, and Project rules: Consumers to check; the same pattern elsewhere (Project rules: Impact checks)
- data already wrong: a query that counts **all** affected rows (every account and date) only if the bug stores bad data and the count changes the fix or a repair; otherwise one line: "no stored data affected" and why
- what was already sent wrong (Project rules: Who sees the difference)

## STOP
Present in chat, short: the root cause in one sentence, one example (input → what happens → what should happen), the 2-3 pieces of evidence that prove it, the blast radius in numbers. The rest is in `bug.md`. Ask me to confirm. Set the status "Cause confirmed" and `Next: /plan-fix` only after I do. Assumptions and open questions: only if there are some.
