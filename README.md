## 🚧 Professional Development Notice

This repository is a personal portfolio project intended to showcase my skills in SQL, Python, and Power BI.  
All analyses, visuals, and code are examples of my professional development work and should not be interpreted as production-ready solutions.  
Use this project for reference to my capabilities and approach—no other uses are implied or warranted.

#  🩺🏥 Healthcare Analytics & Visualization Project *(In Progress)*
> 🚧 *Current phase: Data Exploration (SQL + Power BI)*

This project explores a multi-source dataset representing global child mortality rates, life expectancies, GDP spend on healthcare and healthcare expenditures, using SQL, Python, and Power BI to uncover data-driven insights. It simulates real-world reporting demands in  public health and economics 

The original data came from [hrterhrter on Kaggle] (https://www.kaggle.com/datasets/programmerrdai/financing-healthcare)

## 📁 Project Overview

The goal of this project is to demonstrate:
- Reviewing tables of data to bring in most relevant data for creating insightful and interesting visualizations
- SQL proficiency for data exploration, transformation, and statistical analysis
- Python (pandas, matplotlib, plotnine) for data wrangling and custom visualizations
- Power BI for designing dynamic, user-friendly dashboards that support strategic decision-making

## 🛠️ Tech Stack
- **SQL Server**: subqueries, basic statistics, CASE WHEN statements, updating table and column names, creating stored procedures and formatted outputs
- **Python**: pandas, matplotlib, plotnine for analysis and visual storytelling
- **Power BI**: data modeling, KPIs, custom visuals, user-centric dashboarding
- **Version Control**: Git + GitHub for project history and version control

## 📊 Key Skills Demonstrated
- Use of subqueries, and statistical filters (e.g. outliers via standard deviation)
- Conversion of `varchar` fields into formatted numeric displays
- Python-based feature engineering and compatibility resolution (e.g., pandas upgrades, matplotlib issues)
- Design of data model and visuals in Power BI for economic metrics and compliance readiness

## 📁 Repository Structure

Healthcare-Analytics-Repo/
├─ README.md  
├─ [LICENSE](https://github.com/jeffbeckinc/Test/blob/main/License)  
├─ .gitignore  
│  
├─ sql/  
│   ├─ [01_table_inspection.sql](https://github.com/jeffbeckinc/Test/blob/main/01_table_inspection.sql)  Lists all user-defined tables and inspects schema details.  
│   ├─ [02_data_quality_checks.sql](https://github.com/jeffbeckinc/Test/blob/main/02_data_quality_checks.sql)  Counts total rows and missing values by column.                       
│   ├─ [03_outlier_detection.sql](https://github.com/jeffbeckinc/Test/blob/main/03_outlier_detection.sql)  Identifies outliers at 1–3 σ thresholds.                              
│   ├─ [04_consolidate_tables.sql](https://github.com/jeffbeckinc/Test/blob/main/04_consolidate_tables.sql)  Joins all source tables into a single fact table.                     
│   ├─ [05_data_cleaning_and_checks.sql](https://github.com/jeffbeckinc/Test/blob/main/05_data_cleaning_and_checks.sql)  Measures NULL counts, backfills missing Continent, filters records.
│  
├─ python/  
│   ├─ [data_wrangling.ipynb](python/data_wrangling.ipynb)  
│   └─ [custom_visuals.ipynb](python/custom_visuals.ipynb)  
│  
└─ powerbi/  
    └─ [HealthcareAnalytics.pbix](https://github.com/jeffbeckinc/Healthcare_Analytics/blob/main/HC_Analytics.pbix)  
