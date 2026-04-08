-- =========================================================
-- A company wants to create a pivot-style business report.
-- Write SQL queries to:
-- 1. Show regional sales as columns
-- 2. Count profitable vs loss orders
-- 3. Segment customers based on total revenue
-- 4. Classify products into performance bands
-- =========================================================

USE case_when_db;
GO

-- =========================================================
-- 1. Regional sales as columns (Pivot using CASE WHEN)
-- =========================================================

SELECT
    SUM(CASE WHEN region = 'North' THEN revenue ELSE 0 END) AS north_sales,
    SUM(CASE WHEN region = 'South' THEN revenue ELSE 0 END) AS south_sales,
    SUM(CASE WHEN region = 'East' THEN revenue ELSE 0 END) AS east_sales,
    SUM(CASE WHEN region = 'West' THEN revenue ELSE 0 END) AS west_sales
FROM sales_data;


-- =========================================================
-- 2. Profitable vs Loss Orders
-- =========================================================

SELECT
    SUM(CASE WHEN revenue > cost THEN 1 ELSE 0 END) AS profitable_orders,
    SUM(CASE WHEN revenue <= cost THEN 1 ELSE 0 END) AS loss_orders
FROM sales_data;


-- =========================================================
-- 3. Customer value segmentation
-- =========================================================

WITH customer_sales AS (
    SELECT
        customer_id,
        SUM(revenue) AS total_revenue
    FROM sales_data
    GROUP BY customer_id
)

SELECT
    customer_id,
    total_revenue,
    CASE
        WHEN total_revenue >= 70000 THEN 'High Value'
        WHEN total_revenue >= 30000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM customer_sales;


-- =========================================================
-- 4. Product performance bands
-- =========================================================

SELECT
    product,
    SUM(revenue) AS total_revenue,
    CASE
        WHEN SUM(revenue) >= 80000 THEN 'Top Performer'
        WHEN SUM(revenue) >= 40000 THEN 'Average Performer'
        ELSE 'Low Performer'
    END AS performance_band
FROM sales_data
GROUP BY product;
GO

