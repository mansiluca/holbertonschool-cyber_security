#!/bin/bash
sudo nmap -sA -sW  $1 -p $2 --exclude-ports $3
