# Apache Spark

Cluster Spark Standalone

### Preparar ambiente para Apache Spark

Alterar arquivo /etc/hosts para adicionar os domínios locais e criar os certificados desses domínios

```bash
#Executar com SUDO no Linux
cd spark
./add-domains-on-etc-hosts.sh
./create-certs.sh
```

Se estiver no Windows, executar no powershell, como administrador, o script para alterar o C:\Windows\System32\drivers\etc\hosts

```powershell
./add-domains-on-etc-hosts.ps1
```

Subir os serviços:

```bash
#cd spark
docker compose up -d
docker compose logs -f
```

**Acesse [https://spark.docker.local](https://spark.docker.local)**

**Acesse também [https://minio.docker.local](https://minio.docker.local)**


