--- Check available tables in the database

Select name
from sys.tables

--- Get information on individual tables  ( table name, column name, data type, length, nullable, etc) 
EXEC sp_columns 'health-protection-coverage'

--- Count number of records in 'health-protection-coverage'

SELECT COUNT(*) as Total
FROM [health-protection-coverage]

--- Count missing values in specific columns
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN Entity IS NULL THEN 1 
        ELSE 0 END) AS missing_entity,
    SUM(CASE WHEN Code IS NULL THEN 1 
        ELSE 0 END) AS missing_Code,
    SUM(CASE WHEN Year IS NULL THEN 1 
        ELSE 0 END) AS missing_entity,
    SUM(CASE WHEN [Share_of_population_covered_by_health_insurance_ILO_2014] IS NULL THEN 1 
        ELSE 0 END) AS missing_sharepop
FROM [health-protection-coverage];


--- Review sample of table's data

Select Top 50 *
 FROM [health-protection-coverage]

--- Update table name, field name

EXEC sp_rename [health-protection-coverage], 'CountryPopInsured', --Table name changed to CountryPopInsured

EXEC sp_rename 'CountryPopInsured.Share_of_population_covered_by_health_insurance_ILO_2014', 'PercentageInsured','COLUMN' -- column name updated to PercentageInsured


--- Calculate basic statistics 

SELECT 
    MIN(PercentageInsured) AS min_PercentageInsured,
    MAX(PercentageInsured) AS max_PercentageInsured,
    AVG(PercentageInsured) AS avg_PercentageInsured,
    STDEVP(PercentageInsured) AS stddev_PercentageInsured, -- standard deviation population
	VAR(PercentageInsured) AS var_PercentageInsured -- variance
	--SUM()
FROM CountryPopInsured;


--- Get distinct counts

SELECT 
COUNT(DISTINCT code) as [TotalCountries], --- number of different countries
COUNT(DISTINCT Year) as [TotalNumberOfYears] -- number of years data was collected
FROM CountryPopInsured


--- Identify Top and Lowest of a category

--Top 5 Country Insured Percentages

SELECT Entity, PercentageInsured
FROM CountryPopInsured
WHERE PercentageInsured IN (
    SELECT DISTINCT TOP 5 PercentageInsured
    FROM CountryPopInsured
    ORDER BY PercentageInsured DESC
)
ORDER BY PercentageInsured DESC;


--Bottom 5 Country Insured Percentages

SELECT Entity, PercentageInsured
FROM CountryPopInsured
WHERE PercentageInsured IN (
    SELECT DISTINCT TOP 5 PercentageInsured
    FROM CountryPopInsured
    ORDER BY PercentageInsured ASC
)
ORDER BY PercentageInsured ASC;


----- Detect outliers within 1,2,3 standard deviations

-- 1 standard deviation
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


-- 2 standard deviation
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



-- 3 standard deviation
SELECT *
FROM CountryPopInsured
WHERE PercentageInsured > (
    SELECT AVG(PercentageInsured) + 3 * STDEV(PercentageInsured)
    FROM CountryPopInsured
)
   OR PercentageInsured < (
    SELECT AVG(PercentageInsured) - 3 * STDEV(PercentageInsured)
    FROM CountryPopInsured
);



