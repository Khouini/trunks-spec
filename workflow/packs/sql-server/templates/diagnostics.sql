-- =============================================================================
-- <bug-folder> - diagnostic queries (READ-ONLY)
--
-- SELECT only: safe to run on dev and on production.
-- Never put INSERT / UPDATE / DELETE / MERGE, DDL, or EXEC of a writing
-- procedure in this file. Fixes go in docs/migrations/<bug-folder>/.
--
-- Paste the results back as IDs and counts. No customer names, emails or
-- phone numbers.
-- =============================================================================
SET NOCOUNT ON;
-- Dirty reads are acceptable for diagnosis and avoid blocking big tables
-- (Project rules: Database) on production.
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

-- Q1: <what it checks>
-- Run on: <dev | production>   Expected if H1 is right: <...>
SELECT 1;
GO
