#!/bin/bash
#
# Reference: Official installation instructions for Google Chrome https://www.google.com/chrome/
# Maintainer: Lien Nguyen
# See LICENSE and README for details.
#

set -e

echo "Installing Google Chrome..."

wget -O ~/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt-get install -y ~/chrome.deb
rm ~/chrome.deb

echo "✅ Chrome installed."