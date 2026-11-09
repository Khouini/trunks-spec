# Database changes

For any database and any tool. Project rules: Database says which one the project uses, and points to a pack if there is one (`packs/`).

## Rules
- **Every change is a file,** never text in chat. Say which files to apply and in what order.
- **Where:** the project's migration tool decides, if it has one. Otherwise `docs/migrations/<item-folder>/NN_<what>` + a `README.md` from `templates/database/SET_README.md`.
- **Never edit a change that has already run anywhere.** Write a new one.
- **One logical change per file.** Schema and data changes in separate files.
- **Each file says:** what changed and why, its apply order, whether it can run twice, and one `UNDO:` line: how to undo it in production. Example: `UNDO: drop column discount from orders`. No separate rollback scripts, unless the project's tool needs them.
- **Claude doesn't apply changes,** unless Project rules: Database allows it on a local database. It gives you the files; you apply them once on dev, then the checks.
- **Big tables:** add first, backfill in batches, constrain last. Note the expected run time.
- **Before changing what a query, table or stored logic gives back,** check Project rules: Consumers to check.

## Fixing data
Its own script, after the change that stops new bad rows:
1. A preview count first.
2. The old values kept (a backup table, or the store's equivalent).
3. An `UNDO:` line that restores them.
4. A later cleanup of the kept data, once production is confirmed.
