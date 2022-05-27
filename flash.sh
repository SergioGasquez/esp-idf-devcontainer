#!/usr/bin/env bash

set -e

source /home/${USER}/.espressif/frameworks/esp-idf/export.sh > /dev/null 2>&1
idf.py build
export ESP_BOARD="esp32"
web-flash --chip ${ESP_BOARD} build/app-template.elf
