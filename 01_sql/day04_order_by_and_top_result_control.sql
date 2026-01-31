/*
Day 4 Summary:
Problem: Query results were unordered and difficult to interpret,
making analysis inconsistent and unreliable.
Approach: Used ORDER BY and TOP to control result order and limit rows
for meaningful analysis.
Key Check: Verified correct sorting and ensured top records matched
business expectations.
Result: Clean, readable, and controlled result sets ready for analysis.
Next Step: Identify unique values and duplicates using DISTINCT.
*/

USE analyst_practice;
GO

/* =====================================================
DAY 4: ORDER BY & TOP – Result Set Control
Objective:
- Sort data meaningfully
- Control result size for analysis
- Improve readability and insights
===================================================== */

/* -----------------------------------------------------
1. Default unordered results (baseline)
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
2. Sort data by signup date (oldest first)
----------------------------------------------------- */
SELECT
    id,
    name,
    age,
    city,
    signup_date
FROM dbo.customers
ORDER BY signup_date ASC;
GO

/* -----------------------------------------------------
3. Sort data by signup date (latest first)
----------------------------------------------------- */
SELECT
    id,
    name,
    age,
    city,
    signup_date
FROM dbo.customers
ORDER BY signup_date DESC;
GO

/* -----------------------------------------------------
4. Sort by multiple columns (city, then age)
----------------------------------------------------- */
SELECT
    id,
    name,
    age,
    city,
    signup_date
FROM dbo.customers
ORDER BY city ASC, age DESC;
GO

/* -----------------------------------------------------
5. Limit results using TOP (recent customers)
----------------------------------------------------- */
SELECT TOP 5
    id,
    name,
    age,
    city,
    signup_date
FROM dbo.customers
ORDER BY signup_date DESC;
GO

/* -----------------------------------------------------
6. Use TOP with ORDER BY for analysis focus
----------------------------------------------------- */
SELECT TOP 3
    id,
    name,
    age,
    city
FROM dbo.customers
WHERE age IS NOT NULL
ORDER BY age DESC;
GO

/* -----------------------------------------------------
Decision:
Result sets are now ordered, readable, and analysis-focused.
Queries return only relevant rows instead of full tables.
----------------------------------------------------- */
