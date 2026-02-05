/*
Day 9 Summary:
Problem:
Customer datasets frequently contain NULL values that break aggregations,
segmentation logic, and reporting accuracy.

Business Scenario:
In real analytics workflows, missing customer age, city, or segmentation
fields cause incorrect KPIs and flawed targeting decisions.

Approach:
Used IS NULL to detect missing values.
Used COALESCE to safely replace NULL values.
Used NULLIF to prevent invalid business values.

Risk If Ignored:
• Aggregations return incorrect results
• Customer segmentation becomes unreliable
• Reports show misleading KPIs
• Dashboard filters behave unpredictably

Key Validation Check:
Verified NULL distribution before and after handling.

Result:
Created standardized dataset suitable for aggregation and reporting.

Next Step:
Apply subqueries to derive advanced business insights.
*/

USE analyst_practice;
GO


------------------------------------------------------------
-- Step 1: Identify NULL values in key business columns
------------------------------------------------------------

SELECT *
FROM dbo.customers
WHERE age IS NULL
   OR city IS NULL;

-- Insight:
-- Identifies incomplete customer records impacting segmentation.


------------------------------------------------------------
-- Step 2: Count NULL distribution across dataset
------------------------------------------------------------

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS null_age_count,
    SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS null_city_count
FROM dbo.customers;

-- Business Insight:
-- Helps quantify data quality risk before performing analysis.


------------------------------------------------------------
-- Step 3: Replace NULL values using COALESCE
------------------------------------------------------------

SELECT
    customer_id,
    customer_name,
    COALESCE(city, 'Unknown') AS cleaned_city,
    COALESCE(age, 0) AS cleaned_age
FROM dbo.customers;

-- Explanation:
-- COALESCE replaces NULL with business-safe default values.


------------------------------------------------------------
-- Step 4: Prevent invalid data using NULLIF
------------------------------------------------------------

SELECT
    customer_id,
    customer_name,
    NULLIF(age, 0) AS validated_age
FROM dbo.customers;

-- Explanation:
-- Converts placeholder values (0 age) into NULL
-- Helps maintain data integrity.


------------------------------------------------------------
-- Step 5: Create cleaned dataset for downstream analytics
------------------------------------------------------------

SELECT
    customer_id,
    customer_name,
    COALESCE(city, 'Unknown') AS city,
    NULLIF(COALESCE(age, 0), 0) AS age
INTO customers_null_cleaned
FROM dbo.customers;

-- Business Outcome:
-- Clean dataset ready for segmentation and aggregation.


------------------------------------------------------------
-- Step 6: Validate cleaned dataset quality
------------------------------------------------------------

SELECT
    COUNT(*) AS total_records,
    SUM(CASE WHEN city = 'Unknown' THEN 1 ELSE 0 END) AS replaced_city_count,
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS remaining_null_age
FROM customers_null_cleaned;

-- Validation Insight:
-- Confirms cleaning effectiveness and residual data quality gaps.


------------------------------------------------------------
-- End of Day 9 Worklog
------------------------------------------------------------
