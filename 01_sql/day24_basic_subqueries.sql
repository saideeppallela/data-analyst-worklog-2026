/*
Day 24 Summary:
Problem:
Business analysts often need filtered insights based on derived values,
such as customers who spend above average or products performing better
than category benchmarks.

Business Scenario:
Management wants to identify high-value customers and above-average orders
without creating temporary tables.

Approach:
Used scalar subqueries in WHERE clauses.
Used subqueries with aggregates to create dynamic benchmarks.
Compared row values against derived dataset values.

Risk If Ignored:
• Hardcoded thresholds become outdated
• Analysts rely on manual calculations
• Reports fail to adapt to changing data patterns

Key Validation Check:
Verified subquery results independently before applying filters.

Result:
Dynamic, self-updating query logic for business comparisons.

Next Step:
Apply correlated subqueries for row-wise evaluation.
*/

USE analyst_practice;
GO

------------------------------------------------------------
-- Step 1: Find customers spending above average order value
------------------------------------------------------------

SELECT *
FROM dbo.orders
WHERE order_amount >
(
    SELECT AVG(order_amount)
    FROM dbo.orders
);

-- Insight:
-- Identifies high-value transactions relative to dataset average.


------------------------------------------------------------
-- Step 2: Identify customers who placed more orders than average
------------------------------------------------------------

SELECT customer_id, COUNT(*) AS total_orders
FROM dbo.orders
GROUP BY customer_id
HAVING COUNT(*) >
(
    SELECT AVG(order_count)
    FROM
    (
        SELECT COUNT(*) AS order_count
        FROM dbo.orders
        GROUP BY customer_id
    ) AS order_stats
);

-- Business Insight:
-- Finds frequent customers using a dynamic benchmark.


------------------------------------------------------------
-- Step 3: Get products priced above category average
------------------------------------------------------------

SELECT *
FROM dbo.products p
WHERE price >
(
    SELECT AVG(price)
    FROM dbo.products
    WHERE category_id = p.category_id
);

-- Explanation:
-- Compares product price to its own category average.


------------------------------------------------------------
-- Step 4: Create dataset of premium customers
------------------------------------------------------------

SELECT *
INTO premium_customers
FROM dbo.customers
WHERE customer_id IN
(
    SELECT customer_id
    FROM dbo.orders
    GROUP BY customer_id
    HAVING SUM(order_amount) >
    (
        SELECT AVG(total_spend)
        FROM
        (
            SELECT SUM(order_amount) AS total_spend
            FROM dbo.orders
            GROUP BY customer_id
        ) AS spend_stats
    )
);

-- Outcome:
-- Generates dataset of customers above average total spend.


------------------------------------------------------------
-- Step 5: Validate premium customer dataset
------------------------------------------------------------

SELECT COUNT(*) AS premium_customer_count
FROM premium_customers;

-- Validation Insight:
-- Ensures subquery logic produced expected segmentation.


------------------------------------------------------------
-- End of Day 24 Worklog
------------------------------------------------------------
