-- Day 1: Understanding raw data before analysis
-- Goal: Validate structure, quality, and readiness of data for business analysis

/* Business question
   What data do we have, and can it be trusted before building metrics or dashboards?
*/

-------------------------------------------------
-- Step 1: Understand table structure
-------------------------------------------------
SELECT 
  column_name, 
  data_type
FROM information_schema.columns
WHERE table_name = 'customers';

/* Observation
- Identified primary fields: id, signup_date, age, city
- Age and city are nullable → may affect segmentation analysis
- signup_date is DATE type → safe for time-based analysis
*/

-------------------------------------------------
-- Step 2: Inspect sample records
-------------------------------------------------
SELECT *
FROM customers
LIMIT 20;

/* Observation
- Some age values are missing → impacts demographic insights
- Signup dates look consistent (no invalid formats)
- City values contain multiple spellings → needs standardization
*/

-------------------------------------------------
-- Step 2.1: Check null distribution
-------------------------------------------------
SELECT 
  COUNT(*) AS total_records,
  COUNT(age) AS age_not_null,
  COUNT(city) AS city_not_null
FROM customers;

/* Observation
- Null values exist in critical columns
- Cleaning required before KPI calculations
*/

-------------------------------------------------
-- Step 3: Check data volume
-------------------------------------------------
SELECT COUNT(*) AS total_records
FROM customers;

/* Observation
- Data volume sufficient for exploratory analysis
*/

-------------------------------------------------
-- Step 3.1: Validate date range
-------------------------------------------------
SELECT 
  MIN(signup_date) AS first_signup,
  MAX(signup_date) AS last_signup
FROM customers;

/* Observation
- Date range is continuous and usable for trend analysis
*/

-------------------------------------------------
-- Decision
-------------------------------------------------
/*
- Remove records with null critical fields (age, signup_date)
- Standardize city values
- Create cleaned base table before analysis
*/

-------------------------------------------------
-- Next step
-------------------------------------------------
/*
Day 2: Apply WHERE filters and build cleaned dataset
*/
