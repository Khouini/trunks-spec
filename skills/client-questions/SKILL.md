---
name: client-questions
description: Optional big-feature phase between /analyze-client-emails and /write-requirements. Turns the open questions of 01-email-analysis.md into a short email to the client (each question with why we ask, options with our proposal, and an example), saves it in 01b-client-questions.md, and records the answers when they come. Use when the user wants to ask the client questions before the requirements are written, or says the open questions must go to the client first. Validating written requirements is /client-validation, not this. Only in a repo whose CLAUDE.md has a Project rules section, or when the user types this command.
---

# Client questions (optional, before requirements)

Use it when the answers to the open questions of `01-email-analysis.md` change the requirements, so writing `02-requirements.md` first would be guesswork. Otherwise skip it: the questions go to the client with the requirements, in `/client-validation`.

## Inputs
- `01-email-analysis.md`: the open questions, and the contradictions and assumptions behind them.
- `00-client-requirements.md`: the client's words, quoted in "why we ask".
- `docs/clients/<client>.md`: language, tone, contacts by role.

## Steps
1. **Write each question for the client**, in plain words and the terms the client uses. No table, function or column names.
   - **Why we ask:** one line quoting what the client wrote.
   - **Options:** A = our proposal, then at most 2 alternatives.
   - **Example:** one small table or a few lines, with the client's own numbers, showing the result of each option.
2. **Draft the email** in `01b-client-questions.md`, from `~/.claude/workflow/templates/feature/01b-client-questions.md`:
   - what we understood: 2-3 lines and the client's own example;
   - what we plan unless the client says otherwise (assumptions the client should see) and what is not included, only if there are some;
   - the numbered questions;
   - a clear ask: "Please confirm or correct by <date>", with a short answer format ("1A, 2A, 3B").

   Match the client's language and tone. Recipients by role placeholder (`<day-to-day contact>`): I put the names in and send it.
3. README: status "Questions", `Next:` waiting for the client's answers; index row updated. Do NOT send anything.

## When the client answers
1. The raw answer goes in `.correspondence/<client>/<feature>/`. Add it to `00-client-requirements.md` (sources table, §2 "The client's answers"), faithful and without personal data, as `/extract-client-requirements` does.
2. Record each answer in `01b-client-questions.md` "Client answers" (summarized, no personal data).
3. Update `01-email-analysis.md`: an answered question becomes a fact with its source (E3, …); assumptions confirmed or changed; what is still unclear stays open.
4. `Next: /write-requirements`.

## STOP
Wait for the client's answers before `/write-requirements`, unless I say to go on.
