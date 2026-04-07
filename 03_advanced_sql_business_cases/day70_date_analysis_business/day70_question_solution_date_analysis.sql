
-- A company wants to analyze delivery performance and revenue trends.
-- Write SQL queries to:
-- 1. Calculate average delivery days per ship mode
-- 2. Show quarterly revenue trend
-- 3. Compare Year-over-Year (YoY) sales
-- 4. Filter last 30 days data
-- =========================================================
-- =========================================================
-- 1. Average delivery days per ship mode
-- =========================================================

SELECT
    ship_mode,
    AVG(DATEDIFF(DAY, order_date, ship_date)) AS avg_delivery_days
FROM orders
GROUP BY ship_mode;


-- =========================================================
-- 2. Quarterly revenue trend
-- =========================================================

SELECT
    YEAR(order_date) AS year,
    DATEPART(QUARTER, order_date) AS quarter,
    SUM(revenue) AS total_revenue
FROM orders
GROUP BY
    YEAR(order_date),
    DATEPART(QUARTER, order_date)
ORDER BY year, quarter;


-- =========================================================
-- 3. Year-over-Year (YoY) comparison
-- =========================================================

WITH yearly_sales AS (
    SELECT
        YEAR(order_date) AS year,
        SUM(revenue) AS total_sales
    FROM orders
    GROUP BY YEAR(order_date)
)

SELECT
    year,
    total_sales,
    LAG(total_sales) OVER (ORDER BY year) AS prev_year_sales,
    ((total_sales - LAG(total_sales) OVER (ORDER BY year))
     / NULLIF(LAG(total_sales) OVER (ORDER BY year), 0)) * 100 AS yoy_growth
FROM yearly_sales;


-- =========================================================
-- 4. Last 30 days filter
-- =========================================================

SELECT *
FROM orders
WHERE order_date >= DATEADD(DAY, -30, GETDATE());
GO
