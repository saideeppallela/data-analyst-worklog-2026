/*
Day 14 Summary:
Problem:
Analysts often confuse WHERE and HAVING while filtering grouped results,
leading to incorrect aggregations and business insights.

Business Scenario:
Companies frequently need to filter aggregated KPIs such as:
• High revenue cities
• Active customer segments
• High-performing product categories

Approach:
Used WHERE to filter raw row-level data.
Used HAVING to filter aggregated GROUP BY results.

Risk If Ignored:
• Incorrect KPI reporting
• Misleading segmentation analysis
• Performance inefficiencies
• Wrong business conclusions

Key Validation Check:
Compared filtering results before and after aggregation.

Result:
Clear understanding of row-level vs aggregate-level filtering logic.

Next Step:
Apply JOIN with GROUP BY and HAVING for multi-table business insights.
*/

USE analyst_practice;
GO


------------------------------------------------------------
-- Step 1: Filter raw dataset using WHERE
------------------------------------------------------------

SELECT
    city,
    age
FROM dbo.customers
WHERE age > 25;

-- Insight:
-- WHERE filters rows BEFORE aggregation.


------------------------------------------------------------
-- Step 2: Basic GROUP BY aggregation
------------------------------------------------------------

SELECT
    city,
    COUNT(customer_id) AS customer_count
FROM dbo.customers
GROUP BY city;

-- Business Insight:
-- Provides customer distribution across cities.


------------------------------------------------------------
-- Step 3: Incorrect attempt to filter aggregated results
------------------------------------------------------------

-- ❌ This will cause error
/*
SELECT
    city,
    COUNT(customer_id) AS customer_count
FROM dbo.customers
WHERE COUNT(customer_id) > 5
GROUP BY city;
*/


------------------------------------------------------------
-- Step 4: Correct filtering using HAVING
------------------------------------------------------------

SELECT
    city,
    COUNT(customer_id) AS customer_count
FROM dbo.customers
GROUP BY city
HAVING COUNT(customer_id) > 5;

-- Explanation:
-- HAVING filters aggregated results AFTER GROUP BY.


------------------------------------------------------------
-- Step 5: Combine WHERE and HAVING for business filtering
------------------------------------------------------------

SELECT
    city,
    COUNT(customer_id) AS eligible_customer_count
FROM dbo.customers
WHERE age > 25
GROUP BY city
HAVING COUNT(customer_id) >= 3;

-- Business Outcome:
-- Identifies cities with minimum active customers above target age.


------------------------------------------------------------
-- Step 6: Multi-metric aggregation with HAVING
------------------------------------------------------------

SELECT
    city,
    COUNT(customer_id) AS total_customers,
    AVG(age) AS average_age
FROM dbo.customers
WHERE age IS NOT NULL
GROUP BY city
HAVING AVG(age) > 30;

-- Validation Insight:
-- Helps identify mature customer markets.


------------------------------------------------------------
-- End of Day 14 Worklog
------------------------------------------------------------
