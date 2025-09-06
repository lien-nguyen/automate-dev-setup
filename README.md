# automate-dev-setup

---
**License & Attribution**

This repository is licensed under the MIT License. While some installation commands are collected or adapted from official documentation and third-party sources, the automation, integration, and logic that make these tools work together are my own contributions. Original authorship is credited where possible; see script headers and comments for references. If you are an original author and wish to be credited or have your code removed, please open an issue or pull request.

---

Scripts to quickly set up a development environment directly on Ubuntu or WSL. 

> ⚠️ **Note:** The Dockerfile is primarily for my own testing of the installation scripts on a WSL machine. The scripts themselves are intended to be run natively on Ubuntu or WSL for actual development use. If you only want to test the scripts, see below.

### What gets installed

- Git
- pyenv (Python version manager)
- Python 13.3.0 (via pyenv)
- Visual Studio Code
- Docker
- DBeaver (SQL client)
- Google Chrome

### Quick start

1. **Clone the repo:**
   ```bash
   git clone https://github.com/lien-nguyen/automate-dev-setup.git
   cd automate-dev-setup
   ```

2. **Run directly on Ubuntu/WSL (recommended):**
   ```bash
   sudo apt-get update
   make all
   ```

3. **Test the scripts in Docker (optional, for script testing only):**
   ```bash
   docker build -t devsetup .
   docker run -it --rm devsetup
   # inside the container:
   make all
   ```

> **Tip:** Use `make <tool>` to install a specific tool (e.g., `make docker`).


### Notes

- After installation, run `source ~/.bashrc` (or open a new terminal) to use pyenv and the installed Python versions.
- Python 13.3.0 is installed by default. To install other Python versions:
  ```bash
  pyenv install <version>
  # Example:
  pyenv install 3.12.2

  # Show all installed Python versions
  pyenv versions

  # Switch to another Python version for the current directory
  pyenv local 3.12.2 
  
  # or set the global Python version for all projects
  pyenv global 3.12.2
  ```
- For more information about pyenv, see the [pyenv official website](https://github.com/pyenv/pyenv).


### Prerequisites

- Ubuntu or WSL (Windows Subsystem for Linux)
- GNU Make
- Bash
- Docker (required if you only want to test the scripts in a container)

---

### Advanced & Troubleshooting

#### Verify Installation
Check installed versions:
```bash
python --version      # Python
pyenv --version      # pyenv
git --version        # Git
docker --version     # Docker
docker compose version
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
## Contribution

Contributions, suggestions, and feedback are welcome!  
If you find any errors or have ideas for improvement, please open an issue or submit a pull request.

Thank you for helping make this project better!


