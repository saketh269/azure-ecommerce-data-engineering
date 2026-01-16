from pyspark.sql import functions as F

src_path  = "abfss://datalake@ecommercedatalake01.dfs.core.windows.net/staging/competitor_prices"
tgt_path  = "abfss://datalake@ecommercedatalake01.dfs.core.windows.net/analytics/fact_competitor_prices"

df_fact_comp_prices = (
    spark.read.format('delta').load(src_path)
    .withColumn("price_date", F.to_date("prices_date"))
    .withColumn("load_date", F.to_date("load_date"))
    .withColumn("competitor", F.lower(F.trim(F.col("competitor"))))
    .withColumn("competitor_price", F.col("competitor_price").cast("double"))
    .dropDuplicates(["product_id", "competitor", "prices_date"])  # keep one record per product+competitor+date
    .select(
        "product_id",
        "competitor",
        "competitor_price",
        "price_date",
        "load_date"
    )
)

df_fact_comp_prices.write \
    .format("delta") \
    .mode("overwrite") \
    .save(tgt_path)
