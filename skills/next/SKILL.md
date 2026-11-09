---
name: next
description: Continue an open work item (bug, change, small feature, big feature) with its next step. Reads the item's header (Status, Next), checks the previous approval was given, and runs that step of its track. Use when the user says /next, "continue", "next step", "go on", or asks to scope, decide, plan, apply, ship or close a change or a small feature, even if they don't name this skill. Only in a repo whose CLAUDE.md has a Project rules section, or when the user types this command.
---

# Next step

1. **Which item:** the one I name (folder, title or link). Otherwise the open items (as `/work status`): one → that one; several → the one whose `Branch:` is the current branch if only one matches, else list them and ask.
2. **Read** the whole item doc (big feature: README, `progress.md`, the current slice plan). Check the branch (`git branch --show-current` against `Branch:`); if different, stop and ask.
3. **Which step:** the `Next:` line; if missing, the item's status in `~/.claude/workflow/WORKFLOW.md` §3.
4. **Gate check:** if the status says the item is waiting for me (Scope, Requirements, Questions, Validation, Plan, Built, a bug's cause not confirmed, or a learn proposal), don't move on. Show what is waiting for my approval and ask. My "OK / approved" in this message counts: record it (status) and continue.
5. **Run the step:**
   - **Bug** and **big feature:** run the skill `~/.claude/workflow/WORKFLOW.md` names for that step (`/investigate-bug`, `/plan-fix`, `/fix-bug`, `/ship-fix`, `/write-requirements`, `/build-slice`, …).
   - **The learn step** on any track, and **change** and **small feature:** follow the step file(s) in `~/.claude/workflow/steps/` for that step (`understand.md`, `impact.md`, `decide.md`, `plan.md`, `apply.md`, `ship.md`, `learn.md`), writing in the item's sections. A small feature runs `impact.md` together with `decide.md`.
   - Stop at every STOP of the step.
6. **At the end:** status, `Next:` and the index row updated; tell me the next step in one line.

Several steps in one session are fine as long as every gate waits for me. If the session is long and quality drops, update the item doc and suggest `/clear` then `/next`.
