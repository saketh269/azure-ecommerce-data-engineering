# Data Modeling (Curated / Gold Layer)

This folder contains SQL scripts used to build analytics-ready
fact and dimension tables in the curated (Gold) layer.

The curated layer applies business logic and follows
dimensional modeling principles (star schema).

## Fact Tables
- `fact_orders` – Core sales and revenue analytics at order-item grain
- - `fact_sales` – Core sales and revenue analytics at order-item grain
  - - `fact_promotions` – Core sales and revenue analytics at order-item grain

## Dimension Tables
- `dim_customers`
- `dim_products`
- `dim_promotion`

## Design Principles
- Clear grain definition
- Conformed dimensions
- Optimized for analytical queries
- Delta Lake storage format
