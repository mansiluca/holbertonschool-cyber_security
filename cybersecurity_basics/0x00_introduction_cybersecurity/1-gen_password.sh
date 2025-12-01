#!/bin/bash
len=${1:-16}; tr -dc '[:alnum:]' </dev/urandom | head -c "$len"; echo
