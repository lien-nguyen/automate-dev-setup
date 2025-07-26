#!/bin/bash
#
# helpers/load_pyenv.sh
#
# Beschreibung: Lädt pyenv in die aktuelle Shell-Sitzung, wenn vorhanden.
#
# Autor: Lien Nguyen
# Erstellt: 07.072025
# Lizenz: MIT
#

PYENV_ROOT="$HOME/.pyenv"

# Überprüfen, ob pyenv überhaupt installiert ist
if [ ! -d "$PYENV_ROOT" ]; then
  echo "❌ pyenv-Verzeichnis wurde nicht gefunden unter: $PYENV_ROOT" >&2
  echo "ℹ️ Bitte stelle sicher, dass install_pyenv.sh erfolgreich ausgeführt wurde." >&2
  exit 1
fi

# Export und Initialisierung
export PYENV_ROOT
export PATH="$PYENV_ROOT/bin:$PATH"

# Sicherstellen, dass pyenv vorhanden ist
if ! command -v pyenv >/dev/null 2>&1; then
  echo "❌ pyenv konnte nicht gefunden werden – ist es korrekt installiert?" >&2
  exit 1
fi

# Initialisierung
eval "$(pyenv init --path)"