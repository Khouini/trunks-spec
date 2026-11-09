# SQL Server pack

For projects on SQL Server with stored procedures and changes applied by hand. It adds to `~/.claude/workflow/database.md`.

```
docs/migrations/<item-folder>/
├── README.md        # apply order (templates/database/SET_README.md in the kit)
├── 01_<what>.sql
└── 02_<what>.sql
```

| Template (`templates/`) | Use for |
|---|---|
| `procedure.sql` | new or changed procedure or function (full body) |
| `create-table.sql` | new table |
| `add-column.sql` | new column or index on an existing table |
| `data-fix-batched.sql` | backfill or data fix |
| `data-fix-with-backup.sql` | repair of rows broken by a bug: preview count, backup table, then update |
| `diagnostics.sql` | read-only queries; use it instead of the kit's `diagnostics.md` |

## Rules
- **`UNDO:` line examples:** a changed procedure → "re-run its previous body as `CREATE OR ALTER`: `git show <commit>:<source>`, lines a-b" (always a fixed commit); a new procedure → `DROP PROCEDURE IF EXISTS [dbo].[x];`; a new column → `ALTER TABLE dbo.t DROP COLUMN c;`; a data fix → restore from its backup table.
- **Idempotent:** `IF NOT EXISTS` / `OBJECT_ID(...) IS NULL` guards; procedures with `CREATE OR ALTER` (or `DROP PROCEDURE IF EXISTS` + `CREATE PROCEDURE`, following the latest set of the same domain).
- **Procedures ship as the full body,** batches separated by `GO`. The plan shows only the changed fragment.
- `SET XACT_ABORT ON` + a transaction for multi-statement table and data scripts.
- **Naming** follows the existing schema: `PK_<table>`, `FK_<table>_<ref>`, `CK_<table>_<column>`, `DF_<table>_<column>`, `IX_<table>_<columns>`.
- **Backup table:** `dbo.bak_<short>_<table>`.
- **Positional readers** (`INSERT INTO #x EXEC`, positional column reads) break when a `SELECT` list changes: list them as consumers.

## In a plan
Per procedure: parameters (name, type, default, meaning); result sets (column, type, code field); errors (`RAISERROR` message → what the caller gets); logic as pseudo-SQL, step by step.
