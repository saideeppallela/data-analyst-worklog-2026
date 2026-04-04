
-- =========================================================
-- INTERVIEW QUESTION
-- =========================================================
-- Write SQL queries to:
-- 1. Find customers who have placed orders
-- 2. Find customers who never placed orders
-- 3. Find products that were never returned
-- 4. Compare EXISTS vs IN usage
-- =========================================================

USE exists_db;
GO

-- =========================================================
-- 1. Customers who have ordered (EXISTS)
-- =========================================================

SELECT *
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);


-- =========================================================
-- 2. Customers who never ordered (NOT EXISTS)
-- =========================================================

SELECT *
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);


-- =========================================================
-- 3. Products never returned (NOT EXISTS)
-- =========================================================

SELECT DISTINCT product_id
FROM orders o
WHERE NOT EXISTS (
    SELECT 1
    FROM returns r
    WHERE r.product_id = o.product_id
);


-- =========================================================
-- 4. EXISTS vs IN comparison
-- =========================================================

-- Using IN
SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id FROM orders
);

-- Using EXISTS
SELECT *
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);
GO
