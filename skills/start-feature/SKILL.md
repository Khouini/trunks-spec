---
name: start-feature
description: Start a big client feature (several stories, more than one slice) by creating its documentation folder from the template, its entry in the features index, and (if wanted) its git branch. Use when /work classifies a request as a big feature, or the user starts a multi-story client feature or says "new big feature". A feature that fits one slice goes through /work as a small feature. Only in a repo whose CLAUDE.md has a Project rules section, or when the user types this command.
---

# Start a feature

If the size is unclear, run `/work` first: a feature that fits one slice is a **small feature** (one `feature.md`), not this full track.

Follow `~/.claude/workflow/steps/intake.md` (track: big feature), with these feature-specific parts:
- No client emails (your own idea, an issue): skip the email phases, `Next: /write-requirements` from my description.
- Inputs: the feature name (ask if missing), client name(s), optional ticket ID.
- Fill the feature README: name, client(s), status "Analysis", start date, `Next: /read-client-emails`. Record the branch in `Branch:` (`feature/<short-name>` or the default branch: "no feature branch"); `/build-slice` and `/final-review` read it.
- Tell me where to put the raw emails: `.correspondence/<client>/<folder>/` (created, git-ignored).

## Output
The new folder, the index row, the branch decision, and the next step: `/read-client-emails` (step 0) once the emails are in `.correspondence/`.
