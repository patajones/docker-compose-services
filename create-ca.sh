#!/bin/bash

OUTPUT=./certs/
mkdir ${OUTPUT}

CA_KEY="${OUTPUT}ca.key"
CA_CERT="${OUTPUT}ca.crt"

# Gera um certificado autoassinado para a CA
openssl genrsa -out $CA_KEY 2048
openssl req -x509 -new -nodes -key $CA_KEY -sha256 -days 1024 -out $CA_CERT -subj "/C=US/ST=State/L=City/O=Organization/OU=OrgUnit/CN=_DockerCA"

echo "CA'S criadas em ${CA_KEY} e ${CA_CERT}"
