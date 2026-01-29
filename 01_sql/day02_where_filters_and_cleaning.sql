/* ============================================================
   DAY 2: Apply WHERE filters & build cleaned dataset
   Objective: Remove invalid records and create analysis-ready data
   ============================================================ */

USE analyst_practice;
GO

/* ------------------------------------------------------------
   Step 1: Review raw data issues
------------------------------------------------------------ */
SELECT *
FROM dbo.customers;
GO

/* Observations (from Day 1):
   - age has NULLs
   - city has NULLs
   - city has inconsistent casing (bangalore/Bangalore)
   - signup_date is valid
*/

/* ------------------------------------------------------------
   Step 2: Apply WHERE filters to remove bad records
------------------------------------------------------------ */
SELECT *
FROM dbo.customers
WHERE age IS NOT NULL
  AND city IS NOT NULL;
GO

/* ------------------------------------------------------------
   Step 3: Standardize text values (clean city names)
------------------------------------------------------------ */
SELECT
    id,
    name,
    age,
    UPPER(city) AS city_cleaned,
    signup_date
FROM dbo.customers
WHERE age IS NOT NULL
  AND city IS NOT NULL;
GO

/* ------------------------------------------------------------
   Step 4: Create cleaned table for analysis
------------------------------------------------------------ */
IF OBJECT_ID('dbo.customers_cleaned', 'U') IS NOT NULL
    DROP TABLE dbo.customers_cleaned;
GO

SELECT
    id,
    name,
    age,
    UPPER(city) AS city,
    signup_date
INTO dbo.customers_cleaned
FROM dbo.customers
WHERE age IS NOT NULL
  AND city IS NOT NULL;
GO

/* ------------------------------------------------------------
   Step 5: Validate cleaned dataset
------------------------------------------------------------ */
SELECT COUNT(*) AS cleaned_records
FROM dbo.customers_cleaned;
GO

SELECT *
FROM dbo.customers_cleaned;
GO

/* ------------------------------------------------------------
   Decision:
   - Raw data filtered
   - Text standardized
   - Clean table ready for KPI calculations
   Next Day: Aggregations & business metrics
------------------------------------------------------------ */
