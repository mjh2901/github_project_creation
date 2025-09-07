#!/bin/bash
#
# github_project_creation.sh
#
# A Bash script to bootstrap new projects locally and on GitHub.
#
# Features:
# - Creates a project folder in the current directory
# - Initializes Git, generates README.md and a starter shell script
# - Sets repo-local Git identity (container-safe)
# - Creates a matching GitHub repo and pushes the initial commit
#
# Requirements:
# - Git installed
# - GitHub CLI (`gh`) installed and authenticated
#
# Supported platforms:
# - macOS
# - Linux
# - Windows WSL
# - Docker / code-server (optional)
#
# Setup instructions:
# 1. Install Git:
#    macOS: brew install git
#    Linux/WSL: sudo apt install git -y
#
# 2. Install GitHub CLI:
#    macOS: brew install gh
#    Linux/WSL: sudo apt install gh -y
#
# 3. Authenticate CLI:
#    gh auth login
#
# 4. Configure Git identity:
#    git config --global user.name "Your Name"
#    git config --global user.email "your_email@example.com"
#    (use GitHub noreply email if privacy enabled)
#
# 5. Make script executable:
#    chmod +x github_project_creation.sh
#
# Usage:
#    ./github_project_creation.sh
#
# Docker / code-server tips:
# - Mount ~/.gitconfig to container to make Git identity available
# - Script sets repo-local identity automatically for commits
#

# --- CONFIGURATION ---
GITHUB_USER="mjh2901"

# --- SCRIPT START ---

# Check global Git identity
GIT_NAME=$(git config --global user.name)
GIT_EMAIL=$(git config --global user.email)

if [[ -z "$GIT_NAME" || -z "$GIT_EMAIL" ]]; then
  echo "❌ Git user.name or user.email not set globally!"
  echo "Set it globally or ensure a .gitconfig is mounted in the container:"
  echo "  git config --global user.name \"Your Name\""
  echo "  git config --global user.email \"your_email@example.com\""
  exit 1
fi

# Ask for project name
read -p "Enter the project name: " PROJECT

# Directory where script is run
BASE_DIR="$(pwd)"

# Create project directory
PROJECT_DIR="$BASE_DIR/$PROJECT"
echo "📂 Creating project directory at: $PROJECT_DIR"
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR" || { echo "❌ Failed to cd into $PROJECT_DIR"; exit 1; }

# Initialize git repository
git init

# --- Container-safe: set local Git identity ---
git config user.name "$GIT_NAME"
git config user.email "$GIT_EMAIL"

# Create README.md
echo "# $PROJECT" > README.md

# Create project shell script
cat <<EOF > "$PROJECT.sh"
#!/bin/bash
# $PROJECT script

echo "Running $PROJECT..."
EOF
chmod +x "$PROJECT.sh"

# Initial commit
git add .
git commit -m "Initial commit"

# Create GitHub repo using gh CLI and push
echo "🌐 Creating GitHub repo $GITHUB_USER/$PROJECT..."
gh repo create "$GITHUB_USER/$PROJECT" --public --source=. --remote=origin --push

echo "✅ Project '$PROJECT' created locally at $PROJECT_DIR and