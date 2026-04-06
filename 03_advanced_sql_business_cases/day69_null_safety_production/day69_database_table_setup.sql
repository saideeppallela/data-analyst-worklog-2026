-- =========================================================
-- DAY 69: DATABASE + TABLE SETUP
-- Topic: NULL Safety + Production Patterns
-- =========================================================

-- STEP 1: Check if database exists
IF DB_ID('null_safety_db') IS NULL
BEGIN
    CREATE DATABASE null_safety_db;
END
GO

-- STEP 2: Use database
USE null_safety_db;
GO

-- STEP 3: Drop table if exists
IF OBJECT_ID('sales', 'U') IS NOT NULL
BEGIN
    DROP TABLE sales;
END
GO

-- STEP 4: Create table
CREATE TABLE sales (
    order_id INT,
    revenue DECIMAL(10,2),
    cost DECIMAL(10,2),
    discount DECIMAL(10,2),
    quantity INT
);
GO

-- STEP 5: Insert sample data (including NULLs)
INSERT INTO sales VALUES
(1, 10000, 7000, 500, 2),
(2, 8000, NULL, NULL, 1),
(3, 12000, 9000, 1000, 0),
(4, NULL, 6000, 300, 3);
GO

-- STEP 6: Verify data
SELECT * FROM sales;
GO

