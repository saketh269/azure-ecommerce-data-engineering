CREATE OR REPLACE TABLE curated.dim_customers
USING DELTA
AS
SELECT DISTINCT
  customer_id,
  customer_name,
  email,
  city,
  state
FROM staging.customers
WHERE customer_id IS NOT NULL;
