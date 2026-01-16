CREATE OR REPLACE TABLE curated.dim_products
USING DELTA
AS
SELECT DISTINCT
  product_id,
  sku,
  product_name,
  category,
  brand,
  cost_price,
  list_price
FROM staging.products
WHERE product_id IS NOT NULL;
