#!/bin/bash
password="$1"
password="${password#'{xor}'}"
echo -n "$password" | base64 -D | od -t u1 -An | while read -r line; do
    for byte in $line; do
        printf "\\$(printf '%03o' "$((byte ^ 95))")"
    done
done
echo ""
