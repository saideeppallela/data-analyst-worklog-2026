/*
Day 8 Summary:
Problem: Raw customer data lacks business-friendly segmentation.
Approach: Used CASE WHEN logic to create age groups and customer classifications.
Key Check: Verified bucket distribution and handled NULL values carefully.
Result: Created business-ready customer segmentation fields.
Next Step: Combine segmentation with aggregations for insights.
*/

USE analyst_practice;
GO

------------------------------------------------------------
-- Step 1: Preview raw age data
------------------------------------------------------------

SELECT
    id,
    name,
    age
FROM dbo.customers;

-- Observation:
-- Raw age values exist but cannot be directly used for business segmentation.

------------------------------------------------------------
-- Step 2: Create Age Group Buckets using CASE WHEN
------------------------------------------------------------

SELECT
    id,
    name,
    age,
    CASE
        WHEN age IS NULL THEN 'Unknown'
        WHEN age < 25 THEN 'Young Customers'
        WHEN age BETWEEN 25 AND 40 THEN 'Mid-Age Customers'
        WHEN age > 40 THEN 'Senior Customers'
    END AS age_group
FROM dbo.customers;

-- Insight:
-- Converts numeric age into business-readable segments.

------------------------------------------------------------
-- Step 3: Validate Distribution of Age Groups
------------------------------------------------------------

SELECT
    CASE
        WHEN age IS NULL THEN 'Unknown'
        WHEN age < 25 THEN 'Young Customers'
        WHEN age BETWEEN 25 AND 40 THEN 'Mid-Age Customers'
        WHEN age > 40 THEN 'Senior Customers'
    END AS age_group,
    COUNT(*) AS customer_count
FROM dbo.customers
GROUP BY
    CASE
        WHEN age IS NULL THEN 'Unknown'
        WHEN age < 25 THEN 'Young Customers'
        WHEN age BETWEEN 25 AND 40 THEN 'Mid-Age Customers'
        WHEN age > 40 THEN 'Senior Customers'
    END
ORDER BY customer_count DESC;

-- Insight:
-- Helps business understand customer demographic distribution.

------------------------------------------------------------
-- Step 4: Create Business Flag Columns
------------------------------------------------------------

SELECT
    id,
    name,
    age,
    CASE
        WHEN age >= 30 THEN 'High Value Target'
        ELSE 'Standard Segment'
    END AS marketing_segment
FROM dbo.customers;

-- Business Use:
-- Used for targeted marketing campaigns.

------------------------------------------------------------
-- Step 5: Create Cleaned Business View Table
------------------------------------------------------------

IF OBJECT_ID('dbo.customers_segmented', 'U') IS NOT NULL
    DROP TABLE dbo.customers_segmented;
GO

SELECT
    id,
    name,
    age,
    city,
    signup_date,

    CASE
        WHEN age IS NULL THEN 'Unknown'
        WHEN age < 25 THEN 'Young Customers'
        WHEN age BETWEEN 25 AND 40 THEN 'Mid-Age Customers'
        WHEN age > 40 THEN 'Senior Customers'
    END AS age_group,

    CASE
        WHEN age >= 30 THEN 'High Value Target'
        ELSE 'Standard Segment'
    END AS marketing_segment

INTO dbo.customers_segmented
FROM dbo.customers;

-- Result:
-- Business-ready segmentation table created.

------------------------------------------------------------
-- Step 6: Verify Final Segmented Table
------------------------------------------------------------

SELECT *
FROM dbo.customers_segmented;

-- Decision:
-- Dataset now supports marketing, customer profiling, and KPI segmentation.

------------------------------------------------------------
-- End of Day 8
------------------------------------------------------------
