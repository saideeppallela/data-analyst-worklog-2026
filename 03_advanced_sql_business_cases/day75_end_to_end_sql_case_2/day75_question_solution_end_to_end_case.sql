---👉 File: day75_question_solution_end_to_end_case.sql

-- =========================================================
-- INTERVIEW CASE STUDY
-- =========================================================
-- A company wants to clean messy sales data and
-- generate business insights for management reporting.
--
-- Build:
-- 1. Clean raw data
-- 2. Standardize fields
-- 3. Calculate KPIs
-- 4. Rank business performance
-- 5. Generate final actionable output
-- =========================================================

-- STEP 1: Use database
USE sql_analyst_case_db;
GO

-- =========================================================
-- STEP 2: CLEAN RAW DATA
-- =========================================================

WITH clean_data AS (

    SELECT
        order_id,
        -- Standardize customer names
        UPPER(TRIM(customer_name)) AS customer_name,
        -- Standardize city names
        UPPER(TRIM(city)) AS city,

        category,
        order_date,

        -- NULL-safe revenue/cost
        COALESCE(revenue,0) AS revenue,
        COALESCE(cost,0) AS cost,
        COALESCE(quantity,0) AS quantity

    FROM sales_raw_data
),

-- =========================================================
-- STEP 3: STANDARDIZE DATE FIELDS
-- =========================================================

standardized_data AS (

    SELECT
        *,
        YEAR(order_date) AS order_year,
        MONTH(order_date) AS order_month

    FROM clean_data
),

-- =========================================================
-- STEP 4: BUSINESS METRICS CTE
-- =========================================================

business_metrics AS (

    SELECT
        category,
        order_year,
        order_month,

        SUM(revenue) AS total_revenue,
        SUM(cost) AS total_cost,
        SUM(quantity) AS total_quantity,

        -- Profit
        SUM(revenue - cost) AS total_profit,

        -- Profit Margin
        SUM(revenue - cost)
        / NULLIF(SUM(revenue),0) AS profit_margin,

        -- Average Order Value
        SUM(revenue)
        / NULLIF(SUM(quantity),0) AS avg_order_value

    FROM standardized_data

    GROUP BY
        category,
        order_year,
        order_month
),

-- =========================================================
-- STEP 5: RANKED INSIGHTS CTE
-- =========================================================

ranked_insights AS (

    SELECT
        *,

        -- Previous month revenue
        LAG(total_revenue) OVER (
            PARTITION BY category
            ORDER BY order_year, order_month
        ) AS prev_month_revenue,

        -- Running total revenue
        SUM(total_revenue) OVER (
            PARTITION BY category
            ORDER BY order_year, order_month
        ) AS running_total_revenue,

        -- Revenue ranking
        RANK() OVER (
            PARTITION BY category
            ORDER BY total_revenue DESC
        ) AS revenue_rank

    FROM business_metrics
),

-- =========================================================
-- STEP 6: FINAL ACTIONABLE OUTPUT
-- =========================================================

final_output AS (

    SELECT

        category,
        order_year,
        order_month,

        total_revenue,
        total_profit,
        profit_margin,
        avg_order_value,

        -- Month-over-Month Growth
        (total_revenue - prev_month_revenue)
        / NULLIF(prev_month_revenue,0) AS mom_growth,

        running_total_revenue,
        revenue_rank,

        -- Business segmentation
        CASE
            WHEN profit_margin >= 0.30 THEN 'High Performance'
            WHEN profit_margin >= 0.15 THEN 'Medium Performance'
            ELSE 'Low Performance'
        END AS performance_status

    FROM ranked_insights
)

-- =========================================================
-- FINAL RESULT
-- =========================================================

SELECT *
FROM final_output
ORDER BY category, order_year, order_month;
GO
