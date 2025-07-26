
FROM ubuntu:24.04

# Lösche Cache und installiere benötigte Tools
RUN apt-get update && apt-get install -y sudo make wget && rm -rf /var/lib/apt/list/*

# Erstelle den Benutzer testadmin mit sudo-Rechten und ohnen Passwortabfrage
RUN useradd -m -s /bin/bash testadmin \
    && usermod -aG sudo testadmin \
    && echo 'testadmin ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/testadmin

# Erstelle einen Ordner für die Dev-Skripte
RUN mkdir -p /home/testadmin/devsetup

# Kopiere alle Dateien in den devsetup-Ordner
COPY . /home/testadmin/devsetup

# Setze die Ausführungsrechte für alle Skripte rekursiv im setup-dev-env-Ordner
RUN find /home/testadmin/devsetup/setup-dev-env -type f -name "*.sh" -exec chmod +x {} \;

USER testadmin

# Setze WORKDIR auf den devsetup-Ordner
WORKDIR /home/testadmin/devsetup