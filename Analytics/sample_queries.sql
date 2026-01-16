-- ============================================================
-- File: analytics/sample_queries.sql
-- Purpose:
--   Example analytical queries executed on curated (Gold)
--   tables to support reporting and business insights.
--=============================================================
-- Audience:
--   Data Analysts, BI Developers, Business Stakeholders
--=============================================================
-- Tables Used:
--   curated.fact_sales
--   curated.dim_customer
--   curated.dim_product
-- ============================================================
-- 1. Total Revenue (Overall)
-- ============================================================
SELECT
  SUM(net_sales_amount) AS total_revenue
FROM curated.fact_sales;


-- ============================================================
-- 2. Revenue by Day
-- ============================================================
SELECT
  order_date,
  SUM(net_sales_amount) AS daily_revenue
FROM curated.fact_sales
GROUP BY order_date
ORDER BY order_date;


-- ============================================================
-- 3. Revenue by Product
-- ============================================================
SELECT
  p.product_name,
  SUM(f.net_sales_amount) AS product_revenue
FROM curated.fact_sales f
JOIN curated.dim_product p
  ON f.product_id = p.product_id
GROUP BY p.product_name
ORDER BY product_revenue DESC;


-- ============================================================
-- 4. Revenue by Customer
-- ============================================================
SELECT
  c.customer_name,
  SUM(f.net_sales_amount) AS customer_revenue
FROM curated.fact_sales f
JOIN curated.dim_customer c
  ON f.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY customer_revenue DESC;


-- ============================================================
-- 5. Top 10 Products by Revenue
-- ============================================================
SELECT
  p.product_name,
  SUM(f.net_sales_amount) AS total_revenue
FROM curated.fact_sales f
JOIN curated.dim_product p
  ON f.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 10;


-- ============================================================
-- 6. Monthly Revenue Trend
-- ============================================================
SELECT
  YEAR(order_date)  AS year,
  MONTH(order_date) AS month,
  SUM(net_sales_amount) AS monthly_revenue
FROM curated.fact_sales
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;


-- ============================================================
-- 7. Average Order Item Value
-- ============================================================
SELECT
  AVG(net_sales_amount) AS avg_order_item_value
FROM curated.fact_sales;


-- ============================================================
-- 8. Revenue Contribution by Product Category
-- ============================================================
SELECT
  p.category,
  SUM(f.net_sales_amount) AS category_revenue
FROM curated.fact_sales f
JOIN curated.dim_product p
  ON f.product_id = p.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;


-- ============================================================
-- 9. Customers with Highest Discount Impact
-- ============================================================
SELECT
  c.customer_name,
  SUM(f.discount_amount) AS total_discount_given
FROM curated.fact_sales f
JOIN curated.dim_customer c
  ON f.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_discount_given DESC;


-- ============================================================
-- 10. Revenue Sanity Check (Gross vs Net)
-- ============================================================
SELECT
  SUM(gross_sales_amount) AS gross_revenue,
  SUM(discount_amount)    AS total_discounts,
  SUM(net_sales_amount)   AS net_revenue
FROM curated.fact_sales;
