#!/usr/bin/env bash

LOG_FILE="${1:-auth.log}"
LINES="${2:-1000}"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: log file not found: $LOG_FILE" >&2
    exit 1
fi

tail -n "$LINES" "$LOG_FILE" | awk '
/Failed password/ {
    for (i=1; i<=NF; i++) {
        if ($i == "for" && (i+1) <= NF)
            failed[$(i+1)]++
    }
}
/Accepted password/ || /Accepted publickey/ {
    for (i=1; i<=NF; i++) {
        if ($i == "for" && (i+1) <= NF)
            accepted[$(i+1)]++
    }
}
END {
    for (user in failed) {
        if (user in accepted) {
            print user
            next
        }
    }
}' | head -1
