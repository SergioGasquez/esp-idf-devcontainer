# esp-idf-devcontainer

This repository uses a container to offer the environment needed to develop applications for [ESP
boards using ESP-IDF](https://github.com/espressif/esp-idf), it also provides integration with Visual Studio Code using [remote containers](https://code.visualstudio.com/docs/remote/containers).

For instructions on how to integrate devcontainers to existing repositories, see
[this section](#integrating-devcontainer-in-existing-repositories).

Developing projects for ESP boards in an online environment is also available with [Gitpod](https://www.gitpod.io/):
[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/github.com/SergioGasquez/esp-idf-devcontainer/)

This repository is can be used as template repository.

## Table of Contents

- [Quick Start](#quick-start)
  - [Requirements](#requirements)
  - [Setup](#setup)
  - [Running the container](#running-the-container)
  - [Build](#build)
  - [Flash](#flash)
    - [Cargo espflash](#cargo-espflash)
    - [Adafruit ESPTool](#adafruit-esptool)
  - [Monitor](#monitor)
    - [Online Serial Monitor](#online-serial-monitor)
- [Wokwi Simulator](#wokwi-simulator)
- [Integrating devcontainer in existing repositories](#integrating-devcontainer-in-existing-repositories)

# Quick Start

## Requirements

- [Visual Studio Code](https://code.visualstudio.com/download)
  - [Remote - Container Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Docker](https://docs.docker.com/get-docker/)
> ### Using Podman instead of Docker
> Using Podman as container tool is possible when using a Linux host machine.
> When using Podman, flashing devices from the container is possible.
>
> > There has been some testing using Lima and Podman in other platforms but with
> > no success so far. Feel free to test with them and report any feedback.
> #### Requirements
>   - [Install Podman](https://podman.io/getting-started/installation)
>   -  Uncomment the `runArgs` line from `devcontianer.json`:
>
>       ```
>       "runArgs": ["--userns=keep-id", "--device", "/dev/ttyUSB0", "--security-opt", "label=disable", "--annotation", "run.oci.keep_original_groups=1"],
>       ```
>      - Edit the device argument to match the serial port of your board.
>   - Edit Visual Code Settings:
>     -  Via UI: In _Extension>Remote-Containers_ set `Remote›Containers:Docker Path`
>   to `podman`
>     -  Via JSON: Add the following line:
>         ```
>         "remote.containers.dockerPath": "podman",
>         ```

## Setup

Select the tag of the [sergiogasquez/esp-idf-env](https://hub.docker.com/r/sergiogasquez/esp-idf-env)
image you would like to use by modifying the `image` property in
`devcontainer.json`.
For more information regarding the image tags, refer to [esp-idf-container](https://github.com/SergioGasquez/esp-idf-container).


## Running the container

1. Open the folder with Visual Studio Code and open the container, there are
   several ways to open the container:
   1. When opening Visual Studio Code, a popup will come up asking to open reopen the folder in a Container, click `Reopen in Container`
   1. Open the [Command Palette](https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette) and select `Remote-Containers: Reopen in Container`
   2. Use the open in a remote window button on the bottom left corner to
   `Reopen in Container`
2. Wait for the container to build and run, once the container is running, you
   should have a working environment to develop ESP boards using Rust
   - If you want to generate an application using the [esp-idf-template](https://github.com/esp-idf/esp-idf-template) use:
     - `cargo generate --git https://github.com/esp-idf/esp-idf-template cargo`
    > There is also a `no_std` template project: https://github.com/esp-idf/esp-template

    > Be sure to match the installed environment in the selected image tag (espidf version and board)

## Build
- Terminal approach:
    ```bash
    ./run-wokwi.sh
    ```
- [Devcontainers] UI approach:

    The default build task is already set to build the project, and it can be used
    in VsCode and Gitpod:
    - From the [Command Palette](https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette) (`Ctrl-Shift-P` or `Cmd-Shift-P`) run the `Tasks: Run Build Task` command.
    - `Terminal`-> `Run Build Task` in the menu.
    - With `Ctrl-Shift-B` or `Cmd-Shift-B`.
    - From the [Command Palette](https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette) (`Ctrl-Shift-P` or `Cmd-Shift-P`) run the `Tasks: Run Task` command and
    select `Build Project`.
    - From UI: Press `Build Project` on the left side of the Status Bar.


## Flash
- Use idf.py (`idf.py -p PORT [-b BAUD] flash`) from the host device.
- Use [Adafruit ESPTool](https://adafruit.github.io/Adafruit_WebSerial_ESPTool/):
  1. Open the [Adafruit ESPTool](https://adafruit.github.io/Adafruit_WebSerial_ESPTool/) flashing tool.
  2. Choose the desired baudrate.
  3. Connect to the serial port of the ESP board.
  4. Upload the generated binary.
Any other method of flashing ESP boards from your host device should work.



# Wokwi Simulator

- Terminal approach:

    ```bash
    bash wokwi/run-wokwi.sh
    ```
- [Devcontainers] UI approach:

    The default test task is already set to build the project, and it can be used
    in VsCode and Gitpod:
    - From the [Command Palette](https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette) (`Ctrl-Shift-P` or `Cmd-Shift-P`) run the `Tasks: Run Test Task` command
    - With `Ctrl-Shift-,` or `Cmd-Shift-,`
        > Note: This Shortcut is not available in Gitpod by default.
    - From the [Command Palette](https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette) (`Ctrl-Shift-P` or `Cmd-Shift-P`) run the `Tasks: Run Task` command and
    select `Build & Run Wokwi Simulation`.
    - From UI: Press `Build & Run Wokwi Simulation` on the left side of the Status Bar.

## Debuging with Wokwi

Wokwi offers debugging with GDB.

- [Devcontainers] Terminal approach:
    ```bash
    $HOME/.espressif/tools/xtensa-esp32-elf/esp-2021r2-8.4.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-gdb \
    target/xtensa-esp32-espidf/debug/rustzx-esp32 -ex "target remote localhost:9333"
    ```
- [Devcontainers] UI approach:

    Debug using with VsCode or Gitpod is also possible:
    1. Run the Wokwi Simulation
        > Note that the simulation will pause if the browser tab is on the background
    2. Go to `Run and Debug` section of the IDE (`Ctrl-Shift-D or Cmd-Shift-D`)
    3. Choose the proper session:
        - `VsCode: Wokwi Debug`
        - `Gitpod: Wokwi Debug`
    4. Start Debugging (`F5`)

# Integrating devcontainer in existing repositories

In order to add devcontainer features to an existing repository:
1. Copy the `.devcontainer` folder to your repository.
2. Edit the `image` property of `devcontainer.json` with you desired tag.
3. For Gitpod support, copy the `.gitpod.yml` and `.gitpod.Dockerfile` files.
   - For instructions about how to add a "Open in Gitpod" button, see their
      [official documentation](https://www.gitpod.io/docs/getting-started#open-in-gitpod-button)
4. If you also want to add Wokwi Simulation support:
   - Copy the `wokwi` folder.
   - Use the run-wokwi.sh script to run simulations, for detailed information on how
  to properly execute it, see [Wokwi Simulator](#wokwi-simulator) Section.
