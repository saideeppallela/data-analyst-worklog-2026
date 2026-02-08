/*
Day 12 Summary:
Problem:
Business analysis often requires combining multiple filtering conditions
based on customer attributes, business rules, and time-based logic.

Business Scenario:
Analysts frequently need to filter customers using multiple rules such as:
• Active customers in recent time periods
• Age-based customer targeting
• Date-driven segmentation for marketing campaigns
• Conditional classification for reporting

Approach:
Used WHERE clause for primary filtering.
Used CASE expressions for business rule classification.
Used DATE functions to apply time-based filters.

Risk If Ignored:
• Incorrect customer targeting
• Marketing campaigns reaching wrong audience
• Time-based reporting inconsistencies
• Dashboard metrics becoming unreliable

Key Validation Check:
Validated filtered datasets against multiple business conditions.

Result:
Created multi-condition filtered dataset suitable for business reporting
and targeted analytics.

Next Step:
Apply JOIN operations to combine customer data with transaction-level insights.
*/

USE analyst_practice;
GO


------------------------------------------------------------
-- Step 1: Filter customers based on registration year
------------------------------------------------------------

SELECT
    customer_id,
    customer_name,
    registration_date
FROM dbo.customers
WHERE YEAR(registration_date) >= 2022;

-- Insight:
-- Identifies recently acquired customers for growth analysis.


------------------------------------------------------------
-- Step 2: Combine WHERE + CASE for Age Segmentation
------------------------------------------------------------

SELECT
    customer_id,
    customer_name,
    age,
    CASE
        WHEN age < 25 THEN 'Young Customers'
        WHEN age BETWEEN 25 AND 45 THEN 'Mid-Age Customers'
        WHEN age > 45 THEN 'Senior Customers'
        ELSE 'Unknown Age Group'
    END AS age_segment
FROM dbo.customers
WHERE age IS NOT NULL;

-- Business Insight:
-- Enables customer segmentation for targeted marketing.


------------------------------------------------------------
-- Step 3: Apply Date-Based Customer Activity Filtering
------------------------------------------------------------

SELECT
    customer_id,
    customer_name,
    registration_date
FROM dbo.customers
WHERE registration_date >= DATEADD(YEAR, -2, GETDATE());

-- Explanation:
-- Filters customers active within last 2 years.


------------------------------------------------------------
-- Step 4: Combine WHERE + CASE + DATE Logic
------------------------------------------------------------

SELECT
    customer_id,
    customer_name,
    city,
    registration_date,
    CASE
        WHEN YEAR(registration_date) = YEAR(GETDATE())
             THEN 'New Customer'
        WHEN YEAR(registration_date) = YEAR(GETDATE()) - 1
             THEN 'Recent Customer'
        ELSE 'Old Customer'
    END AS customer_status
FROM dbo.customers
WHERE city IS NOT NULL
  AND registration_date IS NOT NULL;

-- Business Outcome:
-- Classifies customers based on recency.


------------------------------------------------------------
-- Step 5: Advanced Multi-Condition Filtering for Campaign Targeting
------------------------------------------------------------

SELECT
    customer_id,
    customer_name,
    age,
    city,
    registration_date
INTO customers_campaign_target
FROM dbo.customers
WHERE age BETWEEN 25 AND 45
  AND city <> 'Unknown'
  AND registration_date >= DATEADD(YEAR, -1, GETDATE());

-- Business Outcome:
-- Creates targeted customer dataset for marketing campaigns.


------------------------------------------------------------
-- Step 6: Validate Campaign Dataset
------------------------------------------------------------

SELECT
    COUNT(*) AS targeted_customers,
    MIN(registration_date) AS earliest_customer,
    MAX(registration_date) AS latest_customer
FROM customers_campaign_target;

-- Validation Insight:
-- Confirms filtering accuracy and dataset readiness.


------------------------------------------------------------
-- End of Day 12 Worklog
------------------------------------------------------------
