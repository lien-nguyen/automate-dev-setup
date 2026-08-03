# automate-dev-setup

Scripts to quickly set up a development environment directly on Ubuntu. 

## Table of Contents
- [automate-dev-setup](#automate-dev-setup)
  - [Table of Contents](#table-of-contents)
    - [What gets installed](#what-gets-installed)
    - [Quick start](#quick-start)
    - [Install tools individually](#install-tools-individually)
    - [Notes](#notes)
    - [Technical Details](#technical-details)
    - [Prerequisites](#prerequisites)
    - [Advanced \& Troubleshooting](#advanced--troubleshooting)
      - [Verify Installation](#verify-installation)
      - [SSL Error when adding Git PPA (company network)](#ssl-error-when-adding-git-ppa-company-network)
      - [Docker Permissions](#docker-permissions)
      - [WSL: containers can't resolve DNS](#wsl-containers-cant-resolve-dns-apt-getpip-fail-with-temporary-failure-resolving)
      - [WSL: Docker bridge MTU mismatch](#wsl-docker-bridge-mtu-mismatch-separate-issue-can-cause-corrupted-large-transfers)
  - [Contribution](#contribution)
---
**License & Attribution**

This repository is licensed under the MIT License. While some installation commands are collected or adapted from official documentation and third-party sources, the automation, integration, and logic that make these tools work together are my own contributions. Original authorship is credited where possible; see script headers and comments for references. If you are an original author and wish to be credited or have your code removed, please open an issue or pull request.

---

This setup script is designed for **Ubuntu, including Ubuntu on WSL**.  
`make docker` and `make all` install Docker Engine natively via apt (the official Docker CE
packages), so there is no need to install Docker Desktop for Windows separately - run the full
`make all` directly in your WSL terminal.

> ⚠️ **Note:** The Dockerfile is primarily for my own testing of the installation scripts on a WSL machine. The scripts themselves are intended to be run natively on Ubuntu, whether it is a VM, a cloud instance (e.g. EC2), or a dedicated Ubuntu laptop. If you only want to test the scripts, see below.

### What gets installed

- Git: https://git-scm.com
- pyenv (Python version manager): https://github.com/pyenv/pyenv
- Python 13.3.0 (via pyenv)
- Visual Studio Code: https://code.visualstudio.com
- Docker:  https://docs.docker.com
- DBeaver (SQL client): https://dbeaver.io
- Google Chrome: https://www.google.com/chrome/

### Quick start

**Note:** You need a basic Git installation to clone this repository. The setup scripts will upgrade Git to the latest version with proper binary files.

1. **Install basic Git (if not already available):**
   ```bash
   sudo apt-get update && sudo apt-get install git

2. **Clone the repo:**
   ```bash
   git clone https://github.com/lien-nguyen/automate-dev-setup.git
   cd automate-dev-setup
   ```

3. **Run directly on Ubuntu/WSL (recommended):**
   ```bash
   sudo apt-get update
   make all
   ```

4. **Test the scripts in Docker (optional, for script testing only):**
   ```bash
   docker build -t devsetup .
   docker run -it --rm devsetup
   # inside the container:
   make all
   ```

### Install tools individually

You can install each tool separately in the following order:

```bash
make git
make pyenv
```

> **Important:** After installing pyenv, reload your shell before installing Python:
> ```bash
> exec $SHELL
> ```

```bash
make python
make vscode
make docker
make dbeaver
make chrome
```

> **Note:** After installation, run `source ~/.bashrc` or open a new terminal to use pyenv and Python in your current session.

### Notes

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

### Technical Details

This project is organized for clarity and extensibility:

- **Modular scripts:** Each tool (Git, pyenv, Python, VS Code, Docker, DBeaver, Chrome) has its own dedicated installation script in `setup-dev-env/`.
- **Makefile automation:** The `Makefile` provides simple commands to install all tools at once or individually (e.g., `make all`, `make docker`).
- **Testable in Docker:** A `Dockerfile` is included for testing the setup process in a clean, reproducible environment.
- **Helper scripts:** Utility scripts (like loading pyenv) are separated for reuse and clarity.
- **Error handling:** Scripts use `set -e` to stop on errors, and check for prerequisites before proceeding.
- **Attribution:** References to official installation sources are included in each script for transparency.

You can easily extend the setup by adding new scripts for additional tools and updating the `Makefile` accordingly.

### Prerequisites

- Ubuntu or WSL (Windows Subsystem for Linux)
- GNU Make
- Bash
- Docker (only required if you want to test the scripts in a container) - not needed for `make docker`, which installs it

> **Important:** Run the scripts as the user who will use the tools and not as root or another admin user. `pyenv` and Python are installed into `$HOME/.pyenv` and configured in `~/.bashrc`, so they are only available to the user who runs the scripts.
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

#### SSL Error when adding Git PPA (company network)

> **Note:** This issue may occur when installing tools inside a VM on a company network.

Corporate networks often use SSL inspection (MITM proxy): the proxy intercepts HTTPS traffic and re-signs certificates with the company's own root CA. A fresh VM does not trust this CA, so `add-apt-repository ppa:git-core/ppa` fails with an SSL error.

**Confirm the cause:**
```bash
curl -v https://ppa.launchpad.net 2>&1 | grep -i "issuer\|ssl\|certificate"
```
If the certificate issuer shows a company name instead of a public CA (e.g. Let's Encrypt), it is the corporate proxy.

**Fix - install the corporate root CA into the VM:**
```bash
# Ask IT for the company root CA certificate file, then:
sudo cp company-ca.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates
```
After that, re-run the script. No firewall changes are needed.

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

#### WSL: containers can't resolve DNS (`apt-get`/`pip` fail with "Temporary failure resolving...")

> **Note:** This only affects `make docker`'s native Docker Engine on WSL - Docker Desktop hides this by managing its own networking layer.

**Symptom:** any `docker build` step that hits the network fails, e.g. `apt-get update` reports
`Temporary failure resolving 'deb.debian.org'` and then `E: Unable to locate package <name>`, or
`pip install` reports `Failed to resolve 'pypi.org' ([Errno -3] Temporary failure in name
resolution)`. This happens for every image, every project - it is a host/daemon-level problem, not
specific to one Dockerfile.

**Root cause:** WSL auto-generates `/etc/resolv.conf` pointing at a special proxy address (e.g.
`10.255.255.254`) that only works for processes running directly in the WSL VM's own network
namespace. A Docker container sits behind the `docker0` bridge in its *own* separate network
namespace, so it can't reach that address - DNS queries from inside the container just time out
(`connection timed out; no servers could be reached`). Raw IP connectivity is unaffected (a
container can `ping 8.8.8.8` or `wget` a bare IP just fine); only name resolution breaks, which is
what makes the error message misleadingly point at "missing packages" instead of "no DNS".

**Fix - give Docker's embedded DNS a real public resolver instead of relying on WSL's address:**
```bash
echo '{"dns": ["8.8.8.8", "1.1.1.1"]}' | sudo tee /etc/docker/daemon.json
sudo systemctl restart docker
```
If `/etc/docker/daemon.json` already has other keys (e.g. `mtu`, see below), merge them into one
JSON object rather than overwriting the file.

**Verify the restart actually applied** (a `docker restart` that silently no-ops is easy to miss,
especially if the sudo password prompt swallows the command's own output in an interactive
terminal):
```bash
systemctl show docker --property=ActiveEnterTimestamp   # should be close to "now"
docker run --rm alpine cat /etc/resolv.conf              # should show 8.8.8.8 / 1.1.1.1, not the old address
```
Then re-run the build.

#### WSL: Docker bridge MTU mismatch (separate issue, can cause corrupted large transfers)

> **Note:** This is a different failure mode from the DNS issue above - fix DNS first, since a DNS
> failure looks similar (network-related build failures) but is unrelated to MTU.

WSL2's network interface (`eth0`) commonly runs at MTU 1492, while Docker's default bridge network
uses MTU 1500. Packets over 1492 bytes can get silently dropped or truncated, which can corrupt
larger transfers during a build even once DNS itself is working.

**Check for the mismatch:**
```bash
ip link show eth0 | grep mtu     # WSL interface MTU
ip link show docker0 | grep mtu  # Docker bridge MTU
```

**Fix - pin Docker's MTU to match WSL's** (merge into the same `daemon.json` as the DNS fix above):
```bash
echo '{"mtu": 1492, "dns": ["8.8.8.8", "1.1.1.1"]}' | sudo tee /etc/docker/daemon.json
sudo systemctl restart docker
```
If your WSL interface reports a different MTU, use that value instead of 1492.

---
## Contribution

Contributions, suggestions, and feedback are welcome!  
If you find any errors or have ideas for improvement, please open an issue or submit a pull request.

Thank you for helping make this project better!


