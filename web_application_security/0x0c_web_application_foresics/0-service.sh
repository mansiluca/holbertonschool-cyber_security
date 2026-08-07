#!/usr/bin/env bash

LOG_FILE="${1:-auth.log}"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: log file not found: $LOG_FILE" >&2
    exit 1
fi

awk '{
    line = $0
    while (match(line, /\(sshd:[^)]*\)/)) {
        token = substr(line, RSTART + 1, RLENGTH - 2)
        count[token]++
        line = substr(line, RSTART + RLENGTH)
    }
}
END {
    for (t in count) print count[t], "pam_unix(" t "):"
}' "$LOG_FILE" | sort -rn

printf "%d %s\n" "$(grep -cE 'sshd\[' "$LOG_FILE")" "sshd"
