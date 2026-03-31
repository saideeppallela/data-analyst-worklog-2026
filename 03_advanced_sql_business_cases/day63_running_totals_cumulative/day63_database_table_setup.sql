-- STEP 4: Create table
CREATE TABLE daily_sales (
    sale_id INT IDENTITY(1,1),
    sale_date DATE,
    category VARCHAR(50),
    sales_amount DECIMAL(10,2)
);
GO

-- STEP 5: Insert sample data (multi-category + multiple dates)
INSERT INTO daily_sales (sale_date, category, sales_amount)
VALUES
('2024-01-01', 'Electronics', 20000),
('2024-01-02', 'Electronics', 15000),
('2024-01-03', 'Furniture', 10000),
('2024-01-04', 'Furniture', 12000),
('2024-02-01', 'Electronics', 25000),
('2024-02-02', 'Furniture', 18000),
('2024-02-03', 'Electronics', 22000),
('2024-03-01', 'Furniture', 20000),
('2024-03-02', 'Electronics', 30000);
GO

-- STEP 6: Verify data
SELECT * FROM daily_sales;
GO


---

?? STEP 4 — QUESTION + SOLUTION

?? File: day63_question_solution_running_totals.sql

-- =========================================================
-- INTERVIEW QUESTION
-- =========================================================
-- A company wants to track its cumulative sales performance.
-- Write a SQL query to:
-- 1. Calculate daily running total of sales
-- 2. Calculate monthly cumulative sales per category
-- 3. Calculate percentage of annual target achieved
-- =========================================================




-- STEP 2: Define annual target (business assumption)
DECLARE @annual_target DECIMAL(10,2) = 200000;
GO

-- STEP 3: Running total + cumulative analysis
WITH base_data AS (
    SELECT
        sale_date,
        category,
        sales_amount,
        YEAR(sale_date) AS sales_year,
        MONTH(sale_date) AS sales_month
    FROM daily_sales
),

running_calc AS (
    SELECT
        sale_date,
        category,
        sales_amount,

        -- Daily running total (overall)
        SUM(sales_amount) OVER (
            ORDER BY sale_date
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_total,

        -- Monthly cumulative per category
        SUM(sales_amount) OVER (
            PARTITION BY category, sales_year, sales_month
            ORDER BY sale_date
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS monthly_category_cumulative,

        -- Total yearly sales
        SUM(sales_amount) OVER () AS total_year_sales
    FROM base_data
)

-- STEP 4: Final output with percentage
SELECT
    sale_date,
    category,
    sales_amount,
    running_total,
    monthly_category_cumulative,

    -- % of annual target achieved
    (running_total / NULLIF(@annual_target, 0)) * 100 AS percent_of_target

FROM running_calc
ORDER BY sale_date;
GO
