# Handover package (developers who build on your work)

How to write the package handed to a developer who builds on your work (frontend, mobile, an integrator): `1. Email body.md` + `2. Technical
documentation (prompt).md`. Used by `/deliver-feature`, the ship step (small feature, change, bug
when a screen is affected) and grouped packages of a multi-phase feature.

**Model (copy its shape):** the one Project rules: Deploy names, if any.

## Rules for both files
- **Contract and screens only. Never their code.** Act as if we don't know it: no file paths, line numbers, function names or code snippets. Writing the code is their job.
  Reading their repo to find which screens are affected is fine; it just never shows in the package.
- Screens by the name the user sees (Orders, Invoices…), endpoints by API route.
- Facts from the real code (routes, query names, JSON, error messages), not from the design.
- One concrete example with fake data for each rule (`shopId=3` = Shop `S5`), with a
  note that IDs are examples.
- Hard rules (what must never be sent again, what will be removed) in a ⚠️ block, in both files.

## `1. Email body.md`
- Language and tone from `docs/clients/<client>.md` or Project rules: Deploy.
- **About 20 lines, no extra talk.** No "what does not change" list, no deadline, no bonus fixes unless the user asks: those go in the doc.
- Shape:
  1. **The context** (2-4 lines): why, in one example; the end goal.
  2. For a multi-phase feature: the phases in one line.
  3. **This delivery** (say "already in production" when true): one sentence of what changes, the screens as a short bullet list.
  4. The ⚠️ hard rule, if there is one (2 lines).
  5. "Details in the attached doc (you can give it as a prompt to your AI assistant)."

Skeleton:
```markdown
**To:** <role>
**Subject:** <subject> (<phase>)

Hi,

**<The context>**

<Why, with an example. The end goal.>

**<This delivery> (already in production)**

<What changes in one sentence>, on N screens:

- <screen>, <screen>

⚠️ <Hard rule: what must never be sent again, and why.>

Details in the attached doc (you can give it as a prompt to your AI assistant).

Thanks,
<name>
```

## `2. Technical documentation (prompt).md`
English, easy words, self-contained, written to be pasted as a prompt. Sections:
1. **Role and goal** — which app, what must change, what stays; then the ⚠️ hard rule block.
   Say that finding where each screen builds its requests is part of the task.
2. **Business context** — why, with an example; phases and where this one fits; the API is
   already in production and what still works meanwhile.
3. **API contract** — new/changed fields with a full JSON example; table endpoint → screens;
   one before → after request; rules table (sent → result, the allowed form marked ✅); the
   exact error JSON; "responses do not change" when true.
4. **What each screen must do** — the change as numbered steps, one example, then a table
   screen → requests. 
5. **Acceptance checklist** — on dev, with a data setup, one `- [ ]` per observable result
   (request sent, same rows as before, what must no longer be sent).
6. **Do not** — what must not be sent, built or changed (other screens, later phases).
