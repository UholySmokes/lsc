#!/usr/bin/env bash
set -euo pipefail

# Example watchdog for cloud archival health.
# Env vars:
#   WATCH_PATH - local directory where new event files appear
#   MAX_AGE_SECONDS - max age for newest file before failing

WATCH_PATH="${WATCH_PATH:-/var/lib/lsc-events}"
MAX_AGE_SECONDS="${MAX_AGE_SECONDS:-600}"

if [[ ! -d "$WATCH_PATH" ]]; then
  echo "ERROR: watch path missing: $WATCH_PATH" >&2
  exit 2
fi

latest_file="$(find "$WATCH_PATH" -type f -printf '%T@ %p\n' | sort -nr | head -n1 | cut -d' ' -f2-)"
if [[ -z "$latest_file" ]]; then
  echo "WARN: no files found in $WATCH_PATH"
  exit 1
fi

latest_epoch="$(stat -c %Y "$latest_file")"
now_epoch="$(date +%s)"
age="$((now_epoch-latest_epoch))"

if (( age > MAX_AGE_SECONDS )); then
  echo "ERROR: newest file is too old (${age}s): $latest_file" >&2
  exit 1
fi

echo "OK: latest file age=${age}s file=$latest_file"
