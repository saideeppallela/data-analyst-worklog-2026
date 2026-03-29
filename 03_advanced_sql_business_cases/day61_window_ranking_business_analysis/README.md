# 📊 SQL Ranking Customers by Revenue Using Window Functions (ROW_NUMBER vs RANK vs DENSE_RANK)

---

## 🚀 Business Scenario

In this project, I am trying to understand how companies identify their top customers across different regions.

I observed that businesses often need to:
- Find highest revenue customers
- Compare performance within regions
- Handle ties in rankings properly

So I practiced solving this using SQL window functions.

---

## 🧩 Dataset Overview

I created a simple dataset to simulate real business sales data.

**Table Name:** `sales_data`

| Column Name     | Description                          |
|-----------------|--------------------------------------|
| order_id        | Unique order identifier              |
| region          | Sales region (South, North, West)    |
| customer_name   | Name of the customer                 |
| revenue         | Revenue generated from the order     |

---

## 📸 Dataset Preview

![Dataset Preview](day61_query_execution.png)

---

## 🎯 Analysis Objective

In this project, I tried to answer:

- How to rank customers within each region?
- How different ranking functions behave when revenue is the same?
- Which ranking function should be used in different scenarios?

---

## 🔍 Step-by-Step Analysis Process

1. I first created the database and table  
2. Inserted sample sales data  
3. Aggregated total revenue per customer  
4. Used window functions to rank customers within each region  
5. Compared results of:
   - ROW_NUMBER()
   - RANK()
   - DENSE_RANK()

---

## 🧠 SQL Concepts I Practiced

- SQL window functions  
- PARTITION BY  
- ORDER BY in window functions  
- ROW_NUMBER()  
- RANK()  
- DENSE_RANK()  
- CTE (Common Table Expression)  
- Aggregation using SUM()  

---

## 💡 Query Logic Explanation

I tried to break the problem into two steps:

**Step 1: Calculate total revenue per customer**
- I grouped data by region and customer
- Then used SUM(revenue)

**Step 2: Apply ranking**
- I used PARTITION BY region to rank inside each region
- Then sorted by revenue in descending order

This helped me clearly see how rankings change when values are tied.

---

## 📊 Analysis Output

![Output](day61_output_result.png)

---

## 📈 What I Observed

- ROW_NUMBER() always gives unique ranks (even if revenue is same)
- RANK() gives same rank but skips numbers after ties
- DENSE_RANK() gives same rank and does NOT skip numbers

This helped me realize that:
👉 Choosing the right ranking function depends on the business use case

---

## 🏢 Where This Is Used in Real Companies

From what I understood, this type of logic is used in:

- Identifying top customers per region
- Sales performance dashboards
- Leaderboards (top performers)
- Customer segmentation
- Revenue analysis reports

---

## 🧠 Skills I Practiced

- Writing structured SQL queries  
- Solving SQL interview questions  
- Understanding ranking logic  
- Business thinking with data  
- Breaking problems into steps  

---

## 🛠 Tools Used

- Microsoft SQL Server  
- SQL Server Management Studio (SSMS)  

---

## 📂 Project Files

- `day61_database_table_setup.sql`  
- `day61_question_solution_window_ranking.sql`  
- `day61_query_execution.png`  
- `day61_output_result.png`  

---

## 🧠 My Learning Reflection

In this project, I am learning how to think like a data analyst.

I tried to:
- Understand the business problem first  
- Then write SQL step by step  
- Compare different approaches  

This practice helped me feel more confident with SQL window functions.

I also realized that small differences in SQL logic can change business results.

---

## 🔍 SEO Keywords

SQL interview questions  
SQL portfolio project  
SQL window functions  
Top N per group SQL  
ROW_NUMBER vs RANK vs DENSE_RANK  
Data analyst SQL project  
SQL ranking functions example  
SQL Server practice project  
