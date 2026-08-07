#!/usr/bin/env bash

LOG_FILE="${1:-dmesg}"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: log file not found: $LOG_FILE" >&2
    exit 1
fi

grep -m1 -E '^\[ *0\.000000\] Linux version' "$LOG_FILE"
