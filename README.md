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

## Serviços

* [MinIO Enterprise Object Store - S3](./minio/README.md)
* [Apache Spark](./spark/README.md)

