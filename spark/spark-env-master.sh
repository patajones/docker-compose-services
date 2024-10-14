# spark-env.sh

# Configura o IP local para cada nó
SPARK_LOCAL_IP=$(hostname -i)

# Configura o DNS público para cada worker
SPARK_PUBLIC_DNS=spark.docker.local
SPARK_WORKER_CORES=2
SPARK_WORKER_MEMORY=4G

# Configura o número de instâncias de workers que o master gerenciará
SPARK_WORKER_INSTANCES=2