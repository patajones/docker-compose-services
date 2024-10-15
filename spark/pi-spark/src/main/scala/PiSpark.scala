import org.apache.spark.sql.SparkSession
import org.apache.logging.log4j.LogManager
import scala.util.Random
import java.text.DecimalFormat
import java.text.DecimalFormatSymbols
import java.util.Locale
import scala.math.BigInt

object PiSpark {

  // Cria o logger
  val logger = LogManager.getLogger(PiSpark.getClass)

  def main(args: Array[String]): Unit = {

    // Inicia a sessão Spark
    val spark = SparkSession.builder
      .appName("PiSpark")
      //.master("local[*]") 
      .getOrCreate()

    // Lê os valores dos argumentos, ou usa os valores padrão
    val defaultNumSamplesMin: Long = 10000
    val numSamplesMin: Long = if (args.length > 0) args(0).toLong else defaultNumSamplesMin

    val defaultNumSamplesMax: Long = numSamplesMin * 10
    val numSamplesMax: Long = if (args.length > 1) args(1).toLong else defaultNumSamplesMax

    val defaultNumSamplesStep: Long = (numSamplesMax - numSamplesMin) / 2
    val numSamplesStep: Long = if (args.length > 2) args(2).toLong else defaultNumSamplesStep

    val formatLong = new DecimalFormat("#,##0", DecimalFormatSymbols.getInstance(new Locale("pt", "BR")))
    logger.info(s"Iniciando cálculos de PI. numSamplesMin=${formatLong.format(numSamplesMin)} numSamplesMax=${formatLong.format(numSamplesMax)} numSamplesStep=${formatLong.format(numSamplesStep)}")

    val sc = spark.sparkContext
    val rdd = sc.range(numSamplesMin, numSamplesMax+numSamplesStep-1, numSamplesStep) //aproximações de PI que serão realizadas
            .flatMap(qtdSamples=>
                      (1L to qtdSamples).map(sample => (qtdSamples, sample))
                      ) //explode os samples que serão realizados  
            .repartition(1000)
            .map(v=>(v._1, {
                  val random = new Random()
                  (random.nextDouble(), random.nextDouble())
                  })
                ) //gera pontos aleatorios 
            .map(v=>(v._1, {
                    val ponto = v._2
                    if (ponto._1 * ponto._1 + ponto._2 * ponto._2 <= 1) 1 else 0
                  })
                )
            .aggregateByKey(0)((a,b)=>a+b,(a,b)=>a+b)
            .map(v=>(v._1, 4.0 * v._2 / v._1)) //calcula aproximação de pi

    val results = rdd.collect()

    // Exibe os resultados após o processamento
    logger.info("Resultados do cálculo de Pi para diferentes quantidades de amostras")
    logger.info(s"numSamplesMin=${formatLong.format(numSamplesMin)} numSamplesMax=${formatLong.format(numSamplesMax)} numSamplesStep=${formatLong.format(numSamplesStep)}")
    results.foreach { case (samples, piValue) =>
      println(s"Aproximação de PI por MontoCarlo usando ${formatLong.format(samples)} amostras: ${piValue}")
    }

    spark.stop()
  }
}
