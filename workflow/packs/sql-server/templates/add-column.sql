-- =============================================================================
-- <feature-folder> - NN: <tableName>.<columnName>
--
-- WHAT CHANGED AND WHY
-- <new column, type, what NULL means, who reads/writes it>
--
-- RISK: Low (nullable column, no backfill) | <why higher: table size, locks>
-- APPLY ORDER: <before the code deploy: additive, the current code ignores it>
-- Re-runnable: the column add is guarded.
-- UNDO: ALTER TABLE dbo.<tableName> DROP COLUMN <columnName>; (after undoing the procs that use it)
-- =============================================================================
SET XACT_ABORT ON;
BEGIN TRANSACTION;

IF NOT EXISTS (SELECT 1
               FROM   sys.columns
               WHERE  object_id = OBJECT_ID('dbo.<tableName>')
                      AND name = '<columnName>')
BEGIN
    ALTER TABLE dbo.<tableName> ADD <columnName> <TYPE> NULL;
END;

COMMIT TRANSACTION;
GO
