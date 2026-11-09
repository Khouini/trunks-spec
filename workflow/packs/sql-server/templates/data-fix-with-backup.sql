-- =============================================================================
-- <bug-folder> - NN: repair <tableName>.<columnName> broken by <bug>
--
-- WHAT AND WHY
-- <which rows are wrong, why (root cause, see docs/bugs/<bug-folder>/bug.md §3),
--  what the correct value is>
--
-- APPLY ORDER: after NN (the fix), so no new bad rows appear after the repair.
-- Every row it changes is first copied into dbo.bak_<bugShortName>_<tableName>.
-- Safe to re-run: only rows still matching the broken condition are touched,
-- and the backup keeps the first original value.
-- Expected rows: <N, from diagnostics Qn on production>   Expected run time: <...>
-- For more than ~50k rows, update in batches (see data-fix-batched.sql).
-- UNDO: UPDATE t SET t.<columnName> = b.<columnName> FROM dbo.<tableName> t
--       JOIN dbo.bak_<bugShortName>_<tableName> b ON b.<key> = t.<key>;
-- =============================================================================
SET NOCOUNT ON;
SET XACT_ABORT ON;

IF OBJECT_ID(N'dbo.bak_<bugShortName>_<tableName>', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.bak_<bugShortName>_<tableName> (
        <key>        INT          NOT NULL CONSTRAINT PK_bak_<bugShortName>_<tableName> PRIMARY KEY,
        <columnName> <type>       NULL,
        backedUpAt   DATETIME2(0) NOT NULL CONSTRAINT DF_bak_<bugShortName>_<tableName>_backedUpAt DEFAULT SYSUTCDATETIME()
    );
END;
GO

SET NOCOUNT ON;
SET XACT_ABORT ON;

SELECT COUNT(*) AS rowsToRepair
FROM   dbo.<tableName> AS t
WHERE  <broken condition>;

BEGIN TRANSACTION;

INSERT INTO dbo.bak_<bugShortName>_<tableName> (<key>, <columnName>)
SELECT t.<key>, t.<columnName>
FROM   dbo.<tableName> AS t
WHERE  <broken condition>
  AND  NOT EXISTS (SELECT 1 FROM dbo.bak_<bugShortName>_<tableName> AS b WHERE b.<key> = t.<key>);

UPDATE t
SET    t.<columnName> = <correct value>
FROM   dbo.<tableName> AS t
WHERE  <broken condition>;

PRINT CONCAT('Rows repaired: ', @@ROWCOUNT);

COMMIT TRANSACTION;
GO
