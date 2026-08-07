#!/usr/bin/env bash

LOG_FILE="${1:-auth.log}"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: log file not found: $LOG_FILE" >&2
    exit 1
fi

awk '
/new user: name=/ {
    for (i = 1; i <= NF; i++) {
        if ($i ~ /^name=/) {
            sub(/^name=/, "", $i)
            sub(/,.*$/, "", $i)
            seen[$i] = 1
        }
    }
}
END {
    n = 0
    for (u in seen) names[++n] = u
    # simple sort using asort alternative (piped to sort later)
    for (i = 1; i <= n; i++) print names[i]
}' "$LOG_FILE" | sort | awk 'BEGIN{first=1} {if(!first) printf ","; printf "%s", $0; first=0} END{print ""}'
