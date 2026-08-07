#!/usr/bin/env bash

LOG_FILE="${1:-auth.log}"
LINES="${2:-1000}"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: log file not found: $LOG_FILE" >&2
    exit 1
fi

tail -n "$LINES" "$LOG_FILE" | awk '
/Failed password/ {
    for (i = 1; i < NF; i++) {
        if ($i == "for")
            failed[$(i+1)]++
    }
}
/Accepted password/ || /Accepted publickey/ {
    for (i = 1; i < NF; i++) {
        if ($i == "for") {
            user = $(i+1)
            accepted[user]++
            if (failed[user] > 0)
                suspects[user] = failed[user]
        }
    }
}
END {
    best = ""
    best_count = 0
    for (u in suspects) {
        if (suspects[u] > best_count) {
            best = u
            best_count = suspects[u]
        }
    }
    if (best != "")
        print best
}'
