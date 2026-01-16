# Spark SQL Scripts

This folder contains Spark SQL scripts used to build
curated fact and dimension tables.
Note: The SQL scripts in this folder represent the logic executed in Databricks to produce curated Delta tables.


These scripts:
- Define table schemas
- Apply business logic
- Enforce analytical grain
- Produce Delta tables for BI consumption

Example outputs:

- `curated.fact_orders`
- `curated.fact_competitor_prices`
- `curated.dim_customers`
- `curated.dim_products`
- `curated.dim_promotion`
