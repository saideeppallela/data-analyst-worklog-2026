# Day 86 – Power Query Folder Import, Schema Drift & Audit Validation

> **Learning Focus:** Power Query | Folder Import | Combine Files | Transform Sample File | Audit Validation | Schema Drift Awareness
>
> This project is part of my **120 Days Data Analyst GitHub Worklog**, where I consistently practice real business scenarios to strengthen practical Data Analytics skills and build an interview-ready portfolio.

---

# 📌 Business Problem

Regional offices send monthly transaction files using a common template, but the files are not always consistent. One region may include additional columns, another may change the column order, and occasionally a regional office may fail to upload its monthly file.

The reporting process requires an automated solution that combines all regional files while making missing source files visible before reports are shared with stakeholders.

---

# 🎯 Objective

- To automate the import of multiple regional CSV files using a Folder connection.
- To standardize reusable data transformations using Power Query.
- To validate imported source files through an audit query.
- To simulate a missing regional file and verify the reporting process.

---

# 🏢 Business Scenario

A financial reporting team receives monthly credit card transaction files from North, South, East, and West regional offices.

The business requires a single reporting dataset that automatically includes new monthly files while reducing manual effort. The reporting solution also needs to help analysts identify missing regional uploads before publishing reports.

---

# 📂 Dataset

### Dataset Type

Regional Credit Card Transaction Files (CSV)

### Files Included

- cc_north.csv
- cc_south.csv
- cc_east.csv
- cc_west.csv

### Dataset Highlights

- ~20,000 transaction records
- Folder-based data import
- Inconsistent text formatting
- Extra `branch_code` column in one regional file
- Different column order in one regional file
- Missing file simulation for audit validation

---

# 🛠️ Activities Performed

During this practice project, I built a folder-based Power Query solution to automate the monthly import of regional transaction files.

I imported multiple CSV files using a **Folder** connection and explored how Power Query generates reusable helper queries during the combine process.

I standardized text values by applying reusable transformations inside **Transform Sample File**, ensuring the same cleaning logic could be applied consistently across every regional file.

After combining all regional files into a single dataset, I verified imported sources using the **Source.Name** column and created an audit query to monitor the files included during each refresh.

Finally, I simulated a missing regional file by temporarily removing one CSV and refreshing the report. This helped me understand how simple validation techniques can detect missing source data before reports are shared with stakeholders.

---

# 🔄 Workflow

```text
Regional CSV Files
        │
        ▼
Get Data → Folder
        │
        ▼
Combine & Transform Data
        │
        ▼
Transform Sample File
(Standardized Cleaning)
        │
        ▼
Regional_Files
(Combined Dataset)
        │
        ▼
Audit_Regional_Files
(Group By Source.Name)
        │
        ▼
Validate Missing Regional Files
```

---

# 📸 Project Screenshot

## Audit Query Validation

```markdown
![Audit Query Validation](01_audit_query_validation.png)
```

**Description**

Created an audit query by grouping records using **Source.Name** and counting rows to verify imported regional files. The audit also demonstrated how missing regional files can be identified before publishing business reports.

---

# 💼 Business Outcome

A reusable folder-based import process was built for combining multiple regional transaction files into a single reporting dataset.

The solution reduced manual file imports, standardized data preparation, and introduced an audit process that helped identify missing regional files before reports were published.

---

# 🎓 Key Learning

This project strengthened my understanding of enterprise-style Power Query workflows.

Through hands-on practice, I understood how Folder Import supports scalable data ingestion, how **Transform Sample File** enables reusable transformations, and how the **Source.Name** column can be used to validate imported files.

Building an audit query and simulating a missing regional file also demonstrated the importance of verifying data quality before business reports are delivered.

---

# 📈 Project Summary

This hands-on project focused on building an automated Power Query workflow for combining multiple regional CSV files into a single reporting dataset.

Instead of manually importing individual files, I created a scalable Folder-based solution that automatically detected available files during refresh. I also implemented an audit query to validate imported source files and practiced a real-world missing file scenario to better understand enterprise reporting workflows.

---

# 🛠️ Skills Demonstrated

- Power BI
- Power Query
- Folder Data Source
- Combine Files
- Transform Sample File
- CSV Import
- Data Cleaning
- Text Standardization
- Query Reference
- Group By
- Count Rows
- Audit Query
- Data Validation
- ETL Workflow
- Schema Drift Awareness
- Business Reporting
- Data Quality
- Problem Solving

---

# 📁 Project Structure

```text
day86_powerquery_folder_import_schema_drift_audit/
│
├── README.md
├── day86_powerquery_folder_import_schema_drift_audit.pbix
├── cc_north.csv
├── cc_south.csv
├── cc_east.csv
├── cc_west.csv
└── 01_audit_query_validation.png
```

---

# 📅 120 Days Data Analyst GitHub Worklog

✅ **Progress:** **Day 86 / 120 Completed**

**Current Focus:** Power Query – Folder Import, Schema Drift & Audit Validation

---

# 👨‍💻 About Me

Hi, I'm **Saideep Pallela** — an aspiring **Data Analyst** and MBA (Business Analytics & Data Science) student.

I am building practical skills through real business scenarios in **Microsoft Excel, SQL Server, Power BI, Python, Statistics, and Business Analytics**.

This repository is one step in my journey toward becoming an industry-ready Data Analyst.

---

# 🤝 Connect With Me

### 💼 LinkedIn

https://www.linkedin.com/in/saideeppallela

### 💻 GitHub

https://github.com/saideeppallela

---

⭐ **Thank you for visiting!**

If you found this project helpful or interesting, consider **starring ⭐ this repository**. Your support motivates me to continue learning, building, and sharing practical Data Analytics projects throughout my **120 Days Data Analyst GitHub Worklog**.

---
