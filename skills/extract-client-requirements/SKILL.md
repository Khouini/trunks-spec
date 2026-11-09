---
name: extract-client-requirements
description: Step 0 of a feature. Turn the raw client emails and their attachments (.eml, .docx, pasted text) into one clean, faithful Markdown copy of what the client actually sent, 00-client-requirements.md, with no analysis. Use right after /start-feature once the emails are in .correspondence/, or whenever the user asks for a clean copy of the client's original request, or to extract an email attachment. Only in a repo whose CLAUDE.md has a Project rules section, or when the user types this command.
---

# Extract client requirements (step 0)

A faithful, readable copy of the client's original request. It is the reference every later phase quotes from, so it must say exactly what the client said: **nothing added, nothing interpreted**. Analysis belongs in `/analyze-client-emails`.

## Inputs
- Raw emails in `.correspondence/<client>/<feature>/` (`.eml`, `.md`, `.txt`), or pasted by the user.
- The item folder: `docs/features/<feature>/` (its README or `feature.md` gives the client), or `docs/changes/<change>/` when a change request came by email with attachments.

## Steps
1. **Extract.** Run `python3 ~/.claude/skills/extract-client-requirements/scripts/extract_correspondence.py .correspondence/<client>/<feature>/`. It prints every email in date order (headers + body), saves the attachments next to the emails as `attachment_<date>_<name>`, converts `.docx` to Markdown, and diffs an attachment re-sent with changes. Standard library only. For a PDF or spreadsheet attachment, use the `pdf` / `xlsx` skills. Images embedded in a document: open them and describe what they show.
2. **Read everything** in date order: bodies (including inline answers written into a quoted email), every attachment, every version.
3. **Write** `00-client-requirements.md` in the item folder, from `~/.claude/workflow/templates/feature/00-client-requirements.md`:
   - Sources table (E1, E2… by date, company and role, one line each).
   - The request, then the client's answers. Inline answers become a Question / Answer table; free text is quoted as written.
   - Corrections: what a later email or attachment version changed, and whether it is applied in the content below.
   - Each attachment in full, latest version, same section numbering as the original.
4. **Faithful, cleaned:**
   - Keep the client's wording, numbers, units, capitals, emphasis (`!!`, bold) and their mistakes in content (a wrong total stays wrong). Fix only obvious spelling typos.
   - Remove signatures, legal disclaimers, quoted history already shown, greetings.
   - Wide or merged-cell tables may be re-laid out (e.g. one table per region, a matrix flattened to rows) as long as every value survives; say in the file header what was re-laid out.
   - No `[sic]`, no notes, no "this seems to mean". If something is ambiguous, leave it as written: `/analyze-client-emails` will raise it.
5. **No personal data**: the file is committed. People by role (`Client (manager)`), never names, email addresses, phone numbers or postal addresses, including names mentioned in the text ("sent by <name> on Monday" → "sent by a colleague on Monday"). Company names and business values are fine.
6. **Verify** before handing over: every table row and amount checked against the extracted source (script it when there are many rows), and a grep for the people's names, `@`, phone prefixes. Report the result.

## Output
`00-client-requirements.md`, the verification result, and the next step: `/analyze-client-emails` (big feature) or `/next` (small feature, change). Point out in one or two lines anything that obviously changes the scope you were expecting (e.g. the client says the feature applies elsewhere than asked), without analysing it.
