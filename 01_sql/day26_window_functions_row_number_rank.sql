/*
Day 26 Summary:
Problem:
Business reports often need ranked outputs like top customers, highest revenue cities,
or most recent transactions. Basic GROUP BY cannot provide row-level ranking.

Business Scenario:
Management wants to identify top-performing customers, detect ties in revenue,
and assign sequence numbers for reporting and pagination logic.

Approach:
Used ROW_NUMBER() for unique sequencing.
Used RANK() for ranking with ties.
Applied PARTITION BY for grouped ranking scenarios.

Risk If Ignored:
• Reports show unordered or misleading results
• Cannot identify top performers reliably
• Pagination and latest-record logic break
• Business insights lack prioritization

Key Validation Check:
Verified ranking resets correctly per partition.

Result:
Created ranked datasets suitable for leaderboards,
performance tracking, and business prioritization.

Next Step:
Use DENSE_RANK() and NTILE() for advanced distribution analysis.
*/

USE analyst_practice;
GO

------------------------------------------------------------
-- Step 1: Assign row numbers to customers by signup date
------------------------------------------------------------

SELECT
    customer_id,
    customer_name,
    signup_date,
    ROW_NUMBER() OVER (ORDER BY signup_date DESC) AS signup_sequence
FROM dbo.customers;

-- Insight:
-- Useful for identifying most recent customers or pagination logic.


------------------------------------------------------------
-- Step 2: Rank customers by total order value
------------------------------------------------------------

SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.order_amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(o.order_amount) DESC) AS spending_rank
FROM dbo.customers c
JOIN dbo.orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- Insight:
-- Handles ties correctly when customers have equal revenue.


------------------------------------------------------------
-- Step 3: Ranking within groups (Partitioned ranking)
------------------------------------------------------------

SELECT
    c.city,
    c.customer_name,
    SUM(o.order_amount) AS total_spent,
    RANK() OVER (
        PARTITION BY c.city
        ORDER BY SUM(o.order_amount) DESC
    ) AS city_rank
FROM dbo.customers c
JOIN dbo.orders o
    ON c.customer_id = o.customer_id
GROUP BY c.city, c.customer_name;

-- Insight:
-- Finds top customers inside each city.


------------------------------------------------------------
-- Step 4: Compare ROW_NUMBER vs RANK behavior
------------------------------------------------------------

SELECT
    customer_name,
    total_spent,
    ROW_NUMBER() OVER (ORDER BY total_spent DESC) AS row_num,
    RANK() OVER (ORDER BY total_spent DESC) AS rank_value
FROM (
    SELECT
        c.customer_name,
        SUM(o.order_amount) AS total_spent
    FROM dbo.customers c
    JOIN dbo.orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_name
) AS spending_summary;

-- Insight:
-- ROW_NUMBER gives unique numbers
-- RANK repeats numbers when values tie


------------------------------------------------------------
-- Step 5: Create ranked dataset for reporting layer
------------------------------------------------------------

SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.order_amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(o.order_amount) DESC) AS rank_position
INTO customer_spending_ranked
FROM dbo.customers c
JOIN dbo.orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- Business Outcome:
-- Ready-to-use ranked dataset for dashboards.


------------------------------------------------------------
-- Step 6: Validate ranking dataset
------------------------------------------------------------

SELECT
    COUNT(*) AS total_customers,
    MIN(rank_position) AS top_rank,
    MAX(rank_position) AS lowest_rank
FROM customer_spending_ranked;

-- Validation Insight:
-- Confirms ranking range and completeness.


------------------------------------------------------------
-- End of Day 26 Worklog
------------------------------------------------------------
