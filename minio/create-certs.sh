#!/bin/bash
#  create-certs.sh

OUTPUT=./certs/
mkdir -p $OUTPUT

# domains
DOMAINS=("docker.local" "minio.docker.local" "s3.minio.docker.local")

# Paths CA
CA_KEY="../certs/ca.key"
CA_CERT="../certs/ca.crt"

for DOMAIN in "${DOMAINS[@]}"; do
    # Gerar chave privada para o domínio
    openssl genrsa -out "${OUTPUT}${DOMAIN}.key" 2048

    # Criar um arquivo de configuração temporário para o SAN
    SAN_CONF="${OUTPUT}${DOMAIN}-san.cnf"
    cat > $SAN_CONF <<- EOM
[req]
distinguished_name = req_distinguished_name
req_extensions = v3_req
prompt = no

[req_distinguished_name]
C = US
ST = State
L = City
O = Organization
OU = OrgUnit
CN = ${DOMAIN}

[v3_req]
keyUsage = critical, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1 = ${DOMAIN}
EOM

    # Gerar CSR (Certificate Signing Request) com SAN para o domínio
    openssl req -new -key "${OUTPUT}${DOMAIN}.key" -out "${OUTPUT}${DOMAIN}.csr" -config $SAN_CONF

    # Gerar o certificado assinado pela CA com SAN
    openssl x509 -req -in "${OUTPUT}${DOMAIN}.csr" -CA $CA_CERT -CAkey $CA_KEY -CAcreateserial -out "${OUTPUT}${DOMAIN}.crt" -days 500 -sha256 -extfile $SAN_CONF -extensions v3_req

    echo "Certificado criado para ${DOMAIN}: ${OUTPUT}${DOMAIN}.crt"

    # Limpar o arquivo de configuração temporário
    rm $SAN_CONF
done

# Concatenar chave privada e certificado com a CA para formar o PEM
for DOMAIN in "${DOMAINS[@]}"; do
    cat "${OUTPUT}${DOMAIN}.crt" "${OUTPUT}${DOMAIN}.key" $CA_CERT > "${OUTPUT}${DOMAIN}.pem"
    echo "Arquivo PEM gerado para ${DOMAIN}: ${OUTPUT}${DOMAIN}.pem"
done

echo "Certificados e PEM's gerados para todos os domínios."
