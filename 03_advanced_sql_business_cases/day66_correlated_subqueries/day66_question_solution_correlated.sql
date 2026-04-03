

-- =========================================================
-- INTERVIEW QUESTION
-- =========================================================
-- Write SQL queries to:
-- 1. Find customers spending above their region average
-- 2. Find products priced above their category average
-- 3. Find orders above monthly average
-- =========================================================

USE correlated_db;
GO

-- =========================================================
-- 1. Customers above region average
-- =========================================================

SELECT *
FROM customers c
WHERE spend > (
    SELECT AVG(spend)
    FROM customers
    WHERE region = c.region
);


-- =========================================================
-- 2. Products above category average
-- =========================================================

SELECT *
FROM products p
WHERE price > (
    SELECT AVG(price)
    FROM products
    WHERE category = p.category
);


-- =========================================================
-- 3. Orders above monthly average
-- =========================================================

SELECT *
FROM orders o
WHERE order_amount > (
    SELECT AVG(order_amount)
    FROM orders
    WHERE MONTH(order_date) = MONTH(o.order_date)
      AND YEAR(order_date) = YEAR(o.order_date)
);
GO

