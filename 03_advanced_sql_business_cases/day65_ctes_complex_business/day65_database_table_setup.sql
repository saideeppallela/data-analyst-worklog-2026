 CREATE DATABASE cte_business_db;
END
Go

-- STEP 2: Use database
USE cte_business_db;
GO

-- STEP 3: Drop table if exists
IF OBJECT_ID('sales_data', 'U') IS NOT NULL
BEGIN
    DROP TABLE sales_data;
END
GO

-- STEP 4: Create table
CREATE TABLE sales_data (
    sale_id INT IDENTITY(1,1),
    category VARCHAR(50),
    sale_date DATE,
    sales_amount DECIMAL(10,2)
);
GO

-- STEP 5: Insert sample data (multiple categories & months)
INSERT INTO sales_data (category, sale_date, sales_amount)
VALUES
('Electronics', '2024-01-10', 20000),
('Electronics', '2024-01-15', 15000),
('Electronics', '2024-02-10', 30000),
('Electronics', '2024-02-20', 25000),
('Electronics', '2024-03-05', 40000),
('Electronics', '2024-03-25', 35000),

('Furniture', '2024-01-12', 10000),
('Furniture', '2024-01-18', 12000),
('Furniture', '2024-02-08', 18000),
('Furniture', '2024-02-22', 15000),
('Furniture', '2024-03-10', 22000),
('Furniture', '2024-03-28', 20000);
GO

-- STEP 6: Verify data
SELECT * FROM sales_data;
GO



