

-- =========================================================
-- INTERVIEW QUESTION
-- =========================================================
-- A company wants to identify top-performing months per category.
-- Write a SQL query to:
-- 1. Calculate monthly sales per category
-- 2. Rank months based on total sales
-- 3. Return top 3 months per category
-- =========================================================

-- STEP 1: Use database
USE cte_business_db;
GO

-- STEP 2: Pre-aggregation CTE (monthly sales)
WITH monthly_sales AS (
    SELECT
        category,
        YEAR(sale_date) AS sales_year,
        MONTH(sale_date) AS sales_month,
        SUM(sales_amount) AS total_sales
    FROM sales_data
    GROUP BY
        category,
        YEAR(sale_date),
        MONTH(sale_date)
),

-- STEP 3: Ranking inside CTE
ranked_months AS (
    SELECT
        category,
        sales_year,
        sales_month,
        total_sales,

        RANK() OVER (
            PARTITION BY category
            ORDER BY total_sales DESC
        ) AS sales_rank
    FROM monthly_sales
)

-- STEP 4: Final filter
SELECT
    category,
    sales_year,
    sales_month,
    total_sales,
    sales_rank
FROM ranked_months
WHERE sales_rank <= 3
ORDER BY category, sales_rank;
GO
