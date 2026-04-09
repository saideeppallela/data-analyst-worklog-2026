-- =========================================================
-- DAY 72: DATABASE + TABLE SETUP
-- Topic: String + Text Business Cleaning
-- =========================================================

-- STEP 1: Check if database exists
IF DB_ID('string_clean_db') IS NULL
BEGIN
    CREATE DATABASE string_clean_db;
END
GO

-- STEP 2: Use database
USE string_clean_db;
GO

-- STEP 3: Drop table if exists
IF OBJECT_ID('customer_data', 'U') IS NOT NULL
BEGIN
    DROP TABLE customer_data;
END
GO

-- STEP 4: Create table
CREATE TABLE customer_data (
    customer_id INT,
    full_name VARCHAR(100),
    order_id VARCHAR(50),
    city VARCHAR(100)
);
GO

-- STEP 5: Insert messy data
INSERT INTO customer_data VALUES
(1, 'Ravi Kumar', 'IND-1001', '  hyderabad '),
(2, 'Sneha Reddy', 'USA-2002', 'DELHI'),
(3, 'Amit Shah', 'IND-3003', 'mumbai'),
(4, 'Kiran Rao', 'UK-4004', ' Bangalore ');
GO

-- STEP 6: Verify data
SELECT * FROM customer_data;
GO
