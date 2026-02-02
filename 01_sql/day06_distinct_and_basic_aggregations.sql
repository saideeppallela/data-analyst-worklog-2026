/*
Day 6 Summary:
Problem: Raw tables often contain repeated values and no clear summary.
Approach: Used DISTINCT and basic aggregation functions to understand data distribution.
Key Check: Verified unique counts and summary statistics.
Result: Clear high-level understanding of customers before deeper analysis.
Next Step: GROUP BY for segmented metrics.
*/

USE analyst_practice;
GO

--------------------------------------------------
-- Step 1: Identify duplicate values in columns
--------------------------------------------------

SELECT city
FROM dbo.customers;
-- Observation: Cities repeat across multiple customers


--------------------------------------------------
-- Step 2: Find unique values using DISTINCT
--------------------------------------------------

SELECT DISTINCT city
FROM dbo.customers;
-- Observation: Helps understand actual city coverage


--------------------------------------------------
-- Step 3: Count total records vs unique values
--------------------------------------------------

SELECT 
    COUNT(*) AS total_customers,
    COUNT(DISTINCT city) AS unique_cities
FROM dbo.customers;
-- Insight: High row count but limited unique dimensions


--------------------------------------------------
-- Step 4: Basic aggregations on numeric columns
--------------------------------------------------

SELECT
    MIN(age) AS min_age,
    MAX(age) AS max_age,
    AVG(age) AS avg_age
FROM dbo.customers
WHERE age IS NOT NULL;
-- Insight: Age range sanity check


--------------------------------------------------
-- Step 5: Business sanity check
--------------------------------------------------
-- Are ages realistic?
-- Are NULLs impacting averages?
-- Should age be bucketed later?

-- Decision:
-- Data is suitable for grouping & segmentation

--------------------------------------------------
-- End of Day 6
--------------------------------------------------
