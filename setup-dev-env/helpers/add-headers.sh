#/!bin/bash
#
# add_headers.sh
#
# Beschreibung: Fügt standardisierte Header (Deutsch oder Englisch) zu allen Shell-Skripten
# im Projekt hinzu, außer sich selbst. Unterstützt automatische Beschreibung und Spracheinstellung.
#
# Authorin: Lien Nguyen
# Erstellt: 07.07.2025
# Lizenz: MIT
#
# Verwendung:
# chmod +x /helpers/add_headers.sh
# ./helpers/add_headers.sh [--lang en|de]
# 

# -------- Language Setup --------
LANGUAGE="de"
if [[ "$1" == "--lang" && "$2" =~ ^(en|de)$ ]]; then 
    LANGUAGE="$2"
fi

# -------- Description Mapping --------
get_description() {
    local file="$1"
    case "$file" in 
        install_git.sh)
            [[ $LANGUAGE == "de" ]] && echo "Installiert die neueste Version von Git." || echo "Installs the latest version of Git."
            ;;
        install_pyenv.sh)
            [[ $LANGUAGE == "de" ]] && echo "Installiert pyenv und richtet die Umgebung ein." || echo "Installs pyenv and configure the environment."
            ;;
        install_python.sh) 
            [[ $LANGUAGE == "de" ]] && echo "Installiert eine bestimmte Python-Version über pyenv." || echo "Installs a specific Python version via pyenv."
            ;;
        install_vscode.sh)
            [[ $LANGUAGE == "de" ]] && echo "Installiert Visual Studio Code." || echo "Install Visual Studio Code."
            ;;
        install_docker.sh) 
            [[ $LANGUAGE == "de" ]] && echo "Installiert Docker und fügt den Benutzer zur docker-Gruppe hinzu." || echo "Installs Docker and add the user to the docker group."
            ;;
        install_dbeaver.sh) 
            [[ $LANGUAGE == "de" ]] && echo "Installert DBeaver als Datenbank-GUI." || echo "Installs DBeaver as a graphical SQL client."
            ;;
        install_chrome.sh) 
            [[ $LANGUAGE == "de" ]] && echo "Installiert den Google Chrome Webbrowser." || echo " Installs the Google Chrome web browser."
            ;;
        setup_all.sh)
            [[ $LANGUAGE == "de" ]] && echo "Führt alle Installationsskripte nacheinander aus, um die Entwicklungsumgebung einzurichten." || echo "Runs all installation scripts to setup the development environment."
            ;;
        *) 
            [[ $LANGUAGE == "de" ]] && echo "Installiert ein Entwicklungswerkzeug." || echo "Installs a development tool."
            ;;
    esac
}

# -------- Main Header Loop --------
for file in *.sh; do 
    [[ "$file" == "add_headers.sh" ]] && continue 

    if ! grep -q "Author: Lien Nguyen" "$file" && ! grep -q "Autor: Lien Nguyen" "$file"; then 
        echo "Adding header to "$file"
        DESCRIPTION=$(get_description "$file")
        CREATED_DATE=$(date +%Y-%m-%d)

        if [[ $LANGUAGE == "de" ]]; then 
            HEADER=$(cat <<EOF 
#! bin/bash
#
# Beschreibung: $DESCRIPTION
#
# Autor: Lien Nguyen
# Erstellt: $CREATED_DATE
# License: MIT
#
# Verwendung:
# ./$file
#
# Hinweise:
# - Dieses Skript setzt Ubuntu als Betriebssystem voraus.
#

EOF 
)
        else
            HEADER=$(cat <<EOF
#!/bin/bash
#
# $file
#
# Description: $DESCRIPTION
#
# Author: Lien Nguyen
# Created: $CREATED_DATE
# License: MIT
#
# Usage:
#   ./$file
#
# Notes:
#   - This script assumes Ubuntu as the operating system.
#

EOF
)
        fi 

        TEMP_FILE=$(mktemp)
        echo "$HEADER" > "$TEMP_FILE"
        cat "$file" >> "$TEMP_FILE"
        mv "$TEMP_FILE" "$file"
        chmod +x "$file"

    else 
        echo "$file already has a header. Skipping."
    fi
done

echo "Headers added where needed (language: $LANGUAGE)."
