-- =========================================================
-- DAY 75: END-TO-END SQL ANALYST CASE STUDY
-- =========================================================

-- STEP 1: Create database if not exists
IF DB_ID('sql_analyst_case_db') IS NULL
BEGIN
    CREATE DATABASE sql_analyst_case_db;
END
GO

-- STEP 2: Use database
USE sql_analyst_case_db;
GO

-- STEP 3: Drop table if exists
IF OBJECT_ID('sales_raw_data', 'U') IS NOT NULL
BEGIN
    DROP TABLE sales_raw_data;
END
GO

-- STEP 4: Create raw sales table
CREATE TABLE sales_raw_data (
    order_id INT,
    customer_name VARCHAR(100),
    city VARCHAR(100),
    category VARCHAR(50),
    order_date DATE,
    revenue DECIMAL(10,2),
    cost DECIMAL(10,2),
    quantity INT
);
GO

-- STEP 5: Insert messy business data
INSERT INTO sales_raw_data VALUES
(1, 'ravi kumar', ' hyderabad ', 'Electronics', '2024-01-10', 50000, 40000, 2),
(2, 'RAVI KUMAR', 'HYDERABAD', 'Electronics', '2024-02-15', 60000, 45000, 3),
(3, 'Sneha reddy', 'delhi', 'Furniture', '2024-01-18', 30000, 20000, 2),
(4, 'SNEHA REDDY', ' Delhi ', 'Furniture', '2024-02-25', 35000, 25000, 3),
(5, 'Amit shah', 'mumbai', 'Electronics', '2024-03-12', 70000, 50000, 4),
(6, 'amit shah', ' MUMBAI ', 'Electronics', '2024-03-18', 30000, 22000, 2),
(7, 'Kiran Rao', 'bangalore', 'Furniture', '2024-03-22', 45000, 32000, 3);
GO

-- STEP 6: Verify data
SELECT * FROM sales_raw_data;
GO
