/*
Day 28 Summary:
Problem:
Business teams often need ranked insights, running totals, and
performance comparisons that simple GROUP BY queries cannot provide.

Business Scenario:
Companies need to identify top customers, track revenue growth trends,
and compare performance across regions and time.

Approach:
Used ROW_NUMBER for ranking.
Used SUM OVER for running totals.
Used PARTITION BY for segmented analysis.

Risk If Ignored:
• High-value customers remain unidentified
• Trend patterns remain hidden
• Performance comparisons become misleading
• Business prioritization becomes guesswork

Key Validation Check:
Verified ranking order and running totals consistency.

Result:
Created advanced analytics-ready dataset for business insights.

Next Step:
Combine window functions with joins and KPIs.
*/

USE analyst_practice;
GO


------------------------------------------------------------
-- Step 1: Rank customers by total spending
------------------------------------------------------------

SELECT
    customer_id,
    customer_name,
    SUM(order_amount) AS total_spent,
    ROW_NUMBER() OVER (ORDER BY SUM(order_amount) DESC) AS spending_rank
FROM dbo.orders
GROUP BY customer_id, customer_name;

-- Insight:
-- Identifies top customers for retention and loyalty programs.


------------------------------------------------------------
-- Step 2: Running revenue total over time
------------------------------------------------------------

SELECT
    order_date,
    SUM(order_amount) AS daily_revenue,
    SUM(SUM(order_amount)) OVER (ORDER BY order_date) AS running_total_revenue
FROM dbo.orders
GROUP BY order_date
ORDER BY order_date;

-- Business Insight:
-- Tracks revenue growth trend for business monitoring.


------------------------------------------------------------
-- Step 3: Regional performance comparison
------------------------------------------------------------

SELECT
    city,
    customer_id,
    order_amount,
    RANK() OVER (PARTITION BY city ORDER BY order_amount DESC) AS city_rank
FROM dbo.orders;

-- Explanation:
-- Shows top-performing customers within each city.


------------------------------------------------------------
-- Step 4: Identify repeat customers over time
------------------------------------------------------------

SELECT
    customer_id,
    order_date,
    COUNT(*) OVER (PARTITION BY customer_id) AS total_orders_by_customer
FROM dbo.orders;

-- Insight:
-- Helps detect loyal customers and churn risk.


------------------------------------------------------------
-- Step 5: Create business insights dataset
------------------------------------------------------------

SELECT
    customer_id,
    city,
    order_date,
    order_amount,
    SUM(order_amount) OVER (PARTITION BY city ORDER BY order_date) AS city_running_revenue
INTO window_business_insights
FROM dbo.orders;

-- Business Outcome:
-- Dataset ready for dashboards and trend analysis.


------------------------------------------------------------
-- Step 6: Validate insights dataset
------------------------------------------------------------

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(order_amount) AS total_revenue
FROM window_business_insights;

-- Validation Insight:
-- Ensures dataset completeness and aggregation consistency.


------------------------------------------------------------
-- End of Day 28 Worklog
------------------------------------------------------------
