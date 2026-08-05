# Day 88 – Building a Reusable Power Query Pipeline Using Parameters

> **Learning Focus:** Power Query Parameters | Reusable ETL Pipeline | Dynamic Filtering | Enterprise Power BI Development | Scalable Reporting

This project is part of my **120 Days Data Analyst GitHub Worklog**, where I consistently practice solving realistic business problems to strengthen practical Data Analytics skills.

Today's project focused on building a **reusable Power Query pipeline** using **Parameters**, allowing the same transformation logic to serve multiple regional managers without maintaining separate Power BI reports. The objective was to understand how enterprise BI teams design scalable and maintainable ETL processes.

---

# 📌 Business Problem

A company has five regional managers (North, South, East, West, and Central), each requiring the same cleaned transaction report filtered for their respective region.

Maintaining five separate Power BI reports creates unnecessary maintenance effort because every future change to the data preparation logic must be repeated across all reports.

The business requires a reusable solution that applies identical transformation logic while dynamically filtering data for different regions.

---

# 🎯 Objective

- To build one reusable Power Query pipeline.
- To eliminate hardcoded region filters.
- To use Power Query Parameters for dynamic filtering.
- To understand how scalable ETL pipelines are implemented in enterprise BI projects.

---

# 🏢 Business Scenario

A national bank provides transaction reports to multiple regional managers.

Each manager requires the same report structure, business rules, and data cleansing process. The only difference is the region being analyzed.

Instead of maintaining multiple Power BI files, a single reusable pipeline dynamically filters the required region through a Power Query Parameter, improving maintainability and reducing duplicate development effort.

---

# 📂 Dataset

### Dataset Type

Bank Transaction Dataset (Practice Dataset)

### Files

- day88_transactions_parameter_practice.xlsx

### Total Records

Approximately **5,000+ transaction records**

### Dataset Highlights

- Multiple business regions
- Transaction information
- Customer information
- Card categories
- Expense categories
- Approval status
- Mixed data quality issues
- Duplicate records
- Blank values
- Inconsistent region formatting
- Mixed date formats for future practice

---

# 🛠️ Activities Performed

The project began by importing the transaction dataset into Power Query to inspect its overall data quality before loading it into the data model.

The Region column was standardized by removing unnecessary spaces and normalizing text formatting to ensure consistent business values across the dataset.

A reusable **Power Query Parameter** named **RegionParameter** was created with predefined regional values. Instead of applying a fixed region filter, the parameter was integrated directly into the M query so that the filtering logic became dynamic.

The pipeline was validated by changing the parameter value from **North** to **South** without modifying any transformation logic. The same query successfully returned different regional datasets, demonstrating how one ETL pipeline can support multiple reporting requirements.

This approach reflected how enterprise BI teams reduce maintenance effort while improving scalability.

---

# 🔄 Workflow

```text
Business Requirement
        │
        ▼
Import Dataset
        │
        ▼
Inspect Data Quality
        │
        ▼
Clean Region Values
        │
        ▼
Create Region Parameter
        │
        ▼
Apply Parameter in M Query
        │
        ▼
Dynamic Region Filtering
        │
        ▼
Validate Pipeline Reusability
        │
        ▼
Reusable Enterprise Power Query Solution
```

---

# 📸 Project Screenshots

## 1️⃣ Parameterized Region Filter

**Filename**

```text
01_parameterized_region_filter.png
```

```markdown
![Parameterized Region Filter](01_parameterized_region_filter.png)
```

This screenshot showed the reusable Power Query pipeline filtering transaction data using the **North** region parameter.

---

## 2️⃣ Parameter Validation

**Filename**

```text
02_parameter_changed_to_south.png
```

```markdown
![Parameter Validation](02_parameter_changed_to_south.png)
```

This screenshot demonstrated that changing only the parameter value automatically refreshed the query to display **South** region transactions without modifying any transformation logic.

---

# 💼 Business Outcome

A single reusable Power Query pipeline was successfully created to support multiple regional reporting requirements.

The solution eliminated hardcoded filters and demonstrated how parameter-driven ETL processes reduce maintenance effort while improving scalability and consistency across reports.

---

# 🎓 Key Learning

- Understood the business purpose of Power Query Parameters.
- Built a reusable ETL pipeline instead of multiple report versions.
- Connected business requirements with scalable Power BI development.
- Applied parameter-driven filtering through M Query.
- Validated dynamic filtering without changing transformation logic.
- Practiced enterprise-style Power Query development.

---

# 📈 Project Summary

This project demonstrated how Power Query Parameters can transform a fixed ETL process into a reusable enterprise solution. Instead of maintaining separate Power BI files for different business users, a single parameterized pipeline dynamically filtered transaction data for different regions, improving maintainability and scalability.

---

# 🛠️ Skills Demonstrated

- Power BI
- Power Query
- Power Query Parameters
- ETL
- Data Cleaning
- Data Transformation
- M Query
- Dynamic Filtering
- Reusable Pipeline Design
- Business Problem Solving

---

# 📁 Project Structure

```text
day88_reusable_regional_pipeline/
│
├── README.md
├── Day88_Reusable_Regional_Report_Parameters.pbix
├── day88_transactions_parameter_practice.xlsx
├── 01_parameterized_region_filter.png
└── 02_parameter_changed_to_south.png
```

---

# 📅 120 Days Data Analyst GitHub Worklog

**Progress**

Day 88 / 120 Completed ✅

**Current Focus**

Enterprise Power Query Development and Reusable ETL Pipeline Design

---

# 👨‍💻 About Me

I am currently pursuing an **MBA in Business Analytics & Data Science** and preparing for a Data Analyst career by building practical portfolio projects based on real business scenarios.

My learning journey focuses on:

- Microsoft Excel
- SQL Server
- Power BI
- Python
- Statistics
- Business Analytics

Each project strengthens practical problem-solving skills while preparing for Data Analyst interviews.

---

# 🤝 Connect With Me

**LinkedIn**

https://www.linkedin.com/in/saideep-pallela

**GitHub**

https://github.com/saideeppallela

---

# ⭐ Thank You

Thank you for visiting my project.

If you found this repository helpful, please consider giving it a ⭐ to support my learning journey and help others discover these practical Data Analytics projects.
