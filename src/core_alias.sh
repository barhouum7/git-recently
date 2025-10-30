#!/usr/bin/env bash
# ============================================
# Core alias logic for git-recently
# ============================================

# Detect which 'stat' to use
if stat --version &>/dev/null; then
  STAT_CMD="stat -c %Y,%n"
else
  STAT_CMD="gstat -f '%m,%N'"
fi

# Define the core alias
read -r -d '' GIT_RECENT_ALIAS <<'EOF'
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
EOF