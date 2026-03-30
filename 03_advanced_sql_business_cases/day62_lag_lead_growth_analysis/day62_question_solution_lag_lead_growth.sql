 File: day62_question_solution_lag_lead_growth.sql

-- =========================================================
-- INTERVIEW QUESTION
-- =========================================================
-- A retail company wants to analyze its monthly sales performance.
-- Write a SQL query to:
-- 1. Show monthly sales
-- 2. Compare current month with previous month
-- 3. Calculate Month-over-Month (MoM) growth %
-- 4. Identify months where sales declined
-- ========================================================

-- STEP 1: Calculate previous and next month sales
WITH sales_with_lag AS (
    SELECT
        sales_month,
        total_sales,

        -- Previous month sales
        LAG(total_sales) OVER (ORDER BY sales_month) AS prev_month_sales,

        -- Next month sales (for understanding trend)
        LEAD(total_sales) OVER (ORDER BY sales_month) AS next_month_sales
    FROM monthly_sales
),

-- STEP 2: Calculate growth %
sales_growth_calc AS (
    SELECT
        sales_month,
        total_sales,
        prev_month_sales,
        next_month_sales,

        -- MoM Growth %
        ((total_sales - prev_month_sales) / NULLIF(prev_month_sales, 0)) * 100 AS mom_growth_percent
    FROM sales_with_lag
)

-- STEP 3: Final output with flag
SELECT
    sales_month,
    total_sales,
    prev_month_sales,
    next_month_sales,
    mom_growth_percent,

    -- Flag negative growth
    CASE 
        WHEN mom_growth_percent < 0 THEN 'Decline'
        ELSE 'Growth'
    END AS growth_status

FROM sales_growth_calc
ORDER BY sales_month;
GO


