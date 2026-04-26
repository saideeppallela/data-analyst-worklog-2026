-- Q1: Find 2nd highest salary
SELECT MAX(salary)
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);

-- Q2: Find 3rd highest salary
SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
OFFSET 2 ROWS FETCH NEXT 1 ROW ONLY;

-- Q3: Find duplicate employee names
SELECT emp_name, COUNT(*)
FROM employees
GROUP BY emp_name
HAVING COUNT(*) > 1;

-- Q4: Find employees with same salary
SELECT a.emp_name, b.emp_name, a.salary
FROM employees a
JOIN employees b
ON a.salary = b.salary AND a.emp_id <> b.emp_id;

-- Q5: Running total of orders
SELECT order_id,
       SUM(amount) OVER (ORDER BY order_date) AS running_total
FROM orders;

-- Q6: Monthly sales
SELECT MONTH(order_date) AS month, SUM(amount)
FROM orders
GROUP BY MONTH(order_date);

-- Q7: Month-over-Month growth
WITH m AS (
 SELECT MONTH(order_date) m, SUM(amount) total
 FROM orders GROUP BY MONTH(order_date)
)
SELECT m, total,
       LAG(total) OVER (ORDER BY m) prev,
       (total - LAG(total) OVER (ORDER BY m))*1.0 /
       NULLIF(LAG(total) OVER (ORDER BY m),0) mom_growth
FROM m;

-- Q8: Top 2 salaries per department
SELECT *
FROM (
 SELECT *, RANK() OVER (PARTITION BY department ORDER BY salary DESC) rnk
 FROM employees
) t WHERE rnk <= 2;

-- Q9: Max salary per dept
SELECT department, MAX(salary)
FROM employees GROUP BY department;

-- Q10: Min salary per dept
SELECT department, MIN(salary)
FROM employees GROUP BY department;

-- Q11: Avg salary
SELECT AVG(salary) FROM employees;

-- Q12: Employees above avg salary
SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Q13: Count employees per dept
SELECT department, COUNT(*) FROM employees GROUP BY department;

-- Q14: Count orders per customer
SELECT customer_id, COUNT(*) FROM orders GROUP BY customer_id;

-- Q15: Total sales
SELECT SUM(amount) FROM orders;

-- Q16: Latest order per customer
SELECT customer_id, MAX(order_date)
FROM orders GROUP BY customer_id;

-- Q17: First order per customer
SELECT *
FROM (
 SELECT *, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) rn
 FROM orders
) t WHERE rn = 1;

-- Q18: Last order per customer
SELECT *
FROM (
 SELECT *, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) rn
 FROM orders
) t WHERE rn = 1;

-- Q19: Rank employees
SELECT emp_name, RANK() OVER (ORDER BY salary DESC)
FROM employees;

-- Q20: Dense rank employees
SELECT emp_name, DENSE_RANK() OVER (ORDER BY salary DESC)
FROM employees;

-- Q21: Row number
SELECT emp_name, ROW_NUMBER() OVER (ORDER BY salary DESC)
FROM employees;

-- Q22: Customers in Jan not Feb
SELECT DISTINCT customer_id
FROM orders
WHERE MONTH(order_date)=1
AND customer_id NOT IN (
 SELECT customer_id FROM orders WHERE MONTH(order_date)=2
);

-- Q23: Orders above average amount
SELECT *
FROM orders
WHERE amount > (SELECT AVG(amount) FROM orders);

-- Q24: Orders in last 30 days
SELECT *
FROM orders
WHERE order_date >= DATEADD(DAY,-30,GETDATE());

-- Q25: Employees in same department
SELECT a.emp_name, b.emp_name, a.department
FROM employees a
JOIN employees b
ON a.department = b.department AND a.emp_id <> b.emp_id;
GO

