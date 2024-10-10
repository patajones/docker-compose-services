# Serviços docker para subir em ambiente de desenvolvimento

Uma série de serviços úteis para ambientes de testes e desenvolvimento com docker. Testado no docker Windows com WSL Ubuntu.

## Certificados

Para configurar o https, criar o CA antes de subir qualquer serviço

```shell
./create-ca.sh
```

Após a criação, instalar no seu browser como um Certificado Raiz Confiável. 

Se for Windows, pressione as teclas Win+R e digite `certmgr.msc`. No painel esquerdo, expanda *Autoridades de Certificação Raiz Confiáveis* Clique com o botão direito do mouse em *Certificados* e selecione Todas as Tarefas > Importar. Use o Assistente de importação para importar o arquivo ./certs/ca.crt.

No Debian/Ubuntu faça:

```bash
sudo cp ./certs/ca.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates
```

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
