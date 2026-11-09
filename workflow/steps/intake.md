# Step: intake (record the request)

Nothing is fixed or designed here. This step records what was asked and creates the item. Look at the code enough to answer what it can: facts from the code, the docs or git are not questions. What the request leaves open (who, which edge cases, what the user sees) goes under **TO ASK**, never filled in silently (`CLAUDE.md`, "How Claude asks").

## Per track
| Track | Folder | Copy from | Index | First status |
|---|---|---|---|---|
| Bug | `docs/bugs/YYYY-MM-DD-<name>/` | `~/.claude/workflow/templates/bug/bug.md` (`diagnostics.md` only later, when a query is really needed) | `docs/bugs/README.md` | Reported |
| Change | `docs/changes/YYYY-MM-DD-<name>/` | `~/.claude/workflow/templates/change/` (`change.md`) | `docs/changes/README.md` | Requested |
| Small feature | `docs/features/YYYY-MM-<name>/` | `~/.claude/workflow/templates/feature-small/` (`feature.md`); `test-guide.md` from `~/.claude/workflow/templates/feature/` once behavior needs manual scenarios | `docs/features/README.md`, Track `small` | Requested |
| Big feature | `docs/features/YYYY-MM-<name>/` | `~/.claude/workflow/templates/feature/`, except `slices/slice-N.md` (leave `slices/` empty) and `01b-client-questions.md` (only when `/client-questions` runs) | `docs/features/README.md`, Track `big` | Analysis |

## Steps
1. **Already open?** Check the three indexes for an open item on the same thing. If there is one, propose continuing it (`/next <item>`) instead.
2. **Folder name** as in the table: the date the request arrived, a short kebab name, the ticket ID if given (`2026-10-INV-142-invoice-export`). The item's database files reuse it.
3. **Copy the template**, add what Project rules: Extra rules says about templates, and fill the header (title, requested/reported by **role** and date, client, environment, ticket) and the request section:
   - a short quote of what was asked; business IDs are fine;
   - **no personal data**: never customer names, people's names, emails or phone numbers. Roles and IDs only;
   - **TO ASK**: what the code can't answer and the request doesn't say, each with your proposed answer (`1. Only the order cancel, not the invoice cancel? (the report names only orders)`). A question for the requester is a short draft, never sent.
4. **Client file:** check `docs/clients/<client>.md` exists. If not, create it from `~/.claude/workflow/templates/client.md` and ask me only what isn't in the emails or older items.
5. **Raw emails:** create `.correspondence/<client>/<folder>/` (git-ignored, never committed). If the request is long or has attachments (Word, PDF, Excel), run `/extract-client-requirements` for a clean copy (`00-client-requirements.md` in the item folder) and quote from it.
6. **Branch: a default, not a question.** The current branch (usually Project rules: Default branch) for a bug or a change; `feature/<name>` for a feature. Write it in one line; I correct it if needed. Record it in `Branch:`.
7. **Index row** added (a missing `docs/<track>/README.md` index is created), status set, `Next:` filled.

## Moving an item to another track
When any step shows the item is on the wrong track (`~/.claude/workflow/WORKFLOW.md` §1: a bug that works as designed, a change that needs something new from Project rules: Words for size or grows past ~10 files, a small feature that needs more than one slice, a change that is really a one-liner):
1. Say so with the evidence, propose the new track, and wait for my yes.
2. Start the new item with this step, **carrying over** what is written (request, impact, decisions) instead of redoing it. A small feature becoming big stays in its folder: `feature.md` §1 → `00-client-requirements.md` (or a link to it), §2 → `02-requirements.md`, §3 → `04-impact-analysis.md`.
3. The old item: status "Moved to <track>" with a link to the new one, index row updated. Nothing is deleted.
