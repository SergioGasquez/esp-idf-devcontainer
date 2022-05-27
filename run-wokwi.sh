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
# Choose ESP_BOARD: [esp32, esp32c3, esp32s2, esp32s3]
export ESP_BOARD="esp32"
export WOKWI_PROJECT_ID=""
if [ "${WOKWI_PROJECT_ID}" == "" ]; then
    wokwi-server --chip ${ESP_BOARD} build/app-template.elf
else
    wokwi-server --chip ${ESP_BOARD} --id ${WOKWI_PROJECT_ID} build/app-template.elf
fi

