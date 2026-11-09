-- =============================================================================
-- <feature-folder> - NN: backfill <tableName>.<columnName>
--
-- WHAT AND WHY
-- <which rows, from where, why>
--
-- APPLY ORDER: after NN (schema) and before NN (constraint / proc that needs it).
-- Batched to avoid long locks; each batch commits on its own. Safe to re-run:
-- only rows still NULL are touched.
-- Expected run time: <estimate on production-size data>
-- UNDO: <one line: set back to NULL / restore from the backup table / none needed>
-- =============================================================================
SET NOCOUNT ON;
DECLARE @BatchSize INT = 5000;
DECLARE @Rows INT = 1;
DECLARE @Total INT = 0;

WHILE @Rows > 0
BEGIN
    UPDATE TOP (@BatchSize) t
    SET    t.<columnName> = s.<sourceColumn>
    FROM   dbo.<tableName> AS t
           INNER JOIN dbo.<sourceTable> AS s
               ON s.<key> = t.<key>
    WHERE  t.<columnName> IS NULL;

    SET @Rows = @@ROWCOUNT;
    SET @Total = @Total + @Rows;
END;

PRINT CONCAT('Rows updated: ', @Total);
GO
