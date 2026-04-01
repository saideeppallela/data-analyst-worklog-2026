-- =========================================================
-- DAY 64: DATABASE + TABLE SETUP
-- Topic: CTEs Clean Code Pattern
-- =========================================================
-- STEP 1: Create database if not exists
IF DB_ID('cte_clean_db') IS NULL
BEGIN
    CREATE DATABASE cte_clean_db;
END;
GO

-- STEP 2: Switch to database
USE cte_clean_db;
GO

-- STEP 3: Drop table if exists (safe for reruns)
IF OBJECT_ID('dbo.orders', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.orders;
END;
GO

-- STEP 4: Create table
CREATE TABLE dbo.orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_amount DECIMAL(10,2) NOT NULL
);
GO

-- STEP 5: Insert sample data
INSERT INTO dbo.orders (customer_id, order_date, order_amount)
VALUES
(1, '2024-01-01', 5000),
(1, '2024-01-10', 7000),
(2, '2024-01-05', 3000),
(2, '2024-01-20', 4000),
(3, '2024-01-15', 10000),
(3, '2024-02-01', 8000),
(4, '2024-02-10', 6000),
(5, '2024-02-15', 9000);
GO

-- STEP 6: Verify data
SELECT * FROM dbo.orders;
