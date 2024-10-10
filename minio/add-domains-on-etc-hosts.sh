#!/bin/bash
# add-domains-on-etc-hosts.sh

set -e

IP="127.0.0.1"

add_domain_to_hosts() {
    local DOMAIN=$1
    if ! grep -q "^$IP $DOMAIN$" /etc/hosts; then
        echo "$IP $DOMAIN" | tee -a /etc/hosts > /dev/null
        echo "Domínio $DOMAIN adicionado ao /etc/hosts."
    else
        echo "O domínio $DOMAIN já está presente no /etc/hosts."
    fi
}

# Domínios que você quer adicionar
add_domain_to_hosts "docker.local"
add_domain_to_hosts "minio.docker.local"
add_domain_to_hosts "s3.minio.docker.local"
