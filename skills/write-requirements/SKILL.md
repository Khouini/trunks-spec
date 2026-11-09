---
name: write-requirements
description: Turn the email analysis into business requirements with user stories, business rules, scope, priorities, acceptance criteria, and concrete examples (normal, edge and failure cases). Use after email analysis and before any design or code, or whenever the user asks for requirements, specs, user stories or acceptance criteria. Only in a repo whose CLAUDE.md has a Project rules section, or when the user types this command.
---

# Write requirements and examples

## Inputs
- `01-email-analysis.md`
- `01b-client-questions.md`, if the optional `/client-questions` phase ran: the client's answers (also merged into `00` §2 and `01`)
- `00-client-requirements.md`: the client's exact wording and values (tables, amounts, examples) to build the rules and examples from
- `docs/clients/<client>.md`
- How the system works today: the sources listed in `docs/system/README.md`, the code, and for logic in the database its **latest** version (Project rules: Database).

## Steps
1. **User stories**: "As a <role>, I want <action> so that <benefit>". Number them US-01, US-02... Roles: Project rules: Example data.
2. **Business rules**: numbered BR-01, BR-02..., each linked to its user stories.
3. **Scope**: in scope / out of scope (be explicit about what we are NOT doing). Name the surfaces (Project rules: Example data).
4. **Priorities**: MoSCoW (Must / Should / Could / Won't) per user story.
5. **Acceptance criteria**: Given / When / Then, per user story.
6. **Examples**: for each business rule, three cases (normal, edge, failure) with sample input and expected output, in a table. Use realistic but fake data (Project rules: Example data).
7. **Non-functional needs**: performance, security, permissions, audit, localization, and Project rules: Example data, if relevant.
8. Flag anything that contradicts current system behavior.

## Output
Write `docs/features/<feature>/02-requirements.md`. Update the README status to "Requirements". Assumptions and open questions: only if there are some.

Small feature (`feature.md`): the same rules, shorter, in `feature.md` §2, as `~/.claude/workflow/steps/understand.md` ("Small feature") describes.

## STOP
Ask me to review and approve. Do not continue to the next phase on your own.
