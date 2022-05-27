FROM gitpod/workspace-base
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ARG CONTAINER_USER=gitpod
ARG CONTAINER_GROUP=gitpod
ARG ESP_BOARD=all
ARG ESP_IDF_VERSION=release/v4.4
# libpython2.7 is due to GDB
RUN sudo install-packages -y git curl wget flex bison gperf python3 python3-pip \
    python3-setuptools ninja-build ccache libffi-dev libssl-dev dfu-util \
    libusb-1.0-0 libpython2.7
USER ${CONTAINER_USER}
WORKDIR /home/${CONTAINER_USER}
RUN mkdir -p .espressif/frameworks/ \
    && git clone --branch ${ESP_IDF_VERSION} --depth 1 --shallow-submodules \
    --recursive https://github.com/espressif/esp-idf.git \
    .espressif/frameworks/esp-idf \
    && python3 .espressif/frameworks/esp-idf/tools/idf_tools.py install cmake \
    && .espressif/frameworks/esp-idf/install.sh ${ESP_BOARD}
RUN curl -L https://github.com/bjoernQ/esp-web-flash-server/releases/latest/download/web-flash-x86_64-unknown-linux-gnu.zip \
    -o /home/${CONTAINER_USER}/.espressif/frameworks/esp-idf/tools/web-flash.zip \
    && unzip /home/${CONTAINER_USER}/.espressif/frameworks/esp-idf/tools/web-flash.zip \
    -d /home/${CONTAINER_USER}/.espressif/frameworks/esp-idf/tools/
RUN chmod u+x /home/${CONTAINER_USER}/.espressif/frameworks/esp-idf/tools/web-flash
RUN curl -L https://github.com/MabezDev/wokwi-server/releases/latest/download/wokwi-server-x86_64-unknown-linux-gnu.zip \
    -o /home/${CONTAINER_USER}/.espressif/frameworks/esp-idf/tools/wokwi-server.zip \
    && unzip /home/${CONTAINER_USER}/.espressif/frameworks/esp-idf/tools/wokwi-server.zip \
    -d /home/${CONTAINER_USER}/.espressif/frameworks/esp-idf/tools/
RUN chmod u+x /home/${CONTAINER_USER}/.espressif/frameworks/esp-idf/tools/wokwi-server
ENV IDF_TOOLS_PATH=/home/${CONTAINER_USER}/.espressif