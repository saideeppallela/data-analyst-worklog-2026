-- =========================================================
-- DAY 62: DATABASE + TABLE SETUP
-- Topic: LAG + LEAD (Month-over-Month Sales Analysis)
-- =========================================================

-- STEP 1: Check if database exists
IF DB_ID('sales_growth_db') IS NULL
BEGIN
    CREATE DATABASE sales_growth_db;
END
GO

-- STEP 2: Use database
USE sales_growth_db;
GO

-- STEP 3: Drop table if exists
IF OBJECT_ID('monthly_sales', 'U') IS NOT NULL
BEGIN
    DROP TABLE monthly_sales;
END
GO

-- STEP 4: Create table
CREATE TABLE monthly_sales (
    month_id INT IDENTITY(1,1),
    sales_month DATE,
    total_sales DECIMAL(10,2)
);
GO

-- STEP 5: Insert sample data (realistic business trend)
INSERT INTO monthly_sales (sales_month, total_sales)
VALUES 
('2024-01-01', 100000),
('2024-02-01', 120000),
('2024-03-01', 90000),
('2024-04-01', 150000),
('2024-05-01', 140000),
('2024-06-01', 170000),
('2024-07-01', 160000);
GO

-- STEP 6: Verify data
SELECT * FROM monthly_sales;
GO


---
