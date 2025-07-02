/*
  File:    sql/03_outlier_detection.sql
  Repo:    https://github.com/jeffbeckinc/Healthcare-Analytics-Repo
  Purpose:
    - Detect country‐year observations lying at 1, 2, and 3 standard deviations.
    - Flag outliers for further review or exclusion.
  Usage:
    1. Adjust σ thresholds or target field as needed.
    2. Execute each block to see progressively extreme values.
*/

--- NOTE: health-protection-coverage table name has been modified to CountryPopInsured

-- Outliers 1 standard deviation
SELECT *
FROM CountryPopInsured
WHERE PercentageInsured > (
    SELECT AVG(PercentageInsured) + 1 * STDEV(PercentageInsured)
    FROM CountryPopInsured
)
   OR PercentageInsured < (
    SELECT AVG(PercentageInsured) - 1 * STDEV(PercentageInsured)
    FROM CountryPopInsured
);


--  Outliers 2 standard deviations
SELECT *
FROM CountryPopInsured
WHERE PercentageInsured > (
    SELECT AVG(PercentageInsured) + 2 * STDEV(PercentageInsured)
    FROM CountryPopInsured
)
   OR PercentageInsured < (
    SELECT AVG(PercentageInsured) - 2 * STDEV(PercentageInsured)
    FROM CountryPopInsured
);

--  Outliers 3 standard deviations
SELECT *
FROM CountryPopInsured
WHERE PercentageInsured > (
    SELECT AVG(PercentageInsured) + 3 * STDEV(PercentageInsured)
    FROM CountryPopInsured
)
   OR PercentageInsured < (
    SELECT AVG(PercentageInsured) - 3* STDEV(PercentageInsured)
    FROM CountryPopInsured
);
