#!/bin/bash

#
# Reference: Official download page for DBeaver https://dbeaver.io/download/
# Maintainer: Lien Nguyen
# See LICENSE and README for details.
#

set -e

echo "Installing DBeaver..."

wget -O ~/dbeaver.deb https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
sudo apt-get install -y ~/dbeaver.deb
rm ~/dbeaver.deb

echo "✅ DBeaver installed."