#!/bin/bash
f="$1"; h="$2"
[ "$(sha256sum "$f" | awk '{print $1}')" = "$h" ] && echo "$f: ok"
