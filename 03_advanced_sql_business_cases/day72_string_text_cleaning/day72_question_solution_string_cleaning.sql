-- =========================================================
-- QUESTIONS
-- =========================================================
-- Clean and transform messy customer data.
-- Write SQL queries to:
-- 1. Extract first and last names
-- 2. Extract country code from order_id
-- 3. Standardize city names
-- 4. Count occurrences of specific characters
-- =========================================================
-- =========================================================
-- 1. Extract first and last name
-- =========================================================

SELECT
    full_name,
    LEFT(full_name, CHARINDEX(' ', full_name) - 1) AS first_name,
    SUBSTRING(
        full_name,
        CHARINDEX(' ', full_name) + 1,
        LEN(full_name)
    ) AS last_name
FROM customer_data;
-- =========================================================
-- 2. Extract country code from order_id
-- =========================================================
SELECT
    order_id, LEFT(order_id, CHARINDEX('-', order_id) - 1) AS country_code
FROM customer_data;

-- =========================================================
-- 3. Clean and standardize city names
-- =========================================================

SELECT
    city,UPPER(TRIM(city)) AS cleaned_city
FROM customer_data;


-- =========================================================
-- 4. Count specific characters (example: count 'a')
-- =========================================================

SELECT
    full_name,LEN(full_name) - LEN(REPLACE(full_name, 'a', '')) AS count_of_a
FROM customer_data;
GO


