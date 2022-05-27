#!/usr/bin/env bash

set -e

source /home/${USER}/.espressif/frameworks/esp-idf/export.sh > /dev/null 2>&1
idf.py build
# Choose ESP_BOARD: [esp32, esp32c3, esp32s2, esp32s3]
export ESP_BOARD="esp32"
web-flash --chip ${ESP_BOARD} build/app-template.elf
