#!/usr/bin/env bash
# =====================================================
# Core alias logic for git-recently
# Author: Ibrahim Ben Salah (@barhouum7)
# =====================================================

### ALIAS START ###
!{ git ls-files -m; git ls-files --others --exclude-standard; } | xargs -r stat -c \"%y %n\" 2>/dev/null | sort -r | awk '{ts=$1\" \"$2; $1=$2=\"\"; printf \"\\033[2m%s\\033[0m  \\033[1;32m%s\\033[0m\\n\", ts, substr($0,3)}'
### ALIAS END ###