/*
Day 2 Summary:
Problem: Raw customer data contained NULLs and inconsistent city values.
Approach: Filtered invalid rows using WHERE conditions and standardized city names.
Key Check: Verified row counts and NULL distribution after cleaning.
Result: Created customers_cleaned table ready for analysis.
Next Step: Deduplicated records and build business metrics.
*/

USE analyst_practice;
GO

/* ============================================================
   Day 2: Data Cleaning Using WHERE Filters
   Objective: Create clean, analysis-ready customer data
   ============================================================ */

---------------------------------------------------------------
-- Step 1: Review raw data quality
---------------------------------------------------------------
SELECT 
    COUNT(*) AS total_rows,
    COUNT(age) AS age_not_null,
    COUNT(city) AS city_not_null,
    COUNT(signup_date) AS signup_not_null
FROM dbo.customers;
GO

/* Observation:
- Some rows had missing age
- Some rows had missing city
- These records were not suitable for analysis
*/

---------------------------------------------------------------
-- Step 2: Standardize city values
---------------------------------------------------------------
SELECT 
    id,
    name,
    age,
    CASE 
        WHEN LOWER(city) = 'bangalore' THEN 'Bangalore'
        WHEN LOWER(city) = 'hyderabad' THEN 'Hyderabad'
        WHEN LOWER(city) = 'chennai' THEN 'Chennai'
        ELSE city
    END AS city_cleaned,
    signup_date
FROM dbo.customers;
GO

/* Observation:
- City values were standardized successfully
*/

---------------------------------------------------------------
-- Step 3: Create cleaned dataset using WHERE filters
---------------------------------------------------------------
IF OBJECT_ID('dbo.customers_cleaned', 'U') IS NOT NULL
    DROP TABLE dbo.customers_cleaned;
GO

SELECT
    id,
    name,
    age,
    CASE 
        WHEN LOWER(city) = 'bangalore' THEN 'Bangalore'
        WHEN LOWER(city) = 'hyderabad' THEN 'Hyderabad'
        WHEN LOWER(city) = 'chennai' THEN 'Chennai'
        ELSE city
    END AS city,
    signup_date
INTO dbo.customers_cleaned
FROM dbo.customers
WHERE age IS NOT NULL
  AND city IS NOT NULL
  AND signup_date IS NOT NULL;
GO

---------------------------------------------------------------
-- Step 4: Validate cleaned dataset
---------------------------------------------------------------
SELECT 
    COUNT(*) AS cleaned_rows,
    COUNT(age) AS age_not_null,
    COUNT(city) AS city_not_null,
    COUNT(signup_date) AS signup_not_null
FROM dbo.customers_cleaned;
GO

---------------------------------------------------------------
-- Step 5: Perform sample data check
---------------------------------------------------------------
SELECT TOP 10 *
FROM dbo.customers_cleaned
ORDER BY signup_date;
GO

/* Decision:
- Cleaned dataset was validated
- No NULLs existed in critical fields
- Data was ready for metric calculations
*/

---------------------------------------------------------------
-- Next Step (Day 3)
---------------------------------------------------------------
/*
- Deduplicate customer records
- Apply ROW_NUMBER() logic
- Prepare final analytical base table
*/
