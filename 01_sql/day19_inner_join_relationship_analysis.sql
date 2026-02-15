/*
Day 19 Summary:
Problem:
Business data is often split across multiple tables. Without proper joins,
analysts cannot connect customers to orders, products, or transactions.

Business Scenario:
A company stores customer details in one table and orders in another.
To analyze customer purchase behavior, we must combine these tables.

Approach:
Used INNER JOIN to connect related tables.
Joined customer and order tables using primary–foreign key relationships.
Validated row counts to ensure join accuracy.

Risk If Ignored:
• Customer insights remain incomplete
• Revenue attribution becomes incorrect
• Reports miss transaction-level details
• Dashboards show fragmented data

Key Validation Check:
Verified matching keys before and after joining.

Result:
Created a unified dataset linking customers with their orders.

Next Step:
Explore LEFT JOIN to include missing relationships.
*/

USE analyst_practice;
GO


------------------------------------------------------------
-- Step 1: Inspect base tables before joining
------------------------------------------------------------

SELECT TOP 10 *
FROM dbo.customers;

SELECT TOP 10 *
FROM dbo.orders;

-- Insight:
-- Understand table structure and join keys.


------------------------------------------------------------
-- Step 2: Perform INNER JOIN using primary-foreign key
------------------------------------------------------------

SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    o.order_id,
    o.order_date,
    o.total_amount
FROM dbo.customers AS c
INNER JOIN dbo.orders AS o
    ON c.customer_id = o.customer_id;

-- Business Insight:
-- Retrieves only customers who placed orders.


------------------------------------------------------------
-- Step 3: Count joined records to validate relationship
------------------------------------------------------------

SELECT COUNT(*) AS joined_rows
FROM dbo.customers c
INNER JOIN dbo.orders o
    ON c.customer_id = o.customer_id;

-- Validation Insight:
-- Confirms number of valid customer-order relationships.


------------------------------------------------------------
-- Step 4: Aggregate revenue by customer using INNER JOIN
------------------------------------------------------------

SELECT
    c.customer_name,
    SUM(o.total_amount) AS total_spent
FROM dbo.customers c
INNER JOIN dbo.orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

-- Business Outcome:
-- Identifies high-value customers.


------------------------------------------------------------
-- Step 5: Create analysis-ready joined dataset
------------------------------------------------------------

SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    o.order_id,
    o.order_date,
    o.total_amount
INTO customer_orders_inner
FROM dbo.customers c
INNER JOIN dbo.orders o
    ON c.customer_id = o.customer_id;

-- Outcome:
-- Dataset ready for segmentation, reporting, and dashboards.


------------------------------------------------------------
-- Step 6: Validate final dataset size
------------------------------------------------------------

SELECT COUNT(*) AS final_rows
FROM customer_orders_inner;

-- Validation:
-- Confirms successful dataset creation.


------------------------------------------------------------
-- End of Day 19 Worklog
------------------------------------------------------------
