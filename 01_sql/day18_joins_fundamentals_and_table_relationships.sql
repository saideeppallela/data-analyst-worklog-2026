/*
Day 18 Summary:
Problem:
Business data is usually spread across multiple tables.
Without joins, analysts cannot combine customer, order, or product data.

Business Scenario:
In real companies, customer info sits in one table,
transactions in another, and products elsewhere.
Joins help analysts build complete business views.

Approach:
Used INNER JOIN to combine matching records.
Used LEFT JOIN to retain all customers even without orders.
Used RIGHT JOIN to validate orphaned transaction data.
Used FULL JOIN to audit missing relationships.

Risk If Ignored:
• Analysts see incomplete business picture
• Revenue attribution becomes wrong
• Customer lifecycle analysis fails
• KPIs mismatch across teams

Key Validation Check:
Compared row counts across join types.

Result:
Built unified dataset connecting customers, orders, and products.

Next Step:
Apply joins with aggregations for KPI reporting.
*/

USE analyst_practice;
GO


------------------------------------------------------------
-- Step 1: View base tables
------------------------------------------------------------

SELECT * FROM dbo.customers;
SELECT * FROM dbo.orders;
SELECT * FROM dbo.products;

-- Insight:
-- Understand table structure before joining.


------------------------------------------------------------
-- Step 2: INNER JOIN (only matching records)
------------------------------------------------------------

SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_date
FROM dbo.customers c
INNER JOIN dbo.orders o
    ON c.customer_id = o.customer_id;

-- Business Insight:
-- Shows only customers who placed orders.


------------------------------------------------------------
-- Step 3: LEFT JOIN (all customers retained)
------------------------------------------------------------

SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_date
FROM dbo.customers c
LEFT JOIN dbo.orders o
    ON c.customer_id = o.customer_id;

-- Business Insight:
-- Helps identify inactive customers with no purchases.


------------------------------------------------------------
-- Step 4: RIGHT JOIN (validate transaction ownership)
------------------------------------------------------------

SELECT
    c.customer_name,
    o.order_id
FROM dbo.customers c
RIGHT JOIN dbo.orders o
    ON c.customer_id = o.customer_id;

-- Insight:
-- Detects orders without valid customer mapping.


------------------------------------------------------------
-- Step 5: FULL JOIN (audit missing relationships)
------------------------------------------------------------

SELECT
    c.customer_id,
    c.customer_name,
    o.order_id
FROM dbo.customers c
FULL JOIN dbo.orders o
    ON c.customer_id = o.customer_id;

-- Insight:
-- Useful for data integrity checks across systems.


------------------------------------------------------------
-- Step 6: Multi-table join example
------------------------------------------------------------

SELECT
    c.customer_name,
    o.order_id,
    p.product_name,
    o.order_amount
FROM dbo.orders o
JOIN dbo.customers c
    ON o.customer_id = c.customer_id
JOIN dbo.products p
    ON o.product_id = p.product_id;

-- Business Outcome:
-- Creates complete order-level analytical dataset.


------------------------------------------------------------
-- End of Day 18 Worklog
------------------------------------------------------------
