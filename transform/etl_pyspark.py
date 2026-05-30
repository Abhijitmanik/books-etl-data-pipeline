"""PySpark transformation step for cleaning and shaping book data."""

from pyspark.sql import SparkSession
from pyspark.sql.functions import regexp_replace,col,when

# -- create session 
spark = SparkSession.builder\
        .appName("BookETK")\
        .getOrCreate()
# read csv file 
df = spark.read.format("csv") \
    .option("header", "true") \
    .option("inferSchema", "true") \
    .load("/Users/abhijitmanik/Desktop/Portfoilio/mamataclothstore/books-data-pipeline/data/raw/books_raw.csv")

# Remove £ symbol 

df = df.withColumn(
    "price",
    regexp_replace(col("price"), "[^0-9.]", "")
)

df = df.withColumn(
    "price",
    col("price").cast("float")
)

df = df.withColumn(
    "rating",
    when(col("rating") == "One", 1)
    .when(col("rating") == "Two", 2)
    .when(col("rating") == "Three", 3)
    .when(col("rating") == "Four", 4)
    .when(col("rating") == "Five", 5)
)

df.printSchema()

df = df.dropDuplicates()
df.show(5)

df.coalesce(1) \
  .write \
  .mode("overwrite") \
  .option("header", "true") \
  .csv("data/processed/clean_data")


# df_raw = spark.read.csv(
#     "data/raw/books_raw.csv",
#     header=True
# )

# df_raw.show(5, truncate=False)


def transform():
    print("Transforming data...")