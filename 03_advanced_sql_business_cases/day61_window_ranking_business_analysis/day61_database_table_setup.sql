-- =========================================================
-- Day 61 - Database & Table Setup (SQL Server)
-- =========================================================

IF DB_ID('analytics_db') IS NULL
BEGIN
    CREATE DATABASE analytics_db;
END;
GO

USE analytics_db;
GO

IF OBJECT_ID('sales_data', 'U') IS NOT NULL
    DROP TABLE sales_data;
GO

CREATE TABLE sales_data (
    order_id INT IDENTITY(1,1),
    region VARCHAR(20),
    customer_name VARCHAR(50),
    revenue INT
);
GO

INSERT INTO sales_data (region, customer_name, revenue)
VALUES
('South','Sai',5000),
('South','Rahul',7000),
('South','Ankit',7000),

('North','John',6000),
('North','David',8000),
('North','Ravi',8000),

('West','Priya',4000),
('West','Neha',9000),
('West','Amit',9000);
GO

SELECT * FROM sales_data;
GO
