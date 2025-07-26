#!/bin/bash

set -e

# pyenv sofort initialisieren (nur für diese Session)
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# pass die Python-Version an
PYTHON_VERSION="3.13.0"
echo "Installing Python $PYTHON_VERSION using pyenv..."

# shellcheck disable=SC1090
source setup-dev-env/helpers/load-pyenv.sh

if ! pyenv versions | grep -q "$PYTHON_VERSION"; then  
    pyenv install "$PYTHON_VERSION"
fi 

pyenv global "$PYTHON_VERSION"
python --version 
echo "Python $PYTHON_VERSION installed and set as global default:"