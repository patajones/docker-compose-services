#!/bin/bash
#    remove-domains-on-etc-hosts.sh

set -e

IP="127.0.0.1"

DOMAIN="docker.local"
if grep -q "^$IP $DOMAIN$" /etc/hosts; then
    sed -i "/^$IP $DOMAIN$/d" /etc/hosts
    echo "Domínio $DOMAIN removido do /etc/hosts."
else
    echo "O domínio $DOMAIN não está presente no /etc/hosts."
fi

DOMAIN="minio.docker.local"
if grep -q "^$IP $DOMAIN$" /etc/hosts; then
    sed -i "/^$IP $DOMAIN$/d" /etc/hosts
    echo "Domínio $DOMAIN removido do /etc/hosts."
else
    echo "O domínio $DOMAIN não está presente no /etc/hosts."
fi

DOMAIN="s3.minio.docker.local"
if grep -q "^$IP $DOMAIN$" /etc/hosts; then
    sed -i "/^$IP $DOMAIN$/d" /etc/hosts
    echo "Domínio $DOMAIN removido do /etc/hosts."
else
    echo "O domínio $DOMAIN não está presente no /etc/hosts."
fi

