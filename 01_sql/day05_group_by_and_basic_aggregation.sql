/*
Day 5 Summary:
Problem: Raw data cannot be used directly for insights or KPIs.
Approach: Used GROUP BY to aggregate customer data into meaningful summaries.
Key Check: Verified distribution across city, age, and signup date.
Result: Converted row-level data into business-ready metrics.
Next Step: Filter aggregated results using HAVING.
*/

USE analyst_practice;
GO

------------------------------------------------------------
-- 1. Total customer count
------------------------------------------------------------
SELECT COUNT(*) AS total_customers
FROM customers_cleaned;
GO

------------------------------------------------------------
-- 2. Customers per city
------------------------------------------------------------
SELECT 
    city,
    COUNT(*) AS customer_count
FROM customers_cleaned
GROUP BY city
ORDER BY customer_count DESC;
GO

------------------------------------------------------------
-- 3. Customers by age
------------------------------------------------------------
SELECT 
    age,
    COUNT(*) AS customer_count
FROM customers_cleaned
GROUP BY age
ORDER BY age;
GO

------------------------------------------------------------
-- 4. Customers by signup date
------------------------------------------------------------
SELECT 
    signup_date,
    COUNT(*) AS customers_signed_up
FROM customers_cleaned
GROUP BY signup_date
ORDER BY signup_date;
GO

------------------------------------------------------------
-- 5. Business question:
-- Which city contributes the most customers?
------------------------------------------------------------
SELECT TOP 1
    city,
    COUNT(*) AS total_customers
FROM customers_cleaned
GROUP BY city
ORDER BY total_customers DESC;
GO

------------------------------------------------------------
-- Observation:
-- GROUP BY transforms raw data into business insight
-- Without aggregation, KPIs cannot exist
------------------------------------------------------------
