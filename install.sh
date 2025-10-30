#!/usr/bin/env bash
# =====================================================
# git-recently Installer Script
# Author: Ibrahim Ben Salah (@barhouum7)
# Repository: https://github.com/barhouum7/git-recently
# =====================================================

set -e

REPO_URL="https://raw.githubusercontent.com/barhouum7/git-recently/master"
ALIAS_NAME="recent"
GIT_CORE_URL="$REPO_URL/src/core_alias.sh"

# ------------- COLORS & LOGGING -------------
BOLD=$(tput bold)
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

log_info()  { echo "${BOLD}${GREEN}[+]${RESET} $1"; }
log_warn()  { echo "${BOLD}${YELLOW}[!]${RESET} $1"; }
log_error() { echo "${BOLD}${RED}[x]${RESET} $1" >&2; }

# ------------- OS DETECTION -------------
detect_os() {
  case "$(uname -s)" in
    Darwin) echo "macos" ;;
    Linux) echo "linux" ;;
    *) echo "unknown" ;;
  esac
}
OS=$(detect_os)
if [ "$OS" = "unknown" ]; then
  log_error "Unsupported OS. Only Linux and macOS are supported."
  exit 1
fi

# ------------- REQUIREMENTS CHECK -------------
if ! command -v git &>/dev/null; then
  log_error "Git is not installed. Please install Git first."
  exit 1
fi

if ! command -v stat &>/dev/null && ! command -v gstat &>/dev/null; then
  log_error "'stat' command not found. Install coreutils (e.g., 'brew install coreutils' on macOS)."
  exit 1
fi

# ------------- FETCH CORE LOGIC -------------
log_info "Fetching alias logic from GitHub..."
if ! GIT_RECENT_ALIAS=$(curl -fsSL "$GIT_CORE_URL" | sed -n '/^### ALIAS START ###/,/^### ALIAS END ###/p' | sed '1d;$d'); then
  log_error "Failed to fetch alias logic from $GIT_CORE_URL"
  exit 1
fi

if [ -z "$GIT_RECENT_ALIAS" ]; then
  log_error "No alias logic fetched. Check the repository content or URL."
  exit 1
fi

# ------------- INSTALL ALIAS -------------
log_info "Installing 'git $ALIAS_NAME' alias globally..."
git config --global alias.$ALIAS_NAME "!bash -c '$GIT_RECENT_ALIAS'"

# ------------- VERIFY -------------
if git $ALIAS_NAME &>/dev/null; then
  log_info "✅ Successfully installed 'git $ALIAS_NAME'!"
  echo
  log_info "👉 Try it out:"
  echo "   git recent"
  echo
  log_info "🧠 Tip: Run inside any Git repo to see your most recently modified files."
else
  log_error "Installation failed. Please check your global .gitconfig manually."
  exit 1
fi