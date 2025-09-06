#!/bin/bash
#
# Reference: Official installation instructions for pyenv  https://github.com/pyenv/pyenv#installation
# Maintainer: Lien Nguyen
# See LICENSE and README for details.
#

PYENV_ROOT="$HOME/.pyenv"

# Check if pyenv is installed at all
if [ ! -d "$PYENV_ROOT" ]; then
  echo "❌ pyenv directory was not found at: $PYENV_ROOT" >&2
  echo "ℹ️ Please make sure that install_pyenv.sh was run successfully." >&2
  exit 1
fi

# Export and initialization
export PYENV_ROOT
export PATH="$PYENV_ROOT/bin:$PATH"

# Ensure that pyenv is available
if ! command -v pyenv >/dev/null 2>&1; then
  echo "❌ pyenv could not be found – is it installed correctly?" >&2
  exit 1
fi

# Initialization
eval "$(pyenv init --path)"