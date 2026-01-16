# Data Transformations (Silver → Gold)

This folder documents the transformation layer of the data pipeline.
Transformations convert raw ingested data into **cleaned, standardized,
and analytics-ready datasets** using Databricks and Spark SQL.

This layer implements the **Silver (Staging)** and **Gold (Curated)**
transformations following the medallion architecture.

---

## 🔄 Transformation Responsibilities

- Schema enforcement and data type standardization
- Column pruning and renaming
- Data quality filtering (nulls, invalid values)
- Business logic application
- Preparation of fact and dimension tables

---

## 🛠️ Tools Used

- Databricks
- Apache Spark (Spark SQL)
- Delta Lake

---

## 🥈 Silver Layer (Staging)

The Silver layer represents **cleaned and validated data** that is still
largely normalized.

### Typical Transformations
- Casting timestamps to dates
- Removing duplicate records
- Handling null and invalid values
- Standardizing column names
- Preserving business keys

Example tables:
- `staging.orders`
- `staging.order_items`
- `staging.customers`
- `staging.products`

---

## 🥇 Gold Layer (Curated)

The Gold layer contains **analytics-ready datasets**, optimized for BI and
reporting.

### Typical Transformations
- Joining staging tables
- Applying revenue and discount logic
- Creating fact and dimension tables
- Optimizing for analytical query patterns

Example tables:
- `curated.fact_sales`
- `curated.dim_customer`
- `curated.dim_product`

---

## 📁 Folder Breakdown

- `databricks_notebooks/`  
  Contains Databricks notebooks used for transformation logic and orchestration.

- `spark_sql/`  
  Contains Spark SQL scripts used to create curated fact and dimension tables.

---

## 🔗 Downstream Consumption

The curated datasets produced in this layer are consumed by:
- Azure Synapse Analytics
- Power BI dashboards
- Ad-hoc analytical queries

---

## ✅ Why This Layer Matters

This transformation layer:
- Centralizes business logic
- Improves data reliability
- Simplifies downstream analytics
- Enables consistent KPI definitions
