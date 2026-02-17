/*
Day 21 Summary:
Problem:
Analysts often fail to detect missing relationships between tables,
especially when some records exist only on one side of a join.

Business Scenario:
In real companies, some customers may exist without orders,
and some orders may exist without valid customer mapping.
This creates reporting gaps and misleading dashboards.

Approach:
Used RIGHT JOIN to identify unmatched customers or dimension records.
Used FULL JOIN to detect mismatches on both sides.
Used NULL checks to isolate missing relationships.

Risk If Ignored:
• Orphan records distort reporting totals
• Revenue attribution becomes inaccurate
• Customer behavior analysis becomes incomplete
• Data integrity issues remain hidden

Key Validation Check:
Compared matched vs unmatched record counts.

Result:
Identified relationship gaps between fact and dimension tables.

Next Step:
Move to JOIN filtering and advanced join conditions.
*/

USE analyst_practice;
GO

------------------------------------------------------------
-- Step 1: RIGHT JOIN to identify customers without orders
------------------------------------------------------------

SELECT 
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_amount
FROM dbo.orders o
RIGHT JOIN dbo.customers c
    ON o.customer_id = c.customer_id;

-- Insight:
-- Shows customers even if they have never placed orders.


------------------------------------------------------------
-- Step 2: Detect customers with NO orders
------------------------------------------------------------

SELECT 
    c.customer_id,
    c.customer_name
FROM dbo.orders o
RIGHT JOIN dbo.customers c
    ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL;

-- Business Insight:
-- Identifies inactive customers for marketing follow-up.


------------------------------------------------------------
-- Step 3: FULL JOIN to detect mismatches on BOTH sides
------------------------------------------------------------

SELECT 
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_amount
FROM dbo.customers c
FULL JOIN dbo.orders o
    ON c.customer_id = o.customer_id;

-- Insight:
-- Displays all matched and unmatched records.


------------------------------------------------------------
-- Step 4: Identify unmatched customers OR unmatched orders
------------------------------------------------------------

SELECT 
    c.customer_id,
    c.customer_name,
    o.order_id
FROM dbo.customers c
FULL JOIN dbo.orders o
    ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL
   OR o.order_id IS NULL;

-- Business Insight:
-- Detects data integrity issues between tables.


------------------------------------------------------------
-- Step 5: Count unmatched records for reporting validation
------------------------------------------------------------

SELECT
    SUM(CASE WHEN c.customer_id IS NULL THEN 1 ELSE 0 END) AS orphan_orders,
    SUM(CASE WHEN o.order_id IS NULL THEN 1 ELSE 0 END) AS customers_without_orders
FROM dbo.customers c
FULL JOIN dbo.orders o
    ON c.customer_id = o.customer_id;

-- Validation Insight:
-- Helps quantify data relationship gaps.


------------------------------------------------------------
-- End of Day 21 Worklog
------------------------------------------------------------
