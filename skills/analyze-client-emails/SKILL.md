---
name: analyze-client-emails
description: Analyze client emails for a feature and extract explicit requests, implied needs, contradictions and open questions, with traceability to each email. Use whenever the user shares client emails, client messages or a client request to understand, even if they just say "read these emails". Only in a repo whose CLAUDE.md has a Project rules section, or when the user types this command.
---

# Analyze client emails

## Inputs
- `00-client-requirements.md` (step 0, `/extract-client-requirements`): the clean copy of what the client sent. Start from it, and quote it rather than the raw emails. If it is missing, run step 0 first.
- Raw emails in `.correspondence/<client>/<feature>/` (`.eml`, `.md`, `.txt`), or pasted by the user.
- `docs/clients/<client>.md` for context.
- To understand the terms the client uses: `CLAUDE.md` and the sources indexed in `docs/system/README.md` (module docs, API contracts). Only if needed.

## Steps
1. Read `00-client-requirements.md`, then every raw email in date order (to check nothing was lost in step 0).
2. Extract:
   - **Explicit requests**: what the client clearly asks for.
   - **Implied needs**: what they need but didn't say (performance, permissions, reporting, existing data, and Project rules: Example data).
   - **Contradictions**: between emails, between clients, or with how the system works today.
   - **Constraints**: deadlines, budget, environment, compliance.
   - **Open questions**: what must be clarified before writing requirements.
3. For each point, reference the source as `[Client, role, YYYY-MM-DD]`.
4. Never copy personal data (names, emails, phone numbers, prices unless needed) into the docs. Use roles. Company names and business values are fine.

## Output
Write `docs/features/<feature>/01-email-analysis.md` using the template sections. Assumptions and open questions: only if there are some. Suggest the next step: `/write-requirements`, or the optional `/client-questions` first if the answers to the open questions change the requirements.
