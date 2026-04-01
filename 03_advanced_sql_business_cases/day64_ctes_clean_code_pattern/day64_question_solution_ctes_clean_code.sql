-- =========================================================
-- INTERVIEW QUESTION
-- =========================================================
-- Using dbo.orders table:
-- 1. Calculate total spending per customer
-- 2. Identify customers whose spending is ABOVE average
-- 3. Use a clean CTE-based approach (avoid repeated logic)
-- =========================================================


-- =========================================================
-- FINAL SOLUTION (Clean CTE Query)
-- =========================================================
WITH customer_totals AS (
    SELECT
        customer_id,
        SUM(order_amount) AS total_spent
    FROM dbo.orders
    GROUP BY customer_id
)

SELECT
    customer_id,
    total_spent
FROM customer_totals
WHERE total_spent > (
    SELECT AVG(total_spent)
    FROM customer_totals
);