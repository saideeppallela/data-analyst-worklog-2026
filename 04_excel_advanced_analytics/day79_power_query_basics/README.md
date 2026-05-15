# Day 79 — Power Query Basics in Microsoft Excel for Data Analytics | Excel Data Cleaning & Automation Project

## 📌 Project Introduction

As part of my Data Analyst learning journey, I worked on a hands-on Microsoft Excel Power Query project focused on importing, cleaning, transforming, and loading messy business data.

In many real-world companies, analysts receive raw CSV or Excel files containing:
- duplicate records,
- inconsistent text formatting,
- blank values,
- incorrect data types,
- and messy date formats.

Instead of cleaning such data manually every day, I used Power Query in Excel to build a reusable data cleaning workflow that can refresh automatically whenever the source CSV file changes.

This project helped me better understand how Excel automation improves reporting efficiency and reduces repetitive manual work in Data Analytics workflows.

---

# 🎯 Business Problem / Objective

The objective of this project was to simulate a realistic business scenario where a sales dataset arrives in an unclean format.

The dataset intentionally included:
- Duplicate rows
- Mixed region capitalization
- Extra spaces in product names
- Numbers stored as text
- Mixed date formats
- Blank values

The goal was to clean and standardize the dataset using Power Query instead of manual Excel operations.

This project focused on building a repeatable and refreshable Excel data cleaning workflow commonly used in Business Analytics and reporting environments.

---

# 📂 Folder Structure

```text
day79_power_query_basics/

├── dirty_sales.csv
├── power_query_cleaning_workflow.xlsx
├── power_query_final_cleaned_output_with_applied_steps.png
└── README.md
```

---

# 📊 Dataset Overview

The dataset used in this project represents a small sales transaction dataset containing common data quality issues.

### Dataset Columns

| Column Name | Description |
|---|---|
| OrderID | Unique order identifier |
| Product | Product category |
| Region | Sales region |
| OrderDate | Date of order |
| Sales_Amount | Sales value |
| Customer_Name | Customer name |

---

# ⚠️ Data Problems Intentionally Included

| Problem | Example |
|---|---|
| Duplicate Rows | Same orders repeated |
| Mixed Capitalization | NORTH / north / North |
| Extra Spaces | " Laptop " |
| Blank Values | Empty Region rows |
| Mixed Date Formats | DD/MM/YYYY and DD-MMM-YYYY |
| Numbers Stored as Text | "1,25,000" |

---

# 🛠 Step-by-Step Power Query Workflow

## Step 1 — Import CSV into Power Query
- Opened CSV using:
  - DATA → Get Data → From Text/CSV
- Loaded dataset into Power Query Editor

---

## Step 2 — Remove Duplicate Rows
- Used:
  - Home → Remove Rows → Remove Duplicates
- Removed repeated transaction records

---

## Step 3 — Standardize Region Values
- Converted:
  - NORTH
  - north
  - North
- Into one consistent format:
  - North

Used:
- Transform → Format → Capitalize Each Word

---

## Step 4 — Clean Product Column
Removed:
- Extra spaces
- Hidden characters

Used:
- Transform → Format → Trim
- Transform → Format → Clean

---

## Step 5 — Convert Sales Amount to Numeric
The sales values were stored as text with commas.

Example:
- "1,25,000"

Actions performed:
- Replaced commas
- Changed column type to Whole Number

---

## Step 6 — Standardize Date Format
The dataset contained mixed date formats.

Used:
- Transform → Data Type → Using Locale

Converted all dates into a consistent Excel Date format.

---

## Step 7 — Remove Blank Region Rows
Filtered out incomplete records using column filters.

---

## Step 8 — Load Cleaned Data into Excel
Used:
- Close & Load

Loaded the transformed dataset back into Excel for reporting and future analysis.

---

# 📸 Project Screenshots

## Final Power Query Workflow Screenshot

![Power Query Workflow](04_power_query_final_cleaned_output_with_applied_steps.png)

This screenshot shows:
- Final cleaned dataset
- Applied Steps panel
- Power Query transformations
- Automated workflow structure

---

# ⚙️ Microsoft Excel Features Used

| Feature | Purpose |
|---|---|
| Power Query | Data import and transformation |
| Remove Duplicates | Remove repeated records |
| Text Transformations | Standardize text formatting |
| Data Type Conversion | Convert text to numbers/dates |
| Filters | Remove blank values |
| Query Refresh | Automate repeated cleaning |

---

# 🧠 Key Learning Outcomes

Through this project, I learned:

- How Power Query automates repetitive Excel tasks
- Importance of proper data cleaning in analytics workflows
- Why analysts standardize text and date formats
- How Applied Steps create reusable workflows
- Difference between manual cleaning and refresh-based automation
- Practical Excel automation concepts used in reporting environments

---

# 🚧 Challenges Faced During Learning

While working on this project, I faced several beginner-level challenges:

- Understanding Power Query interface
- Identifying incorrect data types
- Handling mixed date formats
- Understanding how Applied Steps work
- Learning the difference between manual cleaning and automated transformations

Solving these issues improved my understanding of real-world Excel data preparation workflows.

---

# 📈 Skills Improved Through This Project

| Skill Area | Improvement |
|---|---|
| Excel Data Cleaning | Improved |
| Power Query Workflow Building | Improved |
| Data Transformation | Improved |
| Business Data Understanding | Improved |
| Data Preparation for Reporting | Improved |
| Excel Automation Thinking | Improved |

---

# ⚡ Manual Cleaning vs Power Query

| Method | Approximate Time |
|---|---|
| Manual Excel Cleaning | ~30 minutes daily |
| Power Query Workflow | 1-click refresh |

This project helped me understand why Power Query is heavily used in Business Analytics and reporting teams.

---

# 🔍 Real-World Analyst Relevance

In many organizations, analysts regularly work with:
- CSV exports
- ERP reports
- CRM system files
- operational business data

Power Query helps convert raw messy datasets into structured and analysis-ready formats.

This project helped me practice a realistic Excel Data Analytics workflow instead of only learning theoretical concepts.

---

# 🚀 Future Improvements

As I continue improving my Excel and Data Analytics skills, I plan to extend this project by:
- Building Pivot Table summaries
- Creating KPI dashboards
- Adding Excel charts and visualizations
- Connecting multiple CSV files
- Automating larger reporting workflows

---

# 💼 Recruiter-Focused Conclusion

This project represents my ongoing effort to build practical Microsoft Excel for Data Analytics skills through hands-on learning.

Instead of only watching tutorials, I am trying to:
- work on realistic datasets,
- understand business data problems,
- and build structured Excel workflows step-by-step.

My goal is to gradually become job-ready for Data Analyst roles through consistent practice and project-based learning.

---

# 🔗 Connect With Me

## GitHub
https://github.com/saideeppallela/data-analyst-worklog-2026


# 🔍 SEO Keywords

Microsoft Excel for Data Analytics,  
Excel Data Analysis Project,  
Excel Dashboard,  
Advanced Excel,  
Excel for Business Analytics,  
Excel Data Cleaning,  
Excel Pivot Tables,  
Excel Charts,  
Excel Formulas,  
Excel KPI Dashboard,  
Excel Analytics Portfolio,  
Aspiring Data Analyst,  
Data Analyst Portfolio,  
Excel Reporting,  
Excel Visualization,  
Business Analytics,  
Data Cleaning in Excel,  
Excel Learning Project,  
GitHub Data Analytics Portfolio,  
Real-world Excel Projects
