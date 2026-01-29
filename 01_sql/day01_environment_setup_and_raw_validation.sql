/*
Day 1 Summary:
Problem: No database environment existed and raw data quality was unknown.
Approach: Created database and table, loaded sample raw data, and validated structure and completeness.
Key Check: Verified schema, row counts, NULLs, and date range.
Result: Identified data quality issues requiring cleaning before analysis.
Next Step: Clean data using WHERE filters and create an analysis-ready table.
*/

---------------------------------------------------------------
-- Step 1: Create database and switch context
---------------------------------------------------------------
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'analyst_practice')
BEGIN
    CREATE DATABASE analyst_practice;
END;
GO

USE analyst_practice;
GO

---------------------------------------------------------------
-- Step 2: Drop existing raw table if present
---------------------------------------------------------------
IF OBJECT_ID('dbo.customers', 'U') IS NOT NULL
    DROP TABLE dbo.customers;
GO

---------------------------------------------------------------
-- Step 3: Create raw customers table
---------------------------------------------------------------
CREATE TABLE dbo.customers (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT NULL,
    city VARCHAR(50) NULL,
    signup_date DATE
);
GO

---------------------------------------------------------------
-- Step 4: Insert raw data (intentionally imperfect)
---------------------------------------------------------------
INSERT INTO dbo.customers VALUES
(101, 'Diana', 29, 'Bangalore', '2024-01-15'),
(102, 'John', NULL, 'Hyderabad', '2024-02-01'),
(103, 'Sarah', 26, NULL, '2024-03-10'),
(104, 'Rahul', 34, 'bangalore', '2024-01-25'),
(105, 'Anita', NULL, 'Chennai', '2024-02-18');
GO

---------------------------------------------------------------
-- Step 5: Validate table structure
---------------------------------------------------------------
SELECT
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'customers'
  AND TABLE_SCHEMA = 'dbo';
GO

/* Observation:
- Primary key existed on id
- age and city allowed NULL values
- signup_date used correct DATE type
*/

---------------------------------------------------------------
-- Step 6: Inspect raw records
---------------------------------------------------------------
SELECT *
FROM dbo.customers;
GO

/* Observation:
- Missing values existed in age and city
- City values were inconsistent in casing
*/

---------------------------------------------------------------
-- Step 7: Check NULL distribution
---------------------------------------------------------------
SELECT
    COUNT(*) AS total_rows,
    COUNT(age) AS age_not_null,
    COUNT(city) AS city_not_null,
    COUNT(signup_date) AS signup_not_null
FROM dbo.customers;
GO

/* Observation:
- Critical fields contained NULLs
- Cleaning was required before analysis
*/

---------------------------------------------------------------
-- Step 8: Validate data volume
---------------------------------------------------------------
SELECT COUNT(*) AS total_rows
FROM dbo.customers;
GO

---------------------------------------------------------------
-- Step 9: Validate date range
---------------------------------------------------------------
SELECT
    MIN(signup_date) AS first_signup,
    MAX(signup_date) AS last_signup
FROM dbo.customers;
GO

/* Observation:
- Date range was continuous
- Data was usable after cleaning
*/

---------------------------------------------------------------
-- Decision
---------------------------------------------------------------
/*
- Raw table was retained for audit
- Data cleaning was required
- Analysis would use a cleaned table
*/
