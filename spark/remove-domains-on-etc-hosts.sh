#!/bin/bash
# remove-domains-on-etc-hosts.sh

set -e

remove_domain_from_hosts() {
    local DOMAIN=$1
    # Remove qualquer linha que contenha o domínio fornecido, independente do IP e com um ou mais espaços
    if grep -q "^[0-9]\{1,3\}\(\.[0-9]\{1,3\}\)\{3\}[[:space:]]\+$DOMAIN$" /etc/hosts; then
        sudo sed -i "/^[0-9]\{1,3\}\(\.[0-9]\{1,3\}\)\{3\}[[:space:]]\+$DOMAIN$/d" /etc/hosts
        echo "Domínio $DOMAIN removido do /etc/hosts."
    else
        echo "O domínio $DOMAIN não está presente no /etc/hosts."
    fi
}

# Domínios que você quer remover
remove_domain_from_hosts "docker.local"
remove_domain_from_hosts "minio.docker.local"
remove_domain_from_hosts "s3.minio.docker.local"
remove_domain_from_hosts "spark.docker.local"
remove_domain_from_hosts "worker1.spark.docker.local"
remove_domain_from_hosts "worker2.spark.docker.local"
