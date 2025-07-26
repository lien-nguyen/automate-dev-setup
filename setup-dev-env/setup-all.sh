#!/bin/bash


# Track start time
START_TIME=$(date +%s)
set -e


SCRIPT_DIR="setup-dev-env"


LOG_FILE="$(pwd)/setup.log"
sudo rm -f "$LOG_FILE"
sudo chown -R "$(whoami)":"$(whoami)" "$(pwd)"
# Note: install_vscode.sh now detects WSL vs native Ubuntu and installs VS Code accordingly.
echo "Starting full dev environment setup..." | tee "$LOG_FILE"

tools=(
  install-git.sh
  install-pyenv.sh
  install-python.sh
  install-docker.sh
  install-dbeaver.sh
  install-chrome.sh
  install-vscode.sh
)


for tool in "${tools[@]}"; do
  echo "Running $tool..." | tee -a "$LOG_FILE"
  "$SCRIPT_DIR/$tool" 2>&1 | tee -a "$LOG_FILE"
  if [ ${PIPESTATUS[0]} -eq 0 ]; then
    echo "$tool finished successfully." | tee -a "$LOG_FILE"
  else
    echo "$tool failed! Check $LOG_FILE for details." | tee -a "$LOG_FILE"
    exit 1
  fi
done

# Track end time and print duration (print to console only, not to log file)
END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))
# Green color for highlight
GREEN="\033[1;32m"
NC="\033[0m"
echo -e "\n${GREEN}✅ Full installation completed in $DURATION seconds ($(printf '%02d:%02d' $((DURATION/60)) $((DURATION%60))))${NC}"
echo "All tools installed successfully!" | tee -a "$LOG_FILE"