/*
Day 10 Summary:
Problem:
Customer datasets often contain inconsistent text formatting such as mixed case,
leading/trailing spaces, and uneven string lengths. These issues break grouping,
search filtering, and reporting accuracy.

Business Scenario:
In real analytics workflows, inconsistent customer names, cities, and categories
cause duplicate records, incorrect segmentation, and unreliable dashboards.

Approach:
Used UPPER and LOWER for case standardization.
Used TRIM to remove unnecessary whitespace.
Used LEN to measure text length and identify data inconsistencies.

Risk If Ignored:
• Duplicate customer segmentation
• Search filters return incomplete results
• Reporting dashboards show fragmented insights
• Business KPIs get split across inconsistent values

Key Validation Check:
Verified string standardization before and after transformation.

Result:
Created standardized text dataset suitable for grouping, filtering,
and reliable analytics reporting.

Next Step:
Apply pattern matching using LIKE and advanced string parsing techniques.
*/

USE analyst_practice;
GO


------------------------------------------------------------
-- Step 1: Identify inconsistent text case issues
------------------------------------------------------------

SELECT DISTINCT city
FROM dbo.customers;

-- Insight:
-- Detects duplicate values caused by mixed case formatting
-- Example: "Hyderabad", "HYDERABAD", "hyderabad"


------------------------------------------------------------
-- Step 2: Standardize text using UPPER and LOWER
------------------------------------------------------------

SELECT
    customer_id,
    customer_name,
    UPPER(customer_name) AS customer_name_upper,
    LOWER(city) AS city_lower
FROM dbo.customers;

-- Explanation:
-- UPPER standardizes text for reporting consistency
-- LOWER helps normalize location grouping


------------------------------------------------------------
-- Step 3: Detect leading and trailing whitespace issues
------------------------------------------------------------

SELECT
    customer_id,
    customer_name,
    city,
    LEN(city) AS original_length,
    LEN(TRIM(city)) AS trimmed_length
FROM dbo.customers
WHERE city <> TRIM(city);

-- Business Insight:
-- Whitespace errors create duplicate grouping and filter mismatches.


------------------------------------------------------------
-- Step 4: Clean whitespace using TRIM
------------------------------------------------------------

SELECT
    customer_id,
    customer_name,
    TRIM(city) AS cleaned_city,
    TRIM(customer_name) AS cleaned_customer_name
FROM dbo.customers;

-- Explanation:
-- TRIM removes leading and trailing spaces.
-- Ensures accurate grouping and filtering.


------------------------------------------------------------
-- Step 5: Identify abnormal string length values
------------------------------------------------------------

SELECT
    customer_id,
    customer_name,
    LEN(customer_name) AS name_length
FROM dbo.customers
WHERE LEN(customer_name) < 3
   OR LEN(customer_name) > 50;

-- Business Insight:
-- Detects invalid customer records or data entry errors.


------------------------------------------------------------
-- Step 6: Create standardized dataset for analytics
------------------------------------------------------------

SELECT
    customer_id,
    UPPER(TRIM(customer_name)) AS customer_name,
    UPPER(TRIM(city)) AS city,
    email
INTO customers_string_cleaned
FROM dbo.customers;

-- Business Outcome:
-- Standardized text dataset ready for aggregation and segmentation.


------------------------------------------------------------
-- Step 7: Validate string standardization effectiveness
------------------------------------------------------------

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT customer_name) AS unique_customer_names,
    COUNT(DISTINCT city) AS unique_cities
FROM customers_string_cleaned;

-- Validation Insight:
-- Confirms text normalization improved grouping consistency.


------------------------------------------------------------
-- End of Day 10 Worklog
------------------------------------------------------------
