# World Layoffs — Exploratory Data Analysis

## Project Overview

This project performs Exploratory Data Analysis (EDA) on a global layoffs dataset using MySQL.

The analysis is performed on a cleaned dataset created during the data-cleaning phase of the project.

The goal is to explore layoffs across companies, countries, industries, company stages, and time periods to identify major trends and patterns.

## Objectives

- Explore the cleaned layoffs dataset
- Identify companies with the highest layoffs
- Analyze layoffs by country and location
- Analyze layoffs by industry and company stage
- Identify yearly and monthly layoffs trends
- Find the top companies by layoffs for each year
- Calculate cumulative layoffs over time
- Identify notable patterns and trends in the dataset

## Tools & Technologies

- MySQL
- MySQL Workbench
- SQL
- Common Table Expressions (CTEs)
- Window Functions
- DENSE_RANK()
- Aggregate Functions
- GROUP BY
- ORDER BY

## Analysis Performed

### 1. Basic Exploration
- Maximum number of employees laid off in a single event
- Minimum and maximum percentage of workforce laid off
- Companies that laid off 100% of their workforce
- Funding raised by companies that laid off 100% of their workforce

### 2. Company Analysis
- Largest single layoff events
- Companies with the highest total layoffs

### 3. Location & Country Analysis
- Locations with the highest total layoffs
- Countries with the highest total layoffs

### 4. Time-Based Analysis
- Total layoffs by year
- Monthly layoffs

### 5. Industry & Company Stage Analysis
- Total layoffs by industry
- Total layoffs by company stage

### 6. Yearly Company Ranking
Used CTEs and `DENSE_RANK()` to identify the top 3 companies by total layoffs for each year.

### 7. Rolling Layoff Analysis
Calculated cumulative layoffs over time using SQL window functions.

## Key Findings

- The dataset contains 1,995 cleaned records.
- 2022 recorded the highest total layoffs at 160,661.
- 2023 recorded 125,677 layoffs.
- The United States recorded 256,559 total layoffs.
- Consumer had the highest recorded layoffs among industries with 45,182.
- Retail followed with 43,613 layoffs.
- Post-IPO companies accounted for the highest total layoffs by company stage, with 204,132 recorded layoffs.

Additional findings from the yearly company rankings and monthly/rolling analysis can be explored in the SQL file.

## Project Structure

```text
mysql-world-layoffs-eda/
│
├── README.md
└── world_layoffs_eda.sql
```

## Related Project

This EDA project is the second stage of the World Layoffs SQL analysis.

The first project focused on cleaning and preparing the raw dataset before performing exploratory analysis.

**Data Cleaning Project:**  
https://github.com/radhika4229/mysql-data-cleaning-world-layoffs

## What I Learned

Through this project, I practiced applying SQL to an end-to-end data analysis workflow, including:

- Aggregating and summarizing data
- Grouping data by different dimensions
- Analyzing trends over time
- Using CTEs to structure multi-step analysis
- Using window functions for ranking and cumulative analysis
- Translating business questions into SQL queries
- Interpreting analytical results from a real-world dataset