#!/bin/bash
set -e

echo "Installing DBeaver..."

wget -O ~/dbeaver.deb https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
sudo apt-get install -y ~/dbeaver.deb
rm ~/dbeaver.deb

echo "✅ DBeaver installed."