/*
Day 15 Summary:
Problem:
Business teams rely on KPIs such as revenue, customer count, and order value
to measure performance. Without structured aggregation, reports become inconsistent.

Business Scenario:
Management needs daily, monthly, and customer-level KPIs to track growth,
marketing performance, and revenue contribution.

Approach:
Used aggregate functions such as SUM(), COUNT(), AVG(), MIN(), MAX().
Applied GROUP BY to derive business-level KPIs.
Created reusable KPI datasets for dashboard and reporting usage.

Risk If Ignored:
• KPI dashboards show inconsistent numbers
• Revenue trends become misleading
• Customer performance tracking becomes unreliable
• Business decision-making loses accuracy

Key Validation Check:
Verified totals and averages against base dataset counts.

Result:
Generated reliable KPI-ready aggregated dataset.

Next Step:
Apply multi-level grouping and advanced window functions for deeper insights.
*/

USE analyst_practice;
GO


------------------------------------------------------------
-- Step 1: Total Business Revenue KPI
------------------------------------------------------------

SELECT 
    SUM(order_amount) AS total_revenue
FROM dbo.orders;

-- Business Insight:
-- Measures overall company revenue performance.


------------------------------------------------------------
-- Step 2: Total Orders and Customer Count KPI
------------------------------------------------------------

SELECT 
    COUNT(order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM dbo.orders;

-- Business Insight:
-- Tracks order volume and customer acquisition performance.


------------------------------------------------------------
-- Step 3: Average Order Value KPI
------------------------------------------------------------

SELECT 
    AVG(order_amount) AS avg_order_value
FROM dbo.orders;

-- Business Insight:
-- Helps evaluate customer spending behavior.


------------------------------------------------------------
-- Step 4: Monthly Revenue Trend KPI
------------------------------------------------------------

SELECT 
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(order_amount) AS monthly_revenue
FROM dbo.orders
GROUP BY 
    YEAR(order_date),
    MONTH(order_date)
ORDER BY 
    order_year,
    order_month;

-- Business Insight:
-- Tracks revenue growth trends over time.


------------------------------------------------------------
-- Step 5: Customer-Level Revenue Contribution KPI
------------------------------------------------------------

SELECT 
    customer_id,
    SUM(order_amount) AS customer_total_revenue,
    COUNT(order_id) AS customer_total_orders,
    AVG(order_amount) AS customer_avg_order_value
FROM dbo.orders
GROUP BY customer_id
ORDER BY customer_total_revenue DESC;

-- Business Insight:
-- Identifies high-value customers and supports segmentation strategies.


------------------------------------------------------------
-- Step 6: Minimum and Maximum Order KPI
------------------------------------------------------------

SELECT 
    MIN(order_amount) AS lowest_order_value,
    MAX(order_amount) AS highest_order_value
FROM dbo.orders;

-- Business Insight:
-- Helps detect anomalies and understand order size variation.


------------------------------------------------------------
-- Step 7: Create KPI Summary Dataset for Dashboard
------------------------------------------------------------

SELECT 
    customer_id,
    COUNT(order_id) AS total_orders,
    SUM(order_amount) AS total_spent,
    AVG(order_amount) AS avg_order_value
INTO customer_kpi_summary
FROM dbo.orders
GROUP BY customer_id;

-- Business Outcome:
-- Reusable KPI dataset for reporting and dashboard visualization.


------------------------------------------------------------
-- Step 8: Validate KPI Dataset Quality
------------------------------------------------------------

SELECT 
    COUNT(*) AS total_customers,
    SUM(total_spent) AS aggregated_revenue
FROM customer_kpi_summary;

-- Validation Insight:
-- Ensures aggregated KPI dataset aligns with base revenue totals.


------------------------------------------------------------
-- End of Day 15 Worklog
------------------------------------------------------------
