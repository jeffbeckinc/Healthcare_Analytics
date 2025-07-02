/*
  File:    sql/02_data_quality_checks.sql
  Repo:    https://github.com/yourusername/Healthcare-Analytics-Repo
  Purpose: 
    - Count total rows in each table slice.
    - Sum missing values across all key columns to pinpoint data‐quality issues.
  Usage:
    1. Open in SSMS or your IDE.
    2. Execute to get a breakdown of NULL counts before transformation.
*/

-- Count total rows and missing values for 'health-protection-coverage'
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN Entity IS NULL THEN 1 
        ELSE 0 END) AS missing_entity,
    SUM(CASE WHEN Code IS NULL THEN 1 
        ELSE 0 END) AS missing_Code,
    SUM(CASE WHEN Year IS NULL THEN 1 
        ELSE 0 END) AS missing_entity
   -- SUM(CASE WHEN [Share_of_population_covered_by_health_insurance_ILO_2014] IS NULL THEN 1 
   --     ELSE 0 END) AS missing_sharepop
FROM [CountryPopInsured];
