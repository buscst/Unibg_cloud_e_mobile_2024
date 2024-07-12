from pyspark.sql import SparkSession
from pyspark.sql.functions import col, udf
from pyspark.sql.types import ArrayType, StructType, StructField, StringType
from pymongo import MongoClient
import logging

# Connettersi a MongoDB
client = MongoClient("mongodb+srv://admin:admin@clustercloudmobile.ucirwhr.mongodb.net")
db = client['unibg_tedx_2024']
tedx_collection = db['tedx_data']
news_collection = db['news_data']
news_with_talks_collection = db['news_with_talks']

# Configurazione Spark
spark = SparkSession.builder \
    .appName("TEDxNewsJob") \
    .getOrCreate()

# Definisci gli schemi per i DataFrame
tedx_schema = StructType([
    StructField("_id", StringType(), True),
    StructField("url_image", StringType(), True),
    StructField("slug", StringType(), True),
    StructField("url", StringType(), True),
    StructField("speakers", StringType(), True),
    StructField("title", StringType(), True),
    StructField("internalId", StringType(), True),
    StructField("description", StringType(), True),
    StructField("duration", StringType(), True),  # Temporaneamente come StringType
    StructField("publishedAt", StringType(), True),
    StructField("tags", ArrayType(StringType()), True),
    StructField("related_videos", ArrayType(StructType([
        StructField("_id", StringType(), True),
        StructField("slug", StringType(), True),
        StructField("speakers", StringType(), True),
        StructField("title", StringType(), True),
        StructField("url", StringType(), True),
        StructField("description", StringType(), True),
        StructField("duration", StringType(), True),  # Temporaneamente come StringType
        StructField("publishedAt", StringType(), True),
    ])), True)
])

news_schema = StructType([
    StructField("article_id", StringType(), True),
    StructField("title", StringType(), True),
    StructField("link", StringType(), True),
    StructField("creator", ArrayType(StringType()), True),
    StructField("description", StringType(), True),
    StructField("pubDate", StringType(), True),
    StructField("source_id", StringType(), True),
    StructField("source_priority", StringType(), True),
    StructField("source_url", StringType(), True),
    StructField("source_icon", StringType(), True),
    StructField("language", StringType(), True),
    StructField("country", ArrayType(StringType()), True),
    StructField("category", ArrayType(StringType()), True)
])

# Leggi i dati da MongoDB e crea i DataFrame
tedx_data = list(tedx_collection.find())
news_data = list(news_collection.find())

talks_df = spark.createDataFrame(tedx_data, tedx_schema)
news_df = spark.createDataFrame(news_data, news_schema)

# UDF per trovare i TEDx talk pertinenti e limitare a 30
def find_matching_talks(categories):
    if categories is None:
        return []
    matching_talks = []
    for talk in tedx_data:
        tags = talk.get('tags', [])
        if any(category in tags for category in categories):
            matching_talks.append(talk)
        if len(matching_talks) >= 30:  # Limita a 30 talk
            break
    return matching_talks[:30]  # Return only up to 30 talks

find_matching_talks_udf = udf(find_matching_talks, ArrayType(tedx_schema))

# Aggiungi la colonna dei talk pertinenti al DataFrame delle news
news_with_talks_df = news_df.withColumn("talks", find_matching_talks_udf(col("category")))

# Mostra il risultato
news_with_talks_df.show(truncate=False)

# Convertire il DataFrame in RDD e poi in lista di dizionari per salvarli su MongoDB
news_with_talks_rdd = news_with_talks_df.rdd.map(lambda row: row.asDict())
news_with_talks_list = news_with_talks_rdd.collect()

# Aggiornare le news con i TEDx talks su MongoDB limitando a 30 talk
for news in news_with_talks_list:
    limited_talks = news['talks'][:30]
    news_with_talks_collection.update_one(
        {'article_id': news['article_id']}, 
        {'$set': {**news, 'talks': limited_talks}}, 
        upsert=True
    )

# Chiudere la connessione a MongoDB
client.close()

# Stop Spark
spark.stop()
