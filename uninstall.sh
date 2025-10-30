#!/usr/bin/env bash
# ============================================
# git-recently Uninstaller
# ============================================

set -e
ALIAS_NAME="recent"

if git config --global --get alias.$ALIAS_NAME &>/dev/null; then
  git config --global --unset alias.$ALIAS_NAME
  echo "✅ 'git $ALIAS_NAME' alias removed successfully."
else
  echo "ℹ️ No 'git $ALIAS_NAME' alias found in your config."
fi