import org.apache.spark.sql.SparkSession

// Cria o SparkSession
val spark = SparkSession.builder.appName("Spark Worksheet").master("local[*]").getOrCreate()

// Exemplo de uso do Spark
val data = Seq(1, 2, 3, 4, 5)
val rdd = spark.sparkContext.parallelize(data)

// Contar elementos no RDD
val count = rdd.count()

// Mostrar o resultado
count
