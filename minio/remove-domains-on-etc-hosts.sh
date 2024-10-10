#!/bin/bash
# remove-domains-on-etc-hosts.sh

set -e

IP="127.0.0.1"

remove_domain_from_hosts() {
    local DOMAIN=$1
    if grep -q "^$IP $DOMAIN$" /etc/hosts; then
        sed -i "/^$IP $DOMAIN$/d" /etc/hosts
        echo "Domínio $DOMAIN removido do /etc/hosts."
    else
        echo "O domínio $DOMAIN não está presente no /etc/hosts."
    fi
}

# Domínios que você quer remover
remove_domain_from_hosts "docker.local"
remove_domain_from_hosts "minio.docker.local"
remove_domain_from_hosts "s3.minio.docker.local"
