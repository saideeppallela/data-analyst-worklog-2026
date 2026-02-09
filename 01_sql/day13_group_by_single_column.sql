/*
Day 13 Summary:
Problem:
Businesses need quick aggregated insights like customer count by city,
orders by category, or revenue by region.

Business Scenario:
Managers often need summarized reports instead of raw transaction-level data.
Without aggregation, datasets remain difficult to analyze and interpret.

Approach:
Used GROUP BY on single business columns.
Applied aggregate functions like COUNT() and SUM().
Validated grouping accuracy using business logic.

Risk If Ignored:
• Raw data becomes difficult to interpret
• Business reporting lacks summarized insights
• KPI dashboards become inefficient
• Performance drops when summarization is delayed

Key Validation Check:
Verified grouping totals match overall dataset totals.

Result:
Generated clean summarized datasets for business reporting.

Next Step:
Apply GROUP BY with multiple columns for advanced segmentation.
*/

USE analyst_practice;
GO


------------------------------------------------------------
-- Step 1: Customer Count by City
------------------------------------------------------------

SELECT
    city,
    COUNT(*) AS total_customers
FROM dbo.customers
GROUP BY city
ORDER BY total_customers DESC;

-- Business Insight:
-- Helps identify customer concentration across locations.


------------------------------------------------------------
-- Step 2: Customer Count by Gender
------------------------------------------------------------

SELECT
    gender,
    COUNT(*) AS total_customers
FROM dbo.customers
GROUP BY gender;

-- Business Insight:
-- Supports demographic analysis for marketing strategy.


------------------------------------------------------------
-- Step 3: Customer Distribution by Age Group
------------------------------------------------------------

SELECT
    age,
    COUNT(*) AS customer_count
FROM dbo.customers
GROUP BY age
ORDER BY age;

-- Explanation:
-- Helps identify customer distribution across age groups.


------------------------------------------------------------
-- Step 4: Total Orders by Product Category
------------------------------------------------------------

SELECT
    category,
    COUNT(order_id) AS total_orders
FROM dbo.orders
GROUP BY category
ORDER BY total_orders DESC;

-- Business Outcome:
-- Identifies high-performing product categories.


------------------------------------------------------------
-- Step 5: Total Revenue by City
------------------------------------------------------------

SELECT
    city,
    SUM(order_amount) AS total_revenue
FROM dbo.orders
GROUP BY city
ORDER BY total_revenue DESC;

-- Business Outcome:
-- Helps identify revenue-driving locations.


------------------------------------------------------------
-- Step 6: Validation Check – Aggregated vs Raw Count
------------------------------------------------------------

SELECT
    COUNT(*) AS total_raw_orders
FROM dbo.orders;

SELECT
    SUM(order_count) AS total_grouped_orders
FROM
(
    SELECT COUNT(order_id) AS order_count
    FROM dbo.orders
    GROUP BY category
) AS grouped_data;

-- Validation Insight:
-- Confirms aggregation accuracy.


------------------------------------------------------------
-- End of Day 13 Worklog
------------------------------------------------------------
