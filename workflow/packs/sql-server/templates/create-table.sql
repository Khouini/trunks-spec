-- =============================================================================
-- <feature-folder> - NN: new table <tableName>
--
-- WHAT AND WHY
-- <what the table holds and why it is needed>
--
-- RULES
-- <row lifecycle, scope, FKs and why (or why not), cascade behavior>
--
-- APPLY ORDER: <first / after NN>. Additive: safe ahead of the code deploy.
-- Re-runnable: creates the table and index only when missing.
-- UNDO: DROP TABLE dbo.<tableName>; (after undoing the procs that use it; its data is lost)
-- =============================================================================
SET XACT_ABORT ON;
BEGIN TRANSACTION;

IF OBJECT_ID('dbo.<tableName>', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.<tableName> (
        <tableName>ID  INT IDENTITY CONSTRAINT PK_<tableName> PRIMARY KEY,
        <parentID>     INT NOT NULL
                       CONSTRAINT FK_<tableName>_<parentTable>
                       REFERENCES dbo.<parentTable> (<parentID>),
        <status>       VARCHAR(20) NOT NULL
                       CONSTRAINT CK_<tableName>_<status> CHECK (<status> IN ('<A>', '<B>')),
        isCancelled    BIT NOT NULL CONSTRAINT DF_<tableName>_isCancelled DEFAULT 0,
        addedDate      DATETIME NOT NULL CONSTRAINT DF_<tableName>_addedDate DEFAULT GETUTCDATE(),
        updatedDate    DATETIME NULL
    );
END;

IF NOT EXISTS (SELECT 1 FROM sys.indexes
               WHERE name = N'IX_<tableName>_<parentID>'
                 AND object_id = OBJECT_ID(N'dbo.<tableName>'))
BEGIN
    CREATE INDEX IX_<tableName>_<parentID> ON dbo.<tableName> (<parentID>);
END;

COMMIT TRANSACTION;
GO
