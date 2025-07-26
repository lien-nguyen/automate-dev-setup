SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help 

SCRIPT_DIR := setup-dev-env
HELPERS_DIR := $(SCRIPT_DIR)/helpers

.PHONY: help setup all git pyenv vscode docker dbeaver chrome headers lint clean

## help: Show all available Make targets
help:
	@grep -E '^[a-zA-Z_-]+:.*?## ' Makefile | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "%-15s %s\n", $$1, $$2}' 

## setup: Run full setup script
setup: 
	@$(SCRIPT_DIR)/setup-all.sh 

## all: Run all individual install scripts
all: git pyenv python vscode docker dbeaver chrome

## git: Install Git 
git:
	@$(SCRIPT_DIR)/install-git.sh 

## pyenv: Install pyenv 
pyenv:
	@$(SCRIPT_DIR)/install-pyenv.sh 

## python: Install Python via pyenv
python:
	@$(SCRIPT_DIR)/install-python.sh

## vscode: Install Visual Studio Code
vscode:
	@$(SCRIPT_DIR)/install-vscode.sh  

## docker: Install Docker
docker:
	@$(SCRIPT_DIR)/install-docker.sh 

## dbeaver: Install Dbeaver SQL Client 
dbeaver:
	@$(SCRIPT_DIR)/install-dbeaver.sh 

## chrome: Install Google Chrome
chrome:
	@$(SCRIPT_DIR)/install-chrome.sh

## lint: Run ShellCheck on all scripts
lint:
	@shellcheck $(SCRIPT_DIR)/*.sh $(HELPERS_DIR)/*.sh || true

## clean: Remove downloaded .deb or temp files 
clean:
	@rm -f  $(SCRIPT_DIR)/*.deb  $(SCRIPT_DIR)/*.gpg



