/*
Day 27 Summary:
Problem:
Businesses often need to rank customers, products, or regions
within groups and track cumulative performance over time.

Business Scenario:
Management wants to know:
• Top customers per city
• Sales rank within each product category
• Running revenue totals month-by-month

Approach:
Used PARTITION BY with window functions:
• ROW_NUMBER() for ranking within groups
• RANK() for tied positions
• SUM() OVER() for running totals

Risk If Ignored:
• Incorrect global rankings instead of grouped insights
• Loss of trend visibility across time
• Hard to identify top performers per segment

Key Validation Check:
Verified rankings reset correctly per partition group.

Result:
Created grouped rankings and cumulative metrics for analysis.

Next Step:
Use window functions for advanced analytics like moving averages.
*/

USE analyst_practice;
GO


------------------------------------------------------------
-- Step 1: Rank customers by spending within each city
------------------------------------------------------------

SELECT
    city,
    customer_name,
    SUM(order_amount) AS total_spent,
    ROW_NUMBER() OVER (
        PARTITION BY city
        ORDER BY SUM(order_amount) DESC
    ) AS city_rank
FROM dbo.orders o
JOIN dbo.customers c
    ON o.customer_id = c.customer_id
GROUP BY city, customer_name;

-- Insight:
-- Shows top customers per city rather than global ranking.



------------------------------------------------------------
-- Step 2: Rank products within category using RANK()
------------------------------------------------------------

SELECT
    category,
    product_name,
    SUM(order_amount) AS total_sales,
    RANK() OVER (
        PARTITION BY category
        ORDER BY SUM(order_amount) DESC
    ) AS category_rank
FROM dbo.orders o
JOIN dbo.products p
    ON o.product_id = p.product_id
GROUP BY category, product_name;

-- Insight:
-- Handles ties properly within each product category.



------------------------------------------------------------
-- Step 3: Running revenue totals over time
------------------------------------------------------------

SELECT
    order_date,
    SUM(order_amount) AS daily_revenue,
    SUM(SUM(order_amount)) OVER (
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_revenue
FROM dbo.orders
GROUP BY order_date
ORDER BY order_date;

-- Insight:
-- Shows revenue growth trend across timeline.



------------------------------------------------------------
-- Step 4: Running revenue per city using PARTITION BY
------------------------------------------------------------

SELECT
    city,
    order_date,
    SUM(order_amount) AS daily_revenue,
    SUM(SUM(order_amount)) OVER (
        PARTITION BY city
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_city_revenue
FROM dbo.orders o
JOIN dbo.customers c
    ON o.customer_id = c.customer_id
GROUP BY city, order_date
ORDER BY city, order_date;

-- Insight:
-- Tracks revenue trend separately for each city.



------------------------------------------------------------
-- Step 5: Validation check – ensure ranking resets per group
------------------------------------------------------------

SELECT
    city,
    MAX(city_rank) AS max_rank_per_city
FROM (
    SELECT
        city,
        ROW_NUMBER() OVER (
            PARTITION BY city
            ORDER BY SUM(order_amount) DESC
        ) AS city_rank
    FROM dbo.orders o
    JOIN dbo.customers c
        ON o.customer_id = c.customer_id
    GROUP BY city, customer_name
) ranked_data
GROUP BY city;

-- Validation Insight:
-- Confirms rankings restart correctly per partition.



------------------------------------------------------------
-- End of Day 27 Worklog
------------------------------------------------------------
