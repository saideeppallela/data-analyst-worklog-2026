/*
Day 22 Summary:
Problem:
Business reporting often requires combining tables AND summarizing metrics.
Many analysts know JOINs and aggregates separately but struggle to combine them.

Business Scenario:
A company wants to understand revenue, customer counts, and order trends
across cities, products, and segments.

Approach:
Joined customers with orders to combine behavioral + transactional data.
Applied aggregations to derive business KPIs.
Grouped results to produce decision-ready summaries.

Risk If Ignored:
• Analysts pull incomplete insights from single tables
• Revenue metrics appear inconsistent across reports
• Customer segmentation becomes misleading
• Executives receive fragmented dashboards

Key Validation Check:
Verified aggregation totals match raw order data.

Result:
Created a joined dataset that supports multi-dimensional KPI analysis.

Next Step:
Apply HAVING and window functions for advanced business reporting.
*/

USE analyst_practice;
GO


------------------------------------------------------------
-- Step 1: Join customers with orders
------------------------------------------------------------

SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    o.order_id,
    o.order_date,
    o.amount
FROM dbo.customers c
INNER JOIN dbo.orders o
    ON c.customer_id = o.customer_id;

-- Insight:
-- Combines demographic + transactional information.


------------------------------------------------------------
-- Step 2: Revenue per city (JOIN + aggregation)
------------------------------------------------------------

SELECT
    c.city,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_revenue,
    AVG(o.amount) AS avg_order_value
FROM dbo.customers c
INNER JOIN dbo.orders o
    ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_revenue DESC;

-- Business Insight:
-- Identifies top-performing cities by revenue.


------------------------------------------------------------
-- Step 3: Customer purchase frequency analysis
------------------------------------------------------------

SELECT
    c.customer_name,
    COUNT(o.order_id) AS purchase_count,
    SUM(o.amount) AS total_spent
FROM dbo.customers c
LEFT JOIN dbo.orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

-- Insight:
-- Shows high-value customers and inactive ones.


------------------------------------------------------------
-- Step 4: Monthly revenue trend (JOIN + DATE aggregation)
------------------------------------------------------------

SELECT
    YEAR(o.order_date) AS order_year,
    MONTH(o.order_date) AS order_month,
    SUM(o.amount) AS monthly_revenue
FROM dbo.orders o
GROUP BY
    YEAR(o.order_date),
    MONTH(o.order_date)
ORDER BY order_year, order_month;

-- Business Insight:
-- Supports revenue forecasting and seasonal planning.


------------------------------------------------------------
-- Step 5: Create KPI-ready dataset for dashboards
------------------------------------------------------------

SELECT
    c.city,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS revenue
INTO joined_kpi_summary
FROM dbo.customers c
LEFT JOIN dbo.orders o
    ON c.customer_id = o.customer_id
GROUP BY c.city;

-- Outcome:
-- City-level KPI dataset ready for BI dashboards.


------------------------------------------------------------
-- Step 6: Validate KPI dataset
------------------------------------------------------------

SELECT
    COUNT(*) AS cities_covered,
    SUM(total_orders) AS total_orders,
    SUM(revenue) AS total_revenue
FROM joined_kpi_summary;

-- Validation Insight:
-- Confirms aggregation accuracy vs base tables.


------------------------------------------------------------
-- End of Day 22 Worklog
------------------------------------------------------------
