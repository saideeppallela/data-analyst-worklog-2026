/*
Day 29 Summary:
Problem:
Slow SQL queries delay dashboards, reports, and analyst workflows.
Most performance issues come from inefficient filters, joins,
and unnecessary full table scans.

Business Scenario:
In real companies, analysts often query large tables (millions of rows).
Poorly optimized queries increase dashboard load time and affect decision speed.

Approach:
Used selective filters to reduce scan size.
Checked indexing impact on query speed.
Compared inefficient vs optimized query patterns.

Risk If Ignored:
• Dashboards refresh slowly
• Reports time out
• Analyst productivity drops
• Business teams lose trust in data speed

Key Validation Check:
Compared logical reads and execution patterns.

Result:
Queries structured for faster filtering and reduced data scanning.

Next Step:
Learn indexing strategies and execution plan reading.
*/

USE analyst_practice;
GO


------------------------------------------------------------
-- Step 1: Inefficient query example (full table scan)
------------------------------------------------------------

SELECT *
FROM dbo.orders;

-- Insight:
-- Pulling entire table without filters causes unnecessary I/O.


------------------------------------------------------------
-- Step 2: Apply selective filtering (performance improvement)
------------------------------------------------------------

SELECT order_id, customer_id, order_date, total_amount
FROM dbo.orders
WHERE order_date >= '2024-01-01';

-- Business Insight:
-- Filters reduce scanned rows and improve response time.


------------------------------------------------------------
-- Step 3: Avoid functions on indexed columns
------------------------------------------------------------

-- Inefficient version
SELECT *
FROM dbo.orders
WHERE YEAR(order_date) = 2024;

-- Optimized version
SELECT *
FROM dbo.orders
WHERE order_date >= '2024-01-01'
  AND order_date <  '2025-01-01';

-- Explanation:
-- Functions on columns prevent index usage.


------------------------------------------------------------
-- Step 4: Reduce SELECT column load
------------------------------------------------------------

SELECT customer_id, SUM(total_amount) AS total_sales
FROM dbo.orders
GROUP BY customer_id;

-- Insight:
-- Avoid SELECT * in aggregation queries.


------------------------------------------------------------
-- Step 5: Join performance awareness
------------------------------------------------------------

SELECT
    o.order_id,
    c.customer_name,
    o.total_amount
FROM dbo.orders o
INNER JOIN dbo.customers c
    ON o.customer_id = c.customer_id
WHERE o.order_date >= '2024-01-01';

-- Explanation:
-- Filtering before aggregation improves join efficiency.


------------------------------------------------------------
-- Step 6: Quick sanity performance check
------------------------------------------------------------

SELECT COUNT(*) AS total_recent_orders
FROM dbo.orders
WHERE order_date >= DATEADD(MONTH, -1, GETDATE());

-- Business Outcome:
-- Efficient query for recent business monitoring.


------------------------------------------------------------
-- End of Day 29 Worklog
------------------------------------------------------------
