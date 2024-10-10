#!/bin/bash
#    add-domains-on-etc-hosts.sh

set -e

IP="127.0.0.1"

DOMAIN="docker.local"
if ! grep -q "^$IP $DOMAIN$" /etc/hosts; then
    echo "$IP $DOMAIN" | tee -a /etc/hosts > /dev/null
    echo "Domínio $DOMAIN adicionado ao /etc/hosts."
else
    echo "O domínio $DOMAIN já está presente no /etc/hosts."
fi

DOMAIN="minio.docker.local"
if ! grep -q "^$IP $DOMAIN$" /etc/hosts; then
    echo "$IP $DOMAIN" | tee -a /etc/hosts > /dev/null
    echo "Domínio $DOMAIN adicionado ao /etc/hosts."
else
    echo "O domínio $DOMAIN já está presente no /etc/hosts."
fi

DOMAIN="s3.minio.docker.local"
if ! grep -q "^$IP $DOMAIN$" /etc/hosts; then
    echo "$IP $DOMAIN" | tee -a /etc/hosts > /dev/null
    echo "Domínio $DOMAIN adicionado ao /etc/hosts."
else
    echo "O domínio $DOMAIN já está presente no /etc/hosts."
fi
