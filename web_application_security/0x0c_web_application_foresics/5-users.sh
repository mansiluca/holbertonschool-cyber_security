#!/usr/bin/env bash

LOG_FILE="${1:-auth.log}"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: log file not found: $LOG_FILE" >&2
    exit 1
fi

awk '
/New user/ || /new user/ || /useradd/ || /adduser/ {
    for (i = 1; i <= NF; i++) {
        if ($i == "user" || $i == "USER") {
            username = $(i + 1)
            gsub(/["'\''<>,]/, "", username)
            if (username != "" && username !~ /^[0-9]/) {
                seen[username] = 1
            }
        }
    }
}
END {
    first = 1
    for (u in seen) {
        if (!first) printf ","
        printf "%s", u
        first = 0
    }
    print ""
}' "$LOG_FILE"
