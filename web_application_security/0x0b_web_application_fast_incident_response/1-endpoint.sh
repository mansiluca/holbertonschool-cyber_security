#!/usr/bin/env bash

LOG_FILE="${1:-logs.txt}"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: log file not found: $LOG_FILE" >&2
    exit 1
fi

if [ ! -s "$LOG_FILE" ]; then
    echo "Error: log file is empty: $LOG_FILE" >&2
    exit 1
fi

awk -F'"' '{
    split($2, req, " ")
    print req[2]
}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -1 | awk '{$1=""; sub(/^ +/, ""); print}'
