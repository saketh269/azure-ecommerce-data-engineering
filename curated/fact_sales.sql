CREATE OR REPLACE TABLE curated.fact_sales
USING DELTA
AS
SELECT
  oi.order_item_id,
  oi.order_id,
  CAST(o.order_date AS DATE) AS order_date,
  o.status                   AS order_status,
  o.customer_id,
  oi.product_id,
  oi.quantity,
  oi.unit_price,

  CAST(oi.quantity * oi.unit_price AS DECIMAL(18,2)) AS gross_sales_amount,

  CAST(COALESCE(oi.discount_price, 0) AS DECIMAL(18,2)) AS discount_amount,

  CAST(
    (oi.quantity * oi.unit_price) - COALESCE(oi.discount_price, 0)
    AS DECIMAL(18,2)
  ) AS net_sales_amount

FROM staging.order_items oi
JOIN staging.orders o
  ON oi.order_id = o.order_id
WHERE oi.order_item_id IS NOT NULL
  AND oi.quantity > 0
  AND oi.unit_price >= 0;
