# Step: learn (Claude's remarks, your decision) ⛔

The last step of every track. Nothing is added to any rule without my yes.

**During the work:** you only write. Every correction, deviation, missing rule or mistake you notice becomes one line in the item's `learn.md`, quietly (`CLAUDE.md`, "Claude's learning notes"). This step is the only place where those notes become changes.

| Track | Where the remarks are | When this step runs |
|---|---|---|
| Trivial | no file | after the commit, only if I corrected you: one line in chat |
| Bug, change, small feature | `learn.md` in the item's folder | after ship |
| Big feature | `learn.md` in the feature's folder | at the end of `/close-feature` |

## Steps
1. **Read** `learn.md` and the item's Deviations sections. Add what is missing. Nothing to learn → say "Nothing to learn" in one line, `Next:` done, and stop.
2. **Sort each remark** into one place. Merge duplicates and drop noise (a one-off slip that no rule would prevent).
   - **Kit:** fits every project, in any technology. No project words.
   - **Project rules:** a fact about this project (its `CLAUDE.md`, `## Project rules`).
   - **Code conventions:** `AGENTS.md`, if the project has one.
   - **Test:** a test that would have caught it.
   - **Decision:** an ADR in `docs/decisions/`.
   - **Client:** durable context for `docs/clients/<client>.md`.
   - **Follow-up:** the same pattern elsewhere (grep it, Project rules: Impact checks). Not fixed here: a Backlog row with the text to start it.
3. **Propose in chat, 10 lines or fewer:** numbered, each with what happened, where it goes and the exact text to add. Example: `1. You corrected me twice on error names. Kit, CLAUDE.md "How Claude asks": "Error codes follow the names already in the file." Add it?`
4. **STOP.** Wait for a yes or no on each. My "ok" accepts all of them. Silence is a no.
5. **Apply only what I said yes to.**
   - Kit: find it with `readlink -f ~/.claude/workflow`; edit there, run its `check.sh`, add a line to its `CHANGELOG.md`. Don't commit it unless I say so.
   - Anything else: edit it in the project.
6. **Record** my decision for each remark in `learn.md`. Keep the file: it is part of the item's history. `Next:` done, index row updated.
