#!/usr/bin/env bash

LOG_FILE="${1:-auth.log}"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: log file not found: $LOG_FILE" >&2
    exit 1
fi

awk '
/Accepted password/ || /Accepted publickey/ {
    for (i=1; i<=NF; i++) {
        if ($i == "from" && (i+1) <= NF) {
            ip = $(i+1)
            if (ip ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/)
                seen[ip] = 1
        }
    }
}
END {
    for (ip in seen) count++
    print count
}' "$LOG_FILE"
