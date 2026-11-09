# Packs

The kit doesn't assume any technology. A pack adds the exact rules and templates for one. It is opt-in: a project names it in `## Project rules`.

```markdown
### Database
Pack: `~/.claude/workflow/packs/sql-server/README.md`. Read it before any database change.
```

| Pack | For |
|---|---|
| [sql-server](sql-server/README.md) | SQL Server with stored procedures, changes applied by hand |

## Add a pack
Create `packs/<name>/README.md`, plus its templates, for a database, a framework or a platform. Example: `packs/postgres-prisma/`. It only adds to the kit's rules and never contradicts them. See [CONTRIBUTING](../../CONTRIBUTING.md).
