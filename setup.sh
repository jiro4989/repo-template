#!/bin/bash

sedw() {
  for f in "$@"; do
    local tmpf="$f.tmp"
    sed -f setup.sed "$f" > "$tmpf"
    mv "$tmpf" "$f"
    echo "[INFO] $f was replaced"
  done
}

grep -q -e YYYY -e YOUR_NAME -e YOUR_GITHUB_ID setup.sed
exit_code=$?
if [[ "$exit_code" -eq 0 ]]; then
  echo "[ERR] must set values to 'setup.sed'"
  exit 1
fi

set -eu

sedw LICENSE
sedw .github/ISSUE_TEMPLATE/*
sedw .github/workflows/*
rm setup.sed
rm setup.sh
echo "[INFO] success"
