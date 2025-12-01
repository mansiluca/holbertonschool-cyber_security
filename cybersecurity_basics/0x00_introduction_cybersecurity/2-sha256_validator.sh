#!/bin/bash
if [ "$(sha256sum "$1" | awk '{print $1}')" = "$2" ]
then echo "$1: OK"
fi
