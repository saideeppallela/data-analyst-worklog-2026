IF DB_ID('interview_practice_db') IS NULL
    CREATE DATABASE interview_practice_db;
GO

USE interview_practice_db;
GO

IF OBJECT_ID('employees','U') IS NOT NULL DROP TABLE employees;
IF OBJECT_ID('orders','U') IS NOT NULL DROP TABLE orders;
GO

CREATE TABLE employees (
    emp_id INT,
    emp_name VARCHAR(50),
    salary INT,
    department VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    amount INT
);

INSERT INTO employees VALUES
(1,'Amit',50000,'IT'),
(2,'Ravi',70000,'IT'),
(3,'Sneha',60000,'HR'),
(4,'Kiran',70000,'HR'),
(5,'John',80000,'IT');

INSERT INTO orders VALUES
(1,101,'2024-01-01',1000),
(2,101,'2024-02-01',2000),
(3,102,'2024-01-15',1500),
(4,103,'2024-02-20',2500),
(5,104,'2024-03-10',3000);
GO

