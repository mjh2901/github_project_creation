# github_project_creation.sh

A Bash script to bootstrap new projects locally and on GitHub.

It creates a project folder in the current directory, initializes a Git repository, generates a `README.md` and a starter shell script, creates a matching GitHub repository (via [GitHub CLI](https://cli.github.com/)), and pushes the initial commit.

---

## Features

- Prompts for a project name  
- Creates a matching folder in the current directory  
- Initializes a Git repository  
- Adds a `README.md` file and a starter shell script `<project>.sh`  
- Sets local Git identity for container-safe usage  
- Creates a GitHub repo and pushes automatically

---

## Requirements

- **Git** installed  
- **GitHub CLI (`gh`)** installed and authenticated

Supported platforms:

- **macOS**
- **Linux**
- **Windows (WSL / Linux subsystem)**
- **Docker / code-server** (optional, container-safe)

---

## Setup Instructions

Follow these steps to get started:

### 1. Install Git

**macOS:**

```bash
brew install git
```

**Linux / WSL (Debian/Ubuntu):**

```bash
sudo apt update
sudo apt install git -y
```

---

### 2. Install GitHub CLI

**macOS:**

```bash
brew install gh
```

**Linux / WSL:**

```bash
sudo apt update
sudo apt install gh -y
```

---

### 3. Authenticate GitHub CLI

```bash
gh auth login
```

- Select **GitHub.com**  
- Choose **SSH** or **HTTPS (token)**  
- If using WSL or Docker, ensure SSH keys or token are accessible inside the environment

---

### 4. Configure Git identity

```bash
git config --global user.name "Your Name"
git config --global user.email "your_email@example.com"
```

- If you have GitHub “Keep my email addresses private” enabled, use your **GitHub-provided noreply email**:

```
12345678+username@users.noreply.github.com
```

- Verify configuration:

```bash
git config --list
```

---

### 5. Make the script executable

```bash
chmod +x github_project_creation.sh
```

---

### 6. Run the script

```bash
./github_project_creation.sh
```

- Enter the project name when prompted  
- Script will:
  - Create a project folder in the current directory  
  - Initialize Git and set repo-local identity  
  - Generate `README.md` and a starter `.sh` script  
  - Create a GitHub repo and push the initial commit

---

### 7. Docker / code-server (optional)

- Mount `.gitconfig` to container to make Git identity available:

```yaml
volumes:
  - ./config/gitconfig:/home/coder/.gitconfig:ro
```

- The script sets **repo-local identity** automatically so commits work in code-server Source Control panel

---

## Notes

- These steps work across **macOS, Linux, Windows WSL**, and containerized environments  
- Ensures your Git commits are associated with your GitHub account, avoiding “Please tell me who you are” errors

---

## License

MIT License — free to use, modify, and share.

