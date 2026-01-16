# Data Ingestion (Bronze Layer)

This folder represents the ingestion layer of the data pipeline.
It focuses on moving data from source systems into Azure Data Lake Storage
Gen2 without applying any business logic.

## Responsibilities
- Extract data from APIs and transactional systems
- Load data into the Raw (Bronze) layer
- Preserve source data immutably for audit and replay

## Tools Used
- Azure Data Factory (ADF)
