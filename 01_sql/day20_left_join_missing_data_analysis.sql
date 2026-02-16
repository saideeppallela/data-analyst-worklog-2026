/*
Day 20 Summary:
Problem:
Business datasets often miss related records between tables,
causing incomplete reporting and hidden operational gaps.

Business Scenario:
In real analytics workflows, LEFT JOIN is used to detect:
• Customers without orders
• Products without sales
• Regions without activity

Approach:
Used LEFT JOIN to preserve primary table records.
Used NULL detection on joined table to identify missing relationships.

Risk If Ignored:
• Inactive customers remain unnoticed
• Inventory gaps go undetected
• Reporting ignores potential revenue loss

Key Validation Check:
Verified unmatched records returned by LEFT JOIN.

Result:
Identified missing relationships and business opportunities.

Next Step:
Use OUTER JOIN combinations to build full data visibility.
*/

USE analyst_practice;
GO


------------------------------------------------------------
-- Step 1: Identify customers without any orders
------------------------------------------------------------

SELECT
    c.customer_id,
    c.customer_name,
    o.order_id
FROM dbo.customers c
LEFT JOIN dbo.orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Business Insight:
-- Detects inactive customers who never placed orders.


------------------------------------------------------------
-- Step 2: Count active vs inactive customers
------------------------------------------------------------

SELECT
    COUNT(DISTINCT c.customer_id) AS total_customers,
    COUNT(DISTINCT o.customer_id) AS customers_with_orders,
    COUNT(DISTINCT c.customer_id) - COUNT(DISTINCT o.customer_id) AS customers_without_orders
FROM dbo.customers c
LEFT JOIN dbo.orders o
    ON c.customer_id = o.customer_id;

-- Insight:
-- Quantifies potential engagement gaps.


------------------------------------------------------------
-- Step 3: Detect products that never sold
------------------------------------------------------------

SELECT
    p.product_id,
    p.product_name
FROM dbo.products p
LEFT JOIN dbo.order_items oi
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

-- Business Insight:
-- Identifies non-performing inventory.


------------------------------------------------------------
-- Step 4: Analyze regional activity gaps
------------------------------------------------------------

SELECT
    r.region_name,
    COUNT(o.order_id) AS total_orders
FROM dbo.regions r
LEFT JOIN dbo.orders o
    ON r.region_id = o.region_id
GROUP BY r.region_name
ORDER BY total_orders ASC;

-- Insight:
-- Highlights regions with low or zero activity.


------------------------------------------------------------
-- Step 5: Create dataset for missing relationship monitoring
------------------------------------------------------------

SELECT
    c.customer_id,
    c.customer_name,
    CASE
        WHEN o.order_id IS NULL THEN 'No Orders'
        ELSE 'Active Customer'
    END AS activity_status
INTO customers_activity_status
FROM dbo.customers c
LEFT JOIN dbo.orders o
    ON c.customer_id = o.customer_id;

-- Business Outcome:
-- Enables segmentation of inactive customers for marketing.


------------------------------------------------------------
-- Step 6: Validate dataset results
------------------------------------------------------------

SELECT
    activity_status,
    COUNT(*) AS customer_count
FROM customers_activity_status
GROUP BY activity_status;

-- Validation Insight:
-- Confirms inactive vs active segmentation.


------------------------------------------------------------
-- End of Day 20 Worklog
------------------------------------------------------------
