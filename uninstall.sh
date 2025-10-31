#!/usr/bin/env bash
# =====================================================
# git-recently Uninstaller Script
# Author: Ibrahim Ben Salah (@barhouum7)
# =====================================================

set -e
ALIAS_NAME="recent"

BOLD=$(tput bold 2>/dev/null || echo "")
GREEN=$(tput setaf 2 2>/dev/null || echo "")
RED=$(tput setaf 1 2>/dev/null || echo "")
RESET=$(tput sgr0 2>/dev/null || echo "")

log_info()  { echo "${BOLD}${GREEN}[+]${RESET} $1"; }
log_error() { echo "${BOLD}${RED}[x]${RESET} $1" >&2; }

if git config --global --get alias.$ALIAS_NAME >/dev/null; then
  git config --global --unset alias.$ALIAS_NAME
  log_info "Removed 'git $ALIAS_NAME' alias."
else
  log_info "No 'git $ALIAS_NAME' alias found. Nothing to remove."
fi

BACKUPS=$(ls -1t "$HOME"/.gitconfig.bak_* 2>/dev/null | head -1 || true)
if [ -n "$BACKUPS" ]; then
  read -p "🔄 Restore last backup ($BACKUPS)? [y/N]: " yn
  case "$yn" in
    [Yy]*) cp "$BACKUPS" "$HOME/.gitconfig"; log_info "Backup restored from $BACKUPS." ;;
    *) log_info "Skipped restoring backup." ;;
  esac
fi

log_info "✅ Uninstallation complete."
