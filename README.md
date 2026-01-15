# Azure E-Commerce Data Engineering Project

## End-to-End Azure Data Engineering Pipeline for Revenue Analytics

---

## 📌 Problem Statement
E-commerce data is generated from multiple sources such as APIs and transactional systems, often arriving in raw, inconsistent, and semi-structured formats. Business teams require **accurate and trustworthy revenue metrics** that correctly account for promotions, discounts, partial returns, and order lifecycle changes (shipped vs returned).  
Without a standardized data pipeline, revenue reporting becomes unreliable and difficult to scale.

---

## 🎯 Solution Overview
This project implements an **end-to-end Azure-based data engineering pipeline** that ingests, transforms, and models e-commerce data into analytics-ready datasets using a **medallion architecture (Bronze, Silver, Gold)**.

Key outcomes:
- Centralized ingestion of API and transactional data
- Standardized transformations and schema enforcement
- Revenue correction logic incorporating promotions and returns
- Analytics-ready fact and dimension tables for BI consumption

---

## 🏗️ Architecture
**Medallion Architecture**
- **Bronze (Raw):** Immutable source data from APIs and transactional systems
- **Silver (Staging):** Cleaned, typed, and validated datasets
- **Gold (Curated):** Analytics-ready fact and dimension tables

> Tools Used:
- Azure Data Factory (ADF)
- Azure Data Lake Storage Gen2
- Databricks (Spark SQL)
- Azure Synapse Analytics
- Power BI (optional for visualization)

---

## 🔄 Data Ingestion
- Implemented parameterized ingestion pipelines using **Azure Data Factory**
- Ingested API-based e-commerce data into ADLS Gen2
- Applied date-based partitioning for traceability and incremental loads
- Ensured raw data immutability for audit and replay purposes

---

## 🔧 Data Transformation
- Performed transformations using **Databricks and Spark SQL**
- Applied schema enforcement and data type standardization
- Removed unnecessary columns and handled null values
- Implemented business rules for revenue calculation

---

## ⭐ Data Modeling
### Fact Table: `fact_sales`
- **Grain:** One row per `order_item`
- **Measures:**
  - Gross Sales
  - Discount Amount
  - Net Sales
  - Returned Amount
- **Logic:**
  - Revenue adjusted based on returns and order status
  - Promotions correctly applied at the line-item level

### Dimension Tables
- `dim_customer`
- `dim_product`
- `dim_date`

This design enables fast, consistent analytical queries without requiring analysts to join raw tables.

---

## 🧪 Data Quality & Validation
Implemented validation checks to ensure data accuracy:
- Detection of duplicate order items
- Validation of negative or null revenue values
- Referential integrity checks between fact and dimension tables

---

## 📊 Results & Impact
- ✅ Improved revenue accuracy by **~5–7%** by accounting for returns and discounts
- ✅ Created a single source of truth for sales and revenue metrics
- ✅ Enabled MoM and YoY revenue analysis
- ✅ Reduced analytical query complexity for downstream BI users

---

## 🚀 Business Use Cases Enabled
- Revenue and profitability reporting
- Promotion effectiveness analysis
- Return impact analysis
- Executive and operational dashboards

---

## 📁 Repository Structure
azure-ecommerce-data-engineering/
│
├── architecture/
├── ingestion/
├── transformations/
├── modeling/
├── data_quality/
├── analytics/
└── results/

## ▶️ How to Run This Project
1. Ingest source data using Azure Data Factory pipelines
2. Execute Databricks notebooks to transform data from Bronze → Silver → Gold
3. Query curated tables using Azure Synapse or SQL
4. (Optional) Connect Power BI to curated tables for reporting

## ⚠️ Assumptions & Limitations
- Source data represents a simulated e-commerce environment
- Late-arriving returns are handled during scheduled pipeline refreshes
- Project focuses on batch processing rather than real-time streaming


  E --> Q[Data Quality Checks<br/>Duplicates, nulls, RI]
  G --> Q
  B --> M[Monitoring / Logs]
  D --> M

