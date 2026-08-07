#!/usr/bin/env bash

LOG_FILE="${1:-auth.log}"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: log file not found: $LOG_FILE" >&2
    exit 1
fi

grep -ciE 'firewall|ufw|iptables|firewalld|added.*rule|block.*ip|deny.*ip|reject.*ip' "$LOG_FILE"
