-- ============================================================
-- File: modeling/fact_sales.sql
-- Table: curated.fact_sales
--
-- Purpose:
--   Build an analytics-ready sales fact table at ORDER-ITEM grain.
--   This table standardizes revenue logic for downstream reporting.
--
-- Grain:
--   1 row per order_item_id (line item)
--
-- Inputs (Staging/Silver):
--   staging.orders
--   staging.order_items
--
-- Revenue Logic:
--   gross_sales_amount = quantity * unit_price
--   discount_amount    = COALESCE(discount_price, 0)
--   net_sales_amount   = gross_sales_amount - discount_amount
--
-- Quality Filters:
--   - non-null keys
--   - quantity > 0
--   - unit_price >= 0
--   - discount_price >= 0
--
-- Platform:
--   Databricks / Spark SQL (Delta)
-- ============================================================

CREATE OR REPLACE TABLE curated.fact_sales
USING DELTA
AS
SELECT
  oi.order_item_id,
  oi.order_id,
  CAST(o.order_date AS DATE)           AS order_date,
  o.status                             AS order_status,
  o.customer_id,
  oi.product_id,
  CAST(oi.quantity AS INT)             AS quantity,
  CAST(oi.unit_price AS DECIMAL(18,2)) AS unit_price,
  CAST(oi.quantity * oi.unit_price AS DECIMAL(18,2)) AS gross_sales_amount,

  CAST(COALESCE(oi.discount_price, 0) AS DECIMAL(18,2)) AS discount_amount,

  CAST(
    (oi.quantity * oi.unit_price) - COALESCE(oi.discount_price, 0)
    AS DECIMAL(18,2)
  ) AS net_sales_amount,
  current_timestamp() AS load_ts

FROM staging.order_items oi
JOIN staging.orders o
  ON oi.order_id = o.order_id

WHERE
  oi.order_item_id IS NOT NULL
  AND oi.order_id IS NOT NULL
  AND oi.product_id IS NOT NULL
  AND o.customer_id IS NOT NULL
  AND oi.quantity > 0
  AND oi.unit_price >= 0
  AND COALESCE(oi.discount_price, 0) >= 0
;
