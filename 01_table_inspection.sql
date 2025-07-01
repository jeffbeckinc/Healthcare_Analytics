/*
  File:   sql/01_table_inspection.sql
  Repo:   https://github.com/yourusername/Healthcare-Analytics-Repo
  Path:   /sql/01_table_inspection.sql
  Purpose: 
    - List all user-defined tables.
    - Inspect schema details via sys.tables and sp_columns.

  Usage:
    1. Open this file in SSMS (or your SQL IDE).
    2. Execute to get table names and schema info.
*/

--  List all user-defined tables in the current database
SELECT name
FROM sys.tables;

--  Show schema details for the 'health-protection-coverage' table:
--    • Column names
--    • Data types
--    • Max lengths
--    • Nullability flags
EXEC sp_columns 'CountryPopInsured';
