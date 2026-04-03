-- DAY 66: DATABASE + TABLE SETUP
-- Topic: Correlated Subqueries
-- =========================================================

-- STEP 1: Check if database exists
IF DB_ID('correlated_db') IS NULL
BEGIN
    CREATE DATABASE correlated_db;
END
GO

-- STEP 2: Use database
USE correlated_db;
GO

-- STEP 3: Drop tables if exist
IF OBJECT_ID('customers', 'U') IS NOT NULL DROP TABLE customers;
IF OBJECT_ID('products', 'U') IS NOT NULL DROP TABLE products;
IF OBJECT_ID('orders', 'U') IS NOT NULL DROP TABLE orders;
GO

-- STEP 4: Create tables

CREATE TABLE customers (
    customer_id INT,
    region VARCHAR(50),
    spend DECIMAL(10,2)
);

CREATE TABLE products (
    product_id INT,
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT,
    order_date DATE,
    order_amount DECIMAL(10,2)
);
GO

-- STEP 5: Insert data

INSERT INTO customers VALUES
(1, 'North', 5000),
(2, 'North', 7000),
(3, 'South', 3000),
(4, 'South', 6000),
(5, 'East', 4000);

INSERT INTO products VALUES
(101, 'Electronics', 20000),
(102, 'Electronics', 15000),
(103, 'Furniture', 8000),
(104, 'Furniture', 12000);

INSERT INTO orders VALUES
(1, '2024-01-10', 10000),
(2, '2024-01-15', 15000),
(3, '2024-02-10', 20000),
(4, '2024-02-20', 18000);
GO

-- STEP 6: Verify
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
GO
