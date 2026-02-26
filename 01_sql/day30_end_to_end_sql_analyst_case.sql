/* =========================================================
Day 30 – End-to-End SQL Analyst Case (Raw Data → Insights)
Objective:
Simulate a real analyst workflow:
1. Clean raw sales data
2. Standardize fields
3. Build business-ready metrics
4. Deliver actionable insights
========================================================= */

-- =========================================================
-- STEP 1: CLEAN RAW DATA
-- Remove NULL customers & invalid revenue
-- =========================================================

WITH cleaned_data AS (
    SELECT
        order_id,
        customer_id,
        product_category,
        city,
        order_date,
        revenue
    FROM sales_raw
    WHERE customer_id IS NOT NULL
      AND revenue > 0
),

-- =========================================================
-- STEP 2: STANDARDIZE TEXT FIELDS
-- Prevent segmentation issues
-- =========================================================

standardized_data AS (
    SELECT
        order_id,
        customer_id,
        UPPER(product_category) AS product_category,
        UPPER(city) AS city,
        order_date,
        revenue
    FROM cleaned_data
),

-- =========================================================
-- STEP 3: DERIVE BUSINESS METRICS
-- Monthly revenue + customer behavior
-- =========================================================

metrics AS (
    SELECT
        city,
        product_category,
        YEAR(order_date) AS order_year,
        MONTH(order_date) AS order_month,
        COUNT(DISTINCT customer_id) AS unique_customers,
        SUM(revenue) AS total_revenue,
        AVG(revenue) AS avg_order_value
    FROM standardized_data
    GROUP BY
        city,
        product_category,
        YEAR(order_date),
        MONTH(order_date)
),

-- =========================================================
-- STEP 4: IDENTIFY TOP PERFORMING SEGMENTS
-- Real analyst decision layer
-- =========================================================

ranked_segments AS (
    SELECT *,
           RANK() OVER (
               PARTITION BY order_year, order_month
               ORDER BY total_revenue DESC
           ) AS revenue_rank
    FROM metrics
)

-- =========================================================
-- FINAL OUTPUT FOR DASHBOARD / BUSINESS REPORT
-- =========================================================

SELECT
    city,
    product_category,
    order_year,
    order_month,
    unique_customers,
    total_revenue,
    avg_order_value,
    revenue_rank
FROM ranked_segments
ORDER BY order_year, order_month, revenue_rank;
