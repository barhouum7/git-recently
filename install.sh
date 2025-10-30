#!/usr/bin/env bash
# =====================================================
# git-recently Installer Script
# Author: Ibrahim Ben Salah (@barhouum7)
# Repository: https://github.com/barhouum7/git-recently
# =====================================================

set -e

REPO_URL="https://raw.githubusercontent.com/barhouum7/git-recently/master"
ALIAS_NAME="recent"

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

# Remove old alias if it exists
git config --global --remove-section alias.$ALIAS_NAME >/dev/null 2>&1 || true

# ------------- ALIAS DEFINITION -------------
# Injecting the alias command directly here
# Escaped properly for Git config storage
ALIAS_CMD="!{ git ls-files -m; git ls-files --others --exclude-standard; } | xargs -r stat -c \"%y %n\" 2>/dev/null | sort -r | awk '{ts=$1\" \"$2; $1=$2=\"\"; printf \"\\033[2m%s\\033[0m  \\033[1;32m%s\\033[0m\\n\", ts, substr($0,3)}'"

# ------------- INSTALL ALIAS -------------
GITCONFIG="$HOME/.gitconfig"
BACKUP="$HOME/.gitconfig.bak_$(date +%s)"

log_info "Backing up existing .gitconfig to $BACKUP"
cp "$GITCONFIG" "$BACKUP" 2>/dev/null || true

log_info "Installing 'git $ALIAS_NAME' alias globally..."
git config --global alias.$ALIAS_NAME "$ALIAS_CMD"

# ------------- VERIFY INSTALLATION -------------
if git config --global --get alias.$ALIAS_NAME >/dev/null; then
  echo
  log_info "✅ Successfully installed 'git $ALIAS_NAME'!"
  echo
  log_info "👉 Try it out:"
  echo "   git recent"
  echo
  log_info "🧠 Tip: Run inside any Git repo to see your most recently modified files."
else
  log_error "Installation failed. Please check your global .gitconfig manually."
  echo "Backup saved at: $BACKUP"
  exit 1
fi