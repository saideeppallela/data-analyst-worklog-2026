/* ============================================================
   DAY 1: Environment Setup & Raw Data Validation
   Objective:
   - Create database
   - Create table
   - Load sample raw data
   - Validate structure & data quality before analysis
   ============================================================ */

---------------------------------------------------------------
-- 1. Create database & switch context
---------------------------------------------------------------
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'analyst_practice')
BEGIN
    CREATE DATABASE analyst_practice;
END;
GO

USE analyst_practice;
GO

---------------------------------------------------------------
-- 2. Drop table if exists (clean setup)
---------------------------------------------------------------
IF OBJECT_ID('dbo.customers', 'U') IS NOT NULL
    DROP TABLE dbo.customers;
GO

---------------------------------------------------------------
-- 3. Create customers table
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
-- 4. Insert sample RAW data (intentionally imperfect)
-- Note: city values contain case variations for cleaning practice
---------------------------------------------------------------
INSERT INTO dbo.customers VALUES
(101, 'Diana', 29, 'Bangalore', '2024-01-15'),
(102, 'John', NULL, 'Hyderabad', '2024-02-01'),
(103, 'Sarah', 26, NULL, '2024-03-10'),
(104, 'Rahul', 34, 'bangalore', '2024-01-25'),
(105, 'Anita', NULL, 'Chennai', '2024-02-18');
GO

---------------------------------------------------------------
-- Business Question
-- What data do we have, and can it be trusted before analysis?
---------------------------------------------------------------

---------------------------------------------------------------
-- 5. Validate table structure
---------------------------------------------------------------
SELECT
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'customers'
  AND TABLE_SCHEMA = 'dbo';
GO

/* Observation:
   - Primary fields identified: id, signup_date, age, city
   - age and city are nullable → affects segmentation
   - signup_date is DATE → safe for time analysis
*/

---------------------------------------------------------------
-- 6. Inspect sample records
---------------------------------------------------------------
SELECT *
FROM dbo.customers;
GO

/* Observation:
   - Missing ages present
   - Missing city present
   - City casing inconsistent
*/

---------------------------------------------------------------
-- 7. Check null distribution
---------------------------------------------------------------
SELECT
    COUNT(*) AS total_records,
    COUNT(age) AS age_not_null,
    COUNT(city) AS city_not_null
FROM dbo.customers;
GO

/* Observation:
   - Nulls exist in critical fields
   - Cleaning required before KPI creation
*/

---------------------------------------------------------------
-- 8. Check data volume
---------------------------------------------------------------
SELECT COUNT(*) AS total_records
FROM dbo.customers;
GO

---------------------------------------------------------------
-- 9. Validate date range
---------------------------------------------------------------
SELECT
    MIN(signup_date) AS first_signup,
    MAX(signup_date) AS last_signup
FROM dbo.customers;
GO

/* Observation:
   - Date range continuous
   - Data usable for trend analysis
*/

---------------------------------------------------------------
-- Decision
-- Next step: clean data using WHERE filters and standardization
---------------------------------------------------------------
