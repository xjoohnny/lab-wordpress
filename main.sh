#!/bin/bash

DATETIME=$(/bin/date +%d/%m/%Y" "%H:%M:%S)

echo " "
echo "Provisionamento de Wordpress (Cloud e Local)"
echo "Digite a opção desejada:"
echo "1) Cloud (Google, com provisionamento via Terraform)"
echo "2) Local (Virtual Box, com provisionamento via Vagrant)"
echo -n "--> "
read PROVISION_OPTION

if [ -z "${PROVISION_OPTION}" ]; then
    echo "Opção vazia."
    exit 101
fi

if [ "${PROVISION_OPTION}" == "1" ]; then
    echo " "
    echo "Preparando provisionamento em Cloud Google..."
    echo "Considere revisar o arquivo terraform/provider.tf para verificar se as variáveis estão de acordo com a necessidade..."
    sleep 5
    clear
elif [ "${PROVISION_OPTION}" == "2" ]; then
    echo " "
    echo "Preparando provisionamento em VM Local..."
    echo "Considere revisar o arquivo vagrant/machines.yml para verificar se as variáveis estão de acordo com a necessidade..."
    sleep 5
    clear
else
    echo " "
    echo "Opção inválida."
    exit 102
fi

