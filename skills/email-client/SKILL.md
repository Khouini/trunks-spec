---
name: email-client
description: Draft an email to the client and record the answers. Two uses - questions before the requirements (01b-client-questions.md), when the open questions of 01-email-analysis.md change them; and validation after the requirements (03-client-validation.md, small feature feature.md §2), so the client confirms scope, rules and examples before design. Never sends anything. Use when the user wants to ask the client something, have the client confirm the scope, or record a client's answer. Only in a repo whose CLAUDE.md has a Project rules section, or when the user types this command.
---

# Email the client

| Use | When | File | Then wait for |
|---|---|---|---|
| **Questions** | before `/write-requirements`, only if the answers change the requirements | `01b-client-questions.md` (template `~/.claude/workflow/templates/feature/01b-client-questions.md`) | the answers, then `/write-requirements` |
| **Validation** | after the requirements are approved | `03-client-validation.md` (small feature: `feature.md` §2) | the confirmation, then `/impact-analysis` |

## Draft
Inputs: `01-email-analysis.md` or `02-requirements.md`, `00-client-requirements.md` (the client's words), `docs/clients/<client>.md` (language, tone, contacts by role).
1. **What we understood:** 2-3 lines and the client's own example.
2. Validation only: the key rules in plain words, 2-3 examples to check, what is out of scope.
3. **Numbered questions** (not those already answered). Each: why we ask (quote the client), options (A = our proposal, at most 2 more), one small example with the client's own numbers.
4. **A clear ask:** "Please confirm or correct by <date>", with a short answer format ("1A, 2A, 3B").

The client's words and language; no table, function or column names. Recipients by role (`<day-to-day contact>`): I put the names in and send it. Status "Questions" or "Validation", `Next:` waiting for the client. **Never send anything.**

## When the client answers
1. The raw answer goes in `.correspondence/<client>/<item>/`; add it to `00-client-requirements.md` as `/read-client-emails` does.
2. Record each answer in the email file, summarized, no personal data.
3. Update the source doc: an answered question becomes a fact with its source (`[E3]`); for validation, `02-requirements.md` with what changed and why.
4. `Next:` as in the table.

## STOP
Wait for the client unless I say to go on.
