-- =========================================================
-- INTERVIEW QUESTION
-- =========================================================
-- A company wants to calculate safe business metrics.
-- Write SQL queries to:
-- 1. Calculate profit margin safely
-- 2. Calculate Average Order Value (AOV) safely
-- 3. Replace NULL discount values
-- 4. Build production-ready query handling NULLs
-- =========================================================
-- =========================================================
-- STEP 1: Replace NULL values using COALESCE / ISNULL
-- =========================================================

SELECT
    order_id,
    COALESCE(revenue, 0) AS revenue,
    ISNULL(cost, 0) AS cost,
    COALESCE(discount, 0) AS discount,
    quantity
FROM sales;
GO
-- =========================================================
-- STEP 2: Safe margin calculation
-- =========================================================

SELECT
    order_id,
    revenue,
    cost,

    -- Margin = (Revenue - Cost) / Revenue
    (COALESCE(revenue,0) - COALESCE(cost,0)) 
    / NULLIF(revenue, 0) AS profit_margin
FROM sales;
GO
-- =========================================================
-- STEP 3: Safe AOV calculation
-- =========================================================

SELECT
    SUM(COALESCE(revenue,0)) 
    / NULLIF(SUM(quantity), 0) AS avg_order_value
FROM sales;
GO
-- =========================================================
-- STEP 4: Production-ready business query
-- =========================================================

SELECT
    order_id,
    COALESCE(revenue,0) AS revenue,
    COALESCE(cost,0) AS cost,
    COALESCE(discount,0) AS discount,
    quantity,

    -- Safe margin
    (COALESCE(revenue,0) - COALESCE(cost,0)) 
    / NULLIF(revenue,0) AS profit_margin

FROM sales;
GO
