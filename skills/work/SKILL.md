---
name: work
description: Single entry point for any piece of work on a project. Looks at the code, classifies the request as question, trivial, bug, change, small feature or big feature with fixed rules, proposes the track, and once the user confirms starts it. "/work status" lists every open item with its next step. Use whenever the user starts new work (a bug report, a change to existing behavior, a new feature, a client request, "can you make X do Y") or asks which workflow to follow, even if they don't name this skill. Only in a repo whose CLAUDE.md has a Project rules section, or when the user types this command.
---

# Work: pick the track

The tracks, their rules and their steps are in `~/.claude/workflow/WORKFLOW.md`. Read §1-§3 first.

**No `## Project rules` section in this repo's `CLAUDE.md`?** Offer to add it from `~/.claude/workflow/PROJECT_RULES_TEMPLATE.md`, filled from what the code shows, and stop for my OK. Also offer `docs/bugs/`, `docs/changes/`, `docs/features/` with their index READMEs, `.correspondence/` in `.gitignore`, and a pack if `~/.claude/workflow/packs/` has one for its database.

## `/work status`
List the open items of `docs/bugs/README.md`, `docs/changes/README.md` and `docs/features/README.md` (status not Shipped, Delivered, Closed, Not a bug, Moved, Dropped): track, title, status, next step (the item's `Next:` line, else `~/.claude/workflow/WORKFLOW.md` §3), branch. Then stop.

## `/work <request>`
1. **Open item?** If one already covers the request, say so and propose `/next <item>`.
2. **Look before classifying** (a quick look, not an investigation): the code and data involved (`file:line`), roughly how many files, whether something new from Project rules: Words for size or a contract change is needed. For a reported malfunction: does the code do what `docs/system/` or `docs/decisions/` say (then the request is a change) or not (a bug)?
3. **Classify** with `~/.claude/workflow/WORKFLOW.md` §1, first match wins.
4. **Propose in 2-4 lines:** the track, the rule that matched and what you saw (files, data, contract), the first step, the branch (the default in `~/.claude/workflow/steps/intake.md`). If two tracks are close, say which and why. Example: *"Change: `getOrder` + 2 code files, no contract change; today child items are listed after all parents, you want them under their parent. First: current vs wanted + impact. Branch: main."* Ask me to confirm. My correction stands.
5. **On my confirmation:**
   - **Question:** answer it. If the answer is durable knowledge missing from `docs/system/`, offer to add it.
   - **Trivial:** in one go, with its two gates: the exact change in chat (`~/.claude/workflow/steps/plan.md` form A, plus a test if logic changes) → STOP for approval → `~/.claude/workflow/steps/apply.md` §1, §3, §4 → show the diff → STOP → commit on approval, and a CHANGELOG line if someone outside the team will notice (ask the version). If it grows (database change, contract change, more files), stop and propose the change or bug track.
   - **Bug:** `/start-bug`.
   - **Change:** `~/.claude/workflow/steps/intake.md`, then `~/.claude/workflow/steps/understand.md` ("Change", which runs `~/.claude/workflow/steps/impact.md`), up to its STOP.
   - **Small feature:** `~/.claude/workflow/steps/intake.md`, then `~/.claude/workflow/steps/understand.md` ("Small feature"), up to its STOP.
   - **Big feature:** `/start-feature`.
6. End with the item's `Next:` in one line.
