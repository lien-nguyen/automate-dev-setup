
# automate-dev-setup

A collection of scripts and tools to quickly set up a complete development environment on Ubuntu, WSL, or inside a Docker container. Supports individual and full installs with easy Makefile orchestration.

## Quick Start Guide

You can use this repo to set up your development environment either inside a Docker container or directly on Ubuntu/WSL.

## Prerequisites

- Docker (if using container)
- GNU Make
- Bash

### 1. Clone the repo

```bash
https://github.com/lien-nguyen/automate-dev-setup.git
cd automate-dev-setup
``` 

### 2. Run in Docker (recommended for testing)
```bash
docker build -t devsetup .
docker run -it --rm devsetup
# inside the container:
make all    # Installs all tools automatically
```

### 3. Run directly on Ubuntu / WSL
```bash
make all    # Installs all tools automatically
```

> **Tip:**  
> Use `make <tool>` to install a specific tool (e.g., `make docker`).

## Notes

- After installation, run `source ~/.bashrc` (or open a new terminal) to use pyenv and the installed Python versions.
- The setup script installs Python 13.3.0 by default. You can install other Python versions anytime using:
	```bash
	pyenv install <version>
	# for example:
	pyenv install 3.12.2
	```


