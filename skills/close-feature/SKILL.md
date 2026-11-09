---
name: close-feature
description: Close a delivered feature by recording client feedback, finalizing the docs, and running the learn step. Use after delivery, when client feedback arrives, or whenever the user wants a retrospective or to wrap up a feature. Only in a repo whose CLAUDE.md has a Project rules section, or when the user types this command.
---

# Close the feature

## Steps
1. Record client feedback (summarized, no personal data) in `08-feedback.md`.
2. If feedback requires changes: list them as follow-up items (`/work`: a change, a small feature or a new slice); do not code them here.
3. Run `~/.claude/workflow/steps/learn.md`: the remarks in `learn.md`, and any implementation preference from the slice plans. Nothing is applied without my yes.
4. Update `docs/clients/<client>.md` with durable new context (preferences, environment, audiences).
5. Update the feature README status to "Closed", `Next:` done, and the features index.
6. Write any ADR that came out of this feature but wasn't recorded (`docs/decisions/`).

## Output
`08-feedback.md` + proposed improvements.
