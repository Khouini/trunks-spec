---
name: start-bug
description: Start a bug fix by creating docs/bugs/YYYY-MM-DD-<name>/bug.md, recording the report (symptom, expected vs actual, IDs, environment), proposing a severity and a branch (defaults, not questions) and adding the index row. Use whenever the user reports a bug, an error, a wrong result or a production incident, or forwards a bug report, even if they don't name this skill. Only in a repo whose CLAUDE.md has a Project rules section, or when the user types this command.
---

# Start a bug

Nothing is fixed here. This step only records what was reported.

Follow `~/.claude/workflow/steps/intake.md` (track: bug), with these bug-specific parts:

1. **§1 "Report"** of `bug.md`: symptom (short quote), expected, actual, the where/when table, steps to reproduce. The report can be pasted text, an `.eml`, a log extract, a screenshot or IDs.
2. **Severity:** propose P1 / P2 / P3 with the reason in one line; I correct it if wrong.
   - P1 = hotfix mode (`~/.claude/workflow/WORKFLOW.md`, "Bug"). Propose a mitigation if one exists: redeploy the previous commit, undo the last database change (the `UNDO:` line of each file), and Project rules: Deploy. Don't apply anything.
3. **Quick triage:** if it clearly works as designed (→ change) or is a new need (→ feature), say so and propose the move (`intake.md`, "Moving an item") or a reply to the reporter. If unsure, continue; the investigation decides.
4. Status "Reported", `Next: /investigate-bug`.

## Output
A short message: the folder, the severity and the branch (your picks, one line each), the **TO ASK** list (only what the code, docs and git can't answer, each with your proposed answer; a draft question to the reporter if needed, never sent), and the next step: `/investigate-bug`.
