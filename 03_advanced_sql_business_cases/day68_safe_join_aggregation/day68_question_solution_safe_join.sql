-- =========================================================
-- INTERVIEW QUESTION
-- =========================================================
-- A company wants to calculate total revenue per customer.
-- However, incorrect joins may inflate values.
-- Write SQL queries to:
-- 1. Show wrong result using direct join
-- 2. Fix using pre-aggregation
-- =========================================================

USE safe_join_db;
GO

-- =========================================================
-- PART 1: WRONG APPROACH (JOIN INFLATION)
-- =========================================================

SELECT
    o.customer_id,
    SUM(oi.price * oi.quantity) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.customer_id;
GO


-- =========================================================
-- PART 2: CORRECT APPROACH (PRE-AGGREGATION USING CTE)
-- =========================================================

WITH order_totals AS (
    -- STEP 1: Aggregate at order level
    SELECT
        order_id,
        SUM(price * quantity) AS order_total
    FROM order_items
    GROUP BY order_id
)

-- STEP 2: Join after aggregation
SELECT
    o.customer_id,
    SUM(ot.order_total) AS total_revenue
FROM orders o
JOIN order_totals ot
    ON o.order_id = ot.order_id
GROUP BY o.customer_id;
GO


---

