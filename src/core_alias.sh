#!/usr/bin/env bash
# =====================================================
# Core alias logic for git-recently
# Author: Ibrahim Ben Salah (@barhouum7)
# =====================================================

### ALIAS START ###
files=$(git status --porcelain | awk '{print $2}' | sort -u)
if [ -z "$files" ]; then
  echo "No unstaged or untracked files."
  exit 0
fi

tmpfile=$(mktemp)

for f in $files; do
  if [ -e "$f" ]; then
    ts=$(stat -c "%y" "$f" 2>/dev/null || gstat -f "%Sm" -t "%Y-%m-%d %H:%M:%S" "$f")
    printf "%s %s\n" "$ts" "$f" >> "$tmpfile"
  fi
done

sort -r "$tmpfile"
rm -f "$tmpfile"
### ALIAS END ###