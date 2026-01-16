from pyspark.sql.functions import col,row_number
from pyspark.sql.window import Window
stg_promo_path="abfss://datalake@ecommercedatalake01.dfs.core.windows.net/staging/promotions"
df_promo_stg=spark.read.format("delta").load(stg_promo_path)

from pyspark.sql.functions import (
    col, trim, upper, when, current_timestamp,
    monotonically_increasing_id, current_date
)
from pyspark.sql.window import Window
from pyspark.sql.functions import row_number

stg_path = "abfss://datalake@ecommercedatalake01.dfs.core.windows.net/staging/promotions"
an_path  = "abfss://datalake@ecommercedatalake01.dfs.core.windows.net/analytics/dim_promotion"

df_stg = spark.read.format("delta").load(stg_path)

df_clean = (df_stg
    .withColumn("promo_name", trim(col("promo_name")))
    .withColumn("discount_type", upper(trim(col("discount_type"))))
    .withColumn(
        "discount_type",
        when(col("discount_type").isin("PCT","AMT"), col("discount_type")).otherwise("UNKNOWN")
    )
)

# dedupe promo_id (keep latest load)
w = Window.partitionBy("promo_id").orderBy(col("load_ts").desc())
df_latest = (df_clean
    .withColumn("rn", row_number().over(w))
    .filter(col("rn") == 1)
    .drop("rn")
)

df_latest = df_latest.withColumn(
    "is_active",
    when(
        (col("start_date").isNotNull()) &
        (col("end_date").isNotNull()) &
        (current_date() >= col("start_date")) &
        (current_date() <= col("end_date")),
        True
    ).otherwise(False)
)

dim_promo = (df_latest.select(
        monotonically_increasing_id().alias("promotion_key"),
        col("promo_id").alias("promotion_id"),
        col("promo_name").alias("promotion_name"),
        col("discount_type").alias("promotion_type"),
        col("discount_value"),
        col("start_date"),
        col("end_date"),
        col("min_order_value"),
        col("is_active"),
        current_timestamp().alias("analytics_ts")
    )
)

dim_promo.write.format("delta").mode("overwrite").save(an_path)
