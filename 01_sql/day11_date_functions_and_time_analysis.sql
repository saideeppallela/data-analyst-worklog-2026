/*
Day 11 Summary:
Problem:
Business datasets contain date fields that require transformation
to analyze trends, customer lifecycle, and reporting periods.

Business Scenario:
Companies track customer signup growth, retention cycles,
and engagement duration using date-based analytics.

Approach:
Used YEAR() and MONTH() for trend segmentation.
Used DATEDIFF() to measure customer lifecycle duration.
Used GETDATE() for real-time date comparisons.

Risk If Ignored:
• Trend analysis becomes inaccurate
• Customer lifecycle metrics cannot be calculated
• Business reporting periods become inconsistent

Key Validation Check:
Verified date extraction accuracy and lifecycle calculations.

Result:
Generated time-based business insights from transactional data.

Next Step:
Apply window functions to perform advanced time-series analysis.
*/

USE analyst_practice;
GO


------------------------------------------------------------
-- Step 1: Extract Year and Month from customer signup date
------------------------------------------------------------

SELECT
    customer_id,
    customer_name,
    signup_date,
    YEAR(signup_date) AS signup_year,
    MONTH(signup_date) AS signup_month
FROM dbo.customers;

-- Business Insight:
-- Helps analyze customer acquisition trends by year and month.


------------------------------------------------------------
-- Step 2: Analyze customer signup trend by Year
------------------------------------------------------------

SELECT
    YEAR(signup_date) AS signup_year,
    COUNT(*) AS customer_count
FROM dbo.customers
GROUP BY YEAR(signup_date)
ORDER BY signup_year;

-- Business Insight:
-- Shows yearly growth pattern of customer acquisition.


------------------------------------------------------------
-- Step 3: Analyze customer signup trend by Month
------------------------------------------------------------

SELECT
    YEAR(signup_date) AS signup_year,
    MONTH(signup_date) AS signup_month,
    COUNT(*) AS monthly_customers
FROM dbo.customers
GROUP BY YEAR(signup_date), MONTH(signup_date)
ORDER BY signup_year, signup_month;

-- Business Insight:
-- Helps identify seasonal growth and campaign impact.


------------------------------------------------------------
-- Step 4: Calculate customer lifecycle duration
------------------------------------------------------------

SELECT
    customer_id,
    customer_name,
    signup_date,
    DATEDIFF(DAY, signup_date, GETDATE()) AS days_since_signup
FROM dbo.customers;

-- Business Insight:
-- Measures customer relationship duration with company.


------------------------------------------------------------
-- Step 5: Segment customers based on lifecycle stage
------------------------------------------------------------

SELECT
    customer_id,
    customer_name,
    signup_date,
    DATEDIFF(MONTH, signup_date, GETDATE()) AS months_since_signup,
    CASE
        WHEN DATEDIFF(MONTH, signup_date, GETDATE()) < 6 THEN 'New Customer'
        WHEN DATEDIFF(MONTH, signup_date, GETDATE()) BETWEEN 6 AND 24 THEN 'Growing Customer'
        ELSE 'Loyal Customer'
    END AS customer_lifecycle_stage
FROM dbo.customers;

-- Business Outcome:
-- Enables lifecycle-based customer segmentation.


------------------------------------------------------------
-- Step 6: Create dataset for time-based analytics reporting
------------------------------------------------------------

SELECT
    customer_id,
    customer_name,
    signup_date,
    YEAR(signup_date) AS signup_year,
    MONTH(signup_date) AS signup_month,
    DATEDIFF(DAY, signup_date, GETDATE()) AS days_since_signup
INTO customers_time_analysis
FROM dbo.customers;

-- Business Outcome:
-- Prepared dataset ready for dashboard time-series analysis.


------------------------------------------------------------
-- Step 7: Validate time analytics dataset
------------------------------------------------------------

SELECT
    COUNT(*) AS total_records,
    MIN(signup_date) AS earliest_signup,
    MAX(signup_date) AS latest_signup
FROM customers_time_analysis;

-- Validation Insight:
-- Ensures date coverage and dataset accuracy.


------------------------------------------------------------
-- End of Day 11 Worklog
------------------------------------------------------------
