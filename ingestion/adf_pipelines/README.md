# Azure Data Factory – Ingestion Pipelines

This folder documents the Azure Data Factory (ADF) pipelines used to ingest
source data into the **Raw (Bronze) layer** of Azure Data Lake Storage Gen2.

The ingestion layer is responsible only for **data movement**, not business
logic. All transformations and modeling are handled downstream.

---

## 📌 Ingestion Architecture Overview

- Tool: Azure Data Factory (ADF)
- Target Storage: Azure Data Lake Storage Gen2
- Layer: Bronze / Raw
- Data is stored **immutably** for audit, replay, and reprocessing

---

## 🔄 Pipelines Implemented

### 1️⃣ API → ADLS Gen2 (Raw)

**Purpose**  
Ingest e-commerce data from a REST API into the raw data lake.

**Details**
- Source: REST API (Fake Store API)
- Sink: ADLS Gen2 (Raw/Bronze)
- File format: JSON
- Load pattern: Full extract (append-only)

**Key Features**
- Parameterized pipeline (file path, date)
- Date-based partitioning (e.g., `ingest_date=YYYY-MM-DD`)
- Raw data preserved exactly as received
- No schema enforcement or business logic at this stage

📷 Screenshot: `pipeline_screenshots/api_to_adls_raw.png`

---

### 2️⃣ Orders & Order Items → ADLS Gen2 (Raw)

**Purpose**  
Ingest transactional order and order item data into the raw layer.

**Details**
- Source: Transactional system (orders, order_items)
- Sink: ADLS Gen2 (Raw/Bronze)
- File format: Parquet / CSV
- Load pattern: Incremental / batch

**Key Features**
- Parameterized source and sink paths
- Incremental ingestion by date
- Schema preserved as source-of-truth
- Supports downstream reprocessing

📷 Screenshot: `pipeline_screenshots/orders_to_adls_raw.png`

---

## 🧠 Design Principles

- Raw layer acts as a **system of record**
- No joins, aggregations, or revenue logic applied
- Pipelines are reusable and parameter-driven
- Supports reprocessing into Silver and Gold layers

---

## 🔗 Downstream Flow

Data ingested by these pipelines is transformed in:
- **Databricks (Spark SQL)** → Silver (Staging)
- **Databricks / Synapse** → Gold (Curated)

Fact and dimension tables are built downstream for analytics consumption.

---

## ✅ Why This Matters

This ingestion design mirrors real-world enterprise data platforms by:
- Separating ingestion from transformation
- Preserving raw data for auditability
- Enabling scalable, repeatable pipelines
