# esp-idf-devcontainer

This repository is a devcontainer version of [espressif/esp-idf-template](https://github.com/espressif/esp-idf-template)
that supports:
-  [Gitpod](https://gitpod.io/): [![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/github.com/SergioGasquez/esp-idf-devcontainer/)
-  [Vs Code Devcontainers](https://code.visualstudio.com/docs/remote/containers)
-  [GitHub Codespaces](https://docs.github.com/en/codespaces/developing-in-codespaces/creating-a-codespace)

For instructions on how to integrate devcontainers to existing repositories, see
[this section](#integrating-devcontainer-in-existing-repositories).

Espressif IDF extension is already configured in the devcontainer and can be used
for configuring and building the project but flashingwith the extension is not possible.

# Quick Start
## Setup
-  [Gitpod](https://gitpod.io/): Gitpod does not require any special setup, it
only requires an account which can be created with Bitbucket, GitLab or GitHub.
-  Vs Code Devcontainers: See [installation](https://code.visualstudio.com/docs/remote/containers#_installation) and the [quick start](https://code.visualstudio.com/docs/remote/containers#_quick-start-open-an-existing-folder-in-a-container) sections.
-  GitHub Codespaces: The user needs to be part of the Codespaces beta or the repository must live under an organization.
   - When using GitHub Codespaces we need to make ports public, [see instructions](https://docs.github.com/en/codespaces/developing-in-codespaces/forwarding-ports-in-your-codespace#sharing-a-port).
## Build
- UI approach:
  - Use the build button from the extension in the status bar.
- Terminal approach:
    ```bash
    idf.py build
    ```

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
    > ** Note **
    >
    > If using another target be sure to modify `gdbpath` of `.vscode/launch.json`.
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
