# Project rules template

Copy this section into the project's `CLAUDE.md`, then fill it. The kit's steps and skills read it by heading ("Project rules: Test rules"). The section also turns the tracks on in this repo.

**These rules only add to the global `CLAUDE.md`. They never contradict it:** when two instructions conflict, Claude may follow either. A heading that doesn't apply says "None."

```markdown
## Project rules

### Stack and commands
Stack. How to run one test, the full suite, format and lint on touched code, the build, the docs check if any. Known test failures before any change.

### Trace path
How a request or action travels from the entry point to the data, with the real folder names.

### Example data
Fake data in the project's shapes, for examples and tests. One worked example of "today → after". Roles for user stories. Surfaces to name under "out of scope". Non-functional points worth checking.

### Who sees the difference
Everyone who can notice a change: users, frontends, partners, background jobs, stores.

### Consumers to check
Who else uses what you change: other repos, other languages, other services.

### Impact checks
Extra places to look at in the impact step, in order.

### Test rules
What the suite can reach, what it can't, where fixtures come from, an example test to follow, how to run what it can't reach by hand.

### Database
Which database and migration tool, where changes go, where the latest version of stored logic is, the dev database, big tables, things never to touch. The pack to use, if any (`~/.claude/workflow/packs/`). "None." if the project has no database.

### Evidence
Where to look when a bug is reported: the exact log command, stores, history sources, limits outside production.

### Plan details
What a code-level plan must also show here: conventions, contract files, generated code, side effects.

### Review points
What `code-reviewer` checks here: code conventions, how a new entry point is wired, data access, project-specific safety.

### Words for size
What counts as "new" and moves an item to a feature track (a new endpoint, a table, a command, a screen). Commit scopes.

### Deploy
The exact deploy, watch and verify steps, what only happens in production, what must be regenerated, how to mitigate a P1. The handover model, language and tone, if any.

### Default branch
The branch name.

### Extra rules
Rules that hold for every track in this project only: more decide questions, rows to add to templates, a special kind of item.
```
