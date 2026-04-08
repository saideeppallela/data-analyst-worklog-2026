
-- STEP 1: Check if database exists
IF DB_ID('case_when_db') IS NULL
BEGIN
    CREATE DATABASE case_when_db;
END
GO

-- STEP 2: Use database
USE case_when_db;
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
    customer_id INT,
    region VARCHAR(50),
    product VARCHAR(50),
    revenue DECIMAL(10,2),
    cost DECIMAL(10,2)
);
GO

-- STEP 5: Insert sample data
INSERT INTO sales_data VALUES
(1, 101, 'North', 'Laptop', 50000, 40000),
(2, 102, 'South', 'Mobile', 20000, 15000),
(3, 103, 'East', 'Tablet', 15000, 16000),
(4, 101, 'North', 'Mobile', 25000, 18000),
(5, 104, 'West', 'Laptop', 60000, 45000),
(6, 105, 'South', 'Tablet', 18000, 12000),
(7, 106, 'East', 'Laptop', 45000, 30000),
(8, 107, 'West', 'Mobile', 22000, 21000);
GO

-- STEP 6: Verify data
SELECT * FROM sales_data;
GO
