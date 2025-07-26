#!/bin/bash

set -e
echo "Installing pyenv dependencies..."

sudo apt-get update
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libffi-dev liblzma-dev git

if [ ! -d "$HOME/.pyenv" ]; then
    echo "Installing pyenv..."
    curl https://pyenv.run | bash
else 
    echo "pyenv already installed." 
fi 

# Hinzufüge pyenv in shell config falls nicht vorhanden
if ! grep -q 'pyenv init' ~/.bashrc; then 
    echo -e '\n# Pyenv setup' >> ~/.bashrc 
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
    echo -e 'eval "$(pyenv init --path)"\neval "$(pyenv virtualenv-init -)"'  >> ~/.bashrc
fi 

echo "pyenv installed. Reloading shell config..."
# shellcheck disable=SC1090
source ~/.bashrc
