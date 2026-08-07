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

awk '
{
    ip = $1
    if (ip ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/)
        count[ip]++
}
END {
    max = 0
    for (ip in count) {
        if (count[ip] > max) {
            max = count[ip]
            attacker = ip
        }
    }
    print attacker
}' "$LOG_FILE"
