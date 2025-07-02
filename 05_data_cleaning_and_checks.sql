/*
  File:    sql/05_data_cleaning_and_checks.sql
  Repo:    https://github.com/jeffbeckinc/Healthcare-Analytics-Repo
  Purpose:
    - Measure NULL counts across the consolidated table.
    - Backfill missing Continent via DimCountry.
    - Filter out incomplete records before analysis.
  Usage:
    1. Execute Step 1 to get current NULL stats.
    2. Run Step 2 to enrich Continent.
    3. Use Step 3 to confirm completeness.
    4. Apply Step 4 to drop rows missing critical metrics.
*/

--  Step 1: NULL counts
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN a.Entity IS NULL THEN 1 
        ELSE 0 END) AS missing_entity,
    SUM(CASE WHEN a.Code IS NULL THEN 1 
        ELSE 0 END) AS missing_Code,
    SUM(CASE WHEN a.Year IS NULL THEN 1 
        ELSE 0 END) AS missing_year,
    SUM(CASE WHEN a.AnnualCHE IS NULL THEN 1 
        ELSE 0 END) AS missing_annualche,

	SUM(CASE WHEN b.CHE_outofGDP IS NULL THEN 1 
        ELSE 0 END) AS missing_che_outofGDP,
    SUM(CASE WHEN c.AnnualChe IS NULL THEN 1 
        ELSE 0 END) AS missing_annualche,
    SUM(CASE WHEN c.GDPperCapita IS NULL THEN 1 
        ELSE 0 END) AS missing_GDPperCapita,
    SUM(CASE WHEN c.EstimatedPopulation IS NULL THEN 1 
	    ELSE 0 END) AS missing_EstimatedPopulation,
	
    SUM(CASE WHEN c.Continent IS NULL THEN 1 
        ELSE 0 END) AS missing_continent,
    SUM(CASE WHEN d.[MortalityRate(Under5_per1000births)] IS NULL THEN 1 
        ELSE 0 END) AS missing_mortalityrate,
    SUM(CASE WHEN e.PercentageInsured IS NULL THEN 1 
        ELSE 0 END) AS missing_percentageinsured,
    SUM(CASE WHEN f.TaxRevenuePerCapita IS NULL THEN 1 
	    ELSE 0 END) AS missing_taxrevenuepercapita,

    SUM(CASE WHEN f.PublicExpenditurePerCapita IS NULL THEN 1 
        ELSE 0 END) AS missing_PublicExpenditurePerCapita,
 -  SUM(CASE WHEN g.GDP_SpendOnHealthcare IS NULL THEN 1 
        ELSE 0 END) AS missing_GDP_SpendOnHealthcare,
    SUM(CASE WHEN h.LifeExpectancy IS NULL THEN 1 
        ELSE 0 END) AS missing_LifeExpectancy,
    SUM(CASE WHEN i.OutOfPocket IS NULL THEN 1 
        ELSE 0 END) AS missing_OutOfPocket
  FROM [Healthcare].[dbo].[AnnualCHEPerCapita] a
    LEFT JOIN [CHE%ofGDP%] b on a.Code = b.Code and a.Year = b.Year
    LEFT JOIN [CHE_GDP_percapita] c on a.Code = c.Code and a.Year = c.Year
    LEFT JOIN [ChildMortalityVsCHE] d on a.Code = d.Code and a.Year = d.Year
    LEFT JOIN [CountryPopInsured] e on a.Code = e.Code and a.Year = e.Year
    LEFT JOIN DevelopingCountriesTaxRevenueHCSpend f on a.Code = f.Code and a.Year = f.Year
    LEFT JOIN GDP_SpendOnHealthcare g on a.Code = g.Code and a.Year = g.Year
    LEFT JOIN LifeExpectVSCHE h on a.Code = h.Code and a.Year = h.Year
    LEFT JOIN OutOfPocketVS_GDP_PerCapita i on a.Code = i.Code and a.Year = i.Year
	WHERE a.Code IS NOT NULL


-- After Step 1:	
	-- NULL Code values are a mixture of continent, region and demographic groupings.

--  Step 2: Continent backfill

	SELECT 
	   a.Entity
      ,a.Code
      ,a.Year
      ,ROUND(a.AnnualCHE,2) AS 'CHE_PerCapita'
	  ,b.CHE_outofGDP
	  ,ROUND(c.AnnualChe,2) As AnnualCHE
	  ,c.GDPperCapita
	  ,c.EstimatedPopulation as Population
	  ,j.Continent
	  ,d.[MortalityRate(Under5_per1000births)] AS MortalityRate
	  ,ROUND(e.PercentageInsured, 2) as PercentageInsured
	  ,ROUND(f.TaxRevenuePerCapita,2) as DevelopingTaxRevenuePerCapita --- Developing Country field only
	  ,ROUND(f.PublicExpenditurePerCapita, 2) as DevelopingPublicExpenditurePerCapita --- Developing Country field only
	 ,ROUND(g.GDP_SpendOnHealthcare,2) as GDPSpendOnHealthcarePercent
	 ,ROUND(h.LifeExpectancy,2) as LifeExpectancy
     ,ROUND(i.OutOfPocket, 2) as OutOfPocket
  FROM [Healthcare].[dbo].[AnnualCHEPerCapita] a
    LEFT JOIN [CHE%ofGDP%] b on a.Code = b.Code and a.Year = b.Year
    LEFT JOIN [CHE_GDP_percapita] c on a.Code = c.Code and a.Year = c.Year
    LEFT JOIN [ChildMortalityVsCHE] d on a.Code = d.Code and a.Year = d.Year
    LEFT JOIN [CountryPopInsured] e on a.Code = e.Code and a.Year = e.Year
    LEFT JOIN DevelopingCountriesTaxRevenueHCSpend f on a.Code = f.Code and a.Year = f.Year
    LEFT JOIN GDP_SpendOnHealthcare g on a.Code = g.Code and a.Year = g.Year
    LEFT JOIN LifeExpectVSCHE h on a.Code = h.Code and a.Year = h.Year
    LEFT JOIN OutOfPocketVS_GDP_PerCapita i on a.Code = i.Code and a.Year = i.Year
	RIGHT JOIN DimCountry j on a.Code = j.Abbreviation
	WHERE a.Code IS NOT NULL

-- After Step 2:	
	-- Deciding to drop NULL Code values.
	-- Reviewing Continent value to see if that can be added.
	-- Found and added Country,Abbreviation table to be able to fill out Continent.
	-- Added additional country dimensional table not found in original source data.



--  Step 3: Re-check NULL counts
	SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN a.Entity IS NULL THEN 1 
        ELSE 0 END) AS missing_entity,
    SUM(CASE WHEN a.Code IS NULL THEN 1 
        ELSE 0 END) AS missing_Code,
    SUM(CASE WHEN a.Year IS NULL THEN 1 
        ELSE 0 END) AS missing_year,
    SUM(CASE WHEN a.AnnualCHE IS NULL THEN 1 
        ELSE 0 END) AS missing_annualche,

	SUM(CASE WHEN b.CHE_outofGDP IS NULL THEN 1 
        ELSE 0 END) AS missing_che_outofGDP,
    SUM(CASE WHEN c.AnnualChe IS NULL THEN 1 
        ELSE 0 END) AS missing_annualche,
    SUM(CASE WHEN c.GDPperCapita IS NULL THEN 1 
        ELSE 0 END) AS missing_GDPperCapita,
    SUM(CASE WHEN c.EstimatedPopulation IS NULL THEN 1 
	    ELSE 0 END) AS missing_EstimatedPopulation,
	
    SUM(CASE WHEN j.Continent IS NULL THEN 1 
        ELSE 0 END) AS missing_continent,
    SUM(CASE WHEN d.[MortalityRate(Under5_per1000births)] IS NULL THEN 1 
        ELSE 0 END) AS missing_mortalityrate,
    SUM(CASE WHEN e.PercentageInsured IS NULL THEN 1 
        ELSE 0 END) AS missing_percentageinsured,
    --SUM(CASE WHEN f.TaxRevenuePerCapita IS NULL THEN 1 
	   -- ELSE 0 END) AS missing_taxrevenuepercapita,

    --SUM(CASE WHEN f.PublicExpenditurePerCapita IS NULL THEN 1 
    --    ELSE 0 END) AS missing_PublicExpenditurePerCapita,
 -  SUM(CASE WHEN g.GDP_SpendOnHealthcare IS NULL THEN 1 
        ELSE 0 END) AS missing_GDP_SpendOnHealthcare,
    SUM(CASE WHEN h.LifeExpectancy IS NULL THEN 1 
        ELSE 0 END) AS missing_LifeExpectancy,
    SUM(CASE WHEN i.OutOfPocket IS NULL THEN 1 
        ELSE 0 END) AS missing_OutOfPocket
  FROM [Healthcare].[dbo].[AnnualCHEPerCapita] a
    LEFT JOIN [CHE%ofGDP%] b on a.Code = b.Code and a.Year = b.Year
    LEFT JOIN [CHE_GDP_percapita] c on a.Code = c.Code and a.Year = c.Year
    LEFT JOIN [ChildMortalityVsCHE] d on a.Code = d.Code and a.Year = d.Year
    LEFT JOIN [CountryPopInsured] e on a.Code = e.Code and a.Year = e.Year
    LEFT JOIN DevelopingCountriesTaxRevenueHCSpend f on a.Code = f.Code and a.Year = f.Year
    LEFT JOIN GDP_SpendOnHealthcare g on a.Code = g.Code and a.Year = g.Year
    LEFT JOIN LifeExpectVSCHE h on a.Code = h.Code and a.Year = h.Year
    LEFT JOIN OutOfPocketVS_GDP_PerCapita i on a.Code = i.Code and a.Year = i.Year
	RIGHT JOIN DimCountry j on a.Code = j.Abbreviation
	WHERE a.Code IS NOT NULL

--After Step 3:
	-- Coninent column is no longer missing any values.
	-- Ignoring missing values for taxrevenuepercapita and publicexpenditure per capita since those were only for developing countries. 
	-- It is understood to have a lot of missing values in those columns, if it is decided to keep them in the final dataset.
	-- Reviewing percentaged insured missing values.

--  Step 4: Filter out missing PercentageInsured
		SELECT 
	   a.Entity
      ,a.Code
      ,a.Year
      ,ROUND(a.AnnualCHE,2) AS 'CHE_PerCapita'
	  ,b.CHE_outofGDP
	  ,ROUND(c.AnnualChe,2) As AnnualCHE
	  ,c.GDPperCapita
	  ,c.EstimatedPopulation as Population
	  ,j.Continent
	  ,d.[MortalityRate(Under5_per1000births)] AS MortalityRate
	  ,ROUND(e.PercentageInsured, 2) as PercentageInsured
	  ,ROUND(f.TaxRevenuePerCapita,2) as DevelopingTaxRevenuePerCapita --- Developing Country field only
	  ,ROUND(f.PublicExpenditurePerCapita, 2) as DevelopingPublicExpenditurePerCapita --- Developing Country field only
	 ,ROUND(g.GDP_SpendOnHealthcare,2) as GDPSpendOnHealthcarePercent
	 ,ROUND(h.LifeExpectancy,2) as LifeExpectancy
     ,ROUND(i.OutOfPocket, 2) as OutOfPocket
  FROM [Healthcare].[dbo].[AnnualCHEPerCapita] a
    LEFT JOIN [CHE%ofGDP%] b on a.Code = b.Code and a.Year = b.Year
    LEFT JOIN [CHE_GDP_percapita] c on a.Code = c.Code and a.Year = c.Year
    LEFT JOIN [ChildMortalityVsCHE] d on a.Code = d.Code and a.Year = d.Year
    LEFT JOIN [CountryPopInsured] e on a.Code = e.Code and a.Year = e.Year
    LEFT JOIN DevelopingCountriesTaxRevenueHCSpend f on a.Code = f.Code and a.Year = f.Year
    LEFT JOIN GDP_SpendOnHealthcare g on a.Code = g.Code and a.Year = g.Year
    LEFT JOIN LifeExpectVSCHE h on a.Code = h.Code and a.Year = h.Year
    LEFT JOIN OutOfPocketVS_GDP_PerCapita i on a.Code = i.Code and a.Year = i.Year
	RIGHT JOIN DimCountry j on a.Code = j.Abbreviation
	WHERE a.Code IS NOT NULL
	AND e.PercentageInsured IS NOT NULL

--After Step 4:
    -- After reviewing data, referring back to CountryPopInsured table, there is only a year value for each country, spread out over 20 years.
	-- DevelopingCountriesTaxRevenueHCSpend table is probably better off removed and just used by itself, but will keep in dataset for time being.
	-- After reviewing those larger missing value columns, there are 4 columns out of 16 columns with largest missing value being 175 rows or 4.7% of the data.
	-- Considering the number of tables joined, 9 fact tables and 1 dimension table, with varying data collected across countries and years,
	-- I feel confident about reviewing the data further in Power BI and seeing what visualizations and insights can be created.
