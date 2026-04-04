-- =========================================================
-- DAY 67: DATABASE + TABLE SETUP
-- Topic: EXISTS + NOT EXISTS
-- =========================================================

-- STEP 1: Check if database exists
IF DB_ID('exists_db') IS NULL
BEGIN
    CREATE DATABASE exists_db;
END
GO

-- STEP 2: Use database
USE exists_db;
GO

-- STEP 3: Drop tables if exist
IF OBJECT_ID('customers', 'U') IS NOT NULL DROP TABLE customers;
IF OBJECT_ID('orders', 'U') IS NOT NULL DROP TABLE orders;
IF OBJECT_ID('returns', 'U') IS NOT NULL DROP TABLE returns;
GO

-- STEP 4: Create tables

CREATE TABLE customers (
    customer_id INT,
    customer_name VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    product_id INT
);

CREATE TABLE returns (
    return_id INT,
    product_id INT
);
GO

-- STEP 5: Insert sample data

INSERT INTO customers VALUES
(1, 'Amit'),
(2, 'Ravi'),
(3, 'Sneha'),
(4, 'Kiran');

INSERT INTO orders VALUES
(101, 1, 1001),
(102, 1, 1002),
(103, 2, 1003);

INSERT INTO returns VALUES
(1, 1002),
(2, 1004);
GO