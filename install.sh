#!/usr/bin/env bash
# =====================================================
# git-recently Installer Script
# Author: Ibrahim Ben Salah (@barhouum7)
# Repository: https://github.com/barhouum7/git-recently
# Version: 1.0.0
# =====================================================

set -e

REPO_URL="https://raw.githubusercontent.com/barhouum7/git-recently/master"
ALIAS_NAME="recent"

# ------------- ALIAS DEFINITION -------------
# Injecting the alias command directly here
# Escaped properly for Git config storage
# Portable alias using POSIX-safe syntax
ALIAS_CMD='!{ git ls-files -m; git ls-files --others --exclude-standard; } | awk NF | xargs -r stat -c "%y %n" 2>/dev/null | sort -r | awk '"'"'{ts=$1" "$2; $1=$2=""; printf "\033[2m%s\033[0m  \033[1;32m%s\033[0m\n", ts, substr($0,3)}'"'"''

# ALIAS_CMD='!{ git ls-files -m; git ls-files --others --exclude-standard; } | tr -d "\r" | awk NF | sort -u | xargs -r -d "\n" stat -c "%y %n" 2>/dev/null | sort -r | awk '\''{ts=$1" "$2; $1=$2=""; printf "\033[2m%s\033[0m  \033[1;32m%s\033[0m\n", ts, substr($0,3)}'\'''


# ------------- COLORS & LOGGING -------------
BOLD=$(tput bold 2>/dev/null || echo "")
GREEN=$(tput setaf 2 2>/dev/null || echo "")
RED=$(tput setaf 1 2>/dev/null || echo "")
YELLOW=$(tput setaf 3 2>/dev/null || echo "")
RESET=$(tput sgr0 2>/dev/null || echo "")

log_info()  { echo "${BOLD}${GREEN}[+]${RESET} $1"; }
log_warn()  { echo "${BOLD}${YELLOW}[!]${RESET} $1"; }
log_error() { echo "${BOLD}${RED}[x]${RESET} $1" >&2; }

# ------------- OS DETECTION -------------
detect_os() {
  case "$(uname -s)" in
    Darwin) echo "macos" ;;
    Linux)
      if grep -qi microsoft /proc/version 2>/dev/null; then
        echo "wsl"
      else
        echo "linux"
      fi
      ;;
    MINGW*|MSYS*|CYGWIN*) echo "windows" ;;
    *) echo "unknown" ;;
  esac
}
OS=$(detect_os)

if [ "$OS" = "unknown" ]; then
  log_error "Unsupported OS. Only Linux, macOS, Windows (Git Bash), and WSL are supported."
  exit 1
fi

# ------------- REQUIREMENTS CHECK -------------
if ! command -v git &>/dev/null; then
  log_error "Git is not installed. Please install Git first."
  exit 1
fi

# macOS `stat` compatibility
if ! command -v stat &>/dev/null && ! command -v gstat &>/dev/null; then
  if [ "$OS" = "macos" ]; then
    log_warn "'stat' missing. Installing coreutils (for gstat)..."
    brew install coreutils || log_warn "Failed to install coreutils. You may need to run 'brew install coreutils' manually."
  else
    log_warn "'stat' command missing. Some systems may require 'coreutils'."
  fi
fi


# ------------- SCRIPT BANNER -------------

# ------------- INSTALL TOOLS (optional cosmetics) -------------

install_tool() {
  local tool="$1"
  local install_cmd="$2"
  if ! command -v "$tool" &>/dev/null; then
    log_warn "$tool not found. Attempting to install..."
    eval "$install_cmd" || log_warn "Could not install $tool. Skipping."
  fi
}


# Ensure figlet and lolcat are installed for banner display (if possible)
case "$OS" in
  macos)
    install_tool figlet "brew install figlet"
    install_tool lolcat "brew install lolcat"
    ;;
  linux|wsl)
    install_tool figlet "sudo apt-get update -y && sudo apt-get install -y figlet"
    install_tool lolcat "sudo apt-get install -y lolcat"
    ;;
  windows)
    # Skip automatic install on Windows (optional only)
    log_warn "Skipping figlet/lolcat setup (not required on Windows)."
    ;;
esac

# ------------- BANNER -------------
echo
echo "${BOLD}${GREEN}   ============================================================${RESET}"
if command -v figlet &>/dev/null; then
  if command -v lolcat &>/dev/null; then
    figlet -f slant "git-recently" | sed 's/^/   /' | lolcat -a -d 1
  else
    figlet -f slant "git-recently" | sed 's/^/   /'
  fi
else
  echo "      git-recently"
fi
echo "${BOLD}${GREEN}      Version 1.0.0 | Author: Ibrahim Ben Salah (@barhouum7) ${RESET}"
echo "${BOLD}${GREEN}      Repository: github.com/barhouum7/git-recently ${RESET}"
echo "${BOLD}${GREEN}   ============================================================${RESET}"
echo

# ------------- BACKUP CONFIG -------------
GITCONFIG="$HOME/.gitconfig"
BACKUP="$HOME/.gitconfig.bak_$(date +%s)"
if [ -f "$GITCONFIG" ]; then
  log_info "Backing up existing .gitconfig → $BACKUP"
  cp "$GITCONFIG" "$BACKUP" 2>/dev/null || true
fi

# ------------- REMOVE OLD ALIAS -------------
git config --global --unset "alias.$ALIAS_NAME" >/dev/null 2>&1 || true

# ------------- INSTALL ALIAS -------------
log_info "Installing 'git $ALIAS_NAME' alias globally..."
git config --global alias."$ALIAS_NAME" "$ALIAS_CMD"

# ------------- VERIFY INSTALLATION -------------
STORED_ALIAS=$(git config --global --get alias.$ALIAS_NAME)
if [ "$STORED_ALIAS" = "$ALIAS_CMD" ]; then
  echo
  log_info "✅ Successfully installed 'git $ALIAS_NAME'!"
  echo
  log_info "👉 Try it out:"
  echo "   git recent"
  echo
  log_info "🧠 Tip: Run it inside any Git repo to see recently modified (unstaged/untracked) files."
else
  log_error "Installation verification failed. Backup saved at: $BACKUP"
  exit 1
fi

# ------------- POST-INSTALL NOTE FOR WINDOWS -------------
if [ "$OS" = "windows" ] || [ "$OS" = "wsl" ]; then
  echo
  log_info "💡 Note for Windows/WSL Users:"
  echo "   - Run 'git recent' inside Git Bash or WSL terminal."
  echo "   - If colors don't display correctly, enable ANSI colors in Git Bash terminal settings."
  echo "   - PowerShell users can also run via the PowerShell installer './install.ps1' if Git Bash isn't available."
  echo
fi