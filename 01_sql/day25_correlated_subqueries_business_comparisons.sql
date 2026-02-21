/*
Day 25 Summary:
Problem:
Businesses often need row-level comparisons such as:
• Customers who spend more than their own city average
• Orders higher than customer’s historical average
• Products priced above their category average

These scenarios require row-dependent logic,
which cannot be solved with simple aggregates alone.

Business Scenario:
A company wants to identify high-value customers and
above-average transactions using contextual comparisons.

Approach:
Used correlated subqueries that reference outer query columns.
Compared row values against group-level metrics dynamically.
Applied them in SELECT and WHERE clauses.

Risk If Ignored:
• High-value customers go unnoticed
• Sales performance insights become shallow
• Targeting strategies become inaccurate
• Revenue opportunities are missed

Key Validation Check:
Verified comparison values against manual grouped aggregates.

Result:
Built queries capable of contextual row-level analytics.

Next Step:
Move into EXISTS / NOT EXISTS logic for advanced filtering.
*/

USE analyst_practice;
GO


------------------------------------------------------------
-- Step 1: Customers spending above their city average
------------------------------------------------------------

SELECT 
    c.customer_id,
    c.customer_name,
    c.city,
    SUM(o.order_amount) AS customer_total
FROM dbo.customers c
JOIN dbo.orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name, c.city
HAVING SUM(o.order_amount) >
(
    SELECT AVG(o2.order_amount)
    FROM dbo.orders o2
    JOIN dbo.customers c2
        ON o2.customer_id = c2.customer_id
    WHERE c2.city = c.city
);

-- Business Insight:
-- Identifies top customers relative to their local market.


------------------------------------------------------------
-- Step 2: Orders higher than customer’s own average
------------------------------------------------------------

SELECT 
    o.order_id,
    o.customer_id,
    o.order_amount
FROM dbo.orders o
WHERE o.order_amount >
(
    SELECT AVG(o2.order_amount)
    FROM dbo.orders o2
    WHERE o2.customer_id = o.customer_id
);

-- Business Insight:
-- Detects unusually high transactions per customer.


------------------------------------------------------------
-- Step 3: Products priced above category average
------------------------------------------------------------

SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.price
FROM dbo.products p
WHERE p.price >
(
    SELECT AVG(p2.price)
    FROM dbo.products p2
    WHERE p2.category = p.category
);

-- Business Insight:
-- Helps identify premium products inside each category.


------------------------------------------------------------
-- Step 4: Customers whose total orders exceed company average
------------------------------------------------------------

SELECT 
    c.customer_id,
    c.customer_name,
    SUM(o.order_amount) AS total_spent
FROM dbo.customers c
JOIN dbo.orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.order_amount) >
(
    SELECT AVG(total_spend)
    FROM
    (
        SELECT customer_id, SUM(order_amount) AS total_spend
        FROM dbo.orders
        GROUP BY customer_id
    ) t
);

-- Business Insight:
-- Highlights high-revenue customers relative to entire business.


------------------------------------------------------------
-- Step 5: Validation query for comparison sanity check
------------------------------------------------------------

SELECT 
    city,
    AVG(order_amount) AS avg_order_value
FROM dbo.customers c
JOIN dbo.orders o 
    ON c.customer_id = o.customer_id
GROUP BY city;

-- Validation Insight:
-- Confirms group averages used in correlated logic.


------------------------------------------------------------
-- End of Day 25 Worklog
------------------------------------------------------------
