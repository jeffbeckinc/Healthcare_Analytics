/*
  File:    sql/04_consolidate_tables.sql
  Repo:    https://github.com/yourusername/Healthcare-Analytics-Repo
  Purpose: 
    - Join multiple source tables into one wide fact table.
    - Prepare a single dataset for statistical analysis and visualization.
  Usage:
    1. Run after initial table inspection and data‐quality checks.
    2. Store the result in a staging table or view for next steps.
*/

-- Consolidate tables with unique and desired fields into one table. Table names have been modified to easier querying and clarity from original source names
SELECT 
	   a.Entity
      ,a.Code
      ,a.Year
      ,ROUND(a.AnnualCHE,2) AS 'CHE_PerCapita'
	  ,b.CHE_outofGDP
	  ,ROUND(c.AnnualChe,2) As AnnualCHE
	  ,c.GDPperCapita
	  ,c.EstimatedPopulation as Population
	  ,c.Continent
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
