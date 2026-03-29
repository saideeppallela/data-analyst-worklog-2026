-- Day 61 - Interview Question + Solution
-- =========================================================

-- Question :
-- A retail company wants to identify its highest revenue-generating customers in each region.
-- Write a SQL query to rank customers within each region based on total revenue.
-- Also demonstrate how ROW_NUMBER, RANK, and DENSE_RANK behave when multiple customers have the same revenue.

USE analytics_db;
GO

-- STEP 1: Aggregate revenue per customer
WITH customer_revenue AS (
    SELECT 
        region,
        customer_name,
        SUM(revenue) AS total_revenue
    FROM sales_data
    GROUP BY region, customer_name
)

-- STEP 2: Apply ranking functions
SELECT 
    region,
    customer_name,
    total_revenue,

    ROW_NUMBER() OVER (
        PARTITION BY region 
        ORDER BY total_revenue DESC
    ) AS row_number_rank,

    RANK() OVER (
        PARTITION BY region 
        ORDER BY total_revenue DESC
    ) AS rank_value,

    DENSE_RANK() OVER (
        PARTITION BY region 
        ORDER BY total_revenue DESC
    ) AS dense_rank_value

FROM customer_revenue;
GO
