CREATE OR REPLACE TABLE curated.fact_competitor_prices
USING DELTA
AS
SELECT
  product_id,
  source                    AS competitor_source,
  CAST(price_date AS DATE)  AS price_date,
  CAST(price AS DECIMAL(18,2)) AS competitor_price,

  current_timestamp() AS load_ts
FROM staging.competitor_prices
WHERE product_id IS NOT NULL
  AND price IS NOT NULL
  AND price >= 0;
