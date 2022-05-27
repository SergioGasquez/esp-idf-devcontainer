#!/usr/bin/env bash

set -e

source /home/${USER}/.espressif/frameworks/esp-idf/export.sh > /dev/null 2>&1
idf.py build

if [ "${USER}" == "gitpod" ];then
    gp_url=$(gp url 9012)
    echo "gp_url=${gp_url}"
    export WOKWI_HOST=${gp_url:8}
elif [ "${CODESPACE_NAME}" != "" ];then
    export WOKWI_HOST=${CODESPACE_NAME}-9012.githubpreview.dev
fi

export ESP_BOARD="esp32"
export ESP_ELF="app-template.elf"
export WOKWI_PROJECT_ID=""
if [ "${WOKWI_PROJECT_ID}" == "" ]; then
    wokwi-server --chip ${ESP_BOARD} build/${ESP_ELF}
else
    wokwi-server --chip ${ESP_BOARD} --id ${WOKWI_PROJECT_ID} build/${ESP_ELF}
fi

