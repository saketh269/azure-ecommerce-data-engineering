from pyspark.sql.functions import (
    col, lit, current_timestamp, lower,
    year, month, dayofmonth
)

df_fact_orders = (
    df_stg_orders
    .withColumnRenamed("status", "order_status")
    .withColumnRenamed("promo_id", "promotion_id")
    .withColumn("order_status", lower(col("order_status")))
    .withColumn("channel", lower(col("channel")))
    .withColumn("order_year", year(col("order_date")))
    .withColumn("order_month", month(col("order_date")))
    .withColumn("order_day", dayofmonth(col("order_date")))
    .withColumn("is_cancelled", (col("order_status") == lit("cancelled")).cast("int"))
    .withColumn("is_delivered", (col("order_status") == lit("delivered")).cast("int"))
    .withColumn("is_shipped", (col("order_status") == lit("shipped")).cast("int"))
    .withColumn("load_ts", current_timestamp())
    .select(
        "order_id",
        "customer_id",
        "order_date",
        "order_year",
        "order_month",
        "order_day",
        "channel",
        "order_status",
        "promotion_id",
        "shipping_fee",
        "tax_amount",
        "is_cancelled",
        "is_shipped",
        "is_delivered",
        "load_ts"
    )
)
