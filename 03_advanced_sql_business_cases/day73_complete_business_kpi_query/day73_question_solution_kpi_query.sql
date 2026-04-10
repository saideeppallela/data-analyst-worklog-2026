-- =========================================================
-- INTERVIEW QUESTION
-- =========================================================
-- Build a complete business KPI query that includes:
-- 1. Revenue, profit, margin, and AOV
-- 2. Month-over-Month growth per category
-- 3. Running total of revenue
-- 4. Category ranking based on revenue
-- =========================================================

-- =========================================================
-- QUESTION 1: Base Aggregation (Revenue, Cost, Quantity)
-- =========================================================
WITH base_data AS (
SELECT category, YEAR(order_date) AS year, MONTH(order_date) AS month,
SUM(COALESCE(revenue,0)) AS total_revenue,
SUM(COALESCE(cost,0)) AS total_cost,
SUM(quantity) AS total_quantity
FROM sales_data
GROUP BY category, YEAR(order_date), MONTH(order_date)
),

-- =========================================================
-- QUESTION 2: KPI Calculations (Profit, Margin, AOV)
-- =========================================================
kpi_calc AS (
SELECT category, year, month, total_revenue, total_cost,
total_revenue - total_cost AS profit,
(total_revenue - total_cost) / NULLIF(total_revenue,0) AS margin,
total_revenue / NULLIF(total_quantity,0) AS avg_order_value
FROM base_data
),

-- =========================================================
-- QUESTION 3: Window Functions (MoM, Running Total, Ranking)
-- =========================================================
final_calc AS (
SELECT category, year, month, total_revenue, profit, margin, avg_order_value,
LAG(total_revenue) OVER (PARTITION BY category ORDER BY year, month) AS prev_month_revenue,
SUM(total_revenue) OVER (PARTITION BY category ORDER BY year, month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total,
RANK() OVER (PARTITION BY year, month ORDER BY total_revenue DESC) AS category_rank
FROM kpi_calc
)

-- =========================================================
-- QUESTION 4: Final Output (MoM Growth % + All KPIs)
-- =========================================================
SELECT category, year, month, total_revenue, profit, margin, avg_order_value, prev_month_revenue,
(total_revenue - prev_month_revenue) / NULLIF(prev_month_revenue,0) AS mom_growth,
running_total, category_rank
FROM final_calc
ORDER BY category, year, month;
GO