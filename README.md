# automate-dev-setup

Scripts to quickly set up a development environment on Ubuntu, WSL, or in a Docker container.

### Quick Start

1. **Clone the repo:**
   ```bash
   git clone https://github.com/lien-nguyen/automate-dev-setup.git
   cd automate-dev-setup
   ```

2. **Run in Docker (recommended for testing):**
   ```bash
   docker build -t devsetup .
   docker run -it --rm devsetup
   # inside the container:
   make all
   ```

3. **Run directly on Ubuntu/WSL:**
   ```bash
   make all
   ```

> **Tip:** Use `make <tool>` to install a specific tool (e.g., `make docker`).

### What Gets Installed

- Git
- pyenv (Python version manager)
- Python 13.3.0 (via pyenv)
- Visual Studio Code
- Docker
- DBeaver (SQL client)
- Google Chrome

### Prerequisites

- Docker (if using container)
- GNU Make
- Bash

### Notes

- After installation, run `source ~/.bashrc` (or open a new terminal) to use pyenv and the installed Python versions.
- Python 13.3.0 is installed by default. To install other Python versions:
  ```bash
  pyenv install <version>
  # Example:
  pyenv install 3.12.2
  ```

---

### Advanced & Troubleshooting

#### Verify Installation
Check installed versions:
```bash
python --version      # Python
pyenv --version      # pyenv
git --version        # Git
docker --version     # Docker
code --version       # VSCode
dbeaver --version    # DBeaver
```

#### Docker Permissions
If you see a Docker permission error:
1. Start Docker:
   ```bash
   sudo service docker start
   ```
2. Add your user to the docker group:
   ```bash
   sudo usermod -aG docker $USER
   ```
3. Log out and log back in, or run:
   ```bash
   newgrp docker
   ```
4. Try again:
   ```bash
   docker version
   ```

---



