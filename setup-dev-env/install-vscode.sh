#!/bin/bash
#
# Reference: Official installation instructions for vscode https://code.visualstudio.com/docs/setup/linux
# Maintainer: Lien Nguyen
# See LICENSE and README for details.
#

set -e
export DEBIAN_FRONTEND=noninteractive

echo "Installing Visual Studio Code..."

sudo apt-get update

sudo apt-get install software-properties-common apt-transport-https -y

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > ~/packages.microsoft.gpg
sudo install -D -o root -g root -m 644 ~/packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get update
    # Detect WSL or native Ubuntu

# Detect WSL or native Ubuntu
if grep -qi microsoft /proc/version; then
    # WSL: suppress VS Code install prompt
    DONT_PROMPT_WSLINSTALL=1 sudo apt-get install -y code
    yes | code --version
else
    # Native Ubuntu
    sudo apt-get install -y code
    code --version
fi

echo "✅ Visual Studio Code installed."
