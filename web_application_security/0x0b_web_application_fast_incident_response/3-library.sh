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

ATTACKER=$(awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -1 | awk '{$1=""; sub(/^ +/, ""); print}')

if [ -z "$ATTACKER" ]; then
    echo "Error: could not identify attacker IP" >&2
    exit 1
fi

grep -F "^$ATTACKER " "$LOG_FILE" | awk -F'"' '{
    print $NF
}' | sort | uniq -c | sort -rn | head -1 | awk '{$1=""; sub(/^ +/, ""); print}'
