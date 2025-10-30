#!/usr/bin/env bash
# ============================================
# git-recently Installer Script
# Author: Ibrahim Ben Salah (@barhouum7)
# ============================================

set -e

REPO_NAME="git-recently"
ALIAS_NAME="recent"
SRC_DIR="$(cd "$(dirname "$0")" && pwd)/src"

# Colors
BOLD=$(tput bold)
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

# Logging functions
log_info()  { echo "${BOLD}${GREEN}[+]${RESET} $1"; }
log_error() { echo "${BOLD}${RED}[!]${RESET} $1" >&2; }

# Detect OS
detect_os() {
  case "$(uname -s)" in
    Darwin) echo "macos" ;;
    Linux) echo "linux" ;;
    *) echo "unknown" ;;
  esac
}

OS=$(detect_os)
if [ "$OS" = "unknown" ]; then
  log_error "Unsupported OS. This script supports Linux and macOS only."
  exit 1
fi

# Load alias logic
source "$SRC_DIR/core_alias.sh"

# Inject alias into Git config
log_info "Installing 'git $ALIAS_NAME' alias into your global gitconfig..."
git config --global alias.$ALIAS_NAME "!bash -c '$GIT_RECENT_ALIAS'"

# Verify installation
if git $ALIAS_NAME &>/dev/null; then
  log_info "✅ Successfully installed! Try running: git recent"
else
  log_error "Installation failed. Please check your git configuration .gitconfig manually."
  exit 1
fi