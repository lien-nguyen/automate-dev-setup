#!/bin/bash

set -e

echo "Installing Google Chrome..."

wget -O ~/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt-get install -y ~/chrome.deb
rm ~/chrome.deb

echo "✅ Chrome installed."