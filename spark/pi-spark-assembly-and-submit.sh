#!/bin/bash

# pi-spark-assembly-and-submit.sh
# Realiza o build/assembly e submit do projeto pi-spark

# Caminho do diretório do projeto
PROJECT_DIR="./pi-spark"
JAR_NAME="pi-spark_2.12-1.0.jar"
DEFAULT_SAMPLES=10000000  # Valor padrão para o número de samples

# Função para exibir mensagens de erro e sair do script
function error_exit {
  echo "$1" 1>&2
  exit 1
}

# Função para solicitar o número de samples
function ask_samples {
  read -p "Informe o número de samples (padrão: ${DEFAULT_SAMPLES}): " samples
  # Se o usuário não inserir nada, usar o valor padrão
  samples=${samples:-$DEFAULT_SAMPLES}
  echo "Número de samples definido para: $samples"
}

# Navegar até o diretório do projeto
cd "$PROJECT_DIR" || error_exit "Erro: não foi possível acessar o diretório do projeto: $PROJECT_DIR"

# Verificar se o arquivo JAR já existe
if [ -f "target/scala-2.12/$JAR_NAME" ]; then
  read -p "O arquivo JAR já existe. Deseja fazer o assembly novamente? (s/N): " response
  if [[ ! "$response" =~ ^([sS][iI][mM]|[sS])$ ]]; then
    echo "Pulando o processo de assembly."
  else
    echo "Realizando o build e assembly do projeto com sbt..."
    sbt clean compile package || error_exit "Erro ao compilar o projeto com sbt."
  fi
else
  echo "Realizando o build e assembly do projeto com sbt..."
  sbt clean compile package || error_exit "Erro ao compilar o projeto com sbt."
fi

# Verificar se o arquivo JAR foi gerado
if [ ! -f "target/scala-2.12/$JAR_NAME" ]; then
  error_exit "Erro: arquivo JAR não encontrado em target/scala-2.12/"
fi

# Solicitar o número de samples
ask_samples

# Realizar o submit ao cluster Spark
echo "Realizando o submit do job ao cluster Spark com ${samples} samples..."
spark-submit \
  --class PiSpark \
  --master spark://spark.docker.local:7077 \
  --deploy-mode client \
  
  --conf spark.driver.host=$(hostname -I | awk '{print $1}') \
  target/scala-2.12/${JAR_NAME} $samples || error_exit "Erro ao submeter o job ao cluster Spark."

echo "Job submetido com sucesso!"
