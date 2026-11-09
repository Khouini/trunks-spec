-- =============================================================================
-- <feature-folder> - NN: <procedure name> (new | changed)
--
-- WHAT CHANGED AND WHY
-- <what the procedure does now, what changed compared with the previous body,
--  and why. Name new/changed parameters and result-set columns: the code reads them
--  by column name, positional consumers by position.>
--
-- CONSUMERS: <code callers, other repos, procs that call it>
-- APPLY ORDER: <after NN / before the code deploy / together with NN>
-- Re-runnable (CREATE OR ALTER).
-- UNDO: re-run the previous body as CREATE OR ALTER, from a fixed commit (the dump is regenerated):
--       git show <commit>:<the schema source named in the project rules | docs/migrations/<set>/NN_<file>.sql>, lines <a-b>
--       (a new procedure: DROP PROCEDURE IF EXISTS [dbo].[<procedure_name>];)
-- =============================================================================

CREATE OR ALTER PROCEDURE [dbo].[<procedure_name>]
    @<param> INT,
    @<optionalParam> VARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM dbo.<table> WHERE <id> = @<param>)
    BEGIN
        RAISERROR ('<Entity> not found.', 16, 1);
        RETURN;
    END

    SELECT <columns>
    FROM   dbo.<table>
    WHERE  <id> = @<param>;
END
GO
