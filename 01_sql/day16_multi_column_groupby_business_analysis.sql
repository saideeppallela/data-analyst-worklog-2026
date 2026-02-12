/*
Day 16 Summary:
Problem:
Single-column GROUP BY often fails to provide deeper business insights.
Real business analytics usually requires grouping across multiple dimensions.

Business Scenario:
Companies frequently analyze performance across combinations like:
City + Customer Segment, Product + Region, or Channel + Time.

Approach:
Used multi-column GROUP BY to analyze data across business dimensions.
Applied aggregate functions to calculate meaningful KPIs.
Validated grouped outputs for reporting readiness.

Risk If Ignored:
• Oversimplified business insights
• Incorrect segmentation decisions
• Hidden performance trends
• Poor strategic targeting

Key Validation Check:
Verified grouped data totals match base dataset.

Result:
Created multi-dimensional KPI dataset for business reporting.

Next Step:
Apply HAVING clause for filtered aggregated insights.
*/

USE analyst_practice;
GO


------------------------------------------------------------
-- Step 1: Analyze customer distribution by City & Gender
------------------------------------------------------------

SELECT
    city,
    gender,
    COUNT(*) AS customer_count
FROM dbo.customers
GROUP BY city, gender
ORDER BY city, gender;

-- Business Insight:
-- Helps understand customer composition across demographics.


------------------------------------------------------------
-- Step 2: Sales performance by City & Product Category
------------------------------------------------------------

SELECT
    city,
    product_category,
    SUM(sales_amount) AS total_sales,
    AVG(sales_amount) AS avg_sales
FROM dbo.sales
GROUP BY city, product_category
ORDER BY total_sales DESC;

-- Business Insight:
-- Identifies high-performing product categories per location.


------------------------------------------------------------
-- Step 3: Customer activity by Signup Year & City
------------------------------------------------------------

SELECT
    YEAR(signup_date) AS signup_year,
    city,
    COUNT(*) AS new_customers
FROM dbo.customers
GROUP BY YEAR(signup_date), city
ORDER BY signup_year, new_customers DESC;

-- Business Insight:
-- Tracks regional growth trends over time.


------------------------------------------------------------
-- Step 4: Revenue contribution by Segment & Payment Mode
------------------------------------------------------------

SELECT
    customer_segment,
    payment_mode,
    SUM(order_value) AS total_revenue
FROM dbo.orders
GROUP BY customer_segment, payment_mode
ORDER BY total_revenue DESC;

-- Business Insight:
-- Helps optimize marketing and payment strategy.


------------------------------------------------------------
-- Step 5: Create aggregated business performance dataset
------------------------------------------------------------

SELECT
    city,
    customer_segment,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(order_value) AS revenue_generated,
    AVG(order_value) AS avg_order_value
INTO multi_dimension_kpi_summary
FROM dbo.orders
GROUP BY city, customer_segment;

-- Business Outcome:
-- Prepared dataset ready for dashboard analytics.


------------------------------------------------------------
-- Step 6: Validate aggregated dataset
------------------------------------------------------------

SELECT
    COUNT(*) AS total_groups,
    SUM(total_customers) AS total_customers_aggregated,
    SUM(revenue_generated) AS total_revenue
FROM multi_dimension_kpi_summary;

-- Validation Insight:
-- Ensures aggregated dataset integrity.


------------------------------------------------------------
-- End of Day 16 Worklog
------------------------------------------------------------
