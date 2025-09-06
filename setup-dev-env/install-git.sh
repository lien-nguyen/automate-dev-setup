#!/bin/bash
#
# Reference: Official installation instructions for git https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
# Maintainer: Lien Nguyen
# See LICENSE and README for details.
#

set -e 

# Ensure tzdata is installed and set timezone to Europe/Berlin non-interactively
export DEBIAN_FRONTEND=noninteractive
echo 'tzdata tzdata/Areas select Europe' | sudo debconf-set-selections
echo 'tzdata tzdata/Zones/Europe select Berlin' | sudo debconf-set-selections
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata --no-install-recommends
sudo ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime
sudo dpkg-reconfigure -f noninteractive tzdata


echo "Installing latest Git version..."
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common
sudo add-apt-repository ppa:git-core/ppa -y
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y git

git --version
echo "Git installed."