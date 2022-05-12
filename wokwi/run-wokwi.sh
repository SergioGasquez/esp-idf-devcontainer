#!/bin/bash
set -e
if [ "$USER" = "esp" ]; then
path="/home/esp/workspace"
else
path="/workspace/esp-idf-devcontainer"
fi
pip3 install websockets==10.2
echo Building and running Wokwi simulation for: $CURRENT_PROJECT
cd $CURRENT_PROJECT
idf.py build
cd $path
python3 $path/wokwi/wokwi-server.py