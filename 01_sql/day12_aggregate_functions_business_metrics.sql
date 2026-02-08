/*
Day 12 Summary:
Problem:
Raw transactional datasets do not directly provide business KPIs.
Analysts must aggregate data to extract meaningful performance insights.

Business Scenario:
Organizations rely on aggregated metrics like total revenue,
average order value, and customer distribution to monitor growth
and guide strategic decisions.

Approach:
Used aggregate functions:
COUNT, SUM, AVG, MIN, MAX

Risk If Ignored:
• Raw data becomes difficult to interpret
• KPI dashboards show incomplete insights
• Performance tracking becomes unreliable

Key Validation Check:
Verified aggregated metrics align with transactional totals.

Result:
Generated business-ready performance metrics dataset.

Next Step:
Use GROUP BY to segment metrics by business categories.
*/

USE analyst_practice;
GO


------------------------------------------------------------
-- Step 1: Count total customers in dataset
------------------------------------------------------------

SELECT COUNT(*) AS total_customers
FROM dbo.customers;

-- Business Insight:
-- Helps understand customer base size.


------------------------------------------------------------
-- Step 2: Count total orders placed
------------------------------------------------------------

SELECT COUNT(*) AS total_orders
FROM dbo.orders;

-- Business Insight:
-- Tracks platform activity volume.


------------------------------------------------------------
-- Step 3: Calculate total revenue generated
------------------------------------------------------------

SELECT SUM(order_amount) AS total_revenue
FROM dbo.orders;

-- Business Insight:
-- Core financial performance metric.


------------------------------------------------------------
-- Step 4: Calculate average order value
------------------------------------------------------------

SELECT AVG(order_amount) AS avg_order_value
FROM dbo.orders;

-- Business Insight:
-- Helps evaluate customer spending behavior.


------------------------------------------------------------
-- Step 5: Identify highest and lowest order values
------------------------------------------------------------

SELECT
    MAX(order_amount) AS highest_order_value,
    MIN(order_amount) AS lowest_order_value
FROM dbo.orders;

-- Business Insight:
-- Detects premium purchase behavior and entry-level transactions.


------------------------------------------------------------
-- Step 6: Generate combined business KPI snapshot
------------------------------------------------------------

SELECT
    COUNT(order_id) AS total_orders,
    SUM(order_amount) AS total_revenue,
    AVG(order_amount) AS average_order_value,
    MAX(order_amount) AS highest_order_value,
    MIN(order_amount) AS lowest_order_value
FROM dbo.orders;

-- Business Outcome:
-- Provides quick performance summary for dashboards and reporting.


------------------------------------------------------------
-- Step 7: Validate aggregation consistency
------------------------------------------------------------

SELECT
    COUNT(*) AS order_record_check,
    SUM(order_amount) AS revenue_validation
FROM dbo.orders;

-- Validation Insight:
-- Confirms KPI calculations match transactional data.


------------------------------------------------------------
-- End of Day 12 Worklog
------------------------------------------------------------
