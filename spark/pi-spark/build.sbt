scalaVersion := "2.12.18"
name := "pi-spark"
organization := "com"
version := "1.0"

libraryDependencies ++= Seq(
  "org.apache.spark" %% "spark-core" % "3.5.3",
  "org.apache.spark" %% "spark-sql" % "3.5.3",
  "org.apache.logging.log4j" % "log4j-api" % "2.14.1",
  "org.apache.logging.log4j" % "log4j-core" % "2.14.1"
)

assembly / assemblyOption := (assembly / assemblyOption).value.withIncludeScala(false)

// Excluir jars do Spark do JAR final gerado pelo assembly
assembly / assemblyExcludedJars := {
  val cp = (fullClasspath in assembly).value
  cp.filter { jar =>
    jar.data.getName.contains("spark-core") ||
    jar.data.getName.contains("spark-sql")
  }
}

// Evitar que o assembly falhe por causa de arquivos duplicados nos jars excluídos
assembly / assemblyMergeStrategy := {
  case PathList("META-INF", xs @ _*) => MergeStrategy.discard
  case x => MergeStrategy.first
}