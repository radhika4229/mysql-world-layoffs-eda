-- ============================================================
-- WORLD LAYOFFS — EXPLORATORY DATA ANALYSIS
-- ============================================================
-- Dataset: layoffs_staging2
-- Purpose: Explore layoffs to identify trends, patterns,
--          outliers, and high-impact companies/industries.
-- ============================================================


-- ============================================================
-- 1. BASIC EXPLORATION
-- ============================================================

-- View the cleaned dataset
SELECT *
FROM layoffs_staging2;


-- Largest single layoff event
SELECT 
    MAX(total_laid_off) AS max_layoff
FROM layoffs_staging2;


-- Largest and smallest percentage of workforce laid off
SELECT 
    MAX(percentage_laid_off) AS max_percentage,
    MIN(percentage_laid_off) AS min_percentage
FROM layoffs_staging2
WHERE percentage_laid_off IS NOT NULL;


-- Companies that laid off 100% of their workforce
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1;


-- Companies that laid off 100% of their workforce,
-- ordered by funding raised
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;


-- ============================================================
-- 2. COMPANY ANALYSIS
-- ============================================================

-- Companies with the biggest single layoff event
SELECT 
    company,
    total_laid_off
FROM layoffs_staging2
ORDER BY total_laid_off DESC
LIMIT 5;


-- Companies with the highest total layoffs
SELECT 
    company,
    SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY company
ORDER BY total_layoffs DESC
LIMIT 10;


-- ============================================================
-- 3. LOCATION & COUNTRY ANALYSIS
-- ============================================================

-- Locations with the highest total layoffs
SELECT 
    location,
    SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY location
ORDER BY total_layoffs DESC
LIMIT 10;


-- Countries with the highest total layoffs
SELECT 
    country,
    SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY country
ORDER BY total_layoffs DESC;


-- ============================================================
-- 4. TIME-BASED ANALYSIS
-- ============================================================

-- Total layoffs by year
SELECT 
    YEAR(date) AS year,
    SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY YEAR(date)
ORDER BY year ASC;


-- ============================================================
-- 5. INDUSTRY & COMPANY STAGE ANALYSIS
-- ============================================================

-- Total layoffs by industry
SELECT 
    industry,
    SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY industry
ORDER BY total_layoffs DESC;


-- Total layoffs by company stage
SELECT 
    stage,
    SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY stage
ORDER BY total_layoffs DESC;


-- ============================================================
-- 6. TOP COMPANIES BY YEAR
-- ============================================================

-- Calculate total layoffs for each company in each year
WITH Company_Year AS (
    SELECT 
        company,
        YEAR(date) AS year,
        SUM(total_laid_off) AS total_layoffs
    FROM layoffs_staging2
    GROUP BY company, YEAR(date)
),

-- Rank companies within each year
Company_Year_Rank AS (
    SELECT 
        company,
        year,
        total_layoffs,
        DENSE_RANK() OVER (
            PARTITION BY year
            ORDER BY total_layoffs DESC
        ) AS ranking
    FROM Company_Year
)

-- Return the top 3 companies for each year
SELECT 
    company,
    year,
    total_layoffs,
    ranking
FROM Company_Year_Rank
WHERE ranking <= 3
  AND year IS NOT NULL
ORDER BY year ASC, total_layoffs DESC;


-- ============================================================
-- 7. MONTHLY LAYOFF ANALYSIS
-- ============================================================

-- Total layoffs by month
SELECT 
    SUBSTRING(date, 1, 7) AS month,
    SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY month
ORDER BY month ASC;


-- ============================================================
-- 8. ROLLING / CUMULATIVE TOTAL
-- ============================================================

-- Calculate monthly layoffs first,
-- then calculate the cumulative layoffs over time
WITH Monthly_Layoffs AS (
    SELECT 
        SUBSTRING(date, 1, 7) AS month,
        SUM(total_laid_off) AS total_layoffs
    FROM layoffs_staging2
    GROUP BY month
)

SELECT 
    month,
    total_layoffs,
    SUM(total_layoffs) OVER (
        ORDER BY month ASC
    ) AS rolling_total_layoffs
FROM Monthly_Layoffs
ORDER BY month ASC;