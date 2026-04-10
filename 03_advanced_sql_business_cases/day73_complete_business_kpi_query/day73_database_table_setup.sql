-- DAY 73: DATABASE + TABLE SETUP
-- Topic: Complete Business KPI Query
-- =========================================================

-- STEP 1: Check if database exists
IF DB_ID('kpi_db') IS NULL
BEGIN
    CREATE DATABASE kpi_db;
END
GO

-- STEP 2: Use database
USE kpi_db;
GO

-- STEP 3: Drop table if exists
IF OBJECT_ID('sales_data', 'U') IS NOT NULL
BEGIN
    DROP TABLE sales_data;
END
GO

-- STEP 4: Create table
CREATE TABLE sales_data (
    order_id INT,
    category VARCHAR(50),
    order_date DATE,
    revenue DECIMAL(10,2),
    cost DECIMAL(10,2),
    quantity INT
);
GO

-- STEP 5: Insert sample data
INSERT INTO sales_data VALUES
(1, 'Electronics', '2024-01-10', 50000, 40000, 2),
(2, 'Electronics', '2024-02-10', 60000, 45000, 3),
(3, 'Electronics', '2024-03-10', 70000, 50000, 4),

(4, 'Furniture', '2024-01-15', 30000, 20000, 2),
(5, 'Furniture', '2024-02-18', 35000, 25000, 3),
(6, 'Furniture', '2024-03-20', 40000, 30000, 2);
GO

-- STEP 6: Verify data
SELECT * FROM sales_data;
GO


