# Design

Feature level: the data model, the public surface, and the slices. The code-level plan of each slice is written later, in `slices/slice-N.md`, at the start of that slice.

## Architecture choices

Decided with you **before** the rest of this design (where logic lives, new tables vs existing, new module vs extend, now vs background...).

| # | Question | Options | Recommendation (why) | Decision |
|---|---|---|---|---|

## Database changes
| File | Object | Change | Undo | Risk | Ahead of code deploy? |
|---|---|---|---|---|---|

## Public surface
| Entry point (route, command, screen) | Purpose | Who can use it |
|---|---|---|

## Technical design
### Components
### Data flow
### Validation and errors
### Permissions and security
### Logging and audit

## Alternatives considered

## Slices
<One slice when the feature is small (about 10 files or less); otherwise one slice per user story or part of one, each leaving the system working.>

### Slice 1: <goal>
- Stories / rules:
- Scope (what is in this slice, what waits):
- Database changes:
- Plan: `slices/slice-1.md` (written at the start of the slice)

## Assumptions
## Open questions
