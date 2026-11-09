---
name: design-feature
description: Design a feature at feature level: agree the architecture choices with the user, then the database changes, the public surface, and the split into vertical slices with a progress file. Use after impact analysis and before any code, or whenever the user asks for a technical design, schema change, migration plan or task breakdown. Only in a repo whose CLAUDE.md has a Project rules section, or when the user types this command.
---

# Design the feature

Feature level only: architecture, data model, public surface, slices. The code-level plan of each slice (signatures, types, database parameters, query logic) is written later by `/build-slice`, in `slices/slice-N.md`.

## Inputs
- `02-requirements.md`, `03-client-validation.md`, `04-impact-analysis.md`
- `CLAUDE.md` (architecture, `## Project rules`), `AGENTS.md` (code conventions, if any), `docs/system/README.md`, `docs/decisions/`
- `~/.claude/workflow/database.md`, Project rules: Database and the most recent database change in the same domain (to follow its style)

## 1. Architecture choices (discuss first, write nothing yet)
- Follow `~/.claude/workflow/steps/decide.md` with the **Architecture** questions (which layer owns the logic, new table or existing, new package or extend, sync or background, which store, which feature to copy from the impact analysis).
- Present them as a short numbered list in chat.
- **STOP.** Discuss with me until every choice has a decision. Don't write `05-design.md` before that.

## 2. Database design
- New/changed tables, columns (types, nullability, defaults), keys, indexes, constraints, and any logic stored in the database.
- Follow existing naming exactly (look at the neighbouring objects; Project rules: Database says where).
- One logical change per file, schema and data changes in separate files, an `UNDO:` line in each.
- For each change: file name, how to undo it, risk (locking, data volume), whether a data fix/backfill is needed, and whether a consumer (Project rules: Consumers to check) must change at the same time.
- Big tables: nullable column first → batched backfill → constraint.
- Apply order, including whether the change can go ahead of the code deploy (additive) or must go with it.

## 3. Public surface and technical design
- Routes: method, path, purpose, who can call it, request and response shapes, audit yes/no.
- Components, data flow, where validation happens, how errors are returned, logging, stores written. Add what Project rules: Plan details lists.
- Follow the reference feature. Record alternatives considered and why rejected. If a decision is significant, propose an ADR.

## 4. Slices
- **Fits one slice (about 10 files or less): propose a single slice** and ask me to confirm.
- Otherwise split into vertical slices: each = one user story (or part) end to end (database + code + tests + docs), ~5-10 files, doable in one session, leaving the system working. Order them so each builds on the previous one.
- For each slice: goal, stories/rules covered, scope (what is in, what waits), database changes. **No file lists or signatures here**: that is the slice plan's job.
- Create `progress.md` from the template with one row per slice.

## Output
Write `05-design.md` (with the architecture decisions from step 1) and `progress.md`. Update the feature README status to "Design" and `Next: /build-slice`. Assumptions and open questions: only if there are some.

## STOP
Ask me to approve the design and slices. No code before approval, and no code for a slice before its own plan is approved (`/build-slice`).
