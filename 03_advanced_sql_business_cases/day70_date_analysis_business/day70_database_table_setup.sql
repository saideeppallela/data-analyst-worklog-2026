
-- =========================================================
-- DAY 70: DATABASE + TABLE SETUP
-- Topic: Date Analysis Business Patterns
-- =========================================================

-- STEP 1: Check if database exists
IF DB_ID('date_analysis_db') IS NULL
BEGIN
    CREATE DATABASE date_analysis_db;
END
GO

-- STEP 2: Use database
USE date_analysis_db;
GO

-- STEP 3: Drop table if exists
IF OBJECT_ID('orders', 'U') IS NOT NULL
BEGIN
    DROP TABLE orders;
END
GO

-- STEP 4: Create table
CREATE TABLE orders (
    order_id INT,
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    revenue DECIMAL(10,2)
);
GO

-- STEP 5: Insert sample data (multiple years + months)
INSERT INTO orders VALUES
(1, '2023-01-10', '2023-01-15', 'Standard', 10000),
(2, '2023-02-05', '2023-02-08', 'Express', 15000),
(3, '2023-03-12', '2023-03-20', 'Standard', 20000),
(4, '2023-04-01', '2023-04-03', 'Express', 12000),

(5, '2024-01-15', '2024-01-18', 'Standard', 18000),
(6, '2024-02-10', '2024-02-15', 'Express', 22000),
(7, '2024-03-05', '2024-03-10', 'Standard', 25000),
(8, '2024-04-12', '2024-04-14', 'Express', 30000);
GO