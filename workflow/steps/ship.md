# Step: ship (changelog, messages, deploy checklist)

Drafts only. Nothing sent, nothing tagged, no database change applied.

| Track | Writes in | Changelog | Message to draft | Done status |
|---|---|---|---|---|
| Trivial | chat | a line, only if someone outside the team will notice | none | — |
| Bug | `bug.md` §9 (`/ship-fix`) | Fixed | reply to the reporter | Shipped |
| Change | `change.md` §7 | Changed | notice to whoever sees the difference (§2) | Shipped |
| Small feature | `feature.md` §8 | Added | short delivery note per affected audience | Shipped |
| Big feature | `07-delivery.md` + `07-delivery/` (`/deliver-feature`) | Added | one package per audience | Delivered |

## Inputs
The item doc (status Committed / Fixed, `Commit:` filled), `docs/clients/<client>.md` (language, tone, contacts by role, delivery audiences), the database set's `README.md` if any.

## Steps
0. **Docs check,** if the project has one (Project rules: Stack and commands): it passes. If not, stop: a committed change broke a doc; fix it before anything ships.
1. **Version:** propose it from the latest tag (`git describe --tags --abbrev=0`; if there is none, the next version in `docs/releases/CHANGELOG.md`): patch for a bug fix or a change with no contract change, minor for a feature or a contract change. One line in your message; I correct it if wrong. Never create a tag.
2. **Changelog:** a line in `docs/releases/CHANGELOG.md` under that version (Added / Changed / Fixed), what changed for the user in one sentence, linking `../bugs|changes|features/<folder>/`. Release notes `docs/releases/v<x.y.z>.md`: big feature, or when I ask.
3. **Message** (draft, role placeholders for names, in the audience's language and tone from the client file, no code):
   - **Bug, reply to the reporter:** what was wrong in plain words, what is fixed and since when, the data repaired (counts) or what they must redo, what to check.
   - **Change, notice:** what behaves differently and from when, what they must do, what did not change. Developer audience: a package per `~/.claude/workflow/handover-package.md` (request and response JSON before → after).
   - **Small feature, delivery note:** what's new and the problem it solves, what changes for them, limits and out of scope, what we need from them (testing by a date). Developer audience: a package per `~/.claude/workflow/handover-package.md` (short email + technical doc prompt, API contract and screens only, never their code).
4. **Deployment checklist** in the item doc:
   1. Backup the database (if a database change or a data change)
   2. Apply the database change in production in the set README's order; say what can go ahead of the code deploy. A data change runs after the change that stops new bad rows; record rows before → after.
   3. Expected run time on big tables
   4. Deploy: the exact steps of Project rules: Deploy
   5. Other repos to deploy, and in which order, if touched
   6. Verify: runnable requests, `test-guide.md` scenarios, the reported IDs, the diagnostics query → expected result (if the item has one). Project rules: Deploy says what only happens in production.
   7. Undo plan: the `UNDO:` lines of the database files in reverse order (data restored from where it was kept), previous commit redeployed
   8. Whatever Project rules: Deploy says must be regenerated or saved after a database change
   9. Cleanup of any kept data planned (once production is confirmed)
   - P1 hotfix: the same list cut to the essentials; deploy first, finish the docs after.
5. **When I confirm production:** done status as in the table, `Version:` filled, index row updated (fixed in / version, status), `docs/clients/<client>.md` "Features delivered" for a feature. `Next:` learn.
