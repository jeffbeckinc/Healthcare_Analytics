#  🩺🏥 Healthcare Analytics & Visualization Project *(In Progress)*
> 🚧 *Current phase: Data Exploration (SQL + Power BI)*

This project explores a multi-source dataset representing global child mortality rates and healthcare expenditures, using SQL, Python, and Power BI to uncover data-driven insights. It simulates real-world reporting demands in logistics, public health, and compliance monitoring.

## 📁 Project Overview

The goal of this project is to demonstrate:
- SQL proficiency for data exploration, transformation, and statistical analysis
- Python (pandas, matplotlib, plotnine) for data wrangling and custom visualizations
- Power BI for designing dynamic, user-friendly dashboards that support strategic decision-making

## 🛠️ Tech Stack
- **SQL Server**: complex queries, ranking, statistical filters, formatted outputs
- **Python**: pandas, matplotlib, plotnine for analysis and visual storytelling
- **Power BI**: data modeling, KPIs, custom visuals, user-centric dashboarding
- **Version Control**: Git + GitHub for project history and collaboration

## 📊 Key Skills Demonstrated
- Use of `RANK()`, `ROW_NUMBER()`, and statistical filters (e.g. outliers via standard deviation)
- Conversion of `varchar` fields into formatted numeric displays
- Python-based feature engineering and compatibility resolution (e.g., pandas upgrades, matplotlib issues)
- Design of data model and visuals in Power BI for fleet KPIs and compliance readiness

## 📁 File Structure

```bash
Financing-Healthcare/
├── SQL/
│   ├── exploratory_analysis.sql               # Queries for initial data exploration and profiling
│   ├── formatting_cleaning.sql                # Scripts for type conversion, formatting, and null handling
│   └── statistical_queries.sql                # Outlier detection and distribution analysis
├── Python/
│   ├── data_cleaning.py                       # Future script for data wrangling using pandas
│   ├── mortality_visuals.py                   # Planned custom plots using plotnine/matplotlib
│   └── che_outliers_analysis.py               # Placeholder for exploratory comparisons
├── PowerBI/
│   ├── FinancingHealthcare.pbix               # Primary Power BI dashboard file
│   └── visuals_documentation.md               # Descriptions of visuals, bookmarks, and interactivity logic
├── data/
│   └── ChildMortalityVsCHE.csv                # Raw dataset of mortality and healthcare expenditure
├── README.md                                  # Project overview and documentation

