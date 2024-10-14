# MinIO Enterprise Object Store - S3

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
#cd minio
docker compose up
```

**Acesse https://minio.docker.local/**

Use o MinIO Client:

```bash
curl https://dl.min.io/client/mc/release/linux-amd64/mc \
  --create-dirs \
  -o $HOME/minio-binaries/mc
chmod +x $HOME/minio-binaries/mc
ln -s $HOME/minio-binaries/mc ~/.local/bin/mc
mc --version
mc --autocompletion
```

mais detalhes em https://min.io/docs/minio/linux/reference/minio-mc.html
