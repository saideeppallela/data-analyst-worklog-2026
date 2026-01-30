/*
Day 3 Summary:
Problem: Dataset structure and column meanings were not fully understood,
which could lead to wrong analysis assumptions.
Approach: Explored columns using SELECT, aliases, expressions, string and
date functions to understand data behavior.
Key Check: Verified derived columns, readability, and data transformations.
Result: Clear understanding of dataset structure and column-level logic.
Next Step: Sort and control result sets using ORDER BY and TOP.
*/

USE analyst_practice;
GO

/* =====================================================
DAY 3: SELECT Basics & Column-Level Exploration
Objective:
- Understand dataset structure deeply
- Explore columns individually
- Use aliases and expressions
- Prepare for analysis logic
===================================================== */

/* -----------------------------------------------------
1. Initial dataset scan
----------------------------------------------------- */
SELECT *
FROM dbo.customers;
GO

/* -----------------------------------------------------
2. Select only relevant columns
----------------------------------------------------- */
SELECT
    id,
    name,
    age,
    city,
    signup_date
FROM dbo.customers;
GO

/* -----------------------------------------------------
3. Column aliases for readability
----------------------------------------------------- */
SELECT
    id AS customer_id,
    name AS customer_name,
    age AS customer_age,
    city AS customer_city,
    signup_date AS signup_date
FROM dbo.customers;
GO

/* -----------------------------------------------------
4. Derived columns using expressions
----------------------------------------------------- */
SELECT
    id,
    name,
    age,
    city,
    signup_date,
    YEAR(signup_date) AS signup_year
FROM dbo.customers;
GO

/* -----------------------------------------------------
5. Arithmetic expressions for analysis
----------------------------------------------------- */
SELECT
    id,
    name,
    age,
    age + 5 AS age_after_5_years
FROM dbo.customers
WHERE age IS NOT NULL;
GO

/* -----------------------------------------------------
6. String functions for text understanding
----------------------------------------------------- */
SELECT
    id,
    name,
    UPPER(name) AS name_uppercase,
    LEN(name) AS name_length,
    city
FROM dbo.customers;
GO

/* -----------------------------------------------------
7. Date exploration
----------------------------------------------------- */
SELECT
    id,
    name,
    signup_date,
    DATENAME(MONTH, signup_date) AS signup_month
FROM dbo.customers;
GO

/* -----------------------------------------------------
Decision:
Dataset structure is now fully understood.
Column transformations are validated and readable.
Ready to control result ordering and limits.
----------------------------------------------------- */
