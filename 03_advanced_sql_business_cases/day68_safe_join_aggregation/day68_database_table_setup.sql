-- =========================================================
-- DAY 68: DATABASE + TABLE SETUP
-- Topic: Safe JOIN + Aggregation
-- =========================================================

-- STEP 1: Check if database exists
IF DB_ID('safe_join_db') IS NULL
BEGIN
    CREATE DATABASE safe_join_db;
END
GO

-- STEP 2: Use database
USE safe_join_db;
GO

-- STEP 3: Drop tables if exist
IF OBJECT_ID('orders', 'U') IS NOT NULL DROP TABLE orders;
IF OBJECT_ID('order_items', 'U') IS NOT NULL DROP TABLE order_items;
GO

-- STEP 4: Create tables

CREATE TABLE orders (
    order_id INT,
    customer_id INT
);

CREATE TABLE order_items (
    item_id INT,
    order_id INT,
    product_id INT,
    price DECIMAL(10,2),
    quantity INT
);
GO

-- STEP 5: Insert sample data

INSERT INTO orders VALUES
(1, 101),
(2, 102);

INSERT INTO order_items VALUES
(1, 1, 1001, 500, 2),
(2, 1, 1002, 300, 1),
(3, 2, 1003, 700, 3);
GO

-- STEP 6: Verify data
SELECT * FROM orders;
SELECT * FROM order_items;
GO


