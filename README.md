# automate-dev-setup

A collection of scripts and tools to quickly set up a complete development environment on Ubuntu, WSL, or inside a Docker container. Supports individual and full installs with easy Makefile orchestration.

## Quick Start Guide

You can use this repo to set up your development environment either inside a Docker container or directly on Ubuntu/WSL.

### 1. Clone the repo

```bash
git clone https://github.com/lien-nguyen/automate-dev-setup.git
cd automate-dev-setup
``` 

### 2. Run in Docker (recommended for testing)
```bash
docker build -t devsetup .
docker run -it --rm devsetup
# inside the container:
make all   # Installs all tools automatically
```

### 3. Run directly on Ubuntu / WSL
```bash
make all  # Installs all tools automatically
```

## What gets installed

The setup scripts will automatically install the following development tools:

- Git
- pyenv (Python version manager)
- Python 13.3.0 (via pyenv)
- Visual Studio Code
- Docker
- DBeaver (SQL client)
- Google Chrome

> **Tip:**  
> You can also install any of these tools individually using `make <tool>` (e.g., `make docker`).

## Prerequisites

- Docker (if using container)
- GNU Make
- Bash

## Notes

- After installation, run `source ~/.bashrc` (or open a new terminal) to use pyenv and the installed Python versions.
- The setup script installs Python 13.3.0 by default. You can install other Python versions anytime using:
	```bash
	pyenv install <version>
	# for example:
	pyenv install 3.12.2
	```