#!/usr/bin/env bash

LOG_FILE="${1:-auth.log}"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: log file not found: $LOG_FILE" >&2
    exit 1
fi

awk '/pam_unix\(sshd/ { service="sshd" } service == "sshd" { print }' "$LOG_FILE" | \
awk '{
    for (i=1; i<=NF; i++) {
        word = $i
        gsub(/[^a-zA-Z0-9_:-]/, "", word)
        if (word ~ /:/) {
            split(word, parts, "(:)")
            if (parts[1] ~ /^[a-zA-Z0-9_-]+$/)
                count[parts[1]":"parts[2]]++
        } else if (word != "") {
            count[word]++
        }
    }
}
END {
    for (w in count) {
        print count[w], w
    }
}' | sort -rn | head -20
