#!/usr/bin/env bash

LOG_FILE="${1:-auth.log}"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: log file not found: $LOG_FILE" >&2
    exit 1
fi

awk '
/COMMAND=.*iptables -A/ {
    count++
}
END {
    print count
}' "$LOG_FILE"
