/*
Day 23 Summary:
Problem:
Joins often create duplicate rows when relationships are not one-to-one.
This leads to inflated KPIs, incorrect revenue totals, and misleading insights.

Business Scenario:
In real dashboards, joining customers with orders or payments without
understanding relationship cardinality causes duplicate aggregations.

Approach:
Validated table relationships before joins.
Checked row counts pre and post join.
Used DISTINCT and aggregation controls to prevent duplication.

Risk If Ignored:
• Revenue metrics get inflated
• Customer counts become incorrect
• Dashboards show misleading growth
• Analysts lose data trust

Key Validation Check:
Compared source row counts vs joined output.

Result:
Built duplicate-safe joins for reliable analytics.

Next Step:
Introduce window functions for advanced deduplication logic.
*/

USE analyst_practice;
GO


------------------------------------------------------------
-- Step 1: Inspect base table row counts
------------------------------------------------------------

SELECT COUNT(*) AS customer_count
FROM dbo.customers;

SELECT COUNT(*) AS order_count
FROM dbo.orders;

-- Insight:
-- Always know base table sizes before joining.


------------------------------------------------------------
-- Step 2: Perform naive join (can cause duplicates)
------------------------------------------------------------

SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_amount
FROM dbo.customers c
INNER JOIN dbo.orders o
    ON c.customer_id = o.customer_id;

-- Risk:
-- Customers with multiple orders appear multiple times.


------------------------------------------------------------
-- Step 3: Validate duplicate inflation after join
------------------------------------------------------------

SELECT
    COUNT(*) AS joined_rows
FROM dbo.customers c
INNER JOIN dbo.orders o
    ON c.customer_id = o.customer_id;

-- Compare this number with customer_count.
-- If much larger, duplicates exist.


------------------------------------------------------------
-- Step 4: Identify customers causing duplication
------------------------------------------------------------

SELECT
    customer_id,
    COUNT(*) AS order_count
FROM dbo.orders
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Insight:
-- Shows one-to-many relationships causing row multiplication.


------------------------------------------------------------
-- Step 5: Prevent duplicate impact using aggregation
------------------------------------------------------------

SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.order_amount) AS total_spent
FROM dbo.customers c
LEFT JOIN dbo.orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name;

-- Business Outcome:
-- Aggregation prevents duplicate row impact.


------------------------------------------------------------
-- Step 6: Validate final dataset reliability
------------------------------------------------------------

SELECT COUNT(*) AS final_customer_rows
FROM (
    SELECT
        c.customer_id
    FROM dbo.customers c
    LEFT JOIN dbo.orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_id
) AS validated;

-- Validation Insight:
-- Final output should match unique customer count.


------------------------------------------------------------
-- End of Day 23 Worklog
------------------------------------------------------------
