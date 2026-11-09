---
name: client-validation
description: Prepare a clear email asking the client to validate requirements, examples and open questions before design starts, and record their answers. Use after requirements are approved internally, or when the user wants the client to confirm the scope. Questions asked before the requirements exist go through /client-questions. Only in a repo whose CLAUDE.md has a Project rules section, or when the user types this command.
---

# Client validation

## Inputs
- `02-requirements.md` (small feature: `feature.md` §2), `docs/clients/<client>.md` (language, tone, contacts by role)

## Steps
1. Draft a short, non-technical email:
   - One-paragraph summary of what we understood
   - The key user stories and rules in plain language
   - 2-3 concrete examples so they can check behavior
   - What is out of scope
   - Numbered open questions they must answer (not those already answered in `01b-client-questions.md`)
   - A clear ask: "Please confirm or correct by <date>"
2. Match the client's language and tone from the client file. Address recipients by role placeholder (e.g. `<day-to-day contact>`); I put the names in when I send it.
3. Save the draft in `03-client-validation.md` (small feature: `feature.md` §2 "Client validation"). Update the status to "Validation". Do NOT send anything.

## When the client answers
- Record their answers in `03-client-validation.md` (summarized, no personal data).
- Update `02-requirements.md` (small feature: `feature.md` §2) and note what changed and why in its change log.

## STOP
Wait for client confirmation before `/impact-analysis` (small feature: impact + decide) unless I say to proceed.
