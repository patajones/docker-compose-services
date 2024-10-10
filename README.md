# Serviços docker para subir em ambiente de desenvolvimento

Uma série de serviços úteis para ambientes de testes e desenvolvimento com docker

## Certificados

Para configurar o https, criar o CA antes de subir qualquer serviço

```shell
./create-ca.sh
```

Após a criação, instalar no seu browser como um Certificado Raiz Confiável.


## MinIO Enterprise Object Store - S3

### Preparar ambiente para MinIO

Alterar arquivo /etc/hosts para adicionar os domínios locais e criar os certificados desses domínios

```bash
#Executar com SUDO no Linux
cd minio
./add-domains-on-etc-hosts.sh
./create-certs.sh
```

Se estiver no Windows, executar no powershell, como administrador, o script para alterar o C:\Windows\System32\drivers\etc\hosts

```powershell
./add-domains-on-etc-hosts.ps1
```

Subir os serviços:

```bash
docker compose up
```

