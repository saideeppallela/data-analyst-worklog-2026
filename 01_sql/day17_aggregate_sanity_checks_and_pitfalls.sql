/*
Day 17 Summary:
Problem:
Aggregates like SUM, COUNT, and AVG can silently produce misleading
results when duplicate records, NULL values, or incorrect joins exist.

Business Scenario:
Companies rely on aggregated metrics to track revenue, customer growth,
and operational KPIs. Without validation, dashboards may display
inflated or deflated numbers.

Approach:
Performed aggregate validation using multiple comparison checks.
Verified row duplication impact.
Compared COUNT vs COUNT DISTINCT.
Checked NULL handling in aggregates.

Risk If Ignored:
• Revenue metrics become inflated due to duplicate joins
• Customer counts become inaccurate
• KPIs mislead stakeholders
• Dashboard trust reduces

Key Validation Check:
Cross-verified aggregates using alternative logic and dataset sampling.

Result:
Created validated aggregate metrics suitable for reliable reporting.

Next Step:
Introduce JOIN-based aggregations for multi-table business analysis.
*/

USE analyst_practice;
GO


------------------------------------------------------------
-- Step 1: Basic Aggregate Calculation
------------------------------------------------------------

SELECT
    COUNT(*) AS total_customers,
    AVG(age) AS average_customer_age
FROM dbo.customers;

-- Insight:
-- Provides baseline aggregate metrics.


------------------------------------------------------------
-- Step 2: COUNT vs COUNT DISTINCT Validation
------------------------------------------------------------

SELECT
    COUNT(customer_id) AS total_records,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM dbo.customers;

-- Business Insight:
-- Detects duplicate customer entries that inflate KPIs.


------------------------------------------------------------
-- Step 3: NULL Impact on Aggregates
------------------------------------------------------------

SELECT
    COUNT(age) AS non_null_age_count,
    COUNT(*) AS total_rows
FROM dbo.customers;

-- Explanation:
-- COUNT(column) ignores NULL values.
-- Helps identify missing data bias.


------------------------------------------------------------
-- Step 4: Detect Duplicate Rows Impacting Aggregation
------------------------------------------------------------

SELECT
    customer_name,
    COUNT(*) AS duplicate_count
FROM dbo.customers
GROUP BY customer_name
HAVING COUNT(*) > 1;

-- Business Insight:
-- Duplicate records distort revenue and customer metrics.


------------------------------------------------------------
-- Step 5: Aggregate Cross Validation
------------------------------------------------------------

-- Method 1
SELECT SUM(total_spent) AS total_revenue
FROM dbo.orders;

-- Method 2
SELECT SUM(order_amount) AS total_revenue_check
FROM dbo.orders;

-- Insight:
-- Comparing metrics from alternative columns prevents data inconsistency.


------------------------------------------------------------
-- Step 6: Validate Aggregation Using Sampling
------------------------------------------------------------

SELECT TOP 10 *
FROM dbo.orders
ORDER BY order_date DESC;

-- Explanation:
-- Sampling verifies source data integrity before aggregation.


------------------------------------------------------------
-- Step 7: Aggregate Validation with Clean Dataset
------------------------------------------------------------

SELECT
    city,
    COUNT(DISTINCT customer_id) AS unique_customer_count,
    SUM(total_spent) AS revenue_by_city
FROM dbo.customers
GROUP BY city
ORDER BY revenue_by_city DESC;

-- Business Outcome:
-- Produces validated city-level KPI metrics.


------------------------------------------------------------
-- End of Day 17 Worklog
------------------------------------------------------------
