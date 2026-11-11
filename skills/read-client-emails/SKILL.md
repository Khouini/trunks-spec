---
name: read-client-emails
description: Read a client's emails and attachments for a feature or change. Writes a faithful clean copy of what the client sent (00-client-requirements.md) and then its analysis (01-email-analysis.md) - explicit requests, implied needs, contradictions, open questions - each traced to its email. Use right after /start-feature once the emails are in .correspondence/, whenever the user shares client emails or says "read these emails", or asks for a clean copy of an attachment. Only in a repo whose CLAUDE.md has a Project rules section, or when the user types this command.
---

# Read client emails

Two files, in this order. The copy says exactly what the client said: nothing added. The analysis comes after, from the copy.

## 1. The clean copy: `00-client-requirements.md`
1. **Extract:** `python3 ~/.claude/skills/read-client-emails/scripts/extract_correspondence.py .correspondence/<client>/<item>/`. It prints every email by date, saves the attachments, converts `.docx` and diffs a re-sent attachment. PDF or spreadsheet: the `pdf` / `xlsx` skills. Images: open them and say what they show.
2. **Read everything** by date: bodies, answers written inside a quoted email, every attachment and version.
3. **Write** from `~/.claude/workflow/templates/feature/00-client-requirements.md`: sources (E1, E2… by date, company and role), the request, the client's answers (inline answers as a Question / Answer table), corrections made by later emails, each attachment in full (latest version).
4. **Faithful:** keep the client's words, numbers and mistakes (a wrong total stays wrong); fix only spelling typos. Remove signatures, disclaimers, quoted history, greetings. A wide table may be re-laid out if every value survives; say so in the header. No notes, no `[sic]`.
5. **No personal data:** people by role (`Client (manager)`), never names, emails, phones or addresses, also inside the text. Companies and business values are fine.
6. **Verify:** every row and amount against the source (scripted when there are many), and a grep for names, `@` and phone prefixes. Report the result.

## 2. The analysis: `01-email-analysis.md` (big feature)
Small feature or change: skip it; the copy feeds `/next`.
1. From the copy (quote it, not the raw emails), with `docs/clients/<client>.md` and, for the client's terms, `docs/system/`.
2. Write, each point with its source `[E2]`:
   - **Explicit requests:** what the client asks for.
   - **Implied needs:** what they need but didn't say (Project rules: Example data).
   - **Contradictions:** between emails, or with how the system works today.
   - **Constraints:** deadlines, environment, compliance.
   - **Open questions:** what must be clear before the requirements.

## Output
Both files, the verification result, and `Next:` `/write-requirements`, or `/email-client` first when the open answers change the requirements.
