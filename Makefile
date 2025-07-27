
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help

SCRIPT_DIR := setup-dev-env
HELPERS_DIR := $(SCRIPT_DIR)/helpers

# set color 
COLOR_CYAN  := \033[1;36m
COLOR_GREEN := \033[1;32m
COLOR_RESET := \033[0m

.PHONY: help setup all git pyenv vscode docker dbeaver chrome headers lint install-lint clean

# show all available Make targets
help:
	@command -v grep >/dev/null 2>&1 && command -v awk >/dev/null 2>&1 && \
	grep -E '^[a-zA-Z_-]+:.*?## ' Makefile | \
	awk 'BEGIN {FS = ":.*?## "; cyan = "$(COLOR_CYAN)"; reset = "$(COLOR_RESET)"} {printf "%s%-15s%s %s\n", cyan, $$1, reset, $$2}' || \
	echo "Available targets:" && \
	awk -F: '/^[a-zA-Z_-]+:/ {print $$1}' Makefile | grep -v '^\.' | xargs -I{} printf "$(COLOR_CYAN)%s$(COLOR_RESET)\n" {}

# run full setup script
setup: 
	@$(SCRIPT_DIR)/setup-all.sh 


# run all individual install scripts and print summary
all:
	@START_TIME=$$(date +%s); \
	printf "%b\n" "$(COLOR_GREEN)[ALL]$(COLOR_RESET) Running all install scripts..."; \
	printf "%b\n" "$(COLOR_CYAN)[1/7]$(COLOR_RESET) Installing Git..." && $(MAKE) git; \
	printf "%b\n" "$(COLOR_CYAN)[2/7]$(COLOR_RESET) Installing pyenv..." && $(MAKE) pyenv; \
	printf "%b\n" "$(COLOR_CYAN)[3/7]$(COLOR_RESET) Installing Python..." && $(MAKE) python; \
	printf "%b\n" "$(COLOR_CYAN)[4/7]$(COLOR_RESET) Installing VSCode..." && $(MAKE) vscode; \
	printf "%b\n" "$(COLOR_CYAN)[5/7]$(COLOR_RESET) Installing Docker..." && $(MAKE) docker; \
	printf "%b\n" "$(COLOR_CYAN)[6/7]$(COLOR_RESET) Installing DBeaver..." && $(MAKE) dbeaver; \
	printf "%b\n" "$(COLOR_CYAN)[7/7]$(COLOR_RESET) Installing Chrome..." && $(MAKE) chrome; \
	END_TIME=$$(date +%s); \
	DURATION=$$((END_TIME-START_TIME)); \
	MIN=$$((DURATION/60)); SEC=$$((DURATION%60)); \
	printf "\n%b\n" "$(COLOR_GREEN)✅ All tools installed successfully in $${DURATION} seconds ($$(printf '%02d:%02d' $$MIN $$SEC))!$(COLOR_RESET)"

# install Git 
git:
	@$(SCRIPT_DIR)/install-git.sh 

# install pyenv 
pyenv:
	@$(SCRIPT_DIR)/install-pyenv.sh 

# install Python via pyenv
python:
	@$(SCRIPT_DIR)/install-python.sh

# install Visual Studio Code
vscode:
	@$(SCRIPT_DIR)/install-vscode.sh  

# install Docker
docker:
	@$(SCRIPT_DIR)/install-docker.sh 

# install SQL Client 
dbeaver:
	@$(SCRIPT_DIR)/install-dbeaver.sh 

## install Google Chrome
chrome:
	@$(SCRIPT_DIR)/install-chrome.sh

# install shellcheck linter (Debian/Ubuntu)
install-lint:
	@echo -e "$(COLOR_CYAN)[LINT]$(COLOR_RESET) Installing shellcheck..."
	sudo apt-get update && sudo apt-get install -y shellcheck
	@echo -e "$(COLOR_GREEN)[LINT]$(COLOR_RESET) shellcheck installed."

# install ShellCheck on all scripts
lint:
	@shellcheck $(SCRIPT_DIR)/*.sh $(HELPERS_DIR)/*.sh || true

# remove downloaded .deb or temp files 
clean:
	@rm -f  $(SCRIPT_DIR)/*.deb  $(SCRIPT_DIR)/*.gpg



