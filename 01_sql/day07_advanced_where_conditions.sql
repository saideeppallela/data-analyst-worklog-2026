/*
Day 7 Summary:
Problem: Business questions require filtering data using multiple logical conditions.
Approach: Used advanced WHERE clauses with AND, OR, BETWEEN, and IN operators.
Key Check: Verified filtered results match expected business scenarios.
Result: Built reusable filtering patterns for segmentation and reporting.
Next Step: Apply CASE WHEN for dynamic business categorization.
*/

USE analyst_practice;
GO

------------------------------------------------------------
-- Step 1: Filter using AND condition
------------------------------------------------------------
-- Business Question:
-- Retrieve customers aged above 25 who belong to Bangalore

SELECT *
FROM dbo.customers
WHERE age > 25
AND city = 'Bangalore';

-- Insight:
-- AND helps narrow down results by applying multiple strict conditions


------------------------------------------------------------
-- Step 2: Filter using OR condition
------------------------------------------------------------
-- Business Question:
-- Retrieve customers from Bangalore OR Hyderabad

SELECT *
FROM dbo.customers
WHERE city = 'Bangalore'
OR city = 'Hyderabad';

-- Insight:
-- OR helps expand results when multiple alternative conditions exist


------------------------------------------------------------
-- Step 3: Filter using BETWEEN
------------------------------------------------------------
-- Business Question:
-- Retrieve customers aged between 25 and 35

SELECT *
FROM dbo.customers
WHERE age BETWEEN 25 AND 35;

-- Insight:
-- BETWEEN improves readability when filtering numeric ranges


------------------------------------------------------------
-- Step 4: Filter using IN operator
------------------------------------------------------------
-- Business Question:
-- Retrieve customers from selected business cities

SELECT *
FROM dbo.customers
WHERE city IN ('Bangalore', 'Hyderabad', 'Chennai');

-- Insight:
-- IN improves scalability when filtering multiple values


------------------------------------------------------------
-- Step 5: Combine multiple filtering techniques
------------------------------------------------------------
-- Business Question:
-- Customers aged 25–40 AND from top business cities

SELECT *
FROM dbo.customers
WHERE age BETWEEN 25 AND 40
AND city IN ('Bangalore', 'Hyderabad');

-- Insight:
-- Combining logical filters builds real-world business segmentation


------------------------------------------------------------
-- Step 6: Business sanity validation
------------------------------------------------------------
-- Check filtered record counts

SELECT
    COUNT(*) AS filtered_customers
FROM dbo.customers
WHERE age BETWEEN 25 AND 40
AND city IN ('Bangalore', 'Hyderabad');

-- Decision:
-- Dataset now supports targeted demographic segmentation

------------------------------------------------------------
-- End of Day 7
------------------------------------------------------------
