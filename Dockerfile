
FROM ubuntu:24.04

# Remove cache and install required tools
RUN apt-get update && apt-get install -y sudo make wget && rm -rf /var/lib/apt/list/*

# Create the user testadmin with sudo rights and no password prompt
RUN useradd -m -s /bin/bash testadmin \
    && usermod -aG sudo testadmin \
    && echo 'testadmin ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/testadmin

# Create a folder for the dev scripts
RUN mkdir -p /home/testadmin/devsetup

# Copy all files into the devsetup folder
COPY . /home/testadmin/devsetup

# Set execute permissions recursively for all scripts in the setup-dev-env folder
RUN find /home/testadmin/devsetup/setup-dev-env -type f -name "*.sh" -exec chmod +x {} \;

USER testadmin

# Set WORKDIR to the devsetup folder
WORKDIR /home/testadmin/devsetup