CREATE OR REPLACE TABLE curated.dim_promotion
USING DELTA
AS
SELECT DISTINCT
  promo_id,
  promo_name,
  discount_type,
  discount_value,
  start_date,
  end_date
FROM staging.promotions
WHERE promo_id IS NOT NULL;
