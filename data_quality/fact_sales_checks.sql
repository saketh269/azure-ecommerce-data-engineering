-- ============================================================
-- File: data_quality/fact_sales_checks.sql
-- Purpose: Basic validation checks for curated.fact_sales
-- ============================================================

SELECT order_item_id, COUNT(*) AS cnt
FROM curated.fact_sales
GROUP BY order_item_id
HAVING COUNT(*) > 1;
SELECT *
FROM curated.fact_sales
WHERE order_item_id IS NULL
   OR order_id IS NULL
   OR product_id IS NULL
   OR customer_id IS NULL;
SELECT *
FROM curated.fact_sales
WHERE quantity <= 0
   OR unit_price < 0
   OR discount_amount < 0
   OR gross_sales_amount < 0
   OR net_sales_amount < 0;
SELECT *
FROM curated.fact_sales
WHERE net_sales_amount <> (gross_sales_amount - discount_amount);
