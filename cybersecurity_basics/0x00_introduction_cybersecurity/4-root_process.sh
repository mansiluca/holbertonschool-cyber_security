#!/bin/bash
[ $# -ne 1 ] && { echo "Usage: $0 user" >&2; exit 1; }
user="$1"
FIELDS="user=,pid=,pcpu=,pmem=,vsz=,rss=,tty=,stat=,start=,time=,cmd="
PATTERN='^[[:space:]]*[^[:space:]]+[[:space:]]+[0-9]+'
PATTERN+='[[:space:]]+[0-9.]+[[:space:]]+[0-9.]+'
PATTERN+='[[:space:]]+0[[:space:]]+0[[:space:]]'
ps -u "$user" -o "$FIELDS" \
| grep -v -E "$PATTERN"
